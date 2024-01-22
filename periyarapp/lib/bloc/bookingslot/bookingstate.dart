import 'package:equatable/equatable.dart';

class BookingSlotState extends Equatable{
  @override
  List<Object?> get props => throw UnimplementedError();

}
class BookingSlotInitial extends BookingSlotState{
  // final int? seatNumber, number;
  // BookingSlotInitial({required this.seatNumber, this.number});
}

class NumberTillNow extends BookingSlotState {
  final int? seatNumber, number;
  NumberTillNow({required this.seatNumber, this.number});
}

class BookingSlotBlocStarted extends BookingSlotState {
  final int? seatNumber, number;
  BookingSlotBlocStarted({required this.seatNumber, this.number});
}