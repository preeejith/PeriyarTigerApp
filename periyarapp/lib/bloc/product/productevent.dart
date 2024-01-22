import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductEvent {
  final dynamic data;

  GetProductsEvent({this.data});
  @override
  List<Object> get props => [];
}
