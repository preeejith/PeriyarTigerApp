// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';

class AddAssetsmainState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAddAssetsmaininitial extends AddAssetsmainState {}

class AddAssetsmaining extends AddAssetsmainState {}

class AddAssetsmainsuccess extends AddAssetsmainState {
  //   final AddAssetMainModel addAssetMainModel;
  // AddAssetsmainsuccess({required this.addAssetMainModel});
  // @override
  // List<Object> get props => [];
}

class RefreshAssests extends AddAssetsmainState {

}

class UnitsError extends AddAssetsmainState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

