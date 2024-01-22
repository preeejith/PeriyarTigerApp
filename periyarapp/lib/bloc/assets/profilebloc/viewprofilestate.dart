import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/viewprofilemodel.dart';

class ViewProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewProfileInitial extends ViewProfileState {}

class Checking extends ViewProfileState {}

class ViewProfileSuccess extends ViewProfileState {
  final ViewProfileModel viewProfileModel;
  ViewProfileSuccess({required this.viewProfileModel});
  @override
  List<Object> get props => [];
}

class ProfileDownloadedSuccess extends ViewProfileState {
  @override
  List<Object> get props => [];
}

class SalesDetailedSuccess extends ViewProfileState {
  @override
  List<Object> get props => [];
}

class SalesDetailedError extends ViewProfileState {
  @override
  List<Object> get props => [];
}

class ProfileDownloadedRefresh extends ViewProfileState {
  @override
  List<Object> get props => [];
}

class SalesDetailedFetching extends ViewProfileState {
  @override
  List<Object> get props => [];
}

class ViewProfileEmpty extends ViewProfileState {
  @override
  List<Object> get props => [];
}

class ViewProfileError extends ViewProfileState {
  @override
  List<Object> get props => [];
}
