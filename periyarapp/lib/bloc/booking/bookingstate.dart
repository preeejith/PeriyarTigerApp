import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/bookingpartial.dart';
import 'package:parambikulam/data/models/bookingsummary.dart';
import 'package:parambikulam/data/models/bookingsummaryall.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/data/models/vehiclemodel.dart';
class BookingState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class BookingInitial extends BookingState {}

class GettingBookingSummary extends BookingState {}

class GettingBookingSummaryFailed extends BookingState {
  final BookingSummary? summaryData;
  GettingBookingSummaryFailed({required this.summaryData});
}

class GettingBookingSummaryRecieved extends BookingState {
  final BookingSummary? summaryData;
  final List<Map>? offlineData, programList;
   final List<BookingSummaryData>? localSlotData;
  final bool? offline;
  GettingBookingSummaryRecieved(
      {this.summaryData, this.programList, this.offline, this.offlineData, this.localSlotData});
}

class NewSlotState extends BookingState {
  final bool? newState;
  NewSlotState({required this.newState});
}

class PartialDataReceived extends BookingState {
  final OfflineBooking? offlineBooking;
  final PartialBooking? partialBooking;
  PartialDataReceived({this.partialBooking, this.offlineBooking});
}

class GettingPartialData extends BookingState {}

class GettingPartialBookingDataTwo extends BookingState {}

class PartialBookingDataTwoReceived extends BookingState {
  final List<Map>? slotDetails, vehicleDetails;
  final BookingSummaryAll? bookingSummaryAll;
  final VehicleModel? vehicleModel;
  final bool? isOffline;
  final String? cartId;
  PartialBookingDataTwoReceived(
      {this.bookingSummaryAll,
      this.vehicleDetails,
      required this.isOffline,
      this.vehicleModel,
      this.slotDetails,
      this.cartId});
}

// class PersonAdded extends BookingState {
//   final BookingSummaryAll? bookingSummaryAll;
//   PersonAdded({this.bookingSummaryAll});
// }

// class PersonNotAdded extends BookingState {
//   final String? error;
//   PersonNotAdded({this.error});
// }

class NewState extends BookingState {
  final BookingSummaryAll? bookingSummaryAll;
  final VehicleModel? vehicleModel;
  final String? cartId;
  NewState(
      {required this.bookingSummaryAll,
      required this.vehicleModel,
      required this.cartId});
}

class AddingVehicle extends BookingState {}
