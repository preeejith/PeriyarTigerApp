import 'package:equatable/equatable.dart';

class EntranceTicketBookingState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class EntranceTicketBookingInitial extends EntranceTicketBookingState {}

class EntranceChargeAdded extends EntranceTicketBookingState {
  final bool? value;
  final int? newEntrance;
  EntranceChargeAdded({this.value, this.newEntrance});
}

class EntranceChargeRemoved extends EntranceTicketBookingState {
  final bool? value;
  final int? newEntrance;
  EntranceChargeRemoved({this.value, this.newEntrance});
}

class RefreshState extends EntranceTicketBookingState {}
