// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/assetsdetailedview.dart';
import 'package:parambikulam/data/models/attendance/halt/haltuploadmodel.dart';
import 'package:parambikulam/data/models/attendance/uploadattentancemodel.dart';

class UploadHaltState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUploadHaltinitial extends UploadHaltState {}

class AssetsView extends UploadHaltState {}

class UploadHaltsuccess extends UploadHaltState {
  final HaltUploadModel haltUploadModel;
  UploadHaltsuccess({required this.haltUploadModel});
  @override
  List<Object> get props => [];
}

class UploadHaltError extends UploadHaltState {
  final String error;
  UploadHaltError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

