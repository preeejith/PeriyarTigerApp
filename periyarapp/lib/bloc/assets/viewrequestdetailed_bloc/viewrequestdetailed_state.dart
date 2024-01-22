// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/viewrequestdetailedmodel.dart';

class ViewRequestDetailedState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewRequestDetailedinitial extends ViewRequestDetailedState {}

class ViewingRequest extends ViewRequestDetailedState {}

class ViewRequestDetailedsuccess extends ViewRequestDetailedState {
  final UnitRequestDetailedModel unitRequestDetailedModel;
  ViewRequestDetailedsuccess({required this.unitRequestDetailedModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends ViewRequestDetailedState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

