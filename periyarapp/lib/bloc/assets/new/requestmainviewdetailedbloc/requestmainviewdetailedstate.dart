// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/new/requestmaindetailedmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/new/search_assetsidmodel.dart';

class RequestMainDetailedState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRequestMainDetailedinitial extends RequestMainDetailedState {}

class RequestMainDetaileding extends RequestMainDetailedState {}

class RequestMainDetailedsuccess extends RequestMainDetailedState {
  final RequestMainDetailedModel requestMainDetailedModel;
  RequestMainDetailedsuccess({required this.requestMainDetailedModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends RequestMainDetailedState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

