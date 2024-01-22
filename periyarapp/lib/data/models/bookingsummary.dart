class BookingSummary {
  bool? status;
  List<BookingSummaryData>? data;
  BookingSummaryProgramData? programData;
  String? msg;

  BookingSummary({this.status, this.programData, this.msg, this.data});
  BookingSummary.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    programData = json['programData'] != null
        ? new BookingSummaryProgramData.fromJson(json['programData'])
        : null;
    if (json['data'] != null) {
      data = <BookingSummaryData>[];
      json['data'].forEach((v) {
        data!.add(new BookingSummaryData.fromJson(v));
      });
    }
  }
}

class BookingSummaryData {
  String? id;
  bool? selected;
  String? startTime, endTime, status;
  int? freeCount, availableNo, bookedCount;
  Slot? slot;
  BookingSummaryData({
    this.availableNo,
    this.bookedCount,
    this.endTime,
    this.freeCount,
    this.id,
    this.selected,
    this.slot,
    this.startTime,
    this.status,
  });
  BookingSummaryData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    status = json['status'];
    selected = false;
    startTime = json['startTime'];
    endTime = json['endTime'];
    freeCount = json['freeCount'];
    availableNo = json['availableNo'];
    bookedCount = json['bookedCount'];
    slot = json['slot'] != null ? new Slot.fromJson(json['slot']) : null;
  }
}

class Slot {
  String? idOne, slotId, programme, fromDate, toDate, slotType, statusOne;
  Slot({
    this.fromDate,
    this.idOne,
    this.programme,
    this.slotType,
    this.statusOne,
    this.toDate,
  });

  Slot.fromJson(Map<String, dynamic> json) {
    statusOne = json['status'];
    idOne = json['_id'];
    fromDate = json['fromDate'];
    programme = json['programme'];
    slotType = json['slotType'];
    toDate = json['toDate'];
  }
}

class BookingSummaryProgramData {
  bool? started;
  Cottage? cottage;
  String? progName;
  BookingAvailability? bookingAvailability;
  BookingSummaryProgramData(
      {this.bookingAvailability, this.cottage, this.progName, this.started});
  BookingSummaryProgramData.fromJson(Map<String, dynamic> json) {
    started = json["started"];
    cottage =
        json["cottage"] != null ? new Cottage.fromJson(json["cottage"]) : null;
    progName = json["progName"];
    bookingAvailability = json['bookingAvailability'] != null
        ? new BookingAvailability.fromJson(json['bookingAvailability'])
        : null;
  }
}

class Cottage {
  int? maxExtraGuestCount,
      maxExtraIndianCount,
      maxExtraForeignerCount,
      maxExtraChildrenCount,
      guestPerRoom,
      maxTotalGuests,
      maxTotalIndians,
      maxTotalForeigners,
      maxTotalChildren;
  Cottage({
    this.guestPerRoom,
    this.maxExtraChildrenCount,
    this.maxExtraForeignerCount,
    this.maxExtraGuestCount,
    this.maxExtraIndianCount,
    this.maxTotalChildren,
    this.maxTotalForeigners,
    this.maxTotalGuests,
    this.maxTotalIndians,
  });

  Cottage.fromJson(Map<String, dynamic> json) {
    guestPerRoom = json["guestPerRoom"];
    maxExtraChildrenCount = json["maxExtraChildrenCount"];
    maxExtraForeignerCount = json["maxExtraForeignerCount"];
    maxExtraGuestCount = json["maxExtraGuestCount"];
    maxExtraIndianCount = json["maxExtraIndianCount"];
    maxTotalChildren = json["maxTotalChildren"];
    maxTotalForeigners = json["maxTotalForeigners"];
    maxTotalIndians = json["maxTotalIndians"];
    maxTotalGuests = json["maxTotalGuests"];
  }
}

class BookingAvailability {
  bool? indian;
  bool? foreigner;
  bool? children;
  BookingAvailability({this.children, this.foreigner, this.indian});
  BookingAvailability.fromJson(Map<String, dynamic> json) {
    indian = json['indian'];
    foreigner = json['foreigner'];
    children = json['children'];
  }
}

class ProgramData {}
