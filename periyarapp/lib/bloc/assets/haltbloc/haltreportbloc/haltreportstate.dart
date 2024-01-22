// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/assetsdetailedview.dart';
import 'package:parambikulam/data/models/attendance/halt/haltreportmodel.dart';
import 'package:parambikulam/data/models/attendance/halt/haltuploadmodel.dart';
import 'package:parambikulam/data/models/attendance/uploadattentancemodel.dart';

class ReportHaltState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetReportHaltinitial extends ReportHaltState {}

class AssetsView extends ReportHaltState {}

class ReportHaltsuccess extends ReportHaltState {
  final HaltReportModel haltReportModel;
  ReportHaltsuccess({required this.haltReportModel});
  @override
  List<Object> get props => [];
}

class ReportHaltError extends ReportHaltState {
  final String error;
  ReportHaltError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

