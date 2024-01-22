import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:objectid/objectid.dart';
import 'package:parambikulam/bloc/addperson/eventaddperson.dart';
import 'package:parambikulam/bloc/addperson/stateaddperson.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/addperson.dart';
import 'package:parambikulam/data/models/bookingsummaryall.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/utils/pref_manager.dart';
import 'package:http/http.dart' as http;

class AddPersonBloc extends Bloc<AddPersonEvent, AddPersonState> {
  AddPersonBloc() : super(AddPersonState()) {
    on<SavePersonData>(_savePersonData);
    on<RefreshAddPersonBloc>(_refreshAddPersonBloc);
  }

  Future<FutureOr<void>> _savePersonData(
      SavePersonData event, Emitter<AddPersonState> emit) async {
    String? name, dob, type, phone, email;
    int? index;

    emit(AddingPerson());
    name = event.name;
    dob = event.dob;
    phone = event.phoneno;
    type = event.guestType;
    index = event.currentIndex;
    AddPerson addPerson;

    if (event.isOffline == false) {
      Map map = {
        "dob": event.dob,
        "name": event.name,
        "phoneno": event.phoneno,
        "ticketid": event.ticketId,
        "guestid": event.guestId,
        "guestType": event.guestType,
        "cartId": event.cartId,
      };
      addPerson = await AuthRepository()
          .savePersonInformation(url: '/guest/checkpoint/add', data: map);
      if (addPerson.status == true) {
        print("the id ${addPerson.id.toString()}");
        if (event.file != "Empty") {
          emit(UploadingFile());
          try {
            var token = await PrefManager.getToken();
            var headers = <String, String>{"token": token ?? ""};
            var request = http.MultipartRequest('POST',
                Uri.parse(WebClient.ip + '/guest/checkpoint/uploadproof'));
            request.fields.addAll({"id": addPerson.id.toString()});
            request.files.add(await http.MultipartFile.fromPath(
                'image', event.file.toString()));
            request.headers.addAll(headers);
            http.StreamedResponse response = await request.send();
            print(request);
            if (response.statusCode == 200) {
              emit(FileUploaded());
              String cartId = await PrefManager.getCartId();
              BookingSummaryAll bookingSummaryAll;
              var url = '/entrypointcart/get?id=' + cartId + "&type=Counter";
              bookingSummaryAll =
                  await AuthRepository().getPartialBookingDataTwo(url: url);
              if (bookingSummaryAll.status == true) {
                emit(PersonAdded(
                  id: addPerson.id,
                  name: name,
                  phone: phone,
                  email: email,
                  dob: dob,
                  type: type,
                  bookingSummaryAll: bookingSummaryAll,
                  currentIndex: index,
                ));
              } else {
                print("Failed to get booking summary ${bookingSummaryAll.msg}");
              }
              // }
            } else {
              emit(FileNotUploaded(msg: response.reasonPhrase));
            }
          } catch (e) {
            Fluttertoast.showToast(msg: "File upload exception $e");
            print("File upload exception $e");
          }
        } else {
          String cartId = await PrefManager.getCartId();
          BookingSummaryAll bookingSummaryAll;
          var url = '/entrypointcart/get?id=' + cartId + "&type=Counter";
          bookingSummaryAll =
              await AuthRepository().getPartialBookingDataTwo(url: url);
          if (bookingSummaryAll.status == true) {
            emit(PersonAdded(
              id: addPerson.id,
              name: name,
              phone: phone,
              email: email,
              dob: dob,
              type: type,
              bookingSummaryAll: bookingSummaryAll,
              currentIndex: index,
            ));
          } else {
            print("Failed to get booking summary ${bookingSummaryAll.msg}");
          }
        }
      } else {
        emit(PersonNotAdded(message: addPerson.msg));
      }
    } else {
      final personId = new ObjectId();
      Map newMap = {
        "dob": event.dob,
        "name": event.name,
        "phoneno": event.phoneno,
        "ticketId": event.ticketId,
        "guestType": event.guestType,
        "cartId": event.cartId,
        'eTicket': event.entranceCharge,
        "id": personId.toString(),
        "guestId": event.guestId,
        "image": event.file,
      };
      Map entranceMap;
      entranceMap = {
        'guest': personId.toString(),
        'charge': event.entranceCharge,
        'bookingDate': event.date,
      };

      print("received");
      print(event.file);
      try {
        event.offlineBooking!.newListTwo.add(newMap);
        event.offlineBooking!.entranceData.add(entranceMap);
        emit(PersonAdded(
          name: name,
          phone: phone,
          email: email,
          dob: dob,
          type: type,
          currentIndex: index,
        ));
        print("members list -- ${event.offlineBooking!.newListTwo}");
      } catch (e) {
        print(e);
      }
    }
  }

