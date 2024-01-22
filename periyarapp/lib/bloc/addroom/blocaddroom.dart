import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/addroom/eventaddroom.dart';
import 'package:parambikulam/bloc/addroom/stateaddroom.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/addroom.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/booking/bookingsummary.dart';
import 'package:parambikulam/utils/pref_manager.dart';

class BlocAddRoom extends Bloc<EventAddRoom, StateAddRoom> {
  DatabaseHelper? db = DatabaseHelper.instance;
  BlocAddRoom() : super(StateAddRoom()) {
    on<AddRoomRefresh>(_addRoomRefresh);
    on<SaveRoomData>(_saveRoomData);
  }
  Future<FutureOr<void>> _addRoomRefresh(
      AddRoomRefresh event, Emitter<StateAddRoom> emit) async {
    emit(AddRoomInitial());
  }

  Future<FutureOr<void>> _saveRoomData(
      SaveRoomData event, Emitter<StateAddRoom> emit) async {
    if (event.isOffline == false) {
      AddRoom addRoom;
      Map map = {
        "programme": event.programId.toString(),
        "numberOfRooms": event.numberOfRooms.toString(),
        "bookingDate": event.bookingDate.toString(),
        "slotDetail": event.slotId,
        "roomAllocation": event.newList,
      };

      // print(map);
      addRoom = await AuthRepository()
          .addRoom(url: '/cart/addpartialagent', data: map);
      print(addRoom.msg);
      if (addRoom.status == true) {
        emit(RoomAdded());
        PrefManager.setCartId(addRoom.id.toString());
        print("RoomAdded Yielded");
      } else {
        emit(RoomNotAdded(msg: addRoom.msg));
      }
    } else {
      OfflineBooking offlineBooking =
          OfflineBooking(newListTwo: [], data: [], entranceData: []);
      List<Map> programmList = await db!
          .getProgramData('allprogramms_seven', event.title.toString());
      offlineBooking.offlineRoomList = event.offlineRoomDataList;
      offlineBooking.slotId = event.slotId;
      //*************** */
      offlineBooking.maxTotalGuests = event.maxTotalGuests;
      offlineBooking.guestPerRoom = event.guestPerRoom;
      offlineBooking.title = event.title;
      offlineBooking.programId = event.programId;
      offlineBooking.members = event.newList;
      offlineBooking.roomCount = event.newList!.length;
      // offlineBooking.totalMembers = event.totalMembers;
      print("seat count in bloc ${event.totalMembers}");
      offlineBooking.bookingDate = event.bookingDate;
      // offlineBooking.totalRooms = event.numberOfRooms;
      offlineBooking.freeCount = event.numberOfRooms;
      offlineBooking.startTime = event.slotDetails![0]['startTime'];
      offlineBooking.endTime = event.slotDetails![0]['endTime'];
      await getRoomData(offlineBooking, event.offlineRoomDataList);
      await generateEntranceCharge(offlineBooking, event.slotDetails,
          programmList, event.offlineRoomDataList, event.vehicleInfo);

      emit(RoomAdded(
          offlineBooking: offlineBooking,
          offlineRoomModel: event.offlineRoomDataList));
    }
  }

  // @override
  // Stream<StateAddRoom> mapEventToState(EventAddRoom event) async* {
  //   if (event is AddRoomRefresh) {
  //     yield AddRoomInitial();
  //   }
  //   if (event is SaveRoomData) {
  //     if (event.isOffline == false) {
  //       AddRoom addRoom;
  //       Map map = {
  //         "programme": event.programId.toString(),
  //         "numberOfRooms": event.numberOfRooms.toString(),
  //         "bookingDate": event.bookingDate.toString(),
  //         "slotDetail": event.slotId,
  //         "roomAllocation": event.newList,
  //       };

  //       // print(map);
  //       addRoom = await AuthRepository()
  //           .addRoom(url: '/cart/addpartialagent', data: map);
  //       print(addRoom.msg);
  //       if (addRoom.status == true) {
  //         yield RoomAdded();
  //         PrefManager.setCartId(addRoom.id.toString());
  //         print("RoomAdded Yielded");
  //       } else {
  //         yield RoomNotAdded(msg: addRoom.msg);
  //       }
  //     } else {
  //       OfflineBooking offlineBooking =
  //           OfflineBooking(newListTwo: [], data: [], entranceData: []);
  //       List<Map> programmList = await db!
  //           .getProgramData('allprogramms_seven', event.title.toString());
  //       offlineBooking.offlineRoomList = event.offlineRoomDataList;
  //       offlineBooking.slotId = event.slotId;
  //       //*************** */
  //       offlineBooking.maxTotalGuests = event.maxTotalGuests;
  //       offlineBooking.guestPerRoom = event.guestPerRoom;
  //       offlineBooking.title = event.title;
  //       offlineBooking.programId = event.programId;
  //       offlineBooking.members = event.newList;
  //       offlineBooking.roomCount = event.newList!.length;
  //       // offlineBooking.totalMembers = event.totalMembers;
  //       print("seat count in bloc ${event.totalMembers}");
  //       offlineBooking.bookingDate = event.bookingDate;
  //       // offlineBooking.totalRooms = event.numberOfRooms;
  //       offlineBooking.freeCount = event.numberOfRooms;
  //       offlineBooking.startTime = event.slotDetails![0]['startTime'];
  //       offlineBooking.endTime = event.slotDetails![0]['endTime'];
  //       await getRoomData(offlineBooking, event.offlineRoomDataList);
  //       await generateEntranceCharge(offlineBooking, event.slotDetails,
  //           programmList, event.offlineRoomDataList, event.vehicleInfo);

