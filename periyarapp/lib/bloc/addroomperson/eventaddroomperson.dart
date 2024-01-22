import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';

class EventAddRoomPerson extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class RefreshRoom extends EventAddRoomPerson {}
class UploadImage extends EventAddRoomPerson {}

class SaveRoomPersonData extends EventAddRoomPerson {
  final String? dob,
      name,
      guestType,
      guestid, ticketid,
      cartId,
      phoneno,
      date,
      file,
      roomAllocationId;
  final int? currentIndex, roomIndex, entranceCharge;
  final bool? isOffline;
  final OfflineBooking? offlineBooking;
  SaveRoomPersonData({
    required this.guestid,
    required this.ticketid,
    this.entranceCharge,
    this.cartId,
    this.dob,
    this.phoneno,
    this.date,
    this.roomAllocationId,
    this.file,
    this.guestType,
    this.currentIndex,
    this.name,
    this.isOffline,
    this.roomIndex,
    this.offlineBooking,
  });
}
