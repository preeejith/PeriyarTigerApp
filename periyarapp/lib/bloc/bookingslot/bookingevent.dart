import 'package:equatable/equatable.dart';

class BookingSlotEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class BookingSlotBlocInitial extends BookingSlotEvent {}

class AddPerson extends BookingSlotEvent {
  final int? seatCount, number;
  AddPerson({required this.seatCount, this.number});
}
