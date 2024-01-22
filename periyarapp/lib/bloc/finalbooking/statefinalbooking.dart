import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/finalsubmission.dart';

class StateFinalBooking extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class FinalBookingInitial extends StateFinalBooking {}

class CheckingFinalData extends StateFinalBooking {}

class FinalDataAdded extends StateFinalBooking {
  final FinalSubmissionModel? finalSubmissionModel;
  FinalDataAdded({this.finalSubmissionModel});
}

class FinalDataNotAdded extends StateFinalBooking {
  final String? msg;
  FinalDataNotAdded({this.msg});
}

class ProceedToViewTicket extends StateFinalBooking {
  final FinalSubmissionModel? finalSubmissionModel;
  ProceedToViewTicket({required this.finalSubmissionModel});
}

class SummaryGenerated extends StateFinalBooking {
  final List<Map>? bookingSummary;
  SummaryGenerated({this.bookingSummary});
}
