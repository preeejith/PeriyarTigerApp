class PreviousBooking2 {
  bool? status;
  PBookingData? data;

  PreviousBooking2({this.status, this.data});
  PreviousBooking2.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? new PBookingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PBookingData {
  List<Upcoming>? upcoming;
  PBookingData({this.upcoming});
  PBookingData.fromJson(Map<String, dynamic> json) {
    if (json['upcoming'] != null) {
      upcoming = <Upcoming>[];
      json['upcoming'].forEach((v) {
        upcoming!.add(new Upcoming.fromJson(v));
      });
    }
  }

  toJson() {}
}

class Upcoming {
  List<Booking>? booking;

  Upcoming({this.booking});
  Upcoming.fromJson(Map<String, dynamic> json) {
    if (json['booking'] != null) {
      booking = <Booking>[];
      json['booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
      });
    }
  }
}

class SlotDetail {
  String? startTime;
  String? endTime;
  SlotDetail({this.endTime, this.startTime});
  SlotDetail.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
  }
}

class Booking {
  String? id;
  int? indian;
  int? children;
  int? foreigner;
  int? foreignStudent;
  int? bonafideStudent;
  Programs? programme;
  String? bookingDate;
  SlotDetail? slotDetail;

  // List<Guest>? guest;
  Booking(
      {this.id,
      this.indian,
      this.children,
      this.foreignStudent,
      this.foreigner,
      this.programme,
      this.bookingDate,
      this.bonafideStudent,
      this.slotDetail});
  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    indian = json['indian'];

    children = json['children'];
    foreigner = json['foreigner'];
    foreignStudent = json['foreignStudent'];
    bookingDate = json['bookingDate'];
    slotDetail = json['slotDetail'] != null
        ? new SlotDetail.fromJson(json['slotDetail'])
        : null;
    programme = json['programme'] != null
        ? new Programs.fromJson(json['programme'])
        : null;
  }
}

class Programs {
  String? id;
  bool? started;
  String? status;
  String? progName;
  String? coverImage;
  // List<Photos>? photos;

  Programs(
      {this.id, this.coverImage, this.started, this.status, this.progName});
  Programs.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    started = json['started'];
    status = json['status'];
    progName = json['progName'];
    coverImage = json['coverImage'];

    // if (json['programme'] != null) {
    //   upcoming = <Upcoming>[];
    //   json['upcoming'].forEach((v) {
    //     upcoming!.add(new Upcoming.fromJson(v));
    //   });
    // }
  }
}

// class Guest {
//   Guest.fromJson(v);
// }

// class GuestEntranceTickets {
//   GuestEntranceTickets.fromJson(v);
// }
