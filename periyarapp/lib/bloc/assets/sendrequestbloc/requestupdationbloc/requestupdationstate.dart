// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/newrequestmodel.dart';

class RequestUpdationState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRequestUpdationinitial extends RequestUpdationState {}

class RequestUpdationing extends RequestUpdationState {}

class RequestUpdationsuccess extends RequestUpdationState {
  final NewRequestModel newRequestModel;
  RequestUpdationsuccess({required this.newRequestModel});
  @override
  List<Object> get props => [];
}

class RequestUpdationError extends RequestUpdationState {
  final String error;
  RequestUpdationError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

