import 'package:equatable/equatable.dart';

class StateRoomUpdateGuest extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateRoomGuestBlocInitial extends StateRoomUpdateGuest {}

class DeletionRoomInitialized extends StateRoomUpdateGuest {}

class PersonRoomDeleted extends StateRoomUpdateGuest {
  final String? personUniqueID;
  final int? i;
  final List? list;
  final bool? isDetailsAdded, isEdStarted;
  PersonRoomDeleted(
      {this.i,
      this.personUniqueID,
      this.list,
      this.isDetailsAdded,
      this.isEdStarted});
}

class PersonRoomNotDeleted extends StateRoomUpdateGuest {}

class RefreshStateOneRoomGuest extends StateRoomUpdateGuest {}
