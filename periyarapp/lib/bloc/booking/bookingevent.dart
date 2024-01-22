import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/bookingsummary.dart';

class BookingEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetBookingSummary extends BookingEvent {
  final String? date, id;
  final bool? isOffline;
  final List<BookingSummaryData>? localSlotData;
  final List<Map>? offlineData, programList;
  GetBookingSummary(
      {required this.date,
      this.programList,
      required this.isOffline,
     this.localSlotData,
      this.id,
      this.offlineData});
}

class SelectedTimeSlot extends BookingEvent {
  final bool? currentState;
  SelectedTimeSlot({required this.currentState});
}

// ignore: must_be_immutable
class DoPartialBookingOne extends BookingEvent {
  final bool? isOffline;
  final int? totalMembers, freeCount;
  final String? programId, slotId, bookingDate, title, startTime, endTime;
  List<Map>? newList = [], slotDetails;
  final List<Map>? vehicleInfo;

  DoPartialBookingOne(
      {required this.programId,
      this.isOffline,
      this.vehicleInfo,
      this.bookingDate,
      this.startTime,
      this.endTime,
      this.freeCount,
      this.slotId,
      this.totalMembers,
      this.slotDetails,
      this.title,
      this.newList});
}

class GetBookingSummaryPartial extends BookingEvent {}

class GetPartialBookingSummary extends BookingEvent {
  final List<Map>? slotDetails, vehicleDetails;
  final bool? isOffline;
  GetPartialBookingSummary(
      {required this.isOffline, this.slotDetails, this.vehicleDetails});
}

class DownloadTicket extends BookingEvent {}


// class SavePersonData extends BookingEvent {
//   final String dob, name, guestType, cartId;
//   SavePersonData(
//       {required this.cartId,
//       required this.dob,
//       required this.guestType,
//       required this.name});
// }
