/////ui Not completed
/////

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/ibgetreservationdatamodel.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

/////
/////
class GetIBGetReservationsBloc
    extends Bloc<IBGetReservationsEvent, IBGetReservationsState> {
  GetIBGetReservationsBloc() : super(IBGetReservationsState()) {
    on<GetIBGetReservationsEvent>(_getIBGetReservationsEvent);
  }
  Future<FutureOr<void>> _getIBGetReservationsEvent(
      GetIBGetReservationsEvent event,
      Emitter<IBGetReservationsState> emit) async {
    emit(IBGetReservations());
    IbGetReservationDataModel ibGetReservationDataModel;

    ibGetReservationDataModel = await AuthRepository()
        .getreservationdata(url: '/booking/ib/adminreservation/getlist/app');

    if (ibGetReservationDataModel.status == true) {
      getdeleteIbgetReservationlist();
      getdeleteReservationListOnlinedata();

      for (int i = 0; i < ibGetReservationDataModel.data!.length; i++) {
        final reserveno = ibGetReservationDataModel.data![i].reserved == null
            ? ""
            : ibGetReservationDataModel.data![i].reserved;

        final bookingDate =
            ibGetReservationDataModel.data![i].bookingDate == null
                ? ""
                : ibGetReservationDataModel.data![i].bookingDate;
        final slotid = ibGetReservationDataModel.data![i].slotDetail!.id == null
            ? ""
            : ibGetReservationDataModel.data![i].slotDetail!.id;
        final slotprogramid = ibGetReservationDataModel
                    .data![i].slotDetail!.slot!.programme!.id ==
                null
            ? ""
            : ibGetReservationDataModel
                .data![i].slotDetail!.slot!.programme!.id;
        final programName = ibGetReservationDataModel
                    .data![i].slotDetail!.slot!.programme!.progName ==
                null
            ? ""
            : ibGetReservationDataModel
                .data![i].slotDetail!.slot!.programme!.progName;

        if (slotid!.isEmpty || slotid.isEmpty) {
          return null;
        } else {
          Map data = {
            'reserveno': reserveno,
            'bookingDate': bookingDate,
            'slotid': slotid,
            'slotprogramid': slotprogramid,
            'programName': programName,
          };
          print(data);
          /////
          getinsertreservationdata(data);
        }
      }

      for (int j = 0; j < ibGetReservationDataModel.data!.length; j++) {
        final reservedcount =
            ibGetReservationDataModel.data![j].reserved == null
                ? ""
                : ibGetReservationDataModel.data![j].reserved;

        final status = "";

        final foodprefered =
            ibGetReservationDataModel.data![j].foodPreference == null ||
                    ibGetReservationDataModel.data![j].foodPreference!.isEmpty
                ? ""
                : ibGetReservationDataModel.data![j].foodPreference![0];

        final vehicleno =
            ibGetReservationDataModel.data![j].vehicleNumbers == null
                ? ""
                : ibGetReservationDataModel.data![j].vehicleNumbers!.length != 0
                    ? ibGetReservationDataModel.data![j].vehicleNumbers![0]
                    : "";

        final bookingid = ibGetReservationDataModel.data![j].id == null
            ? ""
            : ibGetReservationDataModel.data![j].id;

        final bookingdate =
            ibGetReservationDataModel.data![j].bookingDate == null
                ? ""
                : ibGetReservationDataModel.data![j].bookingDate;

        final slotid = ibGetReservationDataModel.data![j].slotDetail!.id == null
            ? ""
            : ibGetReservationDataModel.data![j].slotDetail!.id;
        final slotprogramid = ibGetReservationDataModel
                    .data![j].slotDetail!.slot!.programme!.id ==
                null
            ? ""
            : ibGetReservationDataModel
                .data![j].slotDetail!.slot!.programme!.id;
        final programName = ibGetReservationDataModel
                    .data![j].slotDetail!.slot!.programme!.progName ==
                null
            ? ""
            : ibGetReservationDataModel
                .data![j].slotDetail!.slot!.programme!.progName;

        final programid = ibGetReservationDataModel
                    .data![j].slotDetail!.slot!.programme!.id ==
                null
            ? ""
            : ibGetReservationDataModel
                .data![j].slotDetail!.slot!.programme!.id;

        final guestName = ibGetReservationDataModel.data![j].guestName == null
            ? ""
            : ibGetReservationDataModel.data![j].guestName;

        final noofCompaningPerson =
            ibGetReservationDataModel.data![j].numberOfAccompanyigPersons ==
                    null
                ? ""
                : ibGetReservationDataModel.data![j].numberOfAccompanyigPersons;

        final guestPhone = ibGetReservationDataModel.data![j].guestPhone == null
            ? ""
            : ibGetReservationDataModel.data![j].guestPhone;

        final refered = ibGetReservationDataModel.data![j].referee == null
            ? ""
            : ibGetReservationDataModel.data![j].referee;

        final referedPhone =
            ibGetReservationDataModel.data![j].refereePhone == null
                ? ""
                : ibGetReservationDataModel.data![j].refereePhone;

        final email = ibGetReservationDataModel.data![j].email == null
            ? ""
            : ibGetReservationDataModel.data![j].email;

        final noofVehicles =
            ibGetReservationDataModel.data![j].numberOfVehicles == null
                ? ""
                : ibGetReservationDataModel.data![j].numberOfVehicles;

        final details = ibGetReservationDataModel.data![j].details == null
            ? ""
            : ibGetReservationDataModel.data![j].details;
        final edited = "false";
        final removed = "false";

        if (slotid!.isEmpty || slotid.isEmpty) {
          return null;
        } else {
          Map data = {
            'reservedcount': reservedcount,
            'status': status,
            'foodprefered': foodprefered,
            'vehicleno': vehicleno,
            'bookingid': bookingid,
            'bookingdate': bookingdate,
            'slotid': slotid,
            'slotprogramid': slotprogramid,
            'programName': programName,
            'programid': programid,
            'guestName': guestName,
            'NoofCompaningPerson': noofCompaningPerson,
            'guestPhone': guestPhone,
            'refered': refered,
            'referedPhone': referedPhone,
            'email': email,
            'noofVehicles': noofVehicles,
            'details': details,
            'edited': edited,
            'removed': removed,
            'added':"false"
          };
          print(data);
          getonlineresevationdata(data);
        }
        ////
      }

      emit(IBGetReservationsSuccess(
          ibGetReservationDataModel: ibGetReservationDataModel));
    } else {
      emit(IBGetReservationsError());
    }
  }
}
