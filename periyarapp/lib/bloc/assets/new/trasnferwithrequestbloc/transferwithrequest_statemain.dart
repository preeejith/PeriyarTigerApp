// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/transferwithrequestmodel.dart';

class TransferwithRequestState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTransferwithRequestinitial extends TransferwithRequestState {}

class TransferwithRequesting extends TransferwithRequestState {}

class TransferwithRequestsuccess extends TransferwithRequestState {
  // final TransferWithRequestMainModel transferWithRequestMainModel;
  // TransferwithRequestsuccess({required this.transferWithRequestMainModel});
  // @override
  // List<Object> get props => [];
}

class RefreshTransfer extends TransferwithRequestState {}

class TransferwithRequestError extends TransferwithRequestState {
  final String error;
  TransferwithRequestError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

