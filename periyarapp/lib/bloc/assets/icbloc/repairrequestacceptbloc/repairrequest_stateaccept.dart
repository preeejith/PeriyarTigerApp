// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/new/repairrequestacceptmodel.dart';




class RepairRequestAcceptState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRepairRequestAcceptinitial extends RepairRequestAcceptState {}

class RepairRequestAccepting extends RepairRequestAcceptState {}

class RepairRequestAcceptsuccess extends RepairRequestAcceptState {
    final RepairRequestAcceptModel repairRequestAcceptModel;
  RepairRequestAcceptsuccess({required this.repairRequestAcceptModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends RepairRequestAcceptState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

