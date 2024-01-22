import 'package:equatable/equatable.dart';



class ReportHalt2Event extends Equatable {
  @override
  List<Object> get props => [];
}

class ReportHaltEvent extends ReportHalt2Event {
  final from;
  final to;
  final empId;
  final date;
  ReportHaltEvent({required this.from, this.to, this.empId, this.date});
  @override
  List<Object> get props => [];
}
