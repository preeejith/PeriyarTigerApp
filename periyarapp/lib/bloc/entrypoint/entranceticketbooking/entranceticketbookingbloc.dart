import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/entrypoint/entranceticketbooking/entranceticketbookingevent.dart';
import 'package:parambikulam/bloc/entrypoint/entranceticketbooking/entranceticketbookingstate.dart';

class EntranceTicketBookingBloc
    extends Bloc<EntranceTicketBookingEvent, EntranceTicketBookingState> {
  EntranceTicketBookingBloc() : super(EntranceTicketBookingState()) {
    on<AlterEntranceCharge>(_alterEntranceCharge);
    on<RefreshBloc>(_refreshBloc);
  }
  Future<FutureOr<void>> _alterEntranceCharge(AlterEntranceCharge event,
      Emitter<EntranceTicketBookingState> emit) async {
    if (event.value == false) {
      event.offlineBooking!.totalAmount = event.offlineBooking!.totalAmount! -
          int.parse(event.entranceCharge.toString());
      event.offlineBooking!.entranceCharge =
          event.offlineBooking!.entranceCharge! -
              int.parse(event.entranceCharge.toString());
      emit(EntranceChargeRemoved(value: event.value, newEntrance: 0));
    } else {
      event.offlineBooking!.totalAmount = event.offlineBooking!.totalAmount! +
          int.parse(event.entranceCharge.toString());
      event.offlineBooking!.entranceCharge =
          event.offlineBooking!.entranceCharge! +
              int.parse(event.entranceCharge.toString());

      emit(EntranceChargeAdded(
          value: event.value,
          newEntrance: int.parse(event.entranceCharge.toString())));
    }
  }

  Future<FutureOr<void>> _refreshBloc(
      RefreshBloc event, Emitter<EntranceTicketBookingState> emit) async {
    emit(EntranceTicketBookingInitial());
  }
}
