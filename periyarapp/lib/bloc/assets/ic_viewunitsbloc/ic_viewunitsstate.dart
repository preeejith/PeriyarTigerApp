import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/ic_viewunnitsmodel.dart';

class IcViewUnitsState extends Equatable {
  @override
  List<Object> get props => [];
}

class IcViewUnitsInitial extends IcViewUnitsState {}

class Checking extends IcViewUnitsState {}
class Refreshingstate extends IcViewUnitsState {}

class IcViewUnitsSuccess extends IcViewUnitsState {
  final IcViewUnitsModel icViewUnitsModel;
  IcViewUnitsSuccess({required this.icViewUnitsModel});
  @override
  List<Object> get props => [];
}

/////
class IcViewUnitsEmpty extends IcViewUnitsState {
  @override
  List<Object> get props => [];
}

class IcViewUnitsError extends IcViewUnitsState {
  @override
  List<Object> get props => [];
}
