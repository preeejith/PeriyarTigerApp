import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/imageupload/eventupload.dart';
import 'package:parambikulam/bloc/imageupload/stateupload.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/utils/pref_manager.dart';
import 'package:http/http.dart' as http;

class BlocUpload extends Bloc<EventUpload, StateUpload> {
  BlocUpload() : super(BlocUploadInitial()) {
    on<GettingImage>(_gettingImage);
  }

  Future<FutureOr<void>> _gettingImage(
      GettingImage event, Emitter<StateUpload> emit) async {
    emit(ProcessingImage());
    // if (token == null) {
    //   emit(TokensCleared());
    //   // Navigator.pushReplacement(
    //   //   event.context!,
    //   //   MaterialPageRoute(builder: (context) => NewHome()),
    //   // );
    // }

    try {
      Fluttertoast.showToast(msg: "Uploading");
      var token = await PrefManager.getToken();
      var request = http.MultipartRequest(
          'POST', Uri.parse(WebClient.ip + '/guest/uploadproof'));
      request.fields.addAll({"id": event.idOffline.toString()});
      // request.fields.addAll({"ticket": event.pdfId!.toString()});
      print("the id ${event.idOffline.toString()}");
      print("the pdf id is + " + event.pdfId.toString());
      print("the path ${event.path.toString()}");
      request.files
          .add(await http.MultipartFile.fromPath('image', event.path!));
      request.headers.addAll(
          {"Content-Type": "application/multipart", "token": token ?? ""});
      http.StreamedResponse response = await request.send();
      print(response);
      if (response.statusCode == 200) {
        print("File Uploaded - " + await response.stream.bytesToString());

        emit(ImageUploaded(iCount: event.iCount));
      } else {
        emit(ImageUploadFailed(iCount: event.iCount));
      }
      // var length = event.path!.length;
      // var uri = Uri.parse(WebClient.ip + '/guest/uploadproof');
      // var request = new http.MultipartRequest("POST", uri);
      // var multipartFile = new http.MultipartFile('file', stream, length,
      //   filename: basename(imageFile.path));

    } catch (e) {
      Fluttertoast.showToast(
          msg: "Image Upload Failed Due To - " + e.toString());
      emit(ImageUploadFailed(iCount: event.iCount));
      print("Image Upload Failed Due To - " + e.toString());
    }
  }

  // @override
  // Stream<StateUpload> mapEventToState(EventUpload event) async* {
  //   if (event is GettingImage) {
  //     yield ProcessingImage();
  //     // print(event.path);
  //     // OpenFile.open(event.path);
  //     try {
  //       Fluttertoast.showToast(msg: "Uploading");
  //       var token = await PrefManager.getToken();
  //       var request = http.MultipartRequest(
  //           'POST', Uri.parse(WebClient.ip + '/guest/uploadproof'));
  //       request.fields.addAll({"id": event.idOffline.toString()});
  //       // request.fields.addAll({"ticket": event.pdfId!.toString()});
  //       print("the id ${event.idOffline.toString()}");
  //       print("the pdf id is + " + event.pdfId.toString());
  //       print("the path ${event.path.toString()}");
  //       request.files
  //           .add(await http.MultipartFile.fromPath('image', event.path!));
  //       request.headers.addAll(
  //           {"Content-Type": "application/multipart", "token": token ?? ""});
  //       http.StreamedResponse response = await request.send();
  //       print(response);
  //       if (response.statusCode == 200) {
  //         print("File Uploaded - " + await response.stream.bytesToString());

  //         yield ImageUploaded(iCount: event.iCount);
  //       } else {
  //         yield ImageUploadFailed(iCount: event.iCount);
  //       }
  //       // var length = event.path!.length;
  //       // var uri = Uri.parse(WebClient.ip + '/guest/uploadproof');
  //       // var request = new http.MultipartRequest("POST", uri);
  //       // var multipartFile = new http.MultipartFile('file', stream, length,
  //       //   filename: basename(imageFile.path));

  //     } catch (e) {
  //       Fluttertoast.showToast(
  //           msg: "Image Upload Failed Due To - " + e.toString());
  //       yield ImageUploadFailed(iCount: event.iCount);
  //       print("Image Upload Failed Due To - " + e.toString());
  //     }
  //     // try {
  //     //   var token = await PrefManager.getToken();
  //     //   var request = http.MultipartRequest(
  //     //       'POST', Uri.parse(WebClient.ip + '/guest/uploadproof'));
  //     //   request.fields.addAll({"id": addPerson.id.toString()});
  //     //   request.files
  //     //       .add(await http.MultipartFile.fromPath('image', event.file));
  //     //   request.headers.addAll(
  //     //       {"Content-Type": "application/json", "token": token ?? ""});
  //     //   http.StreamedResponse response = await request.send();
  //     //   if (response.statusCode == 200) {
  //     //     print("File Uploaded" + await response.stream.bytesToString());
  //     //     yield FileUploaded();
  //   }
  // }
}
