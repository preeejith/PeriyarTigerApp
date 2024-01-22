// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/new/employeeassignunitmodel.dart';

class EmployeeUnitAssignState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEmployeeUnitAssigninitial extends EmployeeUnitAssignState {}
class EmployeeAssignError extends EmployeeUnitAssignState {
  final String error;
  EmployeeAssignError({required this.error});
  @override
  List<Object> get props => [];
}
class EmployeeUnitAssigning extends EmployeeUnitAssignState {}

class EmployeeUnitAssignsuccess extends EmployeeUnitAssignState {
  // final EmployeeAssignUnitModel employeeAssignUnitModel;
  // EmployeeUnitAssignsuccess({required this.employeeAssignUnitModel});
  // @override
  // List<Object> get props => [];
}
class RefreshUnitAssign extends EmployeeUnitAssignState {}
class EmployeeUnitAssignError extends EmployeeUnitAssignState {
  final String error;
  EmployeeUnitAssignError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

