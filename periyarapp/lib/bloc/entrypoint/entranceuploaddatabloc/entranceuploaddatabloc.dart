import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/entrypoint/entranceuploaddatabloc/entranceuploaddataevent.dart';
import 'package:parambikulam/bloc/entrypoint/entranceuploaddatabloc/entranceuploaddatastate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';

import 'package:parambikulam/data/models/entrymodel/commonentryModel.dart';
import 'package:parambikulam/data/models/entrymodel/entrybookingmodel.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/utils/pref_manager.dart';

class UploadEntryBookingBloc
    extends Bloc<UploadEntryBookingEvent, UploadEntryBookingState> {
  UploadEntryBookingBloc() : super(UploadEntryBookingState()) {
    on<UploadEntryBooking>(_uploadData);
    on<UpdateIdProofs>(_uploadIdProofs);
    on<RefreshEntryBookings>((event, emit) => emit(RefreshState()));
  }
  DatabaseHelper? db = DatabaseHelper.instance;

  Future<FutureOr<void>> _uploadData(
      UploadEntryBooking event, Emitter<UploadEntryBookingState> emit) async {
    emit(UploadingEntryData());
    CommonEntryModel commonModel;
    print(jsonDecode(event.entryBookingData!.bookingData!)['customers'][0]
        ['bookingDate']);
    Map data = {
      "ticket": {
        "ticketid": event.entryBookingData!.ticketId,
      },
      "guest": [
        for (int i = 0;
            i <
                jsonDecode(event.entryBookingData!.bookingData!)['customers']
                    .length;
            i++)
          {
            "name":
                jsonDecode(event.entryBookingData!.bookingData!)['customers'][i]
                    ['name'],
            "guestid":
                jsonDecode(event.entryBookingData!.bookingData!)['customers'][i]
                    ['guestId'],
            "guestType":
                jsonDecode(event.entryBookingData!.bookingData!)['customers'][i]
                    ['label'],
            "dob": jsonDecode(event.entryBookingData!.bookingData!)['customers']
                [i]['dob'],
            "phoneno":
                jsonDecode(event.entryBookingData!.bookingData!)['customers'][i]
                    ['phoneNumber'],
            "gender": "Male",
            "locality":
                jsonDecode(event.entryBookingData!.bookingData!)['place'],
            "idproofs": {"idType": "Adhar"},
            "visaNumber":
                jsonDecode(event.entryBookingData!.bookingData!)['customers'][i]
                    ['visaNumber'],
            "VisaValidTo":
                jsonDecode(event.entryBookingData!.bookingData!)['customers'][i]
                    ['visaValidTo'],
            "passportValidationDate":
                jsonDecode(event.entryBookingData!.bookingData!)['customers'][i]
                    ['passportValidationDate'],
          }
      ],
      "entranceTicket": [
        for (int i = 0;
            i <
                jsonDecode(event.entryBookingData!.bookingData!)['customers']
                    .length;
            i++)
          {
            "guestId":
                jsonDecode(event.entryBookingData!.bookingData!)['customers'][i]
                    ['guestId'],
            "charge":
                jsonDecode(event.entryBookingData!.bookingData!)['customers'][i]
                    ['charge'],
            "bookingDate":
                jsonDecode(event.entryBookingData!.bookingData!)['customers'][i]
                    ['bookingDate'],
            "ticketType": "guest"
          }
      ],
      "vehicle": [
        for (int i = 0;
            i <
                jsonDecode(
                        event.entryBookingData!.bookingData!)['vehicleDetails']
                    .length;
            i++)
          {
            "charge": jsonDecode(event.entryBookingData!.bookingData!)[
                'vehicleDetails'][i]['amount'],
            "bookingDate": jsonDecode(event.entryBookingData!.bookingData!)[
                'vehicleDetails'][i]['bookingDate'],
            "ticketType": "vehicle",
            "vehicleNumber": jsonDecode(event.entryBookingData!.bookingData!)[
                'vehicleDetails'][i]['vehicleNumber'],
            "vehicleType": jsonDecode(event.entryBookingData!.bookingData!)[
                'vehicleDetails'][i]['type'],
          }
      ],
      "camera": [
        for (int i = 0;
            i <
                jsonDecode(
                        event.entryBookingData!.bookingData!)['cameraDetails']
                    .length;
            i++)
          {
            "charge": jsonDecode(event.entryBookingData!.bookingData!)[
                'cameraDetails'][i]['amount'],
            "bookingDate": jsonDecode(event.entryBookingData!.bookingData!)[
                'cameraDetails'][i]['bookingDate'],
            "ticketType": "camera",
            "cameraType": jsonDecode(event.entryBookingData!.bookingData!)[
                'cameraDetails'][i]['type'],
          }
      ]
    };

    commonModel = await AuthRepository()
        .entryUploadData(url: '/checkpoint/entrenceticket/sync', data: data);
    print(commonModel.msg);
    if (commonModel.status == true) {
      emit(UploadEntryBookingSuccess());
      uploadfiles(event.entryBookingData!);
      db!.deleteOneEntryTicket(event.entryBookingData!.ticketId);
    }
    if (commonModel.status == false) {
      Fluttertoast.showToast(msg: commonModel.msg!);
    }
  }

  Future<FutureOr<void>> _uploadIdProofs(
      UpdateIdProofs event, Emitter<UploadEntryBookingState> emit) async {
    //   Map data = {"IdProofs": event.imagePath, "guestid": event.id};
    var token = await PrefManager.getToken();

    var request = http.MultipartRequest(
        'POST', Uri.parse(WebClient.ip + '/documents/upload/idproofs'));
    //documents/upload/idproofs
    //guestid, IdProofs
    request.fields.addAll({"guestid": event.id.toString()});
    request.files.add(
      await http.MultipartFile.fromPath(
        'IdProofs',
        event.imagePath!,
      ),
    );
    request.headers
        .addAll({"Content-Type": "application/json", "token": token ?? ""});
    http.StreamedResponse response = await request.send();
    print(response);
    if (response.statusCode == 200) {
      print("File Uploaded" + await response.stream.bytesToString());
      var deleteResult = await db!.deleteFromPreviousUpdates(event.index!);
      print("deleted result $deleteResult");
      emit(ImageUploaded());
    } else {
      print("not uploaded");
    }
    // print(data);
  }
}

