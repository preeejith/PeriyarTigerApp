//want to chnage the remaining

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/booking/bookingevent.dart';
import 'package:parambikulam/bloc/booking/bookingstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/bookingpartial.dart';
import 'package:parambikulam/data/models/bookingsummary.dart';
import 'package:parambikulam/data/models/bookingsummaryall.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/data/models/vehiclemodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/utils/pref_manager.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  DatabaseHelper? db = DatabaseHelper.instance;
  BookingBloc() : super(BookingState()) {
    on<GetBookingSummary>(_getBookingSummary);
    on<DoPartialBookingOne>(_doPartialBookingOne);
    on<GetPartialBookingSummary>(_getPartialBookingSummary);
  }
  Future<FutureOr<void>> _getBookingSummary(
      GetBookingSummary event, Emitter<BookingState> emit) async {
    print("the status ${event.isOffline}");

    emit(GettingBookingSummary());
    if (event.isOffline == false) {
      print("inside");
      BookingSummary bookingSummary;
      var url = '/booking/getagentslots?programme=' +
          event.id.toString() +
          '&date=' +
          event.date.toString();
      bookingSummary = await AuthRepository().getBookingSummary(url: url);
      print(url);
      if (bookingSummary.status == true) {
        print("inside one");
        // print(bookingSummary.data![0].startTime);
        // PrefManager.setRoomCount(bookingSummary.data![0].freeCount);
        emit(GettingBookingSummaryRecieved(
            summaryData: bookingSummary, offline: event.isOffline));
      } else {
        print("inside failed");
        emit(GettingBookingSummaryFailed(summaryData: bookingSummary));
      }
    } else {
      emit(GettingBookingSummaryRecieved(
        offline: event.isOffline,
        offlineData: event.offlineData,
        programList: event.programList,
        localSlotData: event.localSlotData,
      ));
    }
  }

  Future<FutureOr<void>> _doPartialBookingOne(
      DoPartialBookingOne event, Emitter<BookingState> emit) async {
    emit(GettingPartialData());

    if (event.isOffline == false) {
      print("online");
      PartialBooking partialBooking;
      Map map = {
        "programme": event.programId.toString(),
        "slotDetail": event.slotId.toString(),
        "bookingDate": event.bookingDate.toString(),
        "data": event.newList,
      };

      print(map);
      partialBooking = await AuthRepository()
          .getPartialBookingData(url: '/cart/addpartialagent', data: map);
      if (partialBooking.status == true) {
        print(partialBooking.msg);
        PrefManager.setCartId(partialBooking.id.toString());
        print(partialBooking);
        emit(PartialDataReceived(partialBooking: partialBooking));
      }
    } else {
      // db!.checkAndCreateBookingTable('bookingTable');
      OfflineBooking offlineBooking =
          OfflineBooking(newListTwo: [], data: [], entranceData: []);
      print("offline");
      if (event.bookingDate != null &&
          event.slotId != null &&
          event.newList != null &&
          event.programId != null) {
        offlineBooking.startTime = event.slotDetails![0]['startTime'];
        offlineBooking.endTime = event.slotDetails![0]['endTime'];
        offlineBooking.title = event.title;
        offlineBooking.programId = event.programId;
        // offlineBooking.totalMembers = event.totalMembers;
        offlineBooking.freeCount = event.totalMembers;
        offlineBooking.members = event.newList;
        offlineBooking.bookingDate = event.bookingDate;
        offlineBooking.slotId = event.slotId;
        offlineBooking.indianCount = await getIndianCount(event.newList);
        offlineBooking.foreignerCount = await getForeignerCount(event.newList);
        offlineBooking.childrenCount = await getChildrenCount(event.newList);
        List<Map> programmList = await db!
            .getProgramData('allprogramms_seven', event.title.toString());
        await generateTotalAmount(
          programmList,
          offlineBooking.indianCount,
          offlineBooking.foreignerCount,
          offlineBooking.childrenCount,
          offlineBooking,
          offlineBooking.entranceCharge,
          event.vehicleInfo,
          event.freeCount,
        );

        emit(PartialDataReceived(offlineBooking: offlineBooking));
      } else {
        Fluttertoast.showToast(msg: "some data missing");
      }
    }
  }

  Future<FutureOr<void>> _getPartialBookingSummary(
      GetPartialBookingSummary event, Emitter<BookingState> emit) async {
    BookingSummaryAll bookingSummaryAll;
    VehicleModel vehicleModel;

    if (!event.isOffline!) {
      String cartId = await PrefManager.getCartId();
      print("CartId - " + cartId.toString());
      var url = '/entrypointcart/get?id=' + cartId + "&type=Counter";
      bookingSummaryAll =
          await AuthRepository().getPartialBookingDataTwo(url: url);
      vehicleModel = await AuthRepository()
          .getVehicleInformations(url: '/static/settings/get');
      print(bookingSummaryAll.status);
      if (bookingSummaryAll.status == true) {
        emit(PartialBookingDataTwoReceived(
            vehicleModel: vehicleModel,
            cartId: cartId,
            bookingSummaryAll: bookingSummaryAll,
            isOffline: event.isOffline));
      } else {
        emit(PartialBookingDataTwoReceived(
          isOffline: event.isOffline,
          slotDetails: event.slotDetails,
          vehicleDetails: event.vehicleDetails,
        ));
      }
    } else {
      emit(PartialBookingDataTwoReceived(
        isOffline: event.isOffline,
        slotDetails: event.slotDetails,
        vehicleDetails: event.vehicleDetails,
      ));
    }
  }

  // @override
  // Stream<BookingState> mapEventToState(BookingEvent event) async* {
  //   if (event is GetBookingSummary) {
  //     print("the status ${event.isOffline}");

  //     yield GettingBookingSummary();
  //     if (event.isOffline == false) {
  //       print("inside");
  //       BookingSummary bookingSummary;
  //       var url = '/booking/getagentslots?programme=' +
  //           event.id.toString() +
  //           '&date=' +
  //           event.date.toString();
  //       bookingSummary = await AuthRepository().getBookingSummary(url: url);
  //       print(url);
  //       if (bookingSummary.status == true) {
  //         print("inside one");
  //         // print(bookingSummary.data![0].startTime);
  //         // PrefManager.setRoomCount(bookingSummary.data![0].freeCount);
  //         yield GettingBookingSummaryRecieved(
  //             summaryData: bookingSummary, offline: event.isOffline);
  //       } else {
  //         print("inside failed");
  //         yield GettingBookingSummaryFailed(summaryData: bookingSummary);
  //       }
  //     } else {
  //       yield GettingBookingSummaryRecieved(
  //         offline: event.isOffline,
  //         offlineData: event.offlineData,
  //         programList: event.programList,
  //         localSlotData: event.localSlotData,
  //       );
  //     }
  //   }

  //   if (event is DoPartialBookingOne) {
  //     yield GettingPartialData();
  //     if (event.isOffline == false) {
  //       print("online");
  //       PartialBooking partialBooking;
  //       Map map = {
  //         "programme": event.programId.toString(),
  //         "slotDetail": event.slotId.toString(),
  //         "bookingDate": event.bookingDate.toString(),
  //         "data": event.newList,
  //       };

  //       print(map);
  //       partialBooking = await AuthRepository()
  //           .getPartialBookingData(url: '/cart/addpartialagent', data: map);
  //       if (partialBooking.status == true) {
  //         print(partialBooking.msg);
  //         PrefManager.setCartId(partialBooking.id.toString());
  //         print(partialBooking);
  //         yield PartialDataReceived(partialBooking: partialBooking);
  //       }
  //     } else {
  //       // db!.checkAndCreateBookingTable('bookingTable');
  //       OfflineBooking offlineBooking =
  //           OfflineBooking(newListTwo: [], data: [], entranceData: []);
  //       print("offline");
  //       if (event.bookingDate != null &&
  //           event.slotId != null &&
  //           event.newList != null &&
  //           event.programId != null) {
  //         offlineBooking.startTime = event.slotDetails![0]['startTime'];
  //         offlineBooking.endTime = event.slotDetails![0]['endTime'];
  //         offlineBooking.title = event.title;
  //         offlineBooking.programId = event.programId;
  //         // offlineBooking.totalMembers = event.totalMembers;
  //         offlineBooking.freeCount = event.totalMembers;
  //         offlineBooking.members = event.newList;
  //         offlineBooking.bookingDate = event.bookingDate;
  //         offlineBooking.slotId = event.slotId;
  //         offlineBooking.indianCount = await getIndianCount(event.newList);
  //         offlineBooking.foreignerCount =
  //             await getForeignerCount(event.newList);
  //         offlineBooking.childrenCount = await getChildrenCount(event.newList);
  //         List<Map> programmList = await db!
  //             .getProgramData('allprogramms_seven', event.title.toString());
  //         await generateTotalAmount(
  //           programmList,
  //           offlineBooking.indianCount,
  //           offlineBooking.foreignerCount,
  //           offlineBooking.childrenCount,
  //           offlineBooking,
  //           offlineBooking.entranceCharge,
  //           event.vehicleInfo,
  //           event.freeCount,
  //         );
  //         // print(
  //         //     "indian count ${offlineBooking.indianCount} && f count ${offlineBooking.foreignerCount} && chi count ${offlineBooking.childrenCount}");
  //         // await generateCalculation(
  //         //     event.programId, event.bookingDate, event.slotId);

  //         yield PartialDataReceived(offlineBooking: offlineBooking);
  //       } else {
  //         Fluttertoast.showToast(msg: "some data missing");
  //       }
  //     }
  //   }

  //   if (event is GetPartialBookingSummary) {
  //     yield GettingPartialBookingDataTwo();

  //     // /static/settings/get
  //     if (event.isOffline == false) {
  //       BookingSummaryAll bookingSummaryAll;
  //       VehicleModel vehicleModel;

  //       String cartId = await PrefManager.getCartId();
  //       print("CartId - " + cartId.toString());
  //       var url = '/cart/get?id=' + cartId + "&type=Counter";
  //       bookingSummaryAll =
  //           await AuthRepository().getPartialBookingDataTwo(url: url);
  //       vehicleModel = await AuthRepository()
  //           .getVehicleInformations(url: '/static/settings/get');
  //       print(bookingSummaryAll.status);
  //       if (bookingSummaryAll.status == true) {
  //         yield PartialBookingDataTwoReceived(
  //             vehicleModel: vehicleModel,
  //             cartId: cartId,
  //             bookingSummaryAll: bookingSummaryAll,
  //             isOffline: event.isOffline);
  //       }
  //     } else {
  //       yield PartialBookingDataTwoReceived(
  //         isOffline: event.isOffline,
  //         slotDetails: event.slotDetails,
  //         vehicleDetails: event.vehicleDetails,
  //       );
  //     }
  //   }

  //   // if (event is SaveRoomData) {
  //   //   AddRoom addRoom;
  //   //   Map map = {
  //   //     "programme": event.programId.toString(),
  //   //     "numberOfRooms": event.numberOfRooms.toString(),
  //   //     "bookingDate": event.bookingDate.toString(),
  //   //     "slotDetail": event.slotId,
  //   //     "roomAllocation": [
  //   //       {
  //   //         "total": event.totalGuests,
  //   //         "type": [
  //   //           {
  //   //             "name": "Indian",
  //   //             "value": event.indianCount,
  //   //           },
  //   //           {
  //   //             "name": "Foreigner",
  //   //             "value": event.foreignerCount,
  //   //           },
  //   //           {
  //   //             "name": "Children",
  //   //             "value": event.childrenCount,
  //   //           },
  //   //         ]
  //   //       }
  //   //     ]
  //   //     // "data": event.newList,
  //   //   };

  //   //   // print(map);
  //   //   addRoom = await AuthRepository()
  //   //       .addRoom(url: '/cart/addpartialagent', data: map);
  //   //   print(addRoom.msg);
  //   //   if (addRoom.status == true) {
  //   //     yield RoomAdded(currentIndex: event.currentIndex);
  //   //   }
  //   // }
  //   if (event is DownloadTicket) {}
  //   // if (event is SavePersonData) {
  //   //   BookingSummaryAll bookingSummaryAll;
  //   //   VehicleModel vehicleModel;
  //   //   Map map = {
  //   //     "dob": event.dob,
  //   //     "name": event.name,
  //   //     "guestType": event.guestType,
  //   //     "cartId": event.cartId,
  //   //   };
  //   //   String cartId = await PrefManager.getCartId();
  //   //   bookingSummaryAll = await AuthRepository()
  //   //       .savePersonInformation(url: '/guest/add', data: map);
  //   //   vehicleModel = await AuthRepository()
  //   //       .getVehicleInformations(url: '/static/settings/get');
  //   //   print(bookingSummaryAll.status);
  //   //   if (bookingSummaryAll.status == true) {
  //   //     yield NewState(
  //   //         cartId: cartId,
  //   //         bookingSummaryAll: bookingSummaryAll,
  //   //         vehicleModel: vehicleModel);
  //   //   } else {
  //   //     yield PersonNotAdded(error: bookingSummaryAll.msg);
  //   //   }
  //   // }
  //   // print(event.cartId +
  //   //     " - " +
  //   //     event.dob +
  //   //     " - " +
  //   //     event.guestType +
  //   //     " - " +
  //   //     event.name);
  // }

  getIndianCount(List<Map>? newList) {
    print("the list $newList");
    int? indianCount;
    if (newList!.length != 0) {
      indianCount = newList[0]['value'];
    } else {
      indianCount = 0;
    }
    return indianCount;
  }

  getForeignerCount(List<Map>? newList) {
    int? foreignerCount;
    if (newList!.length != 0) {
      foreignerCount = newList[1]['value'];
    } else {
      foreignerCount = 0;
    }
    return foreignerCount;
  }

  getChildrenCount(List<Map>? newList) {
    int? childrenCount;
    if (newList!.length != 0) {
      childrenCount = newList[2]['value'];
    } else {
      childrenCount = 0;
    }
    return childrenCount;
  }

  generateTotalAmount(
      List<Map> programmList,
      int? indianCount,
      int? foreignerCount,
      int? childrenCount,
      OfflineBooking offlineBooking,
      int? entranceCharge,
      List<Map>? vehicleInfo,
      int? freeCount) {
    var theProgram = programmList[0]['dateType'];
    var indianTotal = 0,
        foreignerTotal = 0,
        childrenTotal = 0,
        totalEntranceCharge = 0;
    // eChargeIndian = 0,
    // eChargeForeigner = 0,
    // eChargeChildren = 0;
    print("theProgram $theProgram");
    if (theProgram == "Normal") {
      if (indianCount != 0) {
        indianTotal = (indianCount)! * (programmList[0]['pNindian'] as int);
        // eChargeIndian =
        //     (indianCount) * (vehicleInfo![0]['indianEntranceCharge'] as int);
      }
      if (foreignerCount != 0) {
        foreignerTotal =
            (foreignerCount)! * (programmList[0]['pNforeigner'] as int);
        // eChargeForeigner = (foreignerCount) *
        //     (vehicleInfo![0]['foreignerEntraneCharge'] as int);
      }
      if (childrenCount != 0) {
        childrenTotal =
            (childrenCount)! * (programmList[0]['pNchildren'] as int);
        // eChargeChildren =
        //     (childrenCount) * (vehicleInfo![0]['childrenEntraneCharge'] as int);
      }
    } else if (theProgram == "Holiday") {
      if (indianCount != 0) {
        indianTotal = (indianCount)! * (programmList[0]['pHindian'] as int);
        // eChargeIndian =
        //     (indianCount) * (vehicleInfo![0]['indianEntranceCharge'] as int);
      }
      if (foreignerCount != 0) {
        foreignerTotal =
            (foreignerCount)! * (programmList[0]['pHforeigner'] as int);
        // eChargeForeigner = (foreignerCount) *
        //     (vehicleInfo![0]['foreignerEntraneCharge'] as int);
      }
      if (childrenCount != 0) {
        childrenTotal =
            (childrenCount)! * (programmList[0]['pHchildren'] as int);
        // eChargeChildren =
        //     (childrenCount) * (vehicleInfo![0]['childrenEntraneCharge'] as int);
      }
    } else {
      if (indianCount != 0) {
        indianTotal = (indianCount)! * (programmList[0]['pEindian'] as int);
        // eChargeIndian =
        //     (indianCount) * (vehicleInfo![0]['indianEntranceCharge'] as int);
      }
      if (foreignerCount != 0) {
        foreignerTotal =
            (foreignerCount)! * (programmList[0]['pEforeigner'] as int);
        // eChargeForeigner = (foreignerCount) *
        //     (vehicleInfo![0]['foreignerEntraneCharge'] as int);
      }
      if (childrenCount != 0) {
        childrenTotal =
            (childrenCount)! * (programmList[0]['pEchildren'] as int);
        // eChargeChildren =
        //     (childrenCount) * (vehicleInfo![0]['childrenEntraneCharge'] as int);
      }
    }

    offlineBooking.indianTotal = indianTotal;
    offlineBooking.foreignerTotal = foreignerTotal;
    offlineBooking.childrenTotal = childrenTotal;
    // totalEntranceCharge = eChargeIndian + eChargeForeigner + eChargeChildren;
    totalEntranceCharge = 0;
    offlineBooking.entranceCharge = 0;
    // offlineBooking.entranceCharge =
    //     eChargeIndian + eChargeForeigner + eChargeChildren;

    // offlineBooking.totalMembers = ((indianCount as int) +
    //     (foreignerCount as int) +
    //     (childrenCount as int));
    // print("total members ${offlineBooking.totalMembers}");

    offlineBooking.totalAmount =
        (indianTotal + foreignerTotal + childrenTotal) + (totalEntranceCharge);

    // return (indianTotal + foreignerTotal + childrenTotal);
  }
}
