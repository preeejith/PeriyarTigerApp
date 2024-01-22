import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/bloc/updateguest/eventupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/stateupdateguest.dart';
import 'package:parambikulam/data/models/removeperson.dart';

class BlocUpdateGuest extends Bloc<EventUpdateGuest, StateUpdateGuest> {
  BlocUpdateGuest() : super(StateUpdateGuest()){

 on<DoDelete>(_doDelete);
  on<RefreshStateOne>(_refreshStateOne);
 

  }


 Future<FutureOr<void>> _doDelete(
      DoDelete event, Emitter<StateUpdateGuest> emit) async {


     emit(  DeletionInitialized()  );
      print("Delete State Activated");
      print(event.personUniqueID);
      RemovePersonModel removePersonModel;
      print("Person Unique ID (Seat) - " + event.personUniqueID.toString());
      Map map = {
        "id": event.personUniqueID,
      };
      removePersonModel =
          await AuthRepository().removePerson(url: '/guest/remove', data: map);
      print("Deletion Message - " + removePersonModel.msg.toString());
      if (removePersonModel.status == true) {
        print("Guest Deleted");
        emit(  PersonDeleted(index: event.index, list: event.list) );
      } else {
        print("Guest Not Deleted");
        emit(PersonNotDeleted()  ) ;
      }
  }




   Future<FutureOr<void>> _refreshStateOne(
      RefreshStateOne event, Emitter<StateUpdateGuest> emit) async {
      emit(Refreshed()  ) ;
  }





  // @override
  // Stream<StateUpdateGuest> mapEventToState(EventUpdateGuest event) async* {
  //   if (event is DoDelete) {
  //     yield DeletionInitialized();
  //     print("Delete State Activated");
  //     print(event.personUniqueID);
  //     RemovePersonModel removePersonModel;
  //     print("Person Unique ID (Seat) - " + event.personUniqueID.toString());
  //     Map map = {
  //       "id": event.personUniqueID,
  //     };
  //     removePersonModel =
  //         await AuthRepository().removePerson(url: '/guest/remove', data: map);
  //     print("Deletion Message - " + removePersonModel.msg.toString());
  //     if (removePersonModel.status == true) {
  //       print("Guest Deleted");
  //       yield PersonDeleted(index: event.index, list: event.list);
  //     } else {
  //       print("Guest Not Deleted");
  //       yield PersonNotDeleted();
  //     }
  //   }

  //   else if (event is RefreshStateOne) {
  //     yield Refreshed();
  //   }
  // }
}
