// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/assetsdetailedview.dart';

class ViewAssetDetailedsState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewAssetDetailedsinitial extends ViewAssetDetailedsState {}

class AssetsView extends ViewAssetDetailedsState {}

class ViewAssetDetailedssuccess extends ViewAssetDetailedsState {
  final AssetsDetailedViewModel assetsDetailedViewModel;
  ViewAssetDetailedssuccess({required this.assetsDetailedViewModel});
  @override
  List<Object> get props => [];
}

class ViewAssetError extends ViewAssetDetailedsState {
  final String error;
  ViewAssetError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

