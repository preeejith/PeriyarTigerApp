import 'package:parambikulam/ui/app/booking/bookingsummary.dart';

class OfflineBooking {
  String? programId,
      slotId,
      bookingDate,
      title,
      startTime,
      endTime,
      tc,
      ticketid;
  int? indianCount,
      childrenCount,
      foreignerCount,
      maxTotalGuests,
      totalAmount,
      indianTotal,
      entranceCharge,
      finalEntranceCharge,
      // totalMembersOrRooms,
      freeCount,
      foreignerTotal,
      tableId,
      ticketNumber,
      childrenTotal,
      // totalMembers,
      // totalRooms,
      guestPerRoom,
      roomCount;
  List? members;
  List<OfflineRoomModel>? offlineRoomList;
  List<Map>? vehicleList = <Map>[];
  List<Map> newListTwo = <Map>[];
  List<Map> data = <Map>[];
  List<Map> entranceData = <Map>[];
  OfflineBooking({
    this.programId,
    this.maxTotalGuests,
    this.tc,
    this.members,
    this.ticketid,
    this.finalEntranceCharge = 0,
    this.guestPerRoom,
    this.roomCount,
    this.title,
    required this.data,
    required this.entranceData,
    this.offlineRoomList,
    this.ticketNumber,
    required this.newListTwo,
    // this.totalRooms,
    this.tableId,
    this.vehicleList,
    this.bookingDate,
    this.entranceCharge,
    this.slotId,
    this.childrenCount,
    this.foreignerCount,
    // this.totalMembers,
    // this.totalMembersOrRooms,
    this.freeCount,
    this.indianCount,
    this.totalAmount = 0,
    this.childrenTotal = 0,
    this.foreignerTotal = 0,
    this.indianTotal = 0,
  });
}

class BookingDetailsModel {
  String? dob, name, phone, guest, cartid;
  BookingDetailsModel({
    this.cartid,
    this.dob,
    this.guest,
    this.name,
    this.phone,
  });
}
