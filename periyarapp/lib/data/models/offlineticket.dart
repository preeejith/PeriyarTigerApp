class OfflineLineTicket {
  bool? status;
  List<TicketData>? ticketData;
  int? page, count;
  String? msg;

  OfflineLineTicket({this.count, this.page, this.status, this.ticketData});
  OfflineLineTicket.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    page = json['page'];
    msg = json['msg'];
    count = json['count'];
    if (json['data'] != null) {
      ticketData = <TicketData>[];
      json['data'].forEach((v) {
        ticketData!.add(new TicketData.fromJson(v));
      });
    }
  }
}

class TicketData {
  TDetails? ticketDetail;
  int? ticketNo;
  TicketPayment? payment;
  List<TicketBooking>? booking;
  List<Vehicles>? vehicles;
  List<EntranceTickets>? entranceTickets;
  TicketData(
      {this.payment,
      this.ticketNo,
      this.ticketDetail,
      this.booking,
      this.entranceTickets,
      this.vehicles});
  TicketData.fromJson(Map<String, dynamic> json) {
    ticketNo = json['ticketNo'];
    payment = json['payment'] != null
        ? TicketPayment.fromJson(json['payment'])
        : null;
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicles.fromJson(v));
      });
    }
    if (json['entranceTickets'] != null) {
      entranceTickets = <EntranceTickets>[];
      json['entranceTickets'].forEach((v) {
        entranceTickets!.add(new EntranceTickets.fromJson(v));
      });
    }
    if (json['booking'] != null) {
      booking = <TicketBooking>[];
      json['booking'].forEach((v) {
        booking!.add(new TicketBooking.fromJson(v));
      });
    }
    ticketDetail = json['ticketDetail'] != null
        ? TDetails.fromJson(json['ticketDetail'])
        : null;
  }
}

class TDetails {
  String? ticketId;
  TDetails({this.ticketId});
  TDetails.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticketid'];
  }
}

class EntranceTickets {
  String? type, status, id, bookingDate, ticket;
  EntranceGuest? entranceGuest;
  int? charge;
  EntranceTickets({
    this.bookingDate,
    this.charge,
    this.entranceGuest,
    this.id,
    this.status,
    this.ticket,
    this.type,
  });
  EntranceTickets.fromJson(Map<String, dynamic> json) {
    bookingDate = json['bookingDate'];
    charge = json['charge'];
    id = json['_id'];
    status = json['status'];
    ticket = json['ticket'];
    type = json['type'];
    entranceGuest =
        json['guest'] != null ? EntranceGuest.fromJson(json['guest']) : null;
    // guest = json['guest'];
  }
}

class EntranceGuest {
  String? status, id, name, guestType, email, dob, phoneno, gender, nationality;
  int? charge;
  EntranceGuest(
      {this.charge,
      this.dob,
      this.email,
      this.gender,
      this.guestType,
      this.id,
      this.name,
      this.nationality,
      this.phoneno,
      this.status});
  EntranceGuest.fromJson(Map<String, dynamic> json) {
    charge = json['charge'];
    dob = json['dob'];
    email = json['email'];
    gender = json['gender'];
    guestType = json['guestType'];
    id = json['_id'];
    name = json['name'];
    nationality = json['nationality'];
    phoneno = json['phoneno'];
    status = json['status'];
  }
}

class Vehicles {
  String? type, status, id, bookingDate, ticket, vehicle;
  int? charge;
  Vehicles({
    this.bookingDate,
    this.charge,
    this.id,
    this.status,
    this.ticket,
    this.type,
    this.vehicle,
  });
  Vehicles.fromJson(Map<String, dynamic> json) {
    bookingDate = json['bookingDate'];
    charge = json['charge'];
    id = json['_id'];
    status = json['status'];
    ticket = json['ticket'];
    type = json['type'];
    vehicle = json['vehicle'];
  }
}

class TicketPayment {
  String? name, id, paymentStatus, type, user, ticket, initDate, complDate;
  int? total;
  TicketPayment(
      {this.complDate,
      this.id,
      this.name,
      this.initDate,
      this.paymentStatus,
      this.ticket,
      this.total,
      this.type,
      this.user});
  TicketPayment.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    total = json['total'];
    paymentStatus = json['payment_status'];
    type = json['type'];
    user = json['user'];
    ticket = json['ticket'];
    initDate = json['init_date'];
    complDate = json['compl_date'];
  }
}

class TicketBooking {
  TicketProgramme? programme;
  List<TicketDetails>? details;

  TicketBooking({this.programme, this.details});
  TicketBooking.fromJson(Map<String, dynamic> json) {
    programme = json['programme'] != null
        ? new TicketProgramme.fromJson(json['programme'])
        : null;
    if (json['details'] != null) {
      details = <TicketDetails>[];
      json['details'].forEach((v) {
        details!.add(new TicketDetails.fromJson(v));
      });
    }
  }
}

class TicketDetails {
  TicketSlotDetail? slotDetail;
  String? bookingDate;
  TicketGuest? guest;
  String? bookType;
  TicketDetails({
    this.slotDetail,
    this.bookingDate,
    this.guest,
    this.bookType,
  });
  TicketDetails.fromJson(Map<String, dynamic> json) {
    slotDetail = json['slotDetail'] != null
        ? new TicketSlotDetail.fromJson(json['slotDetail'])
        : null;
    bookingDate = json['bookingDate'];
    bookType = json['bookType'];
    guest =
        json['guest'] != null ? new TicketGuest.fromJson(json['guest']) : null;
    bookType = json['bookType'];
  }
}

