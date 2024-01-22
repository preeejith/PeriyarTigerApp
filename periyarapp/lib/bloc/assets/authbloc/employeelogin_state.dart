import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/loginsucessemployee_model.dart';

class EmployeeloginState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEmployeelogininitial extends EmployeeloginState {}

class Employeelogin extends EmployeeloginState {}

class Employeeloginsuccess extends EmployeeloginState {
  final EmployeeLoginSuccessModel employeeLoginSuccessModel;
  Employeeloginsuccess({required this.employeeLoginSuccessModel});
  @override
  List<Object> get props => [];
}

class ProductionUnitsuccess extends EmployeeloginState {
  final EmployeeLoginSuccessModel employeeLoginSuccessModel;
  ProductionUnitsuccess({required this.employeeLoginSuccessModel});
  @override
  List<Object> get props => [];
}

class IBsuccess extends EmployeeloginState {
  final EmployeeLoginSuccessModel employeeLoginSuccessModel;
  IBsuccess({required this.employeeLoginSuccessModel});
  @override
  List<Object> get props => [];
}

class Ecoshopsuccess extends EmployeeloginState {
  final EmployeeLoginSuccessModel employeeLoginSuccessModel;
  Ecoshopsuccess({required this.employeeLoginSuccessModel});
  @override
  List<Object> get props => [];
}

class Stayssuccess extends EmployeeloginState {
  final EmployeeLoginSuccessModel employeeLoginSuccessModel;
  Stayssuccess({required this.employeeLoginSuccessModel});
  @override
  List<Object> get props => [];
}

class CheckPostSuccess extends EmployeeloginState {
  final EmployeeLoginSuccessModel employeeLoginSuccessModel;
  CheckPostSuccess({required this.employeeLoginSuccessModel});
  @override
  List<Object> get props => [];
}

class ReceptionSuccess extends EmployeeloginState {
  final EmployeeLoginSuccessModel employeeLoginSuccessModel;
  ReceptionSuccess({required this.employeeLoginSuccessModel});
  @override
  List<Object> get props => [];
}

class EmployeeloginError extends EmployeeloginState {
  final String error;
  EmployeeloginError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

