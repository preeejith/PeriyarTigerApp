import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/purchaseorderviewmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/viewpurchaseordermodel.dart';

class ViewPurchaseOrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewPurchaseOrderInitial extends ViewPurchaseOrderState {}

class PurchaseListing extends ViewPurchaseOrderState {}

class ViewPurchaseOrderSuccess extends ViewPurchaseOrderState {
  final ViewPurchaseListModel viewPurchaseListModel;
  ViewPurchaseOrderSuccess({required this.viewPurchaseListModel});
  @override
  List<Object> get props => [];
}

class FetchPurchaseSuccess extends ViewPurchaseOrderState {}

class ViewPurchaseOrderEmpty extends ViewPurchaseOrderState {
  @override
  List<Object> get props => [];
}

class RefreshState extends ViewPurchaseOrderState {}

class RefreshStateSucces extends ViewPurchaseOrderState {
  final List<PurchaseData> purchaseData;
  final List<PurchaseOrder> purchaseOrder;
  final List<AssetMasterTable> assetMasterTable;
  RefreshStateSucces(
      {required this.purchaseData,
      required this.purchaseOrder,
      required this.assetMasterTable});
  @override
  List<Object> get props => [];
}

class ViewPurchaseOrderError extends ViewPurchaseOrderState {
  @override
  List<Object> get props => [];
}


class RefreshStateSucces2 extends ViewPurchaseOrderState {
  @override
  List<Object> get props => [];
}