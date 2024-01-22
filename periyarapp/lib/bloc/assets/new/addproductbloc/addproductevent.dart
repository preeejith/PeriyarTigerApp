import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/ic_main/addproductmain.dart';

class AddProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddProduct extends AddProductEvent {}

class BackEvent extends AddProductEvent {}


class GetAddProduct extends AddProductEvent {
  final ProductsModel productsModel;

  GetAddProduct({required this.productsModel});
  @override
  List<Object> get props => [];
}
