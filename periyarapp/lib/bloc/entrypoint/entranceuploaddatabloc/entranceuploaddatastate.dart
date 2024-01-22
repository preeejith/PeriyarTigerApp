import 'package:equatable/equatable.dart';

class UploadEntryBookingState extends Equatable {
  @override
  List<Object?> get props =>[];
}

class UploadEntryBookingInitial extends UploadEntryBookingState {}

class UploadingEntryData extends UploadEntryBookingState {}

class UploadEntryBookingSuccess extends UploadEntryBookingState {
  final int? index;
  final String? ticketId;
  UploadEntryBookingSuccess({this.index,this.ticketId});

  // final FinalSubmissionModel? finalSubmissionModel;
  // UploadEntryBooking({this.finalSubmissionModel});
}

class UploadEntryBookingError extends UploadEntryBookingState {
  final String? msg;
  UploadEntryBookingError({this.msg});
}
class RefreshState extends UploadEntryBookingState{}

class ImageUploaded extends UploadEntryBookingState{}
