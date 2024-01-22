// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/echoshopsalesmodel.dart';



class EchoShopSaleState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEchoShopSaleinitial extends EchoShopSaleState {}

class EchoShopSaleing extends EchoShopSaleState {}

class EchoShopSalesuccess extends EchoShopSaleState {
    final EchoShopSaleModel echoShopSaleModel;
  EchoShopSalesuccess({required this.echoShopSaleModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends EchoShopSaleState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

