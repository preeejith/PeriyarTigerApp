import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/entrypoint/entrybooking/entrybookingevent.dart';
import 'package:parambikulam/bloc/entrypoint/entrybooking/entrybookingstate.dart';

import 'package:parambikulam/local/db/dbhelper.dart';

class EntryBookingBloc extends Bloc<EntryBookingEvent, EntryBookingState> {
  EntryBookingBloc() : super(EntryBookingState()) {
    on<SaveEntryTicket>(_addFinalData);
    on<ViewTicket>(_viewTicket);
    on<GenerateSummary>(_generateSummary);
    on<Refresh>(refresh);
  }

  Future<FutureOr<void>> refresh(
      Refresh event, Emitter<EntryBookingState> emit) async {
    emit(RefreshState());
  }

  Future<FutureOr<void>> _addFinalData(
      SaveEntryTicket event, Emitter<EntryBookingState> emit) async {
    emit(CheckingFinalData());

    DatabaseHelper? db = DatabaseHelper.instance;

    Map data = {
      "vehicleDetails": event.vehicleDetailsSelected,
      'cameraDetails': event.cameraDetailsSelected,
      'customers': event.customerlist,
      'totalAmount': event.finalAmount,
      'place': event.place,
    };

    String jsonData = json.encode(data);

    var theResult = await db.addEntryBookingData(jsonData, event.ticketId);

    if (theResult >= 0) {
      emit(FinalDataAdded());
    } else {
      print("result 0");
    }
  }

  Future<FutureOr<void>> _viewTicket(
      ViewTicket event, Emitter<EntryBookingState> emit) async {
    emit(ProceedToViewTicket(finalSubmissionModel: event.finalSubmissionModel));
  }

  Future<FutureOr<void>> _generateSummary(
      GenerateSummary event, Emitter<EntryBookingState> emit) async {
    if (event.isOffline == true) {
      List<Map> list =
          await event.db!.getBookingData(event.offlineBooking!.tableId);

      list.forEach((element) {
        print(element);
      });

      emit(SummaryGenerated(bookingSummary: list));
    } else {
      emit(SummaryGenerated());
    }
  }
}
