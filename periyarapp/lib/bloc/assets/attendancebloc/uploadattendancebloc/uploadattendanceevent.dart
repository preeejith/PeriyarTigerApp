import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/ic_main/attendance/viewattentance.dart';

class UploadAttendance2Event extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadAttendanceEvent extends UploadAttendance2Event {
 final List<AttendanceUploadModel> attendanceuploadlist;

  UploadAttendanceEvent({
     required this.attendanceuploadlist
  });
  @override
  List<Object> get props => [];
}
