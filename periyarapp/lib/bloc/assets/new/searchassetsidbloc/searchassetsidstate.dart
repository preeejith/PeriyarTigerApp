// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/search_assetsidmodel.dart';

class SearchAssetsState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSearchAssetsinitial extends SearchAssetsState {}

class SearchAssetsing extends SearchAssetsState {}

class SearchAssetssuccess extends SearchAssetsState {
  final List<AssetMasterTable> assetMasterSuggestion;
  SearchAssetssuccess({required this.assetMasterSuggestion});
  @override
  List<Object> get props => [];
}

class UnitsError extends SearchAssetsState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

