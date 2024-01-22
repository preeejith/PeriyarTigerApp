/////ui Not completed
/////
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetholidaysbloc/ibgetholidaysevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetholidaysbloc/ibgetholidaysstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/getibholidaysmodel.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

///new needed
/////////
////////
class GetIBGetHolidaysBloc
    extends Bloc<IBGetHolidaysEvent, IBGetHolidaysState> {
  GetIBGetHolidaysBloc() : super(IBGetHolidaysState()) {
    on<GetIBGetHolidaysEvent>(_getIBGetHolidaysEvent);
  }

  Future<FutureOr<void>> _getIBGetHolidaysEvent(
      GetIBGetHolidaysEvent event, Emitter<IBGetHolidaysState> emit) async {
    emit(IBGetHolidays());
    GetIbHolidaysModel getIbHolidaysModel;

    getIbHolidaysModel =
        // await AuthRepository().IBGetHolidays(url: '/programme/IBgetlist');
        await AuthRepository().getibholidays(url: '/holiday/getlist');
    if (getIbHolidaysModel.status == true) {
      for (int i = 0; i < getIbHolidaysModel.data!.length; i++) {
        final hname = getIbHolidaysModel.data![i].name == null
            ? ""
            : getIbHolidaysModel.data![i].name;
        final hstatus = getIbHolidaysModel.data![i].status == null
            ? ""
            : getIbHolidaysModel.data![i].status;

        final hid = getIbHolidaysModel.data![i].id == null
            ? ""
            : getIbHolidaysModel.data![i].id;
        final addedBy = getIbHolidaysModel.data![i].addedBy == null
            ? ""
            : getIbHolidaysModel.data![i].addedBy;
        final hstart = getIbHolidaysModel.data![i].start == null
            ? ""
            : getIbHolidaysModel.data![i].start;
        final hend = getIbHolidaysModel.data![i].end == null
            ? ""
            : getIbHolidaysModel.data![i].end;

        if (hid!.isEmpty || hstart!.isEmpty) {
          return null;
        } else {
          Map data = {
            'hname': hname,
            'hstatus': hstatus,
            'hid': hid,
            'addedBy': addedBy,
            'hstart': hstart,
            'hend': hend
          };

          print(data);
          insertHolidaysdata(data);
        }
      }
      emit(IBGetHolidaysSuccess(getIbHolidaysModel: getIbHolidaysModel));
    } else {
      emit(IBGetHolidaysError());
    }
  }
}
