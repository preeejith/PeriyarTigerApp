import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/getibholidaysmodel.dart';



//new

class IBGetHolidaysState extends Equatable {
  @override
  List<Object> get props => [];
}

class IBGetHolidaysInitial extends IBGetHolidaysState {}

class IBGetHolidays extends IBGetHolidaysState {}

class IBGetHolidaysSuccess extends IBGetHolidaysState {
  final GetIbHolidaysModel getIbHolidaysModel;
  IBGetHolidaysSuccess({required this.getIbHolidaysModel});
  @override
  List<Object> get props => [];
}

class IBGetHolidaysEmpty extends IBGetHolidaysState {
  @override
  List<Object> get props => [];
}

class IBGetHolidaysError extends IBGetHolidaysState {
  @override
  List<Object> get props => [];
}
