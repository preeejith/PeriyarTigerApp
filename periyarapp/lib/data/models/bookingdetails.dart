class BookingDetails {
  bool? status;
  Data? data;
  String? msg;
  BookingDetails({this.status, this.data, this.msg});
  BookingDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  Payment? payment;
  List<Details>? details;
  bool? isVerified;
  Data({this.details, this.payment, this.isVerified});
  Data.fromJson(Map<String, dynamic> json) {
    isVerified = json['isVerified'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
  }
}

class Payment {
  int? total;
  String? name;
  String? type, id;
  String? ticket;
  Payment({this.name, this.id, this.ticket, this.type, this.total});

  Payment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['_id'];
    ticket = json['ticket'];
    total = json['total'];
    type = json['type'];
  }
}

class Details {
  int? indian;
  int? children;
  int? foreigner;
  int? foreignStudent;
  int? bonafideStudent;
  int? indianTotal;
  int? childrenTotal;
  int? foreignerTotal;
  int? foreignStudentTotal;
  int? bonafideStudentTotal;
  int? total;
  SelectedSlot? slotDetail;
  Programms? programme;
  List<Guest>? guest;
  List<Booking>? booking;
  Details(
      {this.guest,
      this.indian,
      this.bonafideStudent,
      this.bonafideStudentTotal,
      this.booking,
      this.children,
      this.childrenTotal,
      this.foreignStudent,
      this.foreignStudentTotal,
      this.foreigner,
      this.foreignerTotal,
      this.indianTotal,
      this.programme,
      this.slotDetail,
      this.total});
  Details.fromJson(Map<String, dynamic> json) {
    indian = json['indian'];
    bonafideStudent = json['bonafideStudent'];
    bonafideStudentTotal = json['bonafideStudentTotal'];
    bonafideStudent = json['bonafideStudent'];
    children = json['children'];
    childrenTotal = json['childrenTotal'];
    foreignStudent = json['foreignStudent'];
    bonafideStudent = json['bonafideStudent'];
    foreignStudentTotal = json['foreignStudentTotal'];
    foreigner = json['foreigner'];
    foreignerTotal = json['foreignerTotal'];
    indianTotal = json['indianTotal'];
    total = json['total'];

    slotDetail = json['slotDetail'] != null
        ? new SelectedSlot.fromJson(json['slotDetail'])
        : null;
    programme = json['programme'] != null
        ? new Programms.fromJson(json['programme'])
        : null;
    if (json['guest'] != null) {
      guest = <Guest>[];
      json['guest'].forEach((v) {
        guest!.add(new Guest.fromJson(v));
      });
    }
    if (json['booking'] != null) {
      booking = <Booking>[];
      json['booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
      });
    }
  }
}

class Programms {
  String? progName;
  Programms({this.progName});
  Programms.fromJson(Map<String, dynamic> json) {
    progName = json['progName'];
  }
}

class SelectedSlot {
  String? startTime;
  String? endTime;
  SelectedSlot({this.startTime, this.endTime});
  SelectedSlot.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
  }
}

class Guest {
  String? status, guestType, email, phoneno;
  String? name;
  String? id;
  IdProofs? idproofs;
  Guest(
      {this.status,
      this.name,
      this.email,
      this.id,
      this.phoneno,
      this.idproofs,
      this.guestType});
  Guest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    email = json['email'];
    id = json['_id'];
    phoneno = json['phoneno'];
    guestType = json['guestType'];
    name = json['name'];
    // idproofs = json['idproofs'] != null
    //     ? new IdProofs.fromJson(json['idproofs'])
    //     : null;
    idproofs = json['idproofs'] != null
        ? new IdProofs.fromJson(json['idproofs'])
        : null;
  }
}

class IdProofs {
  List<String>? image;
  IdProofs({this.image});
  IdProofs.fromJson(Map<String, dynamic> json) {
    //image = json['image'];
    // image = json['image'].cast<String>
     if (json['image'] != null) {
      image = <String>[];
      json['image'].forEach((v) {
        image!.add(v);
      });
    }
  }
}

class Booking {
  String? bookingDate;
  String? ticket;
  Booking({this.bookingDate, this.ticket});
  Booking.fromJson(Map<String, dynamic> json) {
    bookingDate = json['bookingDate'];
    ticket = json['ticket'];
  }
}
