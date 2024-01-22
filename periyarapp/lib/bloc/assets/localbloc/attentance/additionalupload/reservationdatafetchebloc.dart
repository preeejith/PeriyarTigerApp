import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class IBReservationdataupload2Bloc
    extends Bloc<EventIbReservationdataupload2, StateIbReservationdataupload2> {
  IBReservationdataupload2Bloc() : super(StateIbReservationdataupload2()) {
    on<GetIbreservationdataupload2Data>(_getIbreservationdataupload2Data);
  }
//
  Future<FutureOr<void>> _getIbreservationdataupload2Data(
      GetIbreservationdataupload2Data event,
      Emitter<StateIbReservationdataupload2> emit) async {
    emit(GettingUpload2Data());

    List items8 = await getAllReservationdata();
    emit(Reservationdata2Uploaded(
      items8: items8,
    ));
  }
}

class EventIbReservationdataupload2 {}

class GetIbreservationdataupload2Data extends EventIbReservationdataupload2 {}

class StateIbReservationdataupload2 {}

class GettingUpload2Data extends StateIbReservationdataupload2 {}

class Reservationdata2Uploaded extends StateIbReservationdataupload2 {
  final List? items8;
  Reservationdata2Uploaded({this.items8});
}
