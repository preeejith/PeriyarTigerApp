// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/unitsdetailedviewmodel.dart';

class UnitsDetailedViewState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUnitsDetailedViewinitial extends UnitsDetailedViewState {}

class UnitsViewing extends UnitsDetailedViewState {}

class UnitsDetailedViewsuccess extends UnitsDetailedViewState {
    final UnitsDetailedViewModel unitsDetailedViewModel;
  UnitsDetailedViewsuccess({required this.unitsDetailedViewModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends UnitsDetailedViewState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

