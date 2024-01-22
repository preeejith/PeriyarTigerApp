import 'package:equatable/equatable.dart';

 class ViewEmployeeListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewEmployeeListEvent extends ViewEmployeeListEvent {
  final dynamic data;

  GetViewEmployeeListEvent({this.data});
  @override
  List<Object> get props => [];
}
