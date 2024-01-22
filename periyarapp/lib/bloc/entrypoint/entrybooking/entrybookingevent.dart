import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/entrymodel/camerainfomodel.dart';
import 'package:parambikulam/data/models/entrymodel/guestinfomodel.dart';
import 'package:parambikulam/data/models/entrymodel/vehicleinfomodel.dart';
import 'package:parambikulam/data/models/finalsubmission.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class EntryBookingEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SaveEntryTicket extends EntryBookingEvent {
  final String? cartId,
      finalAmount,
      startTime,
      endTime,
      offlineFinalAmount,
      ticketId,place;

  final List<GuestInfoModel> customerlist;
  final List<VehicleInfoModel> vehicleDetailsSelected;
  final List<CameraInfoModel> cameraDetailsSelected;

  SaveEntryTicket(
      {this.cartId,
      this.startTime,
      this.offlineFinalAmount,
      this.ticketId,
      this.endTime,this.place,
      this.finalAmount,
      required this.customerlist,
      required this.vehicleDetailsSelected,
      required this.cameraDetailsSelected});
}

class ViewTicket extends EntryBookingEvent {
  final bool? isOffline;
  final FinalSubmissionModel? finalSubmissionModel;
  ViewTicket({required this.finalSubmissionModel, this.isOffline});
}

class GenerateSummary extends EntryBookingEvent {
  final OfflineBooking? offlineBooking;
  final DatabaseHelper? db;
  final bool? isOffline, previousBooked;
  GenerateSummary(
      {this.db, this.offlineBooking, this.isOffline, this.previousBooked});
}
class Refresh extends EntryBookingEvent {
 
}
