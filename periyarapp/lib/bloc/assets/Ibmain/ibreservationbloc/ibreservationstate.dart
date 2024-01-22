// ignore_for_file: constant_identifier_names, unused_import

import 'dart:async';

import 'package:equatable/equatable.dart';

class IbReservationDetailedsState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetIbReservationDetailedsinitial extends IbReservationDetailedsState {}

class IbReservationing extends IbReservationDetailedsState {}

class IbReservationDetailedssuccess extends IbReservationDetailedsState {
  @override
  List<Object> get props => [];
}


class IbReservationEditssuccess extends IbReservationDetailedsState {
  @override
  List<Object> get props => [];
}

class IbReservationRemovesuccess extends IbReservationDetailedsState {
  @override
  List<Object> get props => [];
}
class IbReservationError extends IbReservationDetailedsState {
  final String error;
  IbReservationError({required this.error});
  @override
  List<Object> get props => [];
}


class IbReservationRemovelError extends IbReservationDetailedsState {
  final String error;
  IbReservationRemovelError({required this.error});
  @override
  List<Object> get props => [];
}

// ignore_for_file: curly_braces_in_flow_control_structures

