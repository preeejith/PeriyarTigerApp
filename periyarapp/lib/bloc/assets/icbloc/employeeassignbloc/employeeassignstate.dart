// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/new/employeeassignmodel.dart';

class EmployeeAssignState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEmployeeAssigninitial extends EmployeeAssignState {}

class EmployeeAssigning extends EmployeeAssignState {}

class EmployeeAssignsuccess extends EmployeeAssignState {
  // final EmployeeassignModel employeeassignModel;
  // EmployeeAssignsuccess({required this.employeeassignModel});
  // @override
  // List<Object> get props => [];
}

class RefreshEmployAssign extends EmployeeAssignState {}

class EmployeeAssignError extends EmployeeAssignState {
  final String error;
  EmployeeAssignError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

