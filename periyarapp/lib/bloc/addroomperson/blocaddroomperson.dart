import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectid/objectid.dart';
import 'package:parambikulam/bloc/addroomperson/eventaddroomperson.dart';
import 'package:parambikulam/bloc/addroomperson/stateaddroomperson.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/addperson.dart';
import 'package:parambikulam/data/models/bookingsummaryall.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/utils/pref_manager.dart';
import 'package:http/http.dart' as http;

class BlocAddRoomPerson extends Bloc<EventAddRoomPerson, StateAddRoomPerson> {
  String id = "";
  BlocAddRoomPerson() : super(StateAddRoomPerson()) {
    //     String? name, dob, type, id, phone, email;
    // int? index;

    on<SaveRoomPersonData>(_saveRoomPersonData);
    on<RefreshRoom>(_refreshRoom);
    on<UploadImage>(_uploadImage);
  }

  Future<FutureOr<void>> _saveRoomPersonData(
      SaveRoomPersonData event, Emitter<StateAddRoomPerson> emit) async {
    String? name, dob, type, phone, email;
    int? index;
    emit(AddPersonRoomInitial());
    name = event.name;
    dob = event.dob;
    phone = event.phoneno;
    type = event.guestType;
    index = event.currentIndex;
    if (event.isOffline == false) {
      try {
        AddPerson addPerson;
        Map map = {
          'guestid': event.guestid,
          'ticketid': event.ticketid,
          "dob": event.dob,
          "name": event.name,
          "phoneno": event.phoneno,
          "roomAllocationId": event.roomAllocationId,
          "guestType": event.guestType,
          "cartId": event.cartId,
        };
        addPerson = await AuthRepository()
            .savePersonInformation(url: '/guest/add/app', data: map);
        print("Person Adding Status In Room - " + addPerson.msg.toString());

        if (addPerson.status == true) {
          if (event.file != "Empty") {
            emit(UploadingFileInRoom());
            try {
              var token = await PrefManager.getToken();
              if (event.file != null || event.file != "Empty") {
                var request = http.MultipartRequest(
                    'POST', Uri.parse(WebClient.ip + '/guest/uploadproof/app'));
                request.fields.addAll({"id": addPerson.id.toString()});
                request.files.add(await http.MultipartFile.fromPath(
                    'image', event.file.toString()));
                request.headers.addAll(
                    {"Content-Type": "application/json", "token": token ?? ""});
                http.StreamedResponse response = await request.send();
                if (response.statusCode == 200) {
                  print(
                      "File Uploaded" + await response.stream.bytesToString());
                  emit(RoomFileUploaded());
                  String cartId = await PrefManager.getCartId();
                  BookingSummaryAll bookingSummaryAll;
                  var url = '/cart/get/app?id=' + cartId + "&type=Counter";
                  bookingSummaryAll =
                      await AuthRepository().getPartialBookingDataTwo(url: url);
                  if (bookingSummaryAll.status == true) {
                    emit(RoomPersonAdded(
                      id: addPerson.id,
                      roomIndex: event.roomIndex,
                      name: name,
                      phone: phone,
                      email: email,
                      dob: dob,
                      type: type,
                      bookingSummaryAll: bookingSummaryAll,
                      currentIndex: index,
                    ));
                  }
                }
                // else {
                //   RemovePersonModel removePersonModel;
                //   Map map = {
                //     "id": addPerson.id,
                //   };
                //   removePersonModel = await AuthRepository()
                //       .removePerson(url: '/guest/remove', data: map);
                //   print(removePersonModel.msg);
                //   emit(RoomFileNotUploaded(msg: response.statusCode.toString()));
                // }
              }
            } catch (e) {
              print(e);
              //  emit(RoomFileNotUploaded(msg: e.toString()));
            }
          } else {
            String cartId = await PrefManager.getCartId();
            BookingSummaryAll bookingSummaryAll;
            var url = '/cart/get/app?id=' + cartId + "&type=Counter";
            bookingSummaryAll =
                await AuthRepository().getPartialBookingDataTwo(url: url);
            if (bookingSummaryAll.status == true) {
              emit(RoomPersonAdded(
                id: addPerson.id,
                roomIndex: event.roomIndex,
                name: name,
                phone: phone,
                email: email,
                dob: dob,
                type: type,
                bookingSummaryAll: bookingSummaryAll,
                currentIndex: index,
              ));
            }
          }
        } else {
          emit(RoomPersonNotAdded(msg: addPerson.msg));
        }
      } on Exception catch (e) {
        emit(RoomPersonNotAdded(msg: e.toString()));
      }
    } else {
      final personId = new ObjectId();
      Map newMap = {
        'guestid': event.guestid,
        'ticketid': event.ticketid,
        "dob": event.dob,
        "name": event.name,
        "phoneno": event.phoneno,
        "guestType": event.guestType,
        "cartId": event.cartId,
        'eTicket': event.entranceCharge,
        "image": event.file,
        "roomnumber": (event.roomIndex! + 1).toString(),
        "id": personId.toString()
      };
      print("received");
      // print(event.file);
      try {
        // List<Map> newList = [];
        // newList.add(newMap);
        event.offlineBooking!.newListTwo.add(newMap);
        Map entranceData = {
          'guest': personId.toString(),
          'charge': event.entranceCharge,
          'bookingDate': event.date,
        };
        event.offlineBooking!.entranceData.add(entranceData);
        emit(RoomPersonAdded(
          // id: addPerson.id,
          roomIndex: event.roomIndex,
          name: name,
          phone: phone,
          email: email,
          dob: dob,
          type: type,
          // bookingSummaryAll: bookingSummaryAll,
          currentIndex: index,
        ));
        // yield PersonAdded(
        //   name: name,
        //   phone: phone,
        //   email: email,
        //   dob: dob,
        //   type: type,
        //   currentIndex: index,
        // );
        print("members list -- ${event.offlineBooking!.newListTwo}");
      } catch (e) {
        print(e);
      }
    }
  }

