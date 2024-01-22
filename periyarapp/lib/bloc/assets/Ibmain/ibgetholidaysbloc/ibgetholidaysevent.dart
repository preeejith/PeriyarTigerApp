import 'package:equatable/equatable.dart';

//new
class IBGetHolidaysEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetIBGetHolidaysEvent extends IBGetHolidaysEvent {
  final dynamic data;

  GetIBGetHolidaysEvent({this.data});
  @override
  List<Object> get props => [];
}
