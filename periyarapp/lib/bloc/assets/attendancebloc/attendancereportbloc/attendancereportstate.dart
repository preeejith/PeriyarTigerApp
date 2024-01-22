// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';


import 'package:parambikulam/data/models/attendance/attendancereportmodel.dart';

class AttendanceReportState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAttendanceReportinitial extends AttendanceReportState {}

class AttendanceReporting extends AttendanceReportState {}

class AttendanceReportsuccess extends AttendanceReportState {
  final AttendanceReportModel attendanceReportModel;
  AttendanceReportsuccess({required this.attendanceReportModel});
  @override
  List<Object> get props => [];
}

class AttendanceReportError extends AttendanceReportState {
  final String error;
  AttendanceReportError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

