// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/productdeletemodel.dart';



class ProductDeleteState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProductDeleteinitial extends ProductDeleteState {}

class ProductDeleteing extends ProductDeleteState {}

class ProductDeletesuccess extends ProductDeleteState {
  final Productdeletemodel productdeletemodel;
  ProductDeletesuccess({required this.productdeletemodel});
  @override
  List<Object> get props => [];
}

class ProductDeleteError extends ProductDeleteState {
  final String error;
  ProductDeleteError({required this.error});
  @override
  List<Object> get props => [];
}
