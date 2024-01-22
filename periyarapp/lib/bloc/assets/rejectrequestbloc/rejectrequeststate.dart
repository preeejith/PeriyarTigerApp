// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/requestrejectmodel.dart';

class RequestRejectState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRequestRejectinitial extends RequestRejectState {}

class Requestrejecting extends RequestRejectState {}

class RequestRejectsuccess extends RequestRejectState {
  final RequestRejectModel requestRejectModel;
  RequestRejectsuccess({required this.requestRejectModel});
  @override
  List<Object> get props => [];
}

class RequestRejectError extends RequestRejectState {
  final String error;
  RequestRejectError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

