import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/new/viewallemployeemodel.dart';

class ViewEmployeeListState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewEmployeeListInitial extends ViewEmployeeListState {}

class ViewingEmployeeList extends ViewEmployeeListState {}

class ViewEmployeeListSuccess extends ViewEmployeeListState {
  final ViewAllEmployeeModel viewAllEmployeeModel;
  ViewEmployeeListSuccess({required this.viewAllEmployeeModel});
  @override
  List<Object> get props => [];
}

class ViewEmployeeListEmpty extends ViewEmployeeListState {
  @override
  List<Object> get props => [];
}

class ViewEmployeeListError extends ViewEmployeeListState {
  final String error;
  ViewEmployeeListError({required this.error});
  @override
  List<Object> get props => [];
}
