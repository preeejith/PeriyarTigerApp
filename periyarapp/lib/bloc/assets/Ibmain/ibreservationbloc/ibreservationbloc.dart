import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/ibreservationmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/reservationeditmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/reservationremovemodel.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

///for reservation edit tooo///
class GetIbReservationDetailedsBloc
    extends Bloc<IbReservationDetailedsEvent, IbReservationDetailedsState> {
  GetIbReservationDetailedsBloc() : super(IbReservationDetailedsState()) {
    on<IbReservationDetailedEvent>(_ibReservationDetailedEvent);

    on<EditIbReservationEvent>(_editIbReservationEvent);
    on<RemoveIbReservationEvent>(_removeIbReservationEvent);
  }

  Future<FutureOr<void>> _ibReservationDetailedEvent(
      IbReservationDetailedEvent event,
      Emitter<IbReservationDetailedsState> emit) async {
    emit(IbReservationing());

    IbReservationModel ibReservationModel;

    Map map = {
      "programme": event.programme,
      "slotDetail": event.slotDetail,
      "bookingDate": event.bookingDate,
      "numberOfRooms": event.numberOfRooms,
      "guestName": event.guestName,
      "numberOfAccompanyigPersons": event.numberOfAccompanyigPersons,
      "guestPhone": event.guestPhone,
      "referee": event.referee,
      "refereePhone": event.refereePhone,
      "email": event.email,
      "foodPreference": event.foodPreference,
      "numberOfVehicles": event.numberOfVehicles,
      "vehicleNumbers": event.vehicleNumbers,
      "details": event.details,
    };

    ibReservationModel = await AuthRepository()
        .ibreservation(url: '/reserve/ib/add/app', data: map);

    if (ibReservationModel.status == true) {
      emit(IbReservationDetailedssuccess());
    } else if (ibReservationModel.status == false) {
      emit(IbReservationError(error: ibReservationModel.msg.toString()));
    }
  }

  Future<FutureOr<void>> _editIbReservationEvent(EditIbReservationEvent event,
      Emitter<IbReservationDetailedsState> emit) async {
    emit(IbReservationing());

    ReservationEditModel reservationEditModel;

    List items7 = await getReservationListOnlinedata();

    if (items7.isNotEmpty) {
      for (int i = 0; i < items7.length; i++) {
        if (items7[i]['edited'] == "true" && items7[i]['added'] == "false") {
          Map map = {
            "id": items7[i]['bookingid'],
            "guestName": items7[i]['guestName'],
            "numberOfAccompanyigPersons": items7[i]['NoofCompaningPerson'],
            "guestPhone": items7[i]['guestPhone'],
            "referee": items7[i]['refered'],
            "refereePhone": items7[i]['referedPhone'],
            "email": items7[i]['email'],
            "foodPreference": items7[i]['foodprefered'],
            "numberOfVehicles": items7[i]['noofVehicles'],
            "vehicleNumbers": items7[i]['vehicleno'],
            "details": items7[i]['details']
          };

          reservationEditModel = await AuthRepository()
              .ibreservationedit(url: '/reserve/ib/edit/app', data: map);
          if (reservationEditModel.status == true) {
            emit(IbReservationEditssuccess());
          } else if (reservationEditModel.status == false) {
            emit(IbReservationEditssuccess());
          }
        }
        // print(items7[i]['edited'] == "true");
      }
    }
  }

  Future<FutureOr<void>> _removeIbReservationEvent(
      RemoveIbReservationEvent event,
      Emitter<IbReservationDetailedsState> emit) async {
    emit(IbReservationing());

    ReservationRemovelModel reservationRemovelModel;

    List items7 = await getReservationListOnlinedata();

    if (items7.isNotEmpty) {
      for (int i = 0; i < items7.length; i++) {
        if (items7[i]['removed'] == "true" && items7[i]['added'] == "false") {
          Map map = {
            "id": items7[i]['bookingid'],
          };

          reservationRemovelModel = await AuthRepository().ibreservationremove(
              url: '/booking/ib/adminreservation/remove/app', data: map);
          if (reservationRemovelModel.status == true) {
            emit(IbReservationRemovesuccess());
          } else if (reservationRemovelModel.status == false) {
            emit(IbReservationRemovelError(
                error: reservationRemovelModel.msg.toString()));
          }
        }
        // print(items7[i]['edited'] == "true");
      }
    }
  }
}
