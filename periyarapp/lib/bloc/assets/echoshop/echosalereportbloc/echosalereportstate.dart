import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/echosalesreportmodel.dart';

class EchoSaleReportState extends Equatable {
  @override
  List<Object> get props => [];
}

class EchoSaleReportInitial extends EchoSaleReportState {}

class ReportGenerating extends EchoSaleReportState {}

class EchoSaleReportSuccess extends EchoSaleReportState {
  final EchoSalesReportModel echoSalesReportModel;
  EchoSaleReportSuccess({required this.echoSalesReportModel});
  @override
  List<Object> get props => [];
}

class EchoSaleReportEmpty extends EchoSaleReportState {
  @override
  List<Object> get props => [];
}

class EchoSaleReportError extends EchoSaleReportState {
  @override
  List<Object> get props => [];
}
