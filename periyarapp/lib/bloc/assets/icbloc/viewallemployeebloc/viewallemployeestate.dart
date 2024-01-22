import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/new/viewallemployeemodel.dart';

class ViewAllEmployeeState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewAllEmployeeInitial extends ViewAllEmployeeState {}

class ViewingEmployee extends ViewAllEmployeeState {}

class ViewAllEmployeeSuccess extends ViewAllEmployeeState {
  final ViewAllEmployeeModel viewAllEmployeeModel;
  ViewAllEmployeeSuccess({required this.viewAllEmployeeModel});
  @override
  List<Object> get props => [];
}


class ViewAllEmployeeEmpty extends ViewAllEmployeeState {
  @override
  List<Object> get props => [];
}


class EmployeeDownloadedSucces extends ViewAllEmployeeState {}
class ViewAllEmployeeRefresh extends ViewAllEmployeeState {}

class ViewAllEmployeeError extends ViewAllEmployeeState {
  final String error;
  ViewAllEmployeeError({required this.error});
  @override
  List<Object> get props => [];
}
