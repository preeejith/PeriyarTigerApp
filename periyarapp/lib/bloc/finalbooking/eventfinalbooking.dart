import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/busmodel.dart';
import 'package:parambikulam/data/models/finalsubmission.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class EventFinalBooking extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddFinalData extends EventFinalBooking {
  final String? cartId,
      finalAmount,
      busId,
      tripId,
      startTime,
      endTime,
      offlineFinalAmount,
      ticketId;
  final OfflineBooking? offlineBooking;
  final List<BusData>? busAllocated;
  final bool? isOffline;
  AddFinalData(
      {this.cartId,
      required this.busId,
       this.tripId,
    
      this.startTime,
      this.busAllocated,
      this.offlineFinalAmount,
      this.ticketId,
      this.endTime,
      this.finalAmount,
      this.offlineBooking,
      this.isOffline});
}

class ViewTicket extends EventFinalBooking {
  final bool? isOffline;
  final FinalSubmissionModel? finalSubmissionModel;
  ViewTicket({required this.finalSubmissionModel, this.isOffline});
}

class GenerateSummary extends EventFinalBooking {
  final OfflineBooking? offlineBooking;
  final DatabaseHelper? db;
  final bool? isOffline, previousBooked;
  GenerateSummary(
      {this.db, this.offlineBooking, this.isOffline, this.previousBooked});
}
