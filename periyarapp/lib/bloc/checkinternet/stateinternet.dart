import 'package:equatable/equatable.dart';

class StateInternet extends Equatable {
  @override
  List<Object?> get props => [];
}

class FoundInternet extends StateInternet {}

class NoInternet extends StateInternet {}

class BlocInternetInitial extends StateInternet {}

class CheckingInternetState extends StateInternet {}

class RefreshState extends StateInternet {}
