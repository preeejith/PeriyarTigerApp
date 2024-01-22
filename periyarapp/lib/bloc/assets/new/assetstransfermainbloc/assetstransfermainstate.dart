// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';


import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/assetstransfermainmodel.dart';




class AssetsTransferMainState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAssetsTransferMaininitial extends AssetsTransferMainState {}

class AssetsTransferMaining extends AssetsTransferMainState {}

class AssetsTransferMainsuccess extends AssetsTransferMainState {
  //   final AssetsTrasnferMainModel assetsTrasnferMainModel;
  // AssetsTransferMainsuccess({required this.assetsTrasnferMainModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends AssetsTransferMainState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

