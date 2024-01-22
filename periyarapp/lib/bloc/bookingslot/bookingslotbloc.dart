import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/bookingslot/bookingevent.dart';
import 'package:parambikulam/bloc/bookingslot/bookingstate.dart';

class BookingSlotBloc extends Bloc<BookingSlotEvent, BookingSlotState> {
  BookingSlotBloc() : super(BookingSlotState()) {
    on<AddPerson>(_addPerson);
    on<BookingSlotBlocInitial>(_bookingSlotBlocInitial);
  }
  Future<FutureOr<void>> _addPerson(
      AddPerson event, Emitter<BookingSlotState> emit) async {
    int newNumber = event.number! + 1;
    int newSeatCount = event.number! - 1;

    emit(NumberTillNow(seatNumber: newSeatCount, number: newNumber));
  }

  Future<FutureOr<void>> _bookingSlotBlocInitial(
      BookingSlotBlocInitial event, Emitter<BookingSlotState> emit) async {
    int seatNumber = 0, number = 0;

    emit(BookingSlotBlocStarted(seatNumber: seatNumber, number: number));
  }

  // @override
  // Stream<BookingSlotState> mapEventToState(BookingSlotEvent event) async* {
  //   if (event is AddPerson) {
  //     int newNumber = event.number! + 1;
  //     int newSeatCount = event.number! - 1;
  //     yield NumberTillNow(seatNumber: newSeatCount, number: newNumber);
  //   }
  //   if (event is BookingSlotBlocInitial) {
  //     int seatNumber = 0, number = 0;
  //     yield BookingSlotBlocStarted(seatNumber: seatNumber, number: number);
  //   }
  // }
}
