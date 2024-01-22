import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class CommonHaltUploadBloc
    extends Bloc<EventCommonHaltUpload, StateCommonHaltUpload> {
  CommonHaltUploadBloc() : super(StateCommonHaltUpload()) {
    on<GetCommonHaltUploadData>(_getCommonHaltUploadData);
  }
/////
  Future<FutureOr<void>> _getCommonHaltUploadData(GetCommonHaltUploadData event,
      Emitter<StateCommonHaltUpload> emit) async {
    emit(CommonHaltUploadFetching());

    List items6 = await getAllEmployeeListdata();
    List items9 = await getAllMarkedAttendancedata();
    List items13 = await getAllHaltDetailsdata();
    List items15 = await getAllDatedata4();

    emit(CommonHaltUploading(
        items6: items6, items9: items9, items13: items13, items15: items15));
  }
}

class EventCommonHaltUpload {}

class GetCommonHaltUploadData extends EventCommonHaltUpload {}

class StateCommonHaltUpload {}

class CommonHaltUploadFetching extends StateCommonHaltUpload {}

class CommonHaltUploading extends StateCommonHaltUpload {
  final List? items6;
  final List? items9;
  final List? items13;
  final List? items15;
  CommonHaltUploading({this.items6, this.items9, this.items13, this.items15});
}
