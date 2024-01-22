import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class CommonAttendanceUploadBloc
    extends Bloc<EventCommonAttendanceUpload, StateCommonAttendanceUpload> {
  CommonAttendanceUploadBloc() : super(StateCommonAttendanceUpload()) {
    on<GetCommonAttendanceUploadData>(_getCommonAttendanceUploadData);
  }
/////
  Future<FutureOr<void>> _getCommonAttendanceUploadData(GetCommonAttendanceUploadData event,
      Emitter<StateCommonAttendanceUpload> emit) async {
    emit(CommonAttendanceUploadFetching());

    List items6 = await getAllEmployeeListdata();
    List items9 = await getAllMarkedAttendancedata();
   

    emit(CommonAttendanceUploading(
      items6: items6,
      items9: items9,
   
    ));
  }
}

class EventCommonAttendanceUpload {}

class GetCommonAttendanceUploadData extends EventCommonAttendanceUpload {}

class StateCommonAttendanceUpload {}

class CommonAttendanceUploadFetching extends StateCommonAttendanceUpload {}

class CommonAttendanceUploading extends StateCommonAttendanceUpload {
  final List? items6;
  final List? items9;

  CommonAttendanceUploading({this.items6, this.items9});
}
