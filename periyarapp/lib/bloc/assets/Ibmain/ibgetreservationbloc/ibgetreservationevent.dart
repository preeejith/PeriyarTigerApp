import 'package:equatable/equatable.dart';

//new
class IBGetReservationsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetIBGetReservationsEvent extends IBGetReservationsEvent {
  final dynamic data;

  GetIBGetReservationsEvent({this.data});
  @override
  List<Object> get props => [];
}
