import 'package:equatable/equatable.dart';

class EventRoomUpdateGuest extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DoDeleteRoomGuest extends EventRoomUpdateGuest {
  final String? personUniqueID;
  final List? list;
  final int? i;
  final bool? isDetailsAdded, isEdStarted;
  DoDeleteRoomGuest(
      {this.i,
      this.personUniqueID,
      required this.list,
      this.isDetailsAdded,
      this.isEdStarted});
}

class RefreshStateOneRoom extends EventRoomUpdateGuest {}
