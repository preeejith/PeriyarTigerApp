////some issue happened


import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:parambikulam/bloc/printticket/eventpticket.dart';
import 'package:parambikulam/bloc/printticket/statepticket.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:path_provider/path_provider.dart';

class BlocPrintTicket extends Bloc<EventPTicket, StatePTicket> {
  BlocPrintTicket() : super(StatePTicket()) {
    on<PrintTicket>(_printTicket);
    // on<PrintTicket>(getDocDirectory());


  }

  Future<FutureOr<void>> _printTicket(
      PrintTicket event, Emitter<StatePTicket> emit) async {
    String dir = await getDocDirectory();
    print("the directory is " + dir.toString());

    File file = new File(dir + "/" + event.ticketId.toString() + ".pdf");
    if (file.existsSync()) {
      await OpenFile.open(file.path);
    } else {
      var request = await http.get(Uri.parse(
          WebClient.ip + '/booking/ticketpdf?id=' + event.ticketId.toString()));
      // print(request);
      var bytes = request.bodyBytes;
      print(request.contentLength);
      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
    }
  }

//
///////some issue during this bloc
 Future<String> getDocDirectory() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    final Directory _docDirextory =
        Directory('/storage/emulated/0/parambikulam');
    if (await _docDirextory.exists()) {
      print("Directory Exists");
      return _docDirextory.path;
    } else {
      print("Directory Not Exists");
      try {
        new Directory(appDocDirectory.path + '/storage/emulated/0/parambikulam')
            .create(recursive: true);
        print('Path of New Dir: ' + appDocDirectory.path);
      } catch (e) {
        print(e.toString());
      }
      return appDocDirectory.path;
    }
  }






//  Future<FutureOr<void>> mapEventToState(
//       PrintTicket event, Emitter<StatePTicket> emit) async {
//     String dir = await getDocDirectory();
//     print("the directory is " + dir.toString());

//     File file = new File(dir + "/" + event.ticketId.toString() + ".pdf");
//     if (file.existsSync()) {
//       await OpenFile.open(file.path);
//     } else {
//       var request = await http.get(Uri.parse(
//           WebClient.ip + '/booking/ticketpdf?id=' + event.ticketId.toString()));
//       // print(request);
//       var bytes = request.bodyBytes;
//       print(request.contentLength);
//       await file.writeAsBytes(bytes);
//       await OpenFile.open(file.path);
//     }
//   }








  // @override
  // Stream<StatePTicket> mapEventToState(EventPTicket event) async* {
  //   if (event is PrintTicket) {
  //     String dir = await getDocDirectory();
  //     print("the directory is " + dir.toString());
  //     File file = new File(dir + "/" + event.ticketId.toString() + ".pdf");
  //     if (file.existsSync()) {
  //       await OpenFile.open(file.path);
  //     } else {
  //       var request = await http.get(Uri.parse(WebClient.ip +
  //           '/booking/ticketpdf?id=' +
  //           event.ticketId.toString()));
  //       // print(request);
  //       var bytes = request.bodyBytes;
  //       print(request.contentLength);
  //       await file.writeAsBytes(bytes);
  //       await OpenFile.open(file.path);
  //     }
  //   }
  // }

  // Future<String> getDocDirectory() async {
  //   Directory appDocDirectory = await getApplicationDocumentsDirectory();
  //   final Directory _docDirextory =
  //       Directory('/storage/emulated/0/parambikulam');
  //   if (await _docDirextory.exists()) {
  //     print("Directory Exists");
  //     return _docDirextory.path;
  //   } else {
  //     print("Directory Not Exists");
  //     try {
  //       new Directory(appDocDirectory.path + '/storage/emulated/0/parambikulam')
  //           .create(recursive: true);
  //       print('Path of New Dir: ' + appDocDirectory.path);
  //     } catch (e) {
  //       print(e.toString());
  //     }
  //     return appDocDirectory.path;
  //   }
  // }
}
