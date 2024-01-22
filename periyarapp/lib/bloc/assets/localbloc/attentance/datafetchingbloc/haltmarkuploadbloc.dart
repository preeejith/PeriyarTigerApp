import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class HaltUploadBloc extends Bloc<EventHaltUpload, StateHaltUpload> {
  HaltUploadBloc() : super(StateHaltUpload()) {
    on<GetHaltUploadData>(_getHaltUploadData);
  }
/////
  Future<FutureOr<void>> _getHaltUploadData(
      GetHaltUploadData event, Emitter<StateHaltUpload> emit) async {
    emit(HaltUploadFetching());

    List items6 = await getAllEmployeeListdata();
    List items9 = await getAllMarkedAttendancedata();
    List items13 = await getAllHaltDetailsdata();

    emit(HaltUploading(
      items6: items6,
      items9: items9,
      items13: items13,
    ));
  }
}

class EventHaltUpload {}

class GetHaltUploadData extends EventHaltUpload {}

class StateHaltUpload {}

class HaltUploadFetching extends StateHaltUpload {}

class HaltUploading extends StateHaltUpload {
  final List? items6;
  final List? items9;
  final List? items13;
  HaltUploading({this.items6, this.items9, this.items13});
}
