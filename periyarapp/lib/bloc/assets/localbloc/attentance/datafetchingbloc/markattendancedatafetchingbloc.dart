import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class MarkAttendanceOfflineBloc
    extends Bloc<EventMarkAttendanceList, StateMarkAttendance> {
  MarkAttendanceOfflineBloc() : super(StateMarkAttendance()) {
    on<GetMarkAttendanceData>(_getMarkAttendanceData);
  }
/////
  Future<FutureOr<void>> _getMarkAttendanceData(
      GetMarkAttendanceData event, Emitter<StateMarkAttendance> emit) async {
    emit(AttendanceFetching());

    List items6 = await getAllEmployeeListdata();
    List items9 = await getAllMarkedAttendancedata();
    List items11 = await getAllDatedata2();
    List items12 = await getAllAttendanceDetailsdata();
    List items13 = await getAllHaltDetailsdata();
    List items15 = await getAllDatedata4();
    List items16 = await getAllHaltReport();
//
    emit(MarkingAttendance(
      items6: items6,
      items9: items9,
      items11: items11,
      items12: items12,
      items13: items13,
      items15: items15,
      items16: items16,
    ));
  }
}

class EventMarkAttendanceList {}

class GetMarkAttendanceData extends EventMarkAttendanceList {}

class StateMarkAttendance {}

class AttendanceFetching extends StateMarkAttendance {}

class MarkingAttendance extends StateMarkAttendance {
  final List? items6;
  final List? items9;
  final List? items11;
  final List? items12;
  final List? items13;
  final List? items15;
  final List? items16;
  MarkingAttendance(
      {this.items6,
      this.items9,
      this.items11,
      this.items12,
      this.items13,
      this.items15,
      this.items16});
}
