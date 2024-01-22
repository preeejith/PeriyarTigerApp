import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class ProgramsEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetPrograms extends ProgramsEvent {
  final bool? isOffline;
  final String? date;
  GetPrograms({required this.isOffline, this.date});
}

class GetBookingData extends ProgramsEvent {
  final bool? showToast;
  GetBookingData({required this.showToast});
}

class CheckAndGetTicket extends ProgramsEvent {}

class HomePageDataNotAvailabale extends ProgramsEvent {}

class GetPreviousBookings extends ProgramsEvent {}

class GetProgramDetails extends ProgramsEvent {
  final List<Map>? offlineData;
  final bool? isOffline;
  final String? id;
  GetProgramDetails({required this.id, this.isOffline, this.offlineData});
}

class InitialGetBookingData extends ProgramsEvent {
  final String bookingId;
  InitialGetBookingData({required this.bookingId});
  @override
  List<Object?> get props => throw UnimplementedError();
}

class InitialGetBookingDataQr extends ProgramsEvent {
  final String qrId;
  InitialGetBookingDataQr({required this.qrId});
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DoLogout extends ProgramsEvent {
  final BuildContext? context;
  DoLogout({this.context});
}

class InitialGetBookingDataFromBooking extends ProgramsEvent {
  final String? qrId;
  final OfflineBooking? offlineBooking;
  final bool? isOffline;
  final DatabaseHelper? databaseHelper;
  InitialGetBookingDataFromBooking({
    required this.qrId,
    this.isOffline,
    this.databaseHelper,
    this.offlineBooking,
  });
}

class NoInternet extends ProgramsEvent {}
