// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/newrequestmodel.dart';

class SendRequestState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSendRequestinitial extends SendRequestState {}

class SendRequesting extends SendRequestState {}

class SendRequestsuccess extends SendRequestState {
  final NewRequestModel newRequestModel;
  SendRequestsuccess({required this.newRequestModel});
  @override
  List<Object> get props => [];
}

class SendRequestError extends SendRequestState {
  final String error;
  SendRequestError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

