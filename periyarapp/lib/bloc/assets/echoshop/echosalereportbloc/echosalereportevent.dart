import 'package:equatable/equatable.dart';

class EchoSaleReportEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEchoSaleReportEvent extends EchoSaleReportEvent {
  final String? date;

  GetEchoSaleReportEvent({this.date});
  @override
  List<Object> get props => [];
}
