import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/finalsubmission.dart';

class EntryBookingState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FinalBookingInitial extends EntryBookingState {}

class CheckingFinalData extends EntryBookingState {}
class RefreshState extends EntryBookingState {}
class FinalDataAdded extends EntryBookingState {
  final FinalSubmissionModel? finalSubmissionModel;
  FinalDataAdded({this.finalSubmissionModel});
}

class FinalDataNotAdded extends EntryBookingState {
  final String? msg;
  FinalDataNotAdded({this.msg});
}

class ProceedToViewTicket extends EntryBookingState {
  final FinalSubmissionModel? finalSubmissionModel;
  ProceedToViewTicket({required this.finalSubmissionModel});
}

class SummaryGenerated extends EntryBookingState {
  final List<Map>? bookingSummary;
  SummaryGenerated({this.bookingSummary});
}
