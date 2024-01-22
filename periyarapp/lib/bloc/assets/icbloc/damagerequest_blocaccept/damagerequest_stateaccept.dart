// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/new/damagerequestacceptmodel.dart';

class DamageRequestAcceptState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDamageRequestAcceptinitial extends DamageRequestAcceptState {}

class DamageRequestAccepting extends DamageRequestAcceptState {}

class DamageRequestAcceptsuccess extends DamageRequestAcceptState {
  final DamageRequestAcceptModel damageRequestAcceptModel;
  DamageRequestAcceptsuccess({required this.damageRequestAcceptModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends DamageRequestAcceptState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

