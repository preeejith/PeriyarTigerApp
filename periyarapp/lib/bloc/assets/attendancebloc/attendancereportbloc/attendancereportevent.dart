import 'package:equatable/equatable.dart';

class AttendanceReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAttendanceReport extends AttendanceReportEvent {
  final String? requestId;



  GetAttendanceReport({this.requestId, });
  @override
  List<Object> get props => [];
}