  Future<FutureOr<void>> _refreshAddPersonBloc(
      RefreshAddPersonBloc event, Emitter<AddPersonState> emit) async {
    emit(AddPersonBlocRefreshed());
  }

  String? name, dob, type, id, phone, email;
  int? index;

  bool? fileUploadStatus = false, isInFileUpload = false;

  // @override
  // Stream<AddPersonState> mapEventToState(AddPersonEvent event) async* {
  //   if (event is SavePersonData) {
  //     yield AddingPerson();
  //     name = event.name;
  //     dob = event.dob;
  //     phone = event.phoneno;
  //     type = event.guestType;
  //     index = event.currentIndex;
  //     AddPerson addPerson;

  //     if (event.isOffline == false) {
  //       Map map = {
  //         "dob": event.dob,
  //         "name": event.name,
  //         "phoneno": event.phoneno,
  //         "guestType": event.guestType,
  //         "cartId": event.cartId,
  //       };
  //       addPerson = await AuthRepository()
  //           .savePersonInformation(url: '/guest/add', data: map);
  //       if (addPerson.status == true) {
  //         print("the id ${addPerson.id.toString()}");
  //         yield UploadingFile();
  //         try {
  //           var token = await PrefManager.getToken();
  //           var headers = <String, String>{"token": token ?? ""};
  //           var request = http.MultipartRequest(
  //               'POST', Uri.parse(WebClient.ip + '/guest/uploadproof'));
  //           request.fields.addAll({"id": addPerson.id.toString()});
  //           request.files.add(await http.MultipartFile.fromPath(
  //               'image', event.file.toString()));
  //           request.headers.addAll(headers);
  //           http.StreamedResponse response = await request.send();
  //           print(request);
  //           if (response.statusCode == 200) {
  //             yield FileUploaded();
  //             isInFileUpload = true;
  //             fileUploadStatus = false;

  //             // }
  //           } else {
  //             yield FileNotUploaded(msg: response.reasonPhrase);
  //             isInFileUpload = true;
  //             fileUploadStatus = true;
  //           }
  //         } catch (e) {
  //           Fluttertoast.showToast(msg: "File upload exception $e");
  //           print("File upload exception $e");
  //         }

  //         if (isInFileUpload == true) {
  //           String cartId = await PrefManager.getCartId();
  //           BookingSummaryAll bookingSummaryAll;
  //           var url = '/cart/get?id=' + cartId + "&type=Counter";
  //           bookingSummaryAll =
  //               await AuthRepository().getPartialBookingDataTwo(url: url);
  //           if (bookingSummaryAll.status == true) {
  //             yield PersonAdded(
  //               id: addPerson.id,
  //               name: name,
  //               phone: phone,
  //               email: email,
  //               dob: dob,
  //               type: type,
  //               bookingSummaryAll: bookingSummaryAll,
  //               currentIndex: index,
  //             );
  //           } else {
  //             print("Failed to get booking summary ${bookingSummaryAll.msg}");
  //           }
  //         }
  //       } else {
  //         yield PersonNotAdded(message: addPerson.msg);
  //       }
  //     } else {
  //       final personId = new ObjectId();
  //       Map newMap = {
  //         "dob": event.dob,
  //         "name": event.name,
  //         "phoneno": event.phoneno,
  //         "guestType": event.guestType,
  //         "cartId": event.cartId,
  //         'eTicket': event.entranceCharge,
  //         "id": personId.toString(),
  //         "image": event.file,
  //       };
  //       Map entranceMap;
  //       entranceMap = {
  //         'guest': personId.toString(),
  //         'charge': event.entranceCharge,
  //         'bookingDate': event.date,
  //       };

