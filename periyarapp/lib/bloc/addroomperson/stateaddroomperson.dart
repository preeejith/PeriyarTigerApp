import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/bookingsummaryall.dart';

class StateAddRoomPerson extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddRoomPersonInitial extends StateAddRoomPerson {}

class RoomRefreshed extends StateAddRoomPerson {}

class AddPersonRoomInitial extends StateAddRoomPerson {}

class RoomPersonAdded extends StateAddRoomPerson {
  final int? currentIndex, roomIndex;
  final String? name, dob, type, id, phone, email;
  final BookingSummaryAll? bookingSummaryAll;
  RoomPersonAdded(
      {this.bookingSummaryAll,
      this.currentIndex,
      this.roomIndex,
      this.dob,
      this.id,
      this.phone,
      this.email,
      this.name,
      this.type});
}

class RoomPersonNotAdded extends StateAddRoomPerson {
  final String? msg;
  RoomPersonNotAdded({this.msg});
}

class RoomPersonUpdated extends StateAddRoomPerson {}

class RoomPersonNotUpdated extends StateAddRoomPerson {
  final String? msg;
  RoomPersonNotUpdated({this.msg});
}

class UploadingFileInRoom extends StateAddRoomPerson {}

class AddingRoomPerson extends StateAddRoomPerson {}

class UploadingRoomFile extends StateAddRoomPerson {}

class RoomFileUploaded extends StateAddRoomPerson {}

class RoomFileNotUploaded extends StateAddRoomPerson {
  final String? msg;
  RoomFileNotUploaded({this.msg});
}
