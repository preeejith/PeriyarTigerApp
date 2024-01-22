import 'package:equatable/equatable.dart';

class RemoveEmployeeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRemoveEmployee extends RemoveEmployeeEvent {
  final String? unitId;
  final String? empId;

  GetRemoveEmployee({
    this.unitId,
    this.empId,
  });
  @override
  List<Object> get props => [];
}

class FetchRemoveEmployee extends RemoveEmployeeEvent {
  final dynamic data;

  FetchRemoveEmployee({
    this.data,

  });
  @override
  List<Object> get props => [];
}
