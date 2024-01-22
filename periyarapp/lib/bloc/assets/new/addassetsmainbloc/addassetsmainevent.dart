import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/ic_main/addassetsmain.dart';

class AddAssetsmainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAddAssetsmain extends AddAssetsmainEvent {
  final String? purchaseId;
  final String? totalAmount;


  final String? discount;
  final List<AddAssetsModel> addassetslist;

  GetAddAssetsmain(
      {this.purchaseId,
      this.totalAmount,
      this.discount,
      required this.addassetslist,
     });
  @override
  List<Object> get props => [];
}

class FetchAddAssetsmain extends AddAssetsmainEvent {
  final dynamic data;

  FetchAddAssetsmain({
    this.data,
  });
  @override
  List<Object> get props => [];
}

class RefreshAddAssetsmain extends AddAssetsmainEvent {
  final dynamic data;

  RefreshAddAssetsmain({
    this.data,
  });
  @override
  List<Object> get props => [];
}
