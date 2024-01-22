// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/assetswithout_requestmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/transferwithoutrequestmainmodel.dart';

class AssetsWithoutRequestState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAssetsWithoutRequestinitial extends AssetsWithoutRequestState {}

class AssetsTransfering extends AssetsWithoutRequestState {}

class AssetsWithoutRequestsuccess extends AssetsWithoutRequestState {
  // final TransferwithoutrequestmainModel transferwithoutrequestmainModel;
  // AssetsWithoutRequestsuccess({required this.transferwithoutrequestmainModel});
  // @override
  // List<Object> get props => [];
}

class RefreshAssetsRequest extends AssetsWithoutRequestState {

}

class UnitsError extends AssetsWithoutRequestState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

