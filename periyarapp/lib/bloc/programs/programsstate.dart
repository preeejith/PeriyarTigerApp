import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/bookingdetails.dart';
import 'package:parambikulam/data/models/packagerate.dart';
import 'package:parambikulam/data/models/previousbooking2.dart';
import 'package:parambikulam/data/models/programmz.dart';

class ProgramsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProgramsInitial extends ProgramsState {}

class TheFinalBookingData extends ProgramsState {
  final List? list;
  TheFinalBookingData({this.list});
}

class NotFound extends ProgramsState {
  @override
  List<Object> get props => [];
}

class LoadingGetBookingData extends ProgramsState {}

class TicketNumberNotFound extends ProgramsState {}

// ignore: must_be_immutable
class LoadedBookingData extends ProgramsState {
  BookingDetails? bookingDetails;
  LoadedBookingData({required this.bookingDetails});
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ProgramDataAvailable extends ProgramsState {
  List<ProgrammData>? programData;
  ProgramDataAvailable({required this.programData});
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class HomePageDataAvailabale extends ProgramsState {
  final bool? isOffline;
  final String? token;
  Programmz? programmz;
  final PBookingData? previoousBookingData;
  HomePageDataAvailabale(
      {required this.isOffline,
      this.programmz,
      this.previoousBookingData,
      this.token});
  @override
  List<Object> get props => [];
}

class HomePageDataNotAvailabaleState extends ProgramsState {}

class PreviousBookingsDataReceived extends ProgramsState {
  final PBookingData? previoousBookingData;
  PreviousBookingsDataReceived({required this.previoousBookingData});
  @override
  List<Object> get props => [];
}

class PreviousBookingsDataNotReceived extends ProgramsState {
  final String error;
  PreviousBookingsDataNotReceived({required this.error});
  @override
  List<Object> get props => [];
}

class GettingProgramDetails extends ProgramsState {}
class IndividualProgramDetailsNotFound extends ProgramsState {}

class IndividualProgramDetails extends ProgramsState {
  final List<Map>? offlineData;
  final bool? isOffline;
  final PackageRate? packageRateData;
  IndividualProgramDetails(
      {this.packageRateData, required this.isOffline, this.offlineData});
}

class LoadingGetBookingDataToBooking extends ProgramsState {}

class LoadedBookingDataToBooking extends ProgramsState {
  final BookingDetails? bookingDetails;
  LoadedBookingDataToBooking({this.bookingDetails});
}

class BookingsDataNotReceived extends ProgramsState {
  final String error;
  BookingsDataNotReceived({required this.error});
}

class TokensCleared extends ProgramsState {}

class NoInternetStateHome extends ProgramsState {}
