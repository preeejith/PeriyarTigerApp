// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/viewrequestunitmodel.dart';


class ViewRequestUnittypeState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewRequestUnittypeinitial extends ViewRequestUnittypeState {}

class ViewingRequest extends ViewRequestUnittypeState {}

class ViewRequestUnittypesuccess extends ViewRequestUnittypeState {
    final ViewUnitsRequestModel viewUnitsRequestModel;
  ViewRequestUnittypesuccess({required this.viewUnitsRequestModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends ViewRequestUnittypeState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