class TicketGuest {
  String? sId;
  String? status;
  String? name;
  String? guestType;
  String? addedBy;
  String? dob;
  String? phoneno;
  int? iV;
  TicketIdproofs? idproofs;
  int? age;

  TicketGuest(
      {this.sId,
      this.status,
      this.name,
      this.guestType,
      this.addedBy,
      this.dob,
      this.phoneno,
      this.iV,
      this.idproofs,
      this.age});
  TicketGuest.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    name = json['name'];
    guestType = json['guestType'];
    addedBy = json['addedBy'];
    dob = json['dob'];
    phoneno = json['phoneno'];
    iV = json['__v'];
    idproofs = json['idproofs'] != null
        ? new TicketIdproofs.fromJson(json['idproofs'])
        : null;
    age = json['age'];
  }
}

class TicketIdproofs {
  List<String>? image;
  TicketIdproofs({this.image});
  TicketIdproofs.fromJson(Map<String, dynamic> json) {
    if (json['image'] != null) {
      image = <String>[];
      json['image'].forEach((v) {
        image!.add(v);
      });
    }
  }
}

class TicketSlotDetail {
  String? sId;
  String? status;
  String? slot;
  String? startTime;
  String? endTime;
  int? availableNo;
  int? iV;
  TicketSlotDetail(
      {this.sId,
      this.status,
      this.slot,
      this.startTime,
      this.endTime,
      this.availableNo,
      this.iV});
  TicketSlotDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    slot = json['slot'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    availableNo = json['availableNo'];
    iV = json['__v'];
  }
}

class TicketProgramme {
  String? sId;
  TicketCottage? cottage;
  bool? started;
  bool? isCottage;
  List<Null>? addons;
  List<String>? photos;
  String? status;
  List<Null>? inactiveStatus;
  String? category;
  String? caption;
  String? progName;
  String? description;
  String? startPoint;
  String? endPoint;
  int? duration;
  int? onlinePercent;
  int? minGuest;
  int? maxGuest;
  int? maxAge;
  int? minAge;
  String? reportingTime;
  String? rules;
  String? notes;
  int? iV;
  String? coverImage;
  TicketBookingAvailability? bookingAvailability;
  TicketProgramme(
      {this.sId,
      this.cottage,
      this.started,
      this.isCottage,
      this.addons,
      this.photos,
      this.status,
      this.inactiveStatus,
      this.category,
      this.caption,
      this.progName,
      this.description,
      this.startPoint,
      this.endPoint,
      this.duration,
      this.onlinePercent,
      this.minGuest,
      this.maxGuest,
      this.maxAge,
      this.minAge,
      this.reportingTime,
      this.rules,
      this.notes,
      this.iV,
      this.coverImage,
      this.bookingAvailability});
  TicketProgramme.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cottage = json['cottage'] != null
        ? new TicketCottage.fromJson(json['cottage'])
        : null;
    started = json['started'];
    isCottage = json['isCottage'];
    photos = json['photos'].cast<String>();
    status = json['status'];
    category = json['category'];
    caption = json['caption'];
    progName = json['progName'];
    description = json['description'];
    startPoint = json['startPoint'];
    endPoint = json['endPoint'];
    duration = json['duration'];
    onlinePercent = json['onlinePercent'];
    minGuest = json['minGuest'];
    maxGuest = json['maxGuest'];
    maxAge = json['maxAge'];
    minAge = json['minAge'];
    reportingTime = json['reportingTime'];
    rules = json['rules'];
    notes = json['notes'];
    iV = json['__v'];
    coverImage = json['coverImage'];
    bookingAvailability = json['bookingAvailability'] != null
        ? new TicketBookingAvailability.fromJson(json['bookingAvailability'])
        : null;
  }
}

class TicketBookingAvailability {
  bool? indian;
  bool? foreigner;
  bool? children;
  TicketBookingAvailability({this.indian, this.foreigner, this.children});
  TicketBookingAvailability.fromJson(Map<String, dynamic> json) {
    indian = json['indian'];
    foreigner = json['foreigner'];
    children = json['children'];
  }
}

class TicketCottage {
  String? schedule;
  int? maxExtraChildrenCount;
  int? maxExtraForeignerCount;
  int? maxExtraGuestCount;
  int? maxExtraIndianCount;
  int? guestPerRoom;
  TicketCottage(
      {this.schedule,
      this.maxExtraChildrenCount,
      this.maxExtraForeignerCount,
      this.maxExtraGuestCount,
      this.maxExtraIndianCount,
      this.guestPerRoom});
  TicketCottage.fromJson(Map<String, dynamic> json) {
    schedule = json['schedule'];
    // maxExtraChildrenCount = json['maxExtraChildrenCount'];
    // maxExtraForeignerCount = json['maxExtraForeignerCount'];
    // maxExtraGuestCount = json['maxExtraGuestCount'];
    // maxExtraIndianCount = json['maxExtraIndianCount'];
    guestPerRoom = json['guestPerRoom'];
  }
}
