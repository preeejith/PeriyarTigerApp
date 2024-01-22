// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/productmain/viewproductmaindetailedmodel.dart';

class ViewProductMainDetailedState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewProductMainDetailedinitial extends ViewProductMainDetailedState {}

class ViewProductMainDetaileding extends ViewProductMainDetailedState {}

class ViewProductMainDetailedsuccess extends ViewProductMainDetailedState {
  final ViewProductMainDetailedModel viewProductMainDetailedModel;
  ViewProductMainDetailedsuccess({required this.viewProductMainDetailedModel});
  @override
  List<Object> get props => [];
}

class ViewProductMainDetailedError extends ViewProductMainDetailedState {
  final String error;
  ViewProductMainDetailedError({required this.error});
  @override
  List<Object> get props => [];
}
