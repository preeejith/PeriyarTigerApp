// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';


import 'package:parambikulam/data/models/assetsmodel/new/icunitassetsviewmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/addproductmainmodel.dart';

class AddProductMainState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAddProductMaininitial extends AddProductMainState {}

class AddProductMaining extends AddProductMainState {}

class AddProductMainsuccess extends AddProductMainState {
  // final AddProductMainModel addProductMainModel;
  // AddProductMainsuccess({required this.addProductMainModel});
  // @override
  // List<Object> get props => [];
}


class Refreshproduct extends AddProductMainState {

}
class AddProductMainError extends AddProductMainState {
  final String error;
  AddProductMainError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