  Future<FutureOr<void>> _refreshRoom(
      RefreshRoom event, Emitter<StateAddRoomPerson> emit) async {
    emit(RoomRefreshed());
  }

  // String? name, dob, type, id, phone, email;
  // int? index;
  // @override
  // Stream<StateAddRoomPerson> mapEventToState(EventAddRoomPerson event) async* {
  //   if (event is SaveRoomPersonData) {
  //     yield AddPersonRoomInitial();
  //     name = event.name;
  //     dob = event.dob;
  //     phone = event.phoneno;
  //     type = event.guestType;
  //     index = event.currentIndex;
  //     if (event.isOffline == false) {
  //       AddPerson addPerson;
  //       Map map = {
  //         "dob": event.dob,
  //         "name": event.name,
  //         "phoneno": event.phoneno,
  //         "roomAllocationId": event.roomAllocationId,
  //         "guestType": event.guestType,
  //         "cartId": event.cartId,
  //       };
  //       addPerson = await AuthRepository()
  //           .savePersonInformation(url: '/guest/add', data: map);
  //       print("Person Adding Status In Room - " + addPerson.msg.toString());

  //       if (addPerson.status == true) {
  //         yield UploadingFileInRoom();
  //         try {
  //           var token = await PrefManager.getToken();
  //           if (event.file != null) {
  //             var request = http.MultipartRequest(
  //                 'POST', Uri.parse(WebClient.ip + '/guest/uploadproof'));
  //             request.fields.addAll({"id": addPerson.id.toString()});
  //             request.files.add(await http.MultipartFile.fromPath(
  //                 'image', event.file.toString()));
  //             request.headers.addAll(
  //                 {"Content-Type": "application/json", "token": token ?? ""});
  //             http.StreamedResponse response = await request.send();
  //             if (response.statusCode == 200) {
  //               print("File Uploaded" + await response.stream.bytesToString());
  //               yield RoomFileUploaded();
  //               String cartId = await PrefManager.getCartId();
  //               BookingSummaryAll bookingSummaryAll;
  //               var url = '/cart/get?id=' + cartId + "&type=Counter";
  //               bookingSummaryAll =
  //                   await AuthRepository().getPartialBookingDataTwo(url: url);
  //               if (bookingSummaryAll.status == true) {
  //                 yield RoomPersonAdded(
  //                   id: addPerson.id,
  //                   roomIndex: event.roomIndex,
  //                   name: name,
  //                   phone: phone,
  //                   email: email,
  //                   dob: dob,
  //                   type: type,
  //                   bookingSummaryAll: bookingSummaryAll,
  //                   currentIndex: index,
  //                 );
  //               }
  //             } else {
  //               RemovePersonModel removePersonModel;
  //               Map map = {
  //                 "id": addPerson.id,
  //               };
  //               removePersonModel = await AuthRepository()
  //                   .removePerson(url: '/guest/remove', data: map);
  //               print(removePersonModel.msg);
  //               yield RoomFileNotUploaded(msg: response.statusCode.toString());
  //             }
  //           }
  //         } catch (e) {
  //           yield RoomFileNotUploaded(msg: e.toString());
  //         }
  //       } else {
  //         yield RoomPersonNotAdded(msg: addPerson.msg);
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
  //         "image": event.file,
  //         "roomnumber": (event.roomIndex! + 1).toString(),
  //         "id": personId.toString()
  //       };
  //       print("received");
  //       // print(event.file);
  //       try {
  //         // List<Map> newList = [];
  //         // newList.add(newMap);
  //         event.offlineBooking!.newListTwo.add(newMap);
  //         Map entranceData = {
  //           'guest': personId.toString(),
  //           'charge': event.entranceCharge,
  //           'bookingDate': event.date,
  //         };
  //         event.offlineBooking!.entranceData.add(entranceData);
  //         yield RoomPersonAdded(
  //           // id: addPerson.id,
  //           roomIndex: event.roomIndex,
  //           name: name,
  //           phone: phone,
  //           email: email,
  //           dob: dob,
  //           type: type,
  //           // bookingSummaryAll: bookingSummaryAll,
  //           currentIndex: index,
  //         );
  //         // yield PersonAdded(
  //         //   name: name,
  //         //   phone: phone,
  //         //   email: email,
  //         //   dob: dob,
  //         //   type: type,
  //         //   currentIndex: index,
  //         // );
  //         print("members list -- ${event.offlineBooking!.newListTwo}");
  //       } catch (e) {
  //         print(e);
  //       }
  //     }
  //   }

  //   if (event is RefreshRoom) {
  //     yield RoomRefreshed();
  //   }
  // }

  FutureOr<void> _uploadImage(
      UploadImage event, Emitter<StateAddRoomPerson> emit) {}
}