  //       yield RoomAdded(
  //           offlineBooking: offlineBooking,
  //           offlineRoomModel: event.offlineRoomDataList);
  //     }
  //   }
  // }

  getRoomData(OfflineBooking offlineBooking,
      List<OfflineRoomModel>? offlineRoomDataList) {
    var indian = 0, foreigner = 0, children = 0;
    //var count = offlineRoomDataList!.length;
    for (int i = 0; i < offlineRoomDataList!.length; i++) {
      if (offlineRoomDataList[i].indianCount != null) {
        indian =
            indian + int.parse(offlineRoomDataList[i].indianCount.toString());
      }
      if (offlineRoomDataList[i].foreignerCount != null) {
        foreigner = foreigner +
            int.parse(offlineRoomDataList[i].foreignerCount.toString());
      }
      if (offlineRoomDataList[i].childrenCount != null) {
        children = children +
            int.parse(offlineRoomDataList[i].childrenCount.toString());
      }
    }
    offlineBooking.indianCount = indian;
    offlineBooking.foreignerCount = foreigner;
    offlineBooking.childrenCount = children;
    Map countMap = {
      "indian": offlineBooking.indianCount,
      "foreigner": offlineBooking.foreignerCount,
      "children": offlineBooking.childrenCount,
    };
    // List newCountList = [];
    // newCountList.add(countMap);
    offlineBooking.data.add(countMap);
    return;
  }

