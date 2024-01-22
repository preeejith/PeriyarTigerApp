import 'package:json_annotation/json_annotation.dart';

part 'attendancemarkmodel.g.dart';

@JsonSerializable()
class AttendanceMarkModel {
  String? empId;
  bool? isPresent;
  String? leaveType;

  AttendanceMarkModel({this.empId, this.isPresent, this.leaveType});

  factory AttendanceMarkModel.fromJson(Map<String, dynamic> data) =>
      _$AttendanceMarkModelFromJson(data);

  Map<String, dynamic> toJson() => _$AttendanceMarkModelToJson(this);
}
