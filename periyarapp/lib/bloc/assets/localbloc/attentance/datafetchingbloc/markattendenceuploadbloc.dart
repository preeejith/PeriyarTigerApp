import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class AttendanceUploadBloc
    extends Bloc<EventAttendanceUpload, StateAttendanceUpload> {
  AttendanceUploadBloc() : super(StateAttendanceUpload()) {
    on<GetAttendanceUploadData>(_getAttendanceUploadData);
  }
///////////
  Future<FutureOr<void>> _getAttendanceUploadData(GetAttendanceUploadData event,
      Emitter<StateAttendanceUpload> emit) async {
    emit(AttendanceUploadFetching());

    List items6 = await getAllEmployeeListdata();
    List items9 = await getAllMarkedAttendancedata();

    emit(AttendanceUploading(
      items6: items6,
      items9: items9,
    ));
  }
}

class EventAttendanceUpload {}

class GetAttendanceUploadData extends EventAttendanceUpload {}

class StateAttendanceUpload {}

class AttendanceUploadFetching extends StateAttendanceUpload {}

class AttendanceUploading extends StateAttendanceUpload {
  final List? items6;
  final List? items9;

  AttendanceUploading({this.items6, this.items9});
}
