// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';


class SyncOfflineDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSyncOfflineDatainitial extends SyncOfflineDataState {}

class SyncOfflineDataing extends SyncOfflineDataState {}
class RefreshAssests extends SyncOfflineDataState {}

class SyncOfflineDatasuccess extends SyncOfflineDataState {
  // final SyncOfflineDataMainModel SyncOfflineDataMainModel;
  // SyncOfflineDatasuccess({required this.SyncOfflineDataMainModel});
  // @override
  // List<Object> get props => [];
}

class RefreshTransfer extends SyncOfflineDataState {}

class SyncOfflineDataError extends SyncOfflineDataState {
  final String error;
  SyncOfflineDataError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

