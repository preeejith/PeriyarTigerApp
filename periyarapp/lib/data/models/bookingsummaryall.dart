class BookingSummaryAll {
  bool? status;
  BookingSummaryDataAll? data;
  int? total;
  List<GuestCounts>? guestcounts;
  String? msg;
  BookingSummaryAll({this.msg, this.status, this.data, this.total});
  BookingSummaryAll.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    total = json['total'];
    if (json['guestcounts'] != null) {
      guestcounts = <GuestCounts>[];
      json['guestcounts'].forEach((v) {
        guestcounts!.add(new GuestCounts.fromJson(v));
      });
    }
    data = json['data'] != null
        ? new BookingSummaryDataAll.fromJson(json['data'])
        : null;
  }
}

class GuestCounts {
  int? indian, children, foreigner;
  GuestCounts({this.children, this.foreigner, this.indian});
  GuestCounts.fromJson(Map<String, dynamic> json) {
    indian = json['indian'];
    children = json['children'];
    foreigner = json['foreigner'];
  }
}

class BookingSummaryDataAll {
  int? indian;
  int? children;
  int? foreigner;
  int? indianTotal;
  int? childrenTotal;
  int? foreignerTotal;
  int? programTotal;
  int? bookingTotal;
  int? total;
  int? finalAmount;
  int? entranceTickettotal;
  BookingSummaryDataAllSlot? slotDetail;
  Programme? programme;
  String? bookingDate;
  bool? isCottage;
  GuestToAdd? guestsToAdd;
  List<RoomAllocation>? roomAllocation;
  BookingSummaryDataAll(
      {this.bookingDate,
      this.bookingTotal,
      this.children,
      this.finalAmount,
      this.isCottage,
      this.childrenTotal,
      this.roomAllocation,
      this.foreigner,
      this.entranceTickettotal,
      this.programme,
      this.foreignerTotal,
      this.indian,
      this.indianTotal,
      this.programTotal,
      this.slotDetail,
      this.guestsToAdd,
      this.total});
  BookingSummaryDataAll.fromJson(Map<String, dynamic> json) {
    bookingDate = json['bookingDate'];
    bookingTotal = json['bookingTotal'];
    childrenTotal = json['childrenTotal'];
    finalAmount = json['finalAmount'];
    children = json['children'];
    entranceTickettotal = json['entranceTickettotal'];
    isCottage = json['isCottage'];
    foreigner = json['foreigner'];
    foreignerTotal = json['foreignerTotal'];
    indian = json['indian'];
    indianTotal = json['indianTotal'];
    programTotal = json['programTotal'];
    total = json['total'];
    slotDetail = json['slotDetail'] != null
        ? new BookingSummaryDataAllSlot.fromJson(json['slotDetail'])
        : null;
    programme = json['programme'] != null
        ? new Programme.fromJson(json['programme'])
        : null;
    guestsToAdd = json['guestsToAdd'] != null
        ? new GuestToAdd.fromJson(json['guestsToAdd'])
        : null;
    if (json['roomAllocation'] != null) {
      roomAllocation = <RoomAllocation>[];
      json['roomAllocation'].forEach((v) {
        roomAllocation!.add(new RoomAllocation.fromJson(v));
      });
    }
  }
}

class RoomAllocation {
  int? totalCount, indianCount, foreignerCount, childrenCount;
  String? id;
  RoomAllocation({
    this.childrenCount,
    this.foreignerCount,
    this.indianCount,
    this.id,
    this.totalCount,
  });
  RoomAllocation.fromJson(Map<String, dynamic> json) {
    childrenCount = json['childrenCount'];
    totalCount = json['totalCount'];
    id = json['_id'];
    indianCount = json['indianCount'];
    foreignerCount = json['foreignerCount'];
  }
}

class GuestToAdd {
  int? indian;
  int? children;
  int? foreigner;
  GuestToAdd({this.children, this.foreigner, this.indian});
  GuestToAdd.fromJson(Map<String, dynamic> json) {
    indian = json['indian'];
    children = json['children'];
    foreigner = json['foreigner'];
  }
}

class Programme {
  String? progName;
  Programme({
    this.progName,
  });
  Programme.fromJson(Map<String, dynamic> json) {
    progName = json['progName'];
  }
}

class BookingSummaryDataAllSlot {
  String? status;
  String? id;
  String? slot;
  String? startTime;
  String? endTime;
  int? availableNo;

  BookingSummaryDataAllSlot(
      {this.availableNo,
      this.endTime,
      this.id,
      this.slot,
      this.startTime,
      this.status});
  BookingSummaryDataAllSlot.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    endTime = json["endTime"];
    availableNo = json["availableNo"];
    slot = json["slot"];
    startTime = json["startTime"];
    status = json["status"];
  }
}
