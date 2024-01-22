// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';

class AddProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class OneAdd extends AddProductState {}
class OneClear extends AddProductState {}

class GetAddProductinitial extends AddProductState {}

class AddProducting extends AddProductState {}

class AddProductsuccess extends AddProductState {
  final AddAssetMainModel addAssetMainModel;
  AddProductsuccess({required this.addAssetMainModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends AddProductState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

