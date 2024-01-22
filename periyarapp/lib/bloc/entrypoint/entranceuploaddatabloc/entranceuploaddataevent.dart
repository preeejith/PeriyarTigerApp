import 'package:parambikulam/data/models/entrymodel/entrybookingmodel.dart';

class UploadEntryBookingEvent {}

class UploadEntryBooking extends UploadEntryBookingEvent {
  final EntryBookingModel? entryBookingData;
  final int? index;

  UploadEntryBooking({this.entryBookingData, this.index});
}

class RefreshEntryBookings extends UploadEntryBookingEvent {}

class UpdateIdProofs extends UploadEntryBookingEvent {
  final String? id, imagePath;
  final int? index;
  UpdateIdProofs({required this.id, required this.imagePath, required this.index});
}
