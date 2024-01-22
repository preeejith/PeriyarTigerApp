// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/new/iclogmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/new/icunitassetsviewmodel.dart';

class IcLogmainState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetIcLogmaininitial extends IcLogmainState {}

class IcLogmaining extends IcLogmainState {}

class IcLogmainsuccess extends IcLogmainState {
  final List items35;
  IcLogmainsuccess({required this.items35});
  @override
  List<Object> get props => [];
}

class IcLogsuccess extends IcLogmainState {
  final IcLogModel icLogModel;
  IcLogsuccess({required this.icLogModel});
  @override
  List<Object> get props => [];
}

class IcRefreshLogmainsuccess extends IcLogmainState {}

class AddLogs extends IcLogmainState {
  final IcLogModel icLogModel;

  AddLogs({required this.icLogModel});
  @override
  List<Object> get props => [];
}

class IcLogmainError extends IcLogmainState {
  final String error;
  IcLogmainError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

