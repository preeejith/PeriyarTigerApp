import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/finalbooking/eventfinalbooking.dart';
import 'package:parambikulam/bloc/finalbooking/statefinalbooking.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class BlocFinalBooking extends Bloc<EventFinalBooking, StateFinalBooking> {
  int membersInTicket = 0;
  BlocFinalBooking() : super(StateFinalBooking()) {
    on<AddFinalData>(_addFinalData);
    on<ViewTicket>(_viewTicket);
    on<GenerateSummary>(_generateSummary);
  }

  Future<FutureOr<void>> _addFinalData(
      AddFinalData event, Emitter<StateFinalBooking> emit) async {
    emit(CheckingFinalData());
    //   FinalSubmissionModel finalSubmissionModel;

    DatabaseHelper? db = DatabaseHelper.instance;

    print("Booking initiated");
    print("-------");
    print(event.offlineBooking!.members);
    print("-------");
    print(event.offlineBooking!.newListTwo);
    print("-------");
    print(event.offlineBooking!.vehicleList);
    print("-------");
    print(event.offlineBooking!.entranceData);
    event.offlineBooking!.totalAmount =
        int.parse(event.offlineFinalAmount.toString());
    print("-------");
    var theResult =
        await db.addBookingData(event.offlineBooking, event.ticketId, event.busId);
    print("-------");
    print("-------");
    print(await db.getBookingData(theResult));
    print("-------");
    print("-------");
    event.offlineBooking!.tableId = theResult;
    print("the result $theResult");
    if (theResult >= 0) {
      print("result one");
      await db.updateSlotTable(
       // event.offlineBooking!.totalMembers,
        event.offlineBooking!.freeCount,
        event.offlineBooking!.slotId,
        event.offlineBooking!.programId,
      );

      //------------------------BUS------------------------

  

      emit(FinalDataAdded());
    } else {
      print("result 0");
    }

    // if (event.isOffline == false) {
    //   finalSubmissionModel = await AuthRepository().finalSubmission(
    //       url: "/cart/finaliseagenttransaction/app?id=" +
    //           event.cartId.toString() +
    //           "&amount=" +
    //           event.finalAmount.toString());
    //   if (finalSubmissionModel.status!) {
    //     emit(FinalDataAdded(finalSubmissionModel: finalSubmissionModel));
    //   } else {
    //     emit(FinalDataNotAdded(msg: finalSubmissionModel.msg));
    //   }
    // } else {

    // }
  }

  Future<FutureOr<void>> _viewTicket(
      ViewTicket event, Emitter<StateFinalBooking> emit) async {
    emit(ProceedToViewTicket(finalSubmissionModel: event.finalSubmissionModel));
  }

  Future<FutureOr<void>> _generateSummary(
      GenerateSummary event, Emitter<StateFinalBooking> emit) async {
    if (event.isOffline == true) {
      print('print');
      List<Map> list =
          await event.db!.getBookingData(event.offlineBooking!.tableId);
      // print("the summary list is + $list");
      print("****************************************");
      list.forEach((element) {
        print(element);
      });
      print("****************************************");
      membersInTicket = list[0]['indianCount'] +
          list[0]['childrenCount'] +
          list[0]['foreignerCount'];
      // print("the ticket id is --> ${list[0]['ticketId']}");
      emit(SummaryGenerated(bookingSummary: list));
    } else {
      emit(SummaryGenerated());
    }
  }

  // @override
  // Stream<StateFinalBooking> mapEventToState(EventFinalBooking event) async* {
  //   FinalSubmissionModel finalSubmissionModel;
  //   if (event is AddFinalData) {
  //     yield CheckingFinalData();
  //     if (event.isOffline == false) {
  //       finalSubmissionModel = await AuthRepository().finalSubmission(
  //           url: "/cart/finaliseagenttransaction?id=" +
  //               event.cartId.toString() +
  //               "&amount=" +
  //               event.finalAmount.toString());
  //       if (finalSubmissionModel.status!) {
  //         yield FinalDataAdded(finalSubmissionModel: finalSubmissionModel);
  //       } else {
  //         yield FinalDataNotAdded(msg: finalSubmissionModel.msg);
  //       }
  //     } else {
  //       DatabaseHelper? db = DatabaseHelper.instance;
  //       print("Booking initiated");
  //       print("-------");
  //       print(event.offlineBooking!.members);
  //       print("-------");
  //       print(event.offlineBooking!.newListTwo);
  //       print("-------");
  //       print(event.offlineBooking!.vehicleList);
  //       print("-------");
  //       print(event.offlineBooking!.entranceData);
  //       event.offlineBooking!.totalAmount =
  //           int.parse(event.offlineFinalAmount.toString());
  //       print("-------");
  //       var theResult =
  //           await db.addBookingData(event.offlineBooking, event.ticketId);
  //       print("-------");
  //       print("-------");
  //       print(await db.getBookingData(theResult));
  //       print("-------");
  //       print("-------");
  //       event.offlineBooking!.tableId = theResult;
  //       print("the result $theResult");
  //       if (theResult >= 0) {
  //         print("result one");
  //         await db.updateSlotTable(
  //           // event.offlineBooking!.totalMembers,
  //           event.offlineBooking!.freeCount,
  //           event.offlineBooking!.slotId,
  //           event.offlineBooking!.programId,
  //         );
  //         yield FinalDataAdded();
  //       } else {
  //         print("result 0");
  //       }
  //     }
  //   }
  //   if (event is ViewTicket) {
  //     yield ProceedToViewTicket(
  //         finalSubmissionModel: event.finalSubmissionModel);
  //   }

  //   if (event is GenerateSummary) {
  //     if (event.isOffline == true) {
  //       print('print');
  //       List<Map> list =
  //           await event.db!.getBookingData(event.offlineBooking!.tableId);
  //       // print("the summary list is + $list");
  //       print("****************************************");
  //       list.forEach((element) {
  //         print(element);
  //       });
  //       print("****************************************");
  //       // print("the ticket id is --> ${list[0]['ticketId']}");
  //       yield SummaryGenerated(bookingSummary: list);
  //     } else {
  //       yield SummaryGenerated();
  //     }
  //   }
  // }
}
