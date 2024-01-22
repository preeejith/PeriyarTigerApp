// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';



import 'package:parambikulam/data/models/assetsmodel/new/removeemployeemodel.dart';

class RemoveEmployeeState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRemoveEmployeeinitial extends RemoveEmployeeState {}

class RemoveEmployeeing extends RemoveEmployeeState {}

class RemoveEmployeesuccess extends RemoveEmployeeState {
  final RemoveEmployeeModel removeEmployeeModel;
  RemoveEmployeesuccess({required this.removeEmployeeModel});
  @override
  List<Object> get props => [];
}

class RemoveEmployeeError extends RemoveEmployeeState {
  final String error;
  RemoveEmployeeError({required this.error});
  @override
  List<Object> get props => [];
}




