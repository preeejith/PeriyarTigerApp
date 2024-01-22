import 'package:equatable/equatable.dart';

class ViewProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSalesDetailedEvent extends ViewProfileEvent {
  final String? salesid;
  String? count = "0";

  GetSalesDetailedEvent({this.salesid, this.count});
  @override
  List<Object> get props => [];
}

class GetViewProfileEvent extends ViewProfileEvent {
  final dynamic data;

  GetViewProfileEvent({this.data});
  @override
  List<Object> get props => [];
}

class FetchOfflineProfileData extends ViewProfileEvent {}
