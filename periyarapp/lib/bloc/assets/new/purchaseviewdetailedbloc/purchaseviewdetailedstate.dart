// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';


import 'package:parambikulam/data/models/assetsmodel/new/search_assetsidmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/viewpurchasedetailed.dart';

class ViewPurchaseOrderDetailedState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewPurchaseOrderDetailedinitial extends ViewPurchaseOrderDetailedState {}

class ViewPurchaseOrderDetaileding extends ViewPurchaseOrderDetailedState {}

class ViewPurchaseOrderDetailedsuccess extends ViewPurchaseOrderDetailedState {
  final ViewPurchaseDetailedModel viewPurchaseDetailedModel;
  ViewPurchaseOrderDetailedsuccess({required this.viewPurchaseDetailedModel});
  @override
  List<Object> get props => [];
}

class UnitsError extends ViewPurchaseOrderDetailedState {
  final String error;
  UnitsError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

