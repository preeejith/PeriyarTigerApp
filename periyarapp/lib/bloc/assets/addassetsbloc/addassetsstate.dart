// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

class ViewAssetsState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewAssetsinitial extends ViewAssetsState {}

class Logginging extends ViewAssetsState {}

class ViewAssetssuccess extends ViewAssetsState {
  @override
  List<Object> get props => [];
}

class ViewAsseError extends ViewAssetsState {
  final String error;
  ViewAsseError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

