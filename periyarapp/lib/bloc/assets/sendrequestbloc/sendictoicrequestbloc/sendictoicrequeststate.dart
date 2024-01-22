// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/newrequestmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/ictoicrequestmodel.dart';

class SendRequestIctoIcState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSendRequestIctoIcinitial extends SendRequestIctoIcState {}

class SendRequestIctoIcing extends SendRequestIctoIcState {}

class SendRequestIctoIcsuccess extends SendRequestIctoIcState {
  final IcToIcRequestModel icToIcRequestModel;
  SendRequestIctoIcsuccess({required this.icToIcRequestModel});
  @override
  List<Object> get props => [];
}

class SendRequestIctoIcError extends SendRequestIctoIcState {
  final String error;
  SendRequestIctoIcError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