  //       print("received");
  //       print(event.file);
  //       try {
  //         event.offlineBooking!.newListTwo.add(newMap);
  //         event.offlineBooking!.entranceData.add(entranceMap);
  //         yield PersonAdded(
  //           name: name,
  //           phone: phone,
  //           email: email,
  //           dob: dob,
  //           type: type,
  //           currentIndex: index,
  //         );
  //         print("members list -- ${event.offlineBooking!.newListTwo}");
  //       } catch (e) {
  //         print(e);
  //       }
  //     }
  //     // if (event is SavePersonData) {
  //     //   yield AddingPerson();
  //     //   name = event.name;
  //     //   dob = event.dob;
  //     //   phone = event.phoneno;
  //     //   // email = event.email;
  //     //   type = event.guestType;
  //     //   index = event.currentIndex;

  //     //   AddPerson addPerson;
  //     //   Map map = {
  //     //     "dob": event.dob,
  //     //     "name": event.name,
  //     //     "phoneno": event.phoneno,
  //     //     "guestType": event.guestType,
  //     //     "cartId": event.cartId,
  //     //   };
  //     //   addPerson = await AuthRepository()
  //     //       .savePersonInformation(url: '/guest/add', data: map);

  //     //   print("Person Adding Status - " + addPerson.msg.toString());

  //     //   if (addPerson.status == true) {
  //     //     // id = addPerson.id.toString();
  //     //     // yield UploadingFile();
  //     //     // print("File is - " + event.file.toString());
  //     //     // print("Uploading File");
  //     //     try {
  //     // var token = await PrefManager.getToken();
  //     // var request = http.MultipartRequest(
  //     //     'POST', Uri.parse(WebClient.ip + '/guest/uploadproof'));
  //     // request.fields.addAll({"id": addPerson.id.toString()});
  //     // request.files.add(await http.MultipartFile.fromPath(
  //     //     'image', event.file.toString()));
  //     // request.headers.addAll(
  //     //     {"Content-Type": "application/json", "token": token ?? ""});
  //     // http.StreamedResponse response = await request.send();
  //     // if (response.statusCode == 200) {
  //     // print("File Uploaded" + await response.stream.bytesToString());
  //     // yield FileUploaded();

  //     // String cartId = await PrefManager.getCartId();
  //     // BookingSummaryAll bookingSummaryAll;
  //     // var url = '/cart/get?id=' + cartId + "&type=Counter";
  //     // bookingSummaryAll =
  //     //     await AuthRepository().getPartialBookingDataTwo(url: url);
  //     // if (bookingSummaryAll.status == true) {
  //     //   yield PersonAdded(
  //     //     id: addPerson.id,
  //     //     name: name,
  //     //     phone: phone,
  //     //     email: email,
  //     //     dob: dob,
  //     //     type: type,
  //     //     bookingSummaryAll: bookingSummaryAll,
  //     //     currentIndex: index,
  //     //   );
  //     // }
  //     //       // }
  //     //       // else {
  //     //       //   print("File Upload Failed");
  //     //       // }
  //     //     } catch (e) {
  //     //       yield FileNotUploaded(msg: e.toString());
  //     //     }
  //     //   //   Map fileMap = {
  //     //   //     "id": addPerson.id.toString(),
  //     //   //     "image": event.file,
  //     //   //   };
  //     //   //   print("File Uploading Arguments - " + fileMap.toString());
  //     //   //   addPerson = await AuthRepository()
  //     //   //       .uploadProof(url: '/guest/uploadproof', data: map);
  //     //   //   print("File Uploading Status - " + addPerson.msg.toString());
  //     //   } else {
  //     //     yield PersonNotAdded(message: addPerson.msg);
  //     //   }
  //     //   // if (bookingSummaryAll.status == true) {
  //     //   //   var url = '/cart/get?id=' + cartId + "&type=Counter";
  //     //   //   bookingSummaryAll =
  //     //   //       await AuthRepository().getPartialBookingDataTwo(url: url);
  //     //   //   if (bookingSummaryAll.status == true) {
  //     //   //     yield PersonAdded(
  //     //   //         name: event.name,
  //     //   //         dob: event.dob,
  //     //   //         type: event.guestType,
  //     //   //         bookingSummaryAll: bookingSummaryAll,
  //     //   //         currentIndex: event.currentIndex);
  //     //   //   }
  //     //   // } else {
  //     //   //   yield PersonNotAdded(message: bookingSummaryAll.msg);
  //     //   // }
  //     // }

