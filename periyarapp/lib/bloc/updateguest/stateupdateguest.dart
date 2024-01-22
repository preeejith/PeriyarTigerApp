import 'package:equatable/equatable.dart';

class StateUpdateGuest extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateGuestBlocInitial extends StateUpdateGuest {}

class DeletionInitialized extends StateUpdateGuest {}

class PersonDeleted extends StateUpdateGuest {
  final int? index;
  final List? list;
  PersonDeleted({this.index, this.list});
}

class PersonNotDeleted extends StateUpdateGuest {}

class Refreshed extends StateUpdateGuest {}
