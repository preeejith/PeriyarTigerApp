import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/ibgetreservationdatamodel.dart';

//new
////newly added one
class IBGetReservationsState extends Equatable {
  @override
  List<Object> get props => [];
}

class IBGetReservationsInitial extends IBGetReservationsState {}

class IBGetReservations extends IBGetReservationsState {}

class IBGetReservationsSuccess extends IBGetReservationsState {
  final IbGetReservationDataModel ibGetReservationDataModel;
  IBGetReservationsSuccess({required this.ibGetReservationDataModel});
  @override
  List<Object> get props => [];
}

class IBGetReservationsEmpty extends IBGetReservationsState {
  @override
  List<Object> get props => [];
}

class IBGetReservationsError extends IBGetReservationsState {
  @override
  List<Object> get props => [];
}
