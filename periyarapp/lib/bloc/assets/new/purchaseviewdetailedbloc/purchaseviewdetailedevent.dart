import 'package:equatable/equatable.dart';

class ViewPurchaseOrderDetailedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewPurchaseOrderDetailed extends ViewPurchaseOrderDetailedEvent {
  final String? purchaseId;

  GetViewPurchaseOrderDetailed({
    this.purchaseId,
  });
  @override
  List<Object> get props => [];
}
