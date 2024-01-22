import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class IBReservationdeleteBloc
    extends Bloc<EventIbReservationdelete, StateIbReservationdelete> {
  IBReservationdeleteBloc() : super(StateIbReservationdelete()) {
    on<GetIbreservationdatadeleteData>(_getIbreservationdatadeleteData);
  }

  Future<FutureOr<void>> _getIbreservationdatadeleteData(
      GetIbreservationdatadeleteData event,
      Emitter<StateIbReservationdelete> emit) async {
    emit(GettingOfflineData());

    List items4 = await getAllReservationdata();

    if (items4.isNotEmpty) {
      for (int j = 0; j < items4.length; j++) {
        deletereservationdata(int.parse(items4[j]['id'].toString()));
      }
    }

    // if (items3.isNotEmpty) {
    //   for (int j = 0; j < items3.length; j++) {
    //     deleteallholidays(int.parse(items3[j]['id'].toString()));
    //   }
    // }
  }
}

class EventIbReservationdelete {}

class GetIbreservationdatadeleteData extends EventIbReservationdelete {}

class StateIbReservationdelete {}

class GettingOfflineData extends StateIbReservationdelete {}

class ReservationdataReceived extends StateIbReservationdelete {
  final List? items;
  final List? items2;
  final List? items3;
  ReservationdataReceived({this.items, this.items2, this.items3});
}
