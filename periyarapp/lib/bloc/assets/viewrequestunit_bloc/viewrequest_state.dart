// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/viewrequestunitmodel.dart';

class ViewRequestUnitState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewRequestUnitinitial extends ViewRequestUnitState {}

class ViewingRequest extends ViewRequestUnitState {}

class ViewRequestUnitsuccess extends ViewRequestUnitState {
  final ViewUnitsRequestModel viewUnitsRequestModel;
  ViewRequestUnitsuccess({required this.viewUnitsRequestModel});
  @override
  List<Object> get props => [];
}

class ViewRequestUnitsuccess2 extends ViewRequestUnitState {
  final ViewUnitsRequestModel viewUnitsRequestModel;
  ViewRequestUnitsuccess2({required this.viewUnitsRequestModel});
  @override
  List<Object> get props => [];
}

class Units2Error extends ViewRequestUnitState {
  final String error;
  Units2Error({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

