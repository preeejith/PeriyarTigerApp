// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/assetsdetailedview.dart';
import 'package:parambikulam/data/models/attendance/uploadattentancemodel.dart';

class UploadAttendanceState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUploadAttendanceinitial extends UploadAttendanceState {}

class AssetsView extends UploadAttendanceState {}

class UploadAttendancesuccess extends UploadAttendanceState {
  final UploadAttendanceModel uploadAttendanceModel;
  UploadAttendancesuccess({required this.uploadAttendanceModel});
  @override
  List<Object> get props => [];
}

class UploadAttendanceError extends UploadAttendanceState {
  final String error;
  UploadAttendanceError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

