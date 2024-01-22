// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendancemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) =>
    AttendanceModel(
      date: json['date'] as String?,
      attendance: (json['attendance'] as List<dynamic>?)
          ?.map((e) => AttendanceMarkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'attendance': instance.attendance,
    };
