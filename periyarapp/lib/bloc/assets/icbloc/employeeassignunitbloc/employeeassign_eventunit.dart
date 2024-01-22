import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/ic_main/assignemployee/assignemployee.dart';

class EmployeeUnitAssignEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEmployeeUnitAssign extends EmployeeUnitAssignEvent {
  final String? requestId;
  final String? unittype;

  final List<String> employeelist2;
  final List<EmployeeIdModel> employeeidlist;

  GetEmployeeUnitAssign(
      {this.requestId,
      this.unittype,
      required this.employeelist2,
      required this.employeeidlist});
  @override
  List<Object> get props => [];
}

class FetchEmployeeUnitAssign extends EmployeeUnitAssignEvent {
  final dynamic data;

  FetchEmployeeUnitAssign({this.data});
  @override
  List<Object> get props => [];
}

class RefreshEmployeeUnitAssign extends EmployeeUnitAssignEvent {
  final dynamic data;

  RefreshEmployeeUnitAssign({this.data});
  @override
  List<Object> get props => [];
}
class TaskEmployeeUnitAssign extends EmployeeUnitAssignEvent {
  final dynamic data;

  TaskEmployeeUnitAssign({this.data});
  @override
  List<Object> get props => [];
}
class TaskEmployee2UnitAssign extends EmployeeUnitAssignEvent {
  final dynamic data;

  TaskEmployee2UnitAssign({this.data});
  @override
  List<Object> get props => [];
}

class DutyEmployeeassign extends EmployeeUnitAssignEvent {
  final dynamic data;

  DutyEmployeeassign({this.data});
  @override
  List<Object> get props => [];
}