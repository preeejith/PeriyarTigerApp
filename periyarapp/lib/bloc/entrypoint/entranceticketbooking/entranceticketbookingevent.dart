import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';

class EntranceTicketBookingEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AlterEntranceCharge extends EntranceTicketBookingEvent {
  final bool? value;
  final int? entranceCharge;
  final OfflineBooking? offlineBooking;
  AlterEntranceCharge(
      {required this.entranceCharge,
      required this.offlineBooking,
      required this.value});
}

class RefreshBloc extends EntranceTicketBookingEvent {}
