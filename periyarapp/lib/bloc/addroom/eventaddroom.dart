import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/ui/app/booking/bookingsummary.dart';

class EventAddRoom extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddRoomRefresh extends EventAddRoom {}

class SaveRoomData extends EventAddRoom {
  final String? programId, slotId, bookingDate, title;
  final int? numberOfRooms, guestPerRoom, totalMembers, freeCount, maxTotalGuests;
  final List<Map>? newList, slotDetails, vehicleInfo;
  final bool? isOffline;
  final OfflineBooking? offlineBooking;
  final List<OfflineRoomModel>? offlineRoomDataList;
  SaveRoomData({
    required this.programId,
    this.bookingDate,
    this.slotDetails,
    this.guestPerRoom,
    this.title,
    this.freeCount,
    this.vehicleInfo,
    this.maxTotalGuests,
    this.offlineRoomDataList,
    this.totalMembers,
    this.numberOfRooms,
    this.slotId,
    this.newList,
    this.offlineBooking,
    this.isOffline,
  });
}
