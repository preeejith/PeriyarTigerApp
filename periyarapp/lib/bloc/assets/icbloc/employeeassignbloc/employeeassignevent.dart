import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/ic_main/viewemployees.dart';

class EmployeeAssignEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEmployeeAssign extends EmployeeAssignEvent {
  final List<AssignEmployeeModel> assignemployeelislist;

  GetEmployeeAssign({required this.assignemployeelislist});
  @override
  List<Object> get props => [];
}

class FetchEmployeeAssign extends EmployeeAssignEvent {
  final dynamic data;

  FetchEmployeeAssign({this.data});
  @override
  List<Object> get props => [];
}
class RefreshBlocEvent extends EmployeeAssignEvent {
  final dynamic data;

  RefreshBlocEvent({this.data});
  @override
  List<Object> get props => [];
}