  generateEntranceCharge(
      OfflineBooking offlineBooking,
      List<Map>? slotDetails,
      List<Map> programmList,
      List<OfflineRoomModel>? offlineRoomDataList,
      List<Map>? vehicleInfo) {
    var indianCharge = 0,
        foreignerCharge = 0,
        childrenCharge = 0,
        //  entranceCharge = 0,
        indianCount = 0,
        childrenCount = 0,
        foreignerCount = 0,
        reIndianCount = 0,
        reChildrenCount = 0,
        reForeignerCount = 0,
        totalMembers = 0;
    // indianEntrance = 0,
    // foreignerEntrance = 0,
    // childrenEntrance = 0;
    var theProgram = programmList[0]['dateType'];
    print("the program +$theProgram");
    print("the max ${offlineBooking.guestPerRoom.toString()}");
    print(
        "offlineBooking.indianTotal ${offlineBooking.indianTotal.toString()}");
    print(
        "offlineBooking.childrenTotal ${offlineBooking.childrenTotal.toString()}");

    if (theProgram == "Normal") {
      for (int i = 0; i < offlineRoomDataList!.length; i++) {
        //addforeigner
        if (offlineRoomDataList[i].foreignerCount != null) {
          totalMembers = totalMembers +
              int.parse(offlineRoomDataList[i].foreignerCount.toString());
          foreignerCount =
              int.parse(offlineRoomDataList[i].foreignerCount.toString());
          reForeignerCount = reForeignerCount +
              int.parse(offlineRoomDataList[i].foreignerCount.toString());
          //error
          if (offlineRoomDataList[i].indianCount != null) {
            totalMembers = totalMembers +
                int.parse(offlineRoomDataList[i].indianCount.toString());
            indianCount =
                int.parse(offlineRoomDataList[i].indianCount.toString());
            //lk
            reIndianCount = reIndianCount +
                int.parse(offlineRoomDataList[i].indianCount.toString());
          } else {
            indianCount = 0;
          }
          if (offlineRoomDataList[i].childrenCount != null) {
            totalMembers = totalMembers +
                int.parse(offlineRoomDataList[i].childrenCount.toString());
            childrenCount =
                int.parse(offlineRoomDataList[i].childrenCount.toString());
            reChildrenCount = reChildrenCount +
                int.parse(offlineRoomDataList[i].childrenCount.toString());
          } else {
            childrenCount = 0;
          }
          //foreigner
          if (offlineRoomDataList[i].roomCount! <=
              int.parse(offlineBooking.guestPerRoom.toString())) {
            // entranceCharge = (programmList[0]['pHforeigner'] as int);
            foreignerCharge =
                (foreignerCharge + (programmList[0]['pNforeigner'] as int));
            offlineBooking.foreignerTotal = foreignerCharge;
            Fluttertoast.showToast(msg: offlineBooking.indianTotal.toString());
            offlineBooking.indianTotal = offlineBooking.indianTotal! + 0;
            offlineBooking.childrenTotal = offlineBooking.childrenTotal! + 0;
          } else {
            var remainingExtra = 0;
            // offlineBooking.foreignerTotal =
            //     (programmList[0]['pNforeigner'] as int);
            // foreignerCharge = (programmList[0]['pNforeigner'] as int);
            remainingExtra = offlineRoomDataList[i].roomCount! -
                int.parse(offlineBooking.guestPerRoom.toString());

            //foreigner
            if (childrenCount > 0) {
              if (childrenCount == remainingExtra) {
                childrenCharge = childrenCharge +
                    childrenCount * (programmList[0]['pEforeigner'] as int);
                offlineBooking.childrenTotal = childrenCharge;
                offlineBooking.indianTotal = offlineBooking.indianTotal! + 0;
                remainingExtra = 0;
              } else if (childrenCount > remainingExtra) {
                var theExtraCount = 0;
                if (childrenCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = childrenCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  childrenCharge = (childrenCharge +
                      (theExtraCount * programmList[0]['pEforeigner'] as int));
                } else if (childrenCount ==
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  childrenCharge = (childrenCharge +
                      (programmList[0]['pEforeigner'] as int));
                }
                theExtraCount = childrenCount -
                    int.parse(offlineBooking.guestPerRoom.toString());
                // childrenCharge = (childrenCharge +
                //     (theExtraCount * programmList[0]['pEforeigner'] as int));
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = remainingExtra - childrenCount;
              } else {
                var newChildrenCount = remainingExtra - childrenCount;
                childrenCharge = (childrenCharge +
                    (newChildrenCount *
                        (programmList[0]['pEforeigner'] as int)));
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = remainingExtra - childrenCount;
              }
              // offlineBooking.childrenTotal = childrenCharge;
              // remainingExtra = 0;
            }
            // }

            // if (remainingExtra != 0) {
            if (indianCount > 0) {
              if (indianCount == remainingExtra) {
                indianCharge = (indianCharge +
                    indianCount * (programmList[0]['pEforeigner'] as int));
                offlineBooking.indianTotal =
                    offlineBooking.indianTotal! + indianCharge;
                // offlineBooking.indianTotal = offlineBooking.indianTotal! + 0;
                remainingExtra = 0;
              } else if (indianCount > remainingExtra) {
                var theExtraCount = 0;
                if (indianCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = indianCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  indianCharge = (indianCharge +
                      (theExtraCount * programmList[0]['pEforeigner'] as int));
                } else if (indianCount ==
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  //error
                  indianCharge =
                      (indianCharge + (programmList[0]['pEforeigner'] as int));
                }
                offlineBooking.indianTotal = indianCharge;
                remainingExtra = 0;
              } else {
                var indianAmount = remainingExtra - indianCount;
                indianCharge = (indianCharge +
                    (indianAmount * (programmList[0]['pEforeigner'] as int)));
                offlineBooking.indianTotal = indianCharge;
                remainingExtra = remainingExtra - indianCount;
              }
            }
            // }

            // if (remainingExtra != 0) {
            if (foreignerCount > 0) {
              if (foreignerCount == remainingExtra) {
                foreignerCharge = (foreignerCharge +
                    foreignerCount * (programmList[0]['pEforeigner'] as int));
                offlineBooking.foreignerTotal = foreignerCharge;
                remainingExtra = 0;
              } else if (foreignerCount > remainingExtra) {
                var theExtraCount = 0;
                if (foreignerCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = foreignerCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  foreignerCharge =
                      (theExtraCount * programmList[0]['pEforeigner'] as int) +
                          (foreignerCharge) +
                          (programmList[0]['pNforeigner'] as int);
                  offlineBooking.foreignerTotal = foreignerCharge;
                } else {
                  foreignerCharge = (foreignerCharge +
                      (programmList[0]['pNforeigner'] as int));
                  offlineBooking.foreignerTotal = foreignerCharge;
                }

                remainingExtra = 0;
              } else {
                var newForeignerCount = remainingExtra - foreignerCount;
                foreignerCharge = foreignerCharge +
                    (newForeignerCount *
                        (programmList[0]['pEforeigner'] as int));
                offlineBooking.foreignerTotal = foreignerCharge;
                remainingExtra = remainingExtra - foreignerCount;
              }
            }
            // }
          }
        }
        //addindians
        else if (offlineRoomDataList[i].indianCount != null) {
          totalMembers = totalMembers +
              int.parse(offlineRoomDataList[i].indianCount.toString());
          indianCount =
              int.parse(offlineRoomDataList[i].indianCount.toString());
          reIndianCount = reIndianCount +
              int.parse(offlineRoomDataList[i].indianCount.toString());

          if (offlineRoomDataList[i].childrenCount != null) {
            totalMembers = totalMembers +
                int.parse(offlineRoomDataList[i].childrenCount.toString());
            childrenCount =
                int.parse(offlineRoomDataList[i].childrenCount.toString());
            reChildrenCount = reChildrenCount +
                int.parse(offlineRoomDataList[i].childrenCount.toString());
          } else {
            childrenCount = 0;
          }

          if (offlineRoomDataList[i].roomCount! <=
              int.parse(offlineBooking.guestPerRoom.toString())) {
            // entranceCharge = (programmList[0]['pHforeigner'] as int);
            indianCharge =
                (indianCharge + (programmList[0]['pNindian'] as int));
            offlineBooking.indianTotal = indianCharge;
            offlineBooking.childrenTotal = offlineBooking.childrenTotal! + 0;
          } else {
            var remainingExtra = 0;
            remainingExtra = offlineRoomDataList[i].roomCount! -
                int.parse(offlineBooking.guestPerRoom.toString());
            if (childrenCount > 0) {
              if (childrenCount == remainingExtra) {
                childrenCharge = childrenCharge +
                    childrenCount * (programmList[0]['pEchildren'] as int);
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = 0;
              } else if (childrenCount > remainingExtra) {
                var theExtraCount = 0;
                if (childrenCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = childrenCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  childrenCharge = (childrenCharge +
                      (theExtraCount * programmList[0]['pEchildren'] as int));
                } else if (childrenCount ==
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  childrenCharge =
                      (childrenCharge + (programmList[0]['pEchildren'] as int));
                }
                theExtraCount = childrenCount -
                    int.parse(offlineBooking.guestPerRoom.toString());
                childrenCharge = (childrenCharge +
                    (theExtraCount * programmList[0]['pEchildren'] as int));
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = remainingExtra - childrenCount;
              } else {
                var newChildrenCount = remainingExtra - childrenCount;
                childrenCharge = (childrenCharge +
                    (newChildrenCount *
                        (programmList[0]['pEchildren'] as int)));
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = remainingExtra - childrenCount;
              }
              // offlineBooking.childrenTotal = childrenCharge;
              // remainingExtra = 0;
            }
            if (indianCount > 0) {
              if (indianCount == remainingExtra) {
                indianCharge = (indianCharge +
                    indianCount * (programmList[0]['pEindian'] as int));
                offlineBooking.indianTotal = indianCharge;
                remainingExtra = 0;
              } else if (indianCount > remainingExtra) {
                var theExtraCount = 0;
                if (indianCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = indianCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  // indianCharge = (indianCharge +
                  //     (theExtraCount * programmList[0]['pEindian'] as int));
                  indianCharge =
                      (theExtraCount * programmList[0]['pEindian'] as int) +
                          (indianCharge) +
                          (programmList[0]['pNindian'] as int);
                  offlineBooking.indianTotal = indianCharge;
                  print(indianCharge);
                } else {
                  indianCharge =
                      (indianCharge + (programmList[0]['pNindian'] as int));
                  offlineBooking.indianTotal = indianCharge;
                }
                remainingExtra = 0;
              } else {
                var newIndianAmount = remainingExtra - indianCount;
                indianCharge = (indianCharge +
                    (newIndianAmount * (programmList[0]['pEindian'] as int)));
                offlineBooking.indianTotal = indianCharge;
                remainingExtra = remainingExtra - indianCount;
              }
            }
          }
        }
        //addchildrens
        else if (offlineRoomDataList[i].childrenCount != null) {
          totalMembers = totalMembers +
              int.parse(offlineRoomDataList[i].childrenCount.toString());
          childrenCount =
              int.parse(offlineRoomDataList[i].childrenCount.toString());
          reChildrenCount = reChildrenCount +
              int.parse(offlineRoomDataList[i].childrenCount.toString());

          if (offlineRoomDataList[i].roomCount! <=
              int.parse(offlineBooking.guestPerRoom.toString())) {
            // entranceCharge = (programmList[0]['pHforeigner'] as int);
            childrenCharge =
                (childrenCharge + (programmList[0]['pNchildren'] as int));
            offlineBooking.childrenTotal = childrenCharge;
          } else {
            var remainingExtra = 0;
            remainingExtra = offlineRoomDataList[i].roomCount! -
                int.parse(offlineBooking.guestPerRoom.toString());
            if (childrenCount > 0) {
              if (childrenCount == remainingExtra) {
                childrenCharge = childrenCharge +
                    childrenCount * (programmList[0]['pEchildren'] as int);
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = 0;
              } else if (childrenCount > remainingExtra) {
                var theExtraCount = 0;
                if (childrenCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = childrenCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  // childrenCharge = (childrenCharge +
                  //     (theExtraCount * programmList[0]['pEchildren'] as int));
                  childrenCharge =
                      (theExtraCount * programmList[0]['pEchildren'] as int) +
                          (childrenCharge) +
                          (programmList[0]['pNchildren'] as int);
                  offlineBooking.childrenTotal = childrenCharge;
                } else {
                  childrenCharge =
                      (childrenCharge + (programmList[0]['pNchildren'] as int));
                  offlineBooking.childrenTotal = childrenCharge;
                }
                remainingExtra = 0;
              } else {
                var newChildrenCharge = remainingExtra - childrenCount;
                childrenCharge = childrenCharge +
                    (newChildrenCharge *
                        (programmList[0]['pEforeigner'] as int));
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = remainingExtra - childrenCount;
              }
            }
          }
        }
      }
    }
    if (theProgram == "Holiday") {
      for (int i = 0; i < offlineRoomDataList!.length; i++) {
        //addforeigner
        if (offlineRoomDataList[i].foreignerCount != null) {
          totalMembers = totalMembers +
              int.parse(offlineRoomDataList[i].foreignerCount.toString());
          foreignerCount =
              int.parse(offlineRoomDataList[i].foreignerCount.toString());
          reForeignerCount = reForeignerCount +
              int.parse(offlineRoomDataList[i].foreignerCount.toString());
          //error
          if (offlineRoomDataList[i].indianCount != null) {
            totalMembers = totalMembers +
                int.parse(offlineRoomDataList[i].indianCount.toString());
            indianCount =
                int.parse(offlineRoomDataList[i].indianCount.toString());
            //lk
            reIndianCount = reIndianCount +
                int.parse(offlineRoomDataList[i].indianCount.toString());
          } else {
            indianCount = 0;
          }
          if (offlineRoomDataList[i].childrenCount != null) {
            totalMembers = totalMembers +
                int.parse(offlineRoomDataList[i].childrenCount.toString());
            childrenCount =
                int.parse(offlineRoomDataList[i].childrenCount.toString());
            reChildrenCount = reChildrenCount +
                int.parse(offlineRoomDataList[i].childrenCount.toString());
          } else {
            childrenCount = 0;
          }
          //foreigner
          if (offlineRoomDataList[i].roomCount! <=
              int.parse(offlineBooking.guestPerRoom.toString())) {
            // entranceCharge = (programmList[0]['pHforeigner'] as int);
            foreignerCharge =
                (foreignerCharge + (programmList[0]['pHforeigner'] as int));
            offlineBooking.foreignerTotal = foreignerCharge;
            Fluttertoast.showToast(msg: offlineBooking.indianTotal.toString());
            offlineBooking.indianTotal = offlineBooking.indianTotal! + 0;
            offlineBooking.childrenTotal = offlineBooking.childrenTotal! + 0;
          } else {
            var remainingExtra = 0;
            // offlineBooking.foreignerTotal =
            //     (programmList[0]['pNforeigner'] as int);
            // foreignerCharge = (programmList[0]['pNforeigner'] as int);
            remainingExtra = offlineRoomDataList[i].roomCount! -
                int.parse(offlineBooking.guestPerRoom.toString());

            // if (remainingExtra != 0) {
            //foreigner
            if (childrenCount > 0) {
              if (childrenCount == remainingExtra) {
                childrenCharge = childrenCharge +
                    childrenCount * (programmList[0]['pEforeigner'] as int);
                offlineBooking.childrenTotal = childrenCharge;
                offlineBooking.indianTotal = offlineBooking.indianTotal! + 0;
                remainingExtra = 0;
              } else if (childrenCount > remainingExtra) {
                var theExtraCount = 0;
                if (childrenCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = childrenCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  childrenCharge = (childrenCharge +
                      (theExtraCount * programmList[0]['pEforeigner'] as int));
                } else if (childrenCount ==
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  childrenCharge = (childrenCharge +
                      (programmList[0]['pEforeigner'] as int));
                }
                theExtraCount = childrenCount -
                    int.parse(offlineBooking.guestPerRoom.toString());
                childrenCharge = (childrenCharge +
                    (theExtraCount * programmList[0]['pEforeigner'] as int));
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = remainingExtra - childrenCount;
              } else {
                var newChildrenCount = remainingExtra - childrenCount;
                childrenCharge = (childrenCharge +
                    (newChildrenCount *
                        (programmList[0]['pEforeigner'] as int)));
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = remainingExtra - childrenCount;
              }
              // offlineBooking.childrenTotal = childrenCharge;
              // remainingExtra = 0;
            }
            // }

            // if (remainingExtra != 0) {
            if (indianCount > 0) {
              if (indianCount == remainingExtra) {
                indianCharge = (indianCharge +
                    indianCount * (programmList[0]['pEforeigner'] as int));
                offlineBooking.indianTotal = indianCharge;
                // offlineBooking.indianTotal = offlineBooking.indianTotal! + 0;
                remainingExtra = 0;
              } else if (indianCount > remainingExtra) {
                var theExtraCount = 0;
                if (indianCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = indianCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  indianCharge = (indianCharge +
                      (theExtraCount * programmList[0]['pEforeigner'] as int));
                } else if (indianCount ==
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  //error
                  indianCharge =
                      (indianCharge + (programmList[0]['pEforeigner'] as int));
                }
                offlineBooking.indianTotal = indianCharge;
                remainingExtra = 0;
              } else {
                var indianAmount = remainingExtra - indianCount;
                indianCharge = (indianCharge +
                    (indianAmount * (programmList[0]['pEforeigner'] as int)));
                offlineBooking.indianTotal = indianCharge;
                remainingExtra = remainingExtra - indianCount;
              }
            }
            // }

            // if (remainingExtra != 0) {
            if (foreignerCount > 0) {
              if (foreignerCount == remainingExtra) {
                foreignerCharge = (foreignerCharge +
                    foreignerCount * (programmList[0]['pEforeigner'] as int));
                offlineBooking.foreignerTotal = foreignerCharge;
                remainingExtra = 0;
              } else if (foreignerCount > remainingExtra) {
                var theExtraCount = 0;
                if (foreignerCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = foreignerCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  foreignerCharge =
                      (theExtraCount * programmList[0]['pEforeigner'] as int) +
                          (foreignerCharge) +
                          (programmList[0]['pHforeigner'] as int);
                  offlineBooking.foreignerTotal = foreignerCharge;
                } else {
                  foreignerCharge = (foreignerCharge +
                      (programmList[0]['pHforeigner'] as int));
                  offlineBooking.foreignerTotal = foreignerCharge;
                }

                remainingExtra = 0;
              } else {
                var newForeignerCount = remainingExtra - foreignerCount;
                foreignerCharge = foreignerCharge +
                    (newForeignerCount *
                        (programmList[0]['pEforeigner'] as int));
                offlineBooking.foreignerTotal = foreignerCharge;
                remainingExtra = remainingExtra - foreignerCount;
              }
            }
            // }
          }
        }
        //addindians
        else if (offlineRoomDataList[i].indianCount != null) {
          totalMembers = totalMembers +
              int.parse(offlineRoomDataList[i].indianCount.toString());
          indianCount =
              int.parse(offlineRoomDataList[i].indianCount.toString());
          reIndianCount = reIndianCount +
              int.parse(offlineRoomDataList[i].indianCount.toString());

          if (offlineRoomDataList[i].childrenCount != null) {
            totalMembers = totalMembers +
                int.parse(offlineRoomDataList[i].childrenCount.toString());
            childrenCount =
                int.parse(offlineRoomDataList[i].childrenCount.toString());
            reChildrenCount = reChildrenCount +
                int.parse(offlineRoomDataList[i].childrenCount.toString());
          } else {
            childrenCount = 0;
          }

          if (offlineRoomDataList[i].roomCount! <=
              int.parse(offlineBooking.guestPerRoom.toString())) {
            // entranceCharge = (programmList[0]['pHforeigner'] as int);
            indianCharge =
                (indianCharge + (programmList[0]['pHindian'] as int));
            offlineBooking.indianTotal = indianCharge;
            offlineBooking.childrenTotal = 0;
          } else {
            var remainingExtra = 0;
            remainingExtra = offlineRoomDataList[i].roomCount! -
                int.parse(offlineBooking.guestPerRoom.toString());
            if (childrenCount > 0) {
              if (childrenCount == remainingExtra) {
                childrenCharge = childrenCharge +
                    childrenCount * (programmList[0]['pEchildren'] as int);
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = 0;
              } else if (childrenCount > remainingExtra) {
                var theExtraCount = 0;
                if (childrenCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = childrenCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  childrenCharge = (childrenCharge +
                      (theExtraCount * programmList[0]['pEchildren'] as int));
                } else if (childrenCount ==
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  childrenCharge =
                      (childrenCharge + (programmList[0]['pEchildren'] as int));
                }
                theExtraCount = childrenCount -
                    int.parse(offlineBooking.guestPerRoom.toString());
                childrenCharge = (childrenCharge +
                    (theExtraCount * programmList[0]['pEchildren'] as int));
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = remainingExtra - childrenCount;
              } else {
                var newChildrenCount = remainingExtra - childrenCount;
                childrenCharge = (childrenCharge +
                    (newChildrenCount *
                        (programmList[0]['pEchildren'] as int)));
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = remainingExtra - childrenCount;
              }
              // offlineBooking.childrenTotal = childrenCharge;
              // remainingExtra = 0;
            }
            if (indianCount > 0) {
              if (indianCount == remainingExtra) {
                indianCharge = (indianCharge +
                    indianCount * (programmList[0]['pEindian'] as int));
                offlineBooking.indianTotal = indianCharge;
                remainingExtra = 0;
              } else if (indianCount > remainingExtra) {
                var theExtraCount = 0;
                if (indianCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = indianCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  // indianCharge = (indianCharge +
                  //     (theExtraCount * programmList[0]['pEindian'] as int));
                  indianCharge =
                      (theExtraCount * programmList[0]['pEindian'] as int) +
                          (indianCharge) +
                          (programmList[0]['pHindian'] as int);
                  offlineBooking.indianTotal = indianCharge;
                  print(indianCharge);
                } else {
                  indianCharge =
                      (indianCharge + (programmList[0]['pHindian'] as int));
                  offlineBooking.indianTotal = indianCharge;
                }
                remainingExtra = 0;
              } else {
                var newIndianAmount = remainingExtra - indianCount;
                indianCharge = (indianCharge +
                    (newIndianAmount * (programmList[0]['pEindian'] as int)));
                offlineBooking.indianTotal = indianCharge;
                remainingExtra = remainingExtra - indianCount;
              }
            }
          }
        }
        //addchildrens
        else if (offlineRoomDataList[i].childrenCount != null) {
          totalMembers = totalMembers +
              int.parse(offlineRoomDataList[i].childrenCount.toString());
          childrenCount =
              int.parse(offlineRoomDataList[i].childrenCount.toString());
          reChildrenCount = reChildrenCount +
              int.parse(offlineRoomDataList[i].childrenCount.toString());

          if (offlineRoomDataList[i].roomCount! <=
              int.parse(offlineBooking.guestPerRoom.toString())) {
            // entranceCharge = (programmList[0]['pHforeigner'] as int);
            childrenCharge =
                (childrenCharge + (programmList[0]['pHchildren'] as int));
            offlineBooking.childrenTotal = childrenCharge;
          } else {
            var remainingExtra = 0;
            remainingExtra = offlineRoomDataList[i].roomCount! -
                int.parse(offlineBooking.guestPerRoom.toString());
            if (childrenCount > 0) {
              if (childrenCount == remainingExtra) {
                childrenCharge = childrenCharge +
                    childrenCount * (programmList[0]['pEchildren'] as int);
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = 0;
              } else if (childrenCount > remainingExtra) {
                var theExtraCount = 0;
                if (childrenCount >
                    int.parse(offlineBooking.guestPerRoom.toString())) {
                  theExtraCount = childrenCount -
                      int.parse(offlineBooking.guestPerRoom.toString());
                  // childrenCharge = (childrenCharge +
                  //     (theExtraCount * programmList[0]['pEchildren'] as int));
                  childrenCharge =
                      (theExtraCount * programmList[0]['pEchildren'] as int) +
                          (childrenCharge) +
                          (programmList[0]['pHchildren'] as int);
                  offlineBooking.childrenTotal = childrenCharge;
                } else {
                  childrenCharge =
                      (childrenCharge + (programmList[0]['pHchildren'] as int));
                  offlineBooking.childrenTotal = childrenCharge;
                }
                remainingExtra = 0;
              } else {
                var newChildrenCharge = remainingExtra - childrenCount;
                childrenCharge = childrenCharge +
                    (newChildrenCharge *
                        (programmList[0]['pEforeigner'] as int));
                offlineBooking.childrenTotal = childrenCharge;
                remainingExtra = remainingExtra - childrenCount;
              }
            }
          }
        }
      }
    }
    // else if (theProgram == "Holiday") {
    //   for (int i = 0; i < offlineRoomDataList!.length; i++) {
    //     //FOREIGNER - if foreigner includes
    //     //-------------------------------------------------
    //     if (offlineRoomDataList[i].foreignerCount != null) {
    //       totalMembers = totalMembers +
    //           int.parse(offlineRoomDataList[i].foreignerCount.toString());
    //       foreignerCount =
    //           int.parse(offlineRoomDataList[i].foreignerCount.toString());
    //       if (offlineRoomDataList[i].indianCount != null) {
    //         totalMembers = totalMembers +
    //             int.parse(offlineRoomDataList[i].indianCount.toString());
    //         indianCount =
    //             int.parse(offlineRoomDataList[i].indianCount.toString());
    //       }
    //       if (offlineRoomDataList[i].childrenCount != null) {
    //         totalMembers = totalMembers +
    //             int.parse(offlineRoomDataList[i].childrenCount.toString());
    //         childrenCount =
    //             int.parse(offlineRoomDataList[i].childrenCount.toString());
    //       }

    //       if (offlineRoomDataList[i].roomCount! <=
    //           int.parse(offlineBooking.guestPerRoom.toString())) {
    //         // entranceCharge = (programmList[0]['pHforeigner'] as int);
    //         foreignerCharge = (programmList[0]['pHforeigner'] as int);
    //         offlineBooking.foreignerTotal = foreignerCharge;
    //         offlineBooking.indianTotal = 0;
    //         offlineBooking.childrenTotal = 0;
    //       } else {
    //         var remainingExtra = 0;
    //         offlineBooking.foreignerTotal =
    //             (programmList[0]['pHforeigner'] as int);
    //         foreignerCharge = (programmList[0]['pHforeigner'] as int);
    //         remainingExtra = offlineRoomDataList[i].roomCount! -
    //             int.parse(offlineBooking.guestPerRoom.toString());

    //         if (remainingExtra != 0) {
    //           if (childrenCount > 0) {
    //             if (childrenCount == remainingExtra) {
    //               childrenCharge =
    //                   childrenCount * (programmList[0]['pEforeigner'] as int);
    //               offlineBooking.childrenTotal = childrenCharge;
    //               offlineBooking.indianTotal = 0;
    //               remainingExtra = 0;
    //             } else if (childrenCount > remainingExtra) {
    //               childrenCharge = (remainingExtra *
    //                   (programmList[0]['pEforeigner'] as int));
    //               offlineBooking.childrenTotal = childrenCharge;
    //               remainingExtra = 0;
    //             } else {
    //               var childrenAmount = remainingExtra - childrenCount;
    //               childrenCharge = (childrenAmount *
    //                   (programmList[0]['pEforeigner'] as int));
    //               offlineBooking.childrenTotal = childrenCharge;
    //               remainingExtra = remainingExtra - childrenCount;
    //             }
    //           }
    //         }

    //         if (remainingExtra != 0) {
    //           if (indianCount > 0) {
    //             if (indianCount == remainingExtra) {
    //               indianCharge =
    //                   indianCount * (programmList[0]['pEforeigner'] as int);
    //               offlineBooking.indianTotal = indianCharge;
    //               remainingExtra = 0;
    //             } else if (indianCount > remainingExtra) {
    //               indianCharge = (remainingExtra *
    //                   (programmList[0]['pEforeigner'] as int));
    //               offlineBooking.indianTotal = indianCharge;
    //               remainingExtra = 0;
    //             } else {
    //               var indianAmount = remainingExtra - indianCount;
    //               indianCharge =
    //                   (indianAmount * (programmList[0]['pEforeigner'] as int));
    //               offlineBooking.indianTotal = indianCharge;
    //               remainingExtra = remainingExtra - indianCount;
    //             }
    //           }
    //         }

    //         if (remainingExtra != 0) {
    //           if (foreignerCount > 0) {
    //             if (foreignerCount == remainingExtra) {
    //               foreignerCharge =
    //                   foreignerCount * (programmList[0]['pEforeigner'] as int);
    //               offlineBooking.foreignerTotal = foreignerCharge;
    //               remainingExtra = 0;
    //             } else if (foreignerCount > remainingExtra) {
    //               foreignerCharge = foreignerCharge +
    //                   (remainingExtra *
    //                       (programmList[0]['pEforeigner'] as int));
    //               offlineBooking.foreignerTotal = foreignerCharge;
    //               remainingExtra = 0;
    //             } else {
    //               var indianAmount = remainingExtra - foreignerCount;
    //               foreignerCharge =
    //                   (indianAmount * (programmList[0]['pEforeigner'] as int));
    //               offlineBooking.foreignerTotal = foreignerCharge;
    //               remainingExtra = remainingExtra - foreignerCount;
    //             }
    //           }
    //         }
    //       }
    //     }
    //     //INDIAN - if indian includes
    //     //-------------------------------------------------
    //     else if (offlineRoomDataList[i].indianCount != null) {
    //       print(offlineRoomDataList[i].indianCount.toString());
    //       totalMembers = totalMembers +
    //           int.parse(offlineRoomDataList[i].indianCount.toString());
    //       indianCount =
    //           int.parse(offlineRoomDataList[i].indianCount.toString());
    //       print("childrencount ${offlineRoomDataList[i].childrenCount}");
    //       if (offlineRoomDataList[i].childrenCount != null) {
    //         totalMembers = totalMembers +
    //             int.parse(offlineRoomDataList[i].childrenCount.toString());
    //         childrenCount =
    //             int.parse(offlineRoomDataList[i].childrenCount.toString());
    //       }

    //       if (offlineRoomDataList[i].roomCount! <=
    //           int.parse(offlineBooking.guestPerRoom.toString())) {
    //         print(offlineRoomDataList[i].roomCount!.toString());
    //         print(offlineBooking.guestPerRoom.toString());
    //         indianCharge = (programmList[0]['pHindian'] as int);
    //         offlineBooking.indianTotal = indianCharge;
    //         offlineBooking.childrenTotal = 0;
    //       } else {
    //         var remainingExtra = 0;
    //         offlineBooking.indianTotal = (programmList[0]['pHindian'] as int);
    //         indianCharge = (programmList[0]['pHindian'] as int);
    //         remainingExtra = offlineRoomDataList[i].roomCount! -
    //             int.parse(offlineBooking.guestPerRoom.toString());
    //         print(remainingExtra);
    //         if (remainingExtra != 0) {
    //           if (childrenCount > 0) {
    //             if (childrenCount == remainingExtra) {
    //               childrenCharge =
    //                   childrenCount * (programmList[0]['pEchildren'] as int);
    //               offlineBooking.childrenTotal = childrenCharge;
    //               remainingExtra = 0;
    //             } else if (childrenCount > remainingExtra) {
    //               childrenCharge =
    //                   (remainingExtra * (programmList[0]['pEchildren'] as int));
    //               offlineBooking.childrenTotal = childrenCharge;
    //               remainingExtra = 0;
    //             } else {
    //               var childrenAmount = remainingExtra - childrenCount;
    //               childrenCharge =
    //                   (childrenAmount * (programmList[0]['pEchildren'] as int));
    //               offlineBooking.childrenTotal = childrenCharge;
    //               remainingExtra = remainingExtra - childrenCount;
    //             }
    //           }
    //         }
    //         if (remainingExtra != 0) {
    //           if (indianCount > 0) {
    //             if (indianCount == remainingExtra) {
    //               indianCharge =
    //                   indianCount * (programmList[0]['pEchildren'] as int);
    //               offlineBooking.indianTotal = indianCharge;
    //               remainingExtra = 0;
    //             } else {
    //               indianCharge =
    //                   (remainingExtra * (programmList[0]['pEindian'] as int)) +
    //                       (programmList[0]['pHindian'] as int);
    //               offlineBooking.indianTotal = indianCharge;
    //             }
    //           }
    //         }
    //       }
    //     } else if (offlineRoomDataList[i].childrenCount != null) {
    //       //getting total members count
    //       totalMembers = totalMembers +
    //           int.parse(offlineRoomDataList[i].childrenCount.toString());
    //       childrenCount =
    //           int.parse(offlineRoomDataList[i].childrenCount.toString());

    //       if (offlineRoomDataList[i].roomCount! <=
    //           int.parse(offlineBooking.guestPerRoom.toString())) {
    //         childrenCharge = (programmList[0]['pHchildren'] as int);
    //       } else {
    //         var extraCount = offlineRoomDataList[i].roomCount! -
    //             int.parse(offlineBooking.guestPerRoom.toString());
    //         print("extraCount $extraCount");
    //         print("roomCount ${offlineRoomDataList[i].roomCount!}");
    //         print("guestPerRoom ${offlineBooking.guestPerRoom}");
    //         var extraCharge =
    //             extraCount * (programmList[0]['pEchildren'] as int);
    //         childrenCharge =
    //             extraCharge + (programmList[0]['pHchildren'] as int);

    //         offlineBooking.childrenTotal = childrenCharge;
    //       }
    //     }
    //   }
    // }

    offlineBooking.indianCount = reIndianCount;
    offlineBooking.childrenCount = reChildrenCount;
    offlineBooking.foreignerCount = reForeignerCount;

    // indianEntrance = offlineBooking.indianCount! *
    //     (vehicleInfo![0]['indianEntranceCharge'] as int);
    // foreignerEntrance = offlineBooking.foreignerCount! *
    //     (vehicleInfo[0]['foreignerEntraneCharge'] as int);
    // childrenEntrance = offlineBooking.childrenCount! *
    //     (vehicleInfo[0]['childrenEntraneCharge'] as int);

    // offlineBooking.entranceCharge =
    //     (indianEntrance + foreignerEntrance + childrenEntrance);

    print(offlineBooking.entranceCharge);
    offlineBooking.totalAmount =
        (indianCharge + foreignerCharge + childrenCharge);
    // offlineBooking.totalAmount = (offlineBooking.entranceCharge!) +
    //     (indianCharge + foreignerCharge + childrenCharge);
  }
}
