import 'package:equatable/equatable.dart';

class ViewPurchaseOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewPurchaseOrderEvent extends ViewPurchaseOrderEvent {
  final dynamic data;

  GetViewPurchaseOrderEvent({this.data});
  @override
  List<Object> get props => [];
}



class FetchViewPurchaseOrderEvent extends ViewPurchaseOrderEvent {
  final dynamic data;

  FetchViewPurchaseOrderEvent({this.data});
  @override
  List<Object> get props => [];
}
class FetchOfflinePurchaseOrderEvent extends ViewPurchaseOrderEvent {
  final dynamic data;

  FetchOfflinePurchaseOrderEvent({this.data});
  @override
  List<Object> get props => [];
}
class RefreshOfflinePurchaseOrderEvent extends ViewPurchaseOrderEvent {
  final dynamic data;

  RefreshOfflinePurchaseOrderEvent({this.data});
  @override
  List<Object> get props => [];
}
class RefreshOfflinePurchaseOrder2Event extends ViewPurchaseOrderEvent {
  final dynamic data;

  RefreshOfflinePurchaseOrder2Event({this.data});
  @override
  List<Object> get props => [];
}