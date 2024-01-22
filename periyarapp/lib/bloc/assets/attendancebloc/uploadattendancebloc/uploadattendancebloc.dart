// ignore_for_file: avoid_print
//////all ready waiting for up the server
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/uploadattendancebloc/uploadattendanceevent.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/uploadattendancebloc/uploadattendancestate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/attendance/uploadattentancemodel.dart';

///
class GetUploadAttendanceBloc
    extends Bloc<UploadAttendanceEvent, UploadAttendanceState> {
  GetUploadAttendanceBloc() : super(UploadAttendanceState()) {
    on<UploadAttendanceEvent>(_uploadAttendanceEvent);
  }

  Future<FutureOr<void>> _uploadAttendanceEvent(
      UploadAttendanceEvent event, Emitter<UploadAttendanceState> emit) async {
    emit(AssetsView());

    UploadAttendanceModel uploadAttendanceModel;

    ///
    Map map = {
      "date": event.attendanceuploadlist.length != 0
          ? event.attendanceuploadlist[0].date.toString()
          : "",
      "attandance": [
        for (int i = 0; i < event.attendanceuploadlist.length; i++)
          {
            "empId": event.attendanceuploadlist[i].empId,
            "isPresent": event.attendanceuploadlist[i].isPresent,
            "leaveType": event.attendanceuploadlist[i].leaveType,
            "remark": event.attendanceuploadlist[i].reason
          }
      ]
    };

    uploadAttendanceModel = await AuthRepository()
        .uploadattendance(url: '/mark/attandance/app', data: map);

    if (uploadAttendanceModel.status == true) {
      emit(UploadAttendancesuccess(
          uploadAttendanceModel: uploadAttendanceModel));
    } else if (uploadAttendanceModel.status == false) {
      emit(UploadAttendanceError(error: uploadAttendanceModel.msg.toString()));
    }
  }
}
