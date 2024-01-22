import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';

class EventVehicle extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddVehicle extends EventVehicle {
  final bool? isOffline;
  final String? vehicleName, bookingDate, cartId, date;
  final OfflineBooking? offlineBooking;
  final int? index, vehicleAmount;
  final List<Map>? vehicleDetailsList;
  AddVehicle({
    this.bookingDate,
    this.vehicleName,
    this.date,
    this.cartId,
    this.offlineBooking,
    this.vehicleAmount,
    this.index,
    this.vehicleDetailsList,
    this.isOffline,
  });
}

class UpdateVehicle extends EventVehicle {
  final String? vehicleName, bookingDate, id, cartId;
  final List<Map>? vehicleDetailsList;
  final OfflineBooking? offlineBooking;
  final bool? isOffline;
  final int? vehicleAmount;
  final int? index;
  UpdateVehicle(
      {this.bookingDate,
      this.vehicleDetailsList,
      this.offlineBooking,
      this.vehicleName,
      this.id,
      this.cartId,
      this.isOffline,
      this.vehicleAmount,
      this.index});
}

class RemoveVehicle extends EventVehicle {
  final OfflineBooking? offlineBooking;
  final bool? isOffline;
  final List<Map>? vehicleDetailsList;
  final String? vehicleName, bookingDate, id, cartId;
  final int? index, vehicleAmount;
  RemoveVehicle({
    this.bookingDate,
    this.vehicleName,
    this.offlineBooking,
    this.id,
    this.cartId,
    this.index,
    this.vehicleAmount,
    this.isOffline,
    this.vehicleDetailsList,
  });
}

class AddEntranceCharge extends EventVehicle{}

class RemoveEntranceCharge extends EventVehicle{}

class RefreshEvent extends EventVehicle {}
