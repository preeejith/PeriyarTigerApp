import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class IBReservationdatauploadBloc
    extends Bloc<EventIbReservationdataupload, StateIbReservationdataupload> {
  IBReservationdatauploadBloc() : super(StateIbReservationdataupload()) {
    on<GetIbreservationdatauploadData>(_getIbreservationdatauploadData);
  }
//
  Future<FutureOr<void>> _getIbreservationdatauploadData(
      GetIbreservationdatauploadData event,
      Emitter<StateIbReservationdataupload> emit) async {
    emit(GettingUploadData());

    List items4 = await getAllReservationdata();

    List items8 = await getAllReservationdata();
    emit(ReservationdataUploaded(
      items4: items4,
      items8: items8,
    ));
  }
}

class EventIbReservationdataupload {}

class GetIbreservationdatauploadData extends EventIbReservationdataupload {}

class StateIbReservationdataupload {}

class GettingUploadData extends StateIbReservationdataupload {}

class ReservationdataUploaded extends StateIbReservationdataupload {
  final List? items4;
  final List? items8;
  ReservationdataUploaded({this.items4, this.items8});
}
