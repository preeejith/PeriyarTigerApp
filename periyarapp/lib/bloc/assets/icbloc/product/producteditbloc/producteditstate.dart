// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';


import 'package:parambikulam/data/models/assetsmodel/new/icunitassetsviewmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/productmain/producteditmodel.dart';

class ProductMainEditState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProductMainEditinitial extends ProductMainEditState {}

class ProductMainEditing extends ProductMainEditState {}

class ProductMainEditsuccess extends ProductMainEditState {
  final 
  ProductEditModeldart productEditModeldart;
  ProductMainEditsuccess({required this.productEditModeldart});
  @override
  List<Object> get props => [];
}

class ProductMainEditError extends ProductMainEditState {
  final String error;
  ProductMainEditError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

