import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/bloc/updateguest/eventroomupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/stateroomupdateguest.dart';
import 'package:parambikulam/data/models/removeperson.dart';

class BlocRoomUpdateGuest
    extends Bloc<EventRoomUpdateGuest, StateRoomUpdateGuest> {
  BlocRoomUpdateGuest() : super(StateRoomUpdateGuest()) {
    on<DoDeleteRoomGuest>(_doDeleteRoomGuest);
    on<RefreshStateOneRoom>(_refreshStateOneRoom);
  }

  Future<FutureOr<void>> _doDeleteRoomGuest(
      DoDeleteRoomGuest event, Emitter<StateRoomUpdateGuest> emit) async {
    emit(DeletionRoomInitialized());
    print("Delete State Activated In room");
    print(event.personUniqueID);
    RemovePersonModel removePersonModel;
    Map map = {
      "id": event.personUniqueID,
    };
    removePersonModel =
        await AuthRepository().removePerson(url: '/guest/remove', data: map);
    print("Deletion Message - " + removePersonModel.msg.toString());
    if (removePersonModel.status == true) {
      print("Guest Deleted");
      emit(PersonRoomDeleted(
        i: event.i,
        personUniqueID: event.personUniqueID,
        list: event.list,
        isDetailsAdded: event.isDetailsAdded,
        isEdStarted: event.isEdStarted,
      ));
    } else {
      print("Guest Not Deleted");
      emit(PersonRoomNotDeleted());
    }
  }

  Future<FutureOr<void>> _refreshStateOneRoom(
      RefreshStateOneRoom event, Emitter<StateRoomUpdateGuest> emit) async {
    emit(RefreshStateOneRoomGuest());
  }

  // @override
  // Stream<StateRoomUpdateGuest> mapEventToState(
  //     EventRoomUpdateGuest event) async* {
  //   if (event is DoDeleteRoomGuest) {
  //     // print("Type is " + event.type.toString());
  //     yield DeletionRoomInitialized();
  //     print("Delete State Activated In room");
  //     print(event.personUniqueID);
  //     RemovePersonModel removePersonModel;
  //     Map map = {
  //       "id": event.personUniqueID,
  //     };
  //     removePersonModel =
  //         await AuthRepository().removePerson(url: '/guest/remove', data: map);
  //     print("Deletion Message - " + removePersonModel.msg.toString());
  //     if (removePersonModel.status == true) {
  //       print("Guest Deleted");
  //       yield PersonRoomDeleted(
  //         i: event.i,
  //         personUniqueID: event.personUniqueID,
  //         list: event.list,
  //         isDetailsAdded: event.isDetailsAdded,
  //         isEdStarted: event.isEdStarted,
  //       );
  //     } else {
  //       print("Guest Not Deleted");
  //       yield PersonRoomNotDeleted();
  //     }
  //   }

  //   if (event is RefreshStateOneRoom) {
  //     yield RefreshStateOneRoomGuest();
  //   }
  // }
}
