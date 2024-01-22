import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/product/productlistmodel.dart';

class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class Checking extends ProductState {}

class GetProductSuccess extends ProductState {
  final ProductListModel productListModel;
  GetProductSuccess({required this.productListModel});
  @override
  List<Object> get props => [];
}

class GetProductError extends ProductState {
  @override
  List<Object> get props => [];
}
