import 'package:equatable/equatable.dart';

class ViewAssetsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewAssetEvent extends ViewAssetsEvent {
  final String? name;
  final String? productType;
  final String? description;
  final String? quantity;
  final String? salePrice;
  final String? price;
  final String? discount;
  final String? remark;

  ViewAssetEvent(
      {this.name,
      this.productType,
      this.description,
      this.quantity,
      this.salePrice,
      this.price,
      this.discount,
      this.remark});
  @override
  List<Object> get props => [];
}
