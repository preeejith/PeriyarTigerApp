// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

class AssetsEditDetailedsState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAssetsEditDetailedsinitial extends AssetsEditDetailedsState {}

class AssetsEditing extends AssetsEditDetailedsState {}

class AssetsEditDetailedssuccess extends AssetsEditDetailedsState {
  @override
  List<Object> get props => [];
}

class AssetsEditError extends AssetsEditDetailedsState {
  final String error;
  AssetsEditError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

