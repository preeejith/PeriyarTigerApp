import 'package:equatable/equatable.dart';

 class ViewAllEmployeeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewAllEmployeeEvent extends ViewAllEmployeeEvent {
  final dynamic data;

  GetViewAllEmployeeEvent({this.data});
  @override
  List<Object> get props => [];
}
class FetchViewAllEmployeeEvent extends ViewAllEmployeeEvent {
  final dynamic data;

  FetchViewAllEmployeeEvent({this.data});
  @override
  List<Object> get props => [];
}

class RefreshViewAllEmployeeEvent extends ViewAllEmployeeEvent {
  final dynamic data;

  RefreshViewAllEmployeeEvent({this.data});
  @override
  List<Object> get props => [];
}