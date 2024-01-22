// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/transferstockupdationmodel.dart';


class TransferStockUpdationState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTransferStockUpdationinitial extends TransferStockUpdationState {}

class TransferStockUpdationing extends TransferStockUpdationState {}

class TransferStockUpdationsuccess extends TransferStockUpdationState {
  // final TransgferStockUpdationModel transgferStockUpdationModel;
  // TransferStockUpdationsuccess({required this.transgferStockUpdationModel});
  // @override
  // List<Object> get props => [];
}
class RefreshStock extends TransferStockUpdationState {

}
class TransferStockUpdationError extends TransferStockUpdationState {
  final String error;
  TransferStockUpdationError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

