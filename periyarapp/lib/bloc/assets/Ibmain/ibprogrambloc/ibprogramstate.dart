import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/ibprogramsmodel.dart';


//new

class IBprogramState extends Equatable {
  @override
  List<Object> get props => [];
}

class IBprogramInitial extends IBprogramState {}

class IBprogram extends IBprogramState {}

class IBprogramSuccess extends IBprogramState {
  final IbProgramsModel ibProgramsModel;
  IBprogramSuccess({required this.ibProgramsModel});
  @override
  List<Object> get props => [];
}

class IBprogramEmpty extends IBprogramState {
  @override
  List<Object> get props => [];
}

class IBprogramError extends IBprogramState {
  @override
  List<Object> get props => [];
}
