import 'package:equatable/equatable.dart';

 class IcViewUnitsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetIcViewUnitsEvent extends IcViewUnitsEvent {
  final dynamic data;

  GetIcViewUnitsEvent({this.data});
  @override
  List<Object> get props => [];
}
class FetchIcViewUnitsEvent extends IcViewUnitsEvent {
  final dynamic data;

  FetchIcViewUnitsEvent({this.data});
  @override
  List<Object> get props => [];
}

class RefreshIcViewUnitsEvent extends IcViewUnitsEvent {
  final dynamic data;

  RefreshIcViewUnitsEvent({this.data});
  @override
  List<Object> get props => [];
}