uploadfiles(EntryBookingModel entryBookingData) async {
  for (int i = 0;
      i < jsonDecode(entryBookingData.bookingData!)['customers'].length;
      i++) {
    if (jsonDecode(entryBookingData.bookingData!)['customers'][i]['label'] ==
        "foreigner") {
      if (jsonDecode(entryBookingData.bookingData!)['customers'][i]
                  ['visaproof'] !=
              null ||
          jsonDecode(entryBookingData.bookingData!)['customers'][i]
                  ['visaproof'] !=
              "null" ||
          jsonDecode(entryBookingData.bookingData!)['customers'][i]
                  ['visaproof'] !=
              "") {
        WebClient.commonFilesUpload(
            '/documents/upload/visa',
            jsonDecode(entryBookingData.bookingData!)['customers'][i]
                ['visaproof'],
            jsonDecode(entryBookingData.bookingData!)['customers'][i]
                ['guestId'],
            'visa',
            'guestid');
      }

      if (jsonDecode(entryBookingData.bookingData!)['customers'][i]
                  ['passportproof'] !=
              null ||
          jsonDecode(entryBookingData.bookingData!)['customers'][i]
                  ['passportproof'] !=
              "") {
        WebClient.commonFilesUpload(
            '/documents/upload/passport',
            jsonDecode(entryBookingData.bookingData!)['customers'][i]
                ['passportproof'],
            jsonDecode(entryBookingData.bookingData!)['customers'][i]
                ['guestId'],
            'passport',
            'guestid');
      }
    } else {
      // var image =
      //     jsonDecode(entryBookingData.bookingData!)['customers'][i]['photo'];
      if (jsonDecode(entryBookingData.bookingData!)['customers'][i]['label'] ==
          "indian") {
       bool status = await checkImageNull(
            jsonDecode(entryBookingData.bookingData!)['customers'][i]['photo']);
        if (status) {
          print(jsonDecode(entryBookingData.bookingData!));
          WebClient.commonFilesUpload(
              '/documents/upload/idproofs',
              jsonDecode(entryBookingData.bookingData!)['customers'][i]
                  ['photo'],
              jsonDecode(entryBookingData.bookingData!)['customers'][i]
                  ['guestId'],
              'IdProofs',
              'guestid');
        }
      }
    }
  }
}

 checkImageNull(image) async{
  if (image == null) {
    return false;
  } else {
    return true;
  }
}
