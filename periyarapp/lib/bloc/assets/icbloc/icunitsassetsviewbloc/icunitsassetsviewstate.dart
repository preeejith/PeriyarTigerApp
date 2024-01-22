// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';


import 'package:parambikulam/data/models/assetsmodel/new/icunitassetsviewmodel.dart';

class IcUnitsassetsviewState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetIcUnitsassetsviewinitial extends IcUnitsassetsviewState {}

class IcUnitsassetsviewing extends IcUnitsassetsviewState {}

class IcUnitsassetsviewsuccess extends IcUnitsassetsviewState {
  final IcUnitAssetsViewModel icUnitAssetsViewModel;
  IcUnitsassetsviewsuccess({required this.icUnitAssetsViewModel});
  @override
  List<Object> get props => [];
}

class IcUnitsassetsviewError extends IcUnitsassetsviewState {
  final String error;
  IcUnitsassetsviewError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

