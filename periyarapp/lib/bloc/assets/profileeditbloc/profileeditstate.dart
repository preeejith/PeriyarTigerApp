// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/profileupdatemodel.dart';
import 'package:parambikulam/data/models/assetsmodel/viewprofilemodel.dart';

class ProfileUpdateState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProfileUpdateinitial extends ProfileUpdateState {}

class ProfileUpdateing extends ProfileUpdateState {}

class ProfileUpdatesuccess extends ProfileUpdateState {
  final ViewProfileUpdateModel viewProfileUpdateModel;
  ProfileUpdatesuccess({required this.viewProfileUpdateModel});
  @override
  List<Object> get props => [];
}

class ProfileUpdateError extends ProfileUpdateState {
  final String error;
  ProfileUpdateError({required this.error});
  @override
  List<Object> get props => [];
}


// ignore_for_file: curly_braces_in_flow_control_structures

