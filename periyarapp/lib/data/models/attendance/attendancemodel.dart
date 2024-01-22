import 'package:parambikulam/data/models/attendance/attendancemarkmodel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attendancemodel.g.dart';

@JsonSerializable()
class AttendanceModel {
  String? date;
  List<AttendanceMarkModel>? attendance;

  AttendanceModel({
    this.date,
    this.attendance,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> data) =>
      _$AttendanceModelFromJson(data);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}
