// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/requesttransfermodel.dart';


class TransferRequestState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTransferRequestinitial extends TransferRequestState {}

class TransferRequesting extends TransferRequestState {}

class TransferRequestsuccess extends TransferRequestState {
    final RequestTransferModel requestTransferModel;
  TransferRequestsuccess({required this.requestTransferModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends TransferRequestState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

