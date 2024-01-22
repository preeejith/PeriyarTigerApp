// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendancemarkmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceMarkModel _$AttendanceMarkModelFromJson(Map<String, dynamic> json) =>
    AttendanceMarkModel(
      empId: json['empId'] as String?,
      isPresent: json['isPresent'] as bool?,
      leaveType: json['leaveType'] as String?,
    );

Map<String, dynamic> _$AttendanceMarkModelToJson(
        AttendanceMarkModel instance) =>
    <String, dynamic>{
      'empId': instance.empId,
      'isPresent': instance.isPresent,
      'leaveType': instance.leaveType,
    };
