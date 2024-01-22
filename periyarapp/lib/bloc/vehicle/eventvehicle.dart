import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/bookingsummaryall.dart';
import 'package:parambikulam/data/models/vehicleadded.dart';
import 'package:parambikulam/data/models/vehiclemodifieddata.dart';

class StateVehicle extends Equatable {
  @override
  List<Object?> get props => [];
}

class VehicleInitial extends StateVehicle {}

class VehicleAddedSuccess extends StateVehicle {
  final VehicleAdded? vehicleAdded;
  final BookingSummaryAll? bookingSummaryAll;
  final int? index;
  VehicleAddedSuccess({this.vehicleAdded, this.index, this.bookingSummaryAll});
}

class VehicleUpdatedSuccess extends StateVehicle {
  final bool? isOffline;
  final VehicleModified? vehicleModified;
  final BookingSummaryAll? bookingSummaryAll;
  final int? index;
  VehicleUpdatedSuccess(
      {this.vehicleModified,
      this.isOffline,
      this.index,
      this.bookingSummaryAll});
}

class VehicleRemovededSuccess extends StateVehicle {
  final bool? isOffline;
  final VehicleModified? vehicleModified;
  final BookingSummaryAll? bookingSummaryAll;
  final int? index;
  VehicleRemovededSuccess(
      {this.vehicleModified,
      this.index,
      this.isOffline,
      this.bookingSummaryAll});
}

class RefreshState extends StateVehicle {}