  //     // if (event is EditPersonData) {
  //     //   print("Edit Person Called");
  //     //   yield EditingPerson();
  //     //   name = event.name;
  //     //   dob = event.dob;
  //     //   phone = event.phoneno;
  //     //   // email = event.email;
  //     //   type = event.guestType;
  //     //   index = event.currentIndex;

  //     //   String cartId = await PrefManager.getCartId();
  //     //   // BookingSummaryAll bookingSummaryAll;
  //     //   AddPerson addPerson;
  //     //   Map map = {
  //     //     "dob": event.dob,
  //     //     "name": event.name,
  //     //     "phoneno": event.phoneno,
  //     //     // "email": event.email,
  //     //     "guestType": event.guestType,
  //     //     "id": event.personId,
  //     //   };
  //     //   print(map);
  //     //   addPerson = await AuthRepository()
  //     //       .savePersonInformation(url: '/guest/edit', data: map);

  //     //   print("Person Updating Status - " + addPerson.msg.toString());

  //     //   if (addPerson.status == true) {
  //     //     BookingSummaryAll bookingSummaryAll;
  //     //     var url = '/cart/get?id=' + cartId + "&type=Counter";
  //     //     bookingSummaryAll =
  //     //         await AuthRepository().getPartialBookingDataTwo(url: url);
  //     //     if (bookingSummaryAll.status == true) {
  //     //       yield PersonUpdated(
  //     //         id: id,
  //     //         name: name,
  //     //         phone: phone,
  //     //         email: email,
  //     //         dob: dob,
  //     //         type: type,
  //     //         bookingSummaryAll: bookingSummaryAll,
  //     //         currentIndex: index,
  //     //       );
  //     //     }
  //     //   } else {
  //     //     yield PersonNotUpdated(message: "Person Not Updated");
  //     //   }
  //     //   // } else {
  //     //   //   print("File Upload Failed");
  //     //   // }
  //     //   // } catch (e) {
  //     //   //   yield FileNotUploaded(msg: e.toString());
  //     //   // }
  //     //   // Map fileMap = {
  //     //   //   "id": addPerson.id.toString(),
  //     //   //   "image": event.file,
  //     //   // };
  //     //   // print("File Uploading Arguments - " + fileMap.toString());
  //     //   // addPerson = await AuthRepository()
  //     //   //     .uploadProof(url: '/guest/uploadproof', data: map);
  //     //   // print("File Uploading Status - " + addPerson.msg.toString());
  //     //   // } else {
  //     //   //   yield PersonNotAdded(message: addPerson.msg);
  //     //   // }
  //     //   // if (bookingSummaryAll.status == true) {
  //     //   //   var url = '/cart/get?id=' + cartId + "&type=Counter";
  //     //   //   bookingSummaryAll =
  //     //   //       await AuthRepository().getPartialBookingDataTwo(url: url);
  //     //   //   if (bookingSummaryAll.status == true) {
  //     //   //     yield PersonAdded(
  //     //   //         name: event.name,
  //     //   //         dob: event.dob,
  //     //   //         type: event.guestType,
  //     //   //         bookingSummaryAll: bookingSummaryAll,
  //     //   //         currentIndex: event.currentIndex);
  //     //   //   }
  //     //   // } else {
  //     //   //   yield PersonNotAdded(message: bookingSummaryAll.msg);
  //     //   // }
  //     // }
  //   }

  //   if (event is RefreshAddPersonBloc) {
  //     yield AddPersonBlocRefreshed();
  //   }
  // }
}
