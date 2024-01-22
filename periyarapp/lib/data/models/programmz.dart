class Programmz {
  bool? status;
  List<ProgrammData>? programData;
  List<PackageData>? packageData;
  String? dateType;
  Programmz({this.status, this.programData});
  Programmz.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dateType = json['dateType'];
    if (json['data'] != null) {
      programData = <ProgrammData>[];
      json['data'].forEach((v) {
        programData!.add(new ProgrammData.fromJson(v));
      });
    }
    if (json['package'] != null) {
      packageData = <PackageData>[];
      json['package'].forEach((v) {
        packageData!.add(new PackageData.fromJson(v));
      });
    } else {
      json['package'] = null;
    }
  }
}

class PackageData {
  WeekendPackage? weekendPackage;
  HolydaysPackage? holydaysPackage;
  ExtraperheadPackage? extraperheadPackage;
  int? nindianAdult,
      nindianStudent,
      nforeignAdult,
      nforeignStudent,
      nbonafiedStudent,
      children,
      foreigner,
      indian;
  bool? isExtraPerHeadAvailable;
  String? id, fromDate, toDate, programme;
  PackageData({
    this.weekendPackage,
    this.holydaysPackage,
    this.extraperheadPackage,
    this.children,
    this.foreigner,
    this.fromDate,
    this.id,
    this.indian,
    this.isExtraPerHeadAvailable,
    this.nbonafiedStudent,
    this.nforeignAdult,
    this.nforeignStudent,
    this.nindianAdult,
    this.nindianStudent,
    this.programme,
    this.toDate,
  });
  PackageData.fromJson(Map<String, dynamic> json) {
    weekendPackage = json['weekend'] != null
        ? new WeekendPackage.fromJson(json['weekend'])
        : null;
    holydaysPackage = json['holidays'] != null
        ? new HolydaysPackage.fromJson(json['holidays'])
        : null;
    extraperheadPackage = json['extraperhead'] != null
        ? new ExtraperheadPackage.fromJson(json['extraperhead'])
        : null;
    nindianAdult = json['indianAdult'];
    nindianStudent = json['indianStudent'];
    nforeignAdult = json['foreignAdult'];
    nforeignStudent = json['foreignStudent'];
    nbonafiedStudent = json['bonafiedStudent'];
    children = json['children'];
    foreigner = json['foreigner'];
    indian = json['indian'];

    isExtraPerHeadAvailable = json['isExtraPerHeadAvailable'];
    id = json['_id'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    programme = json['programme'];
  }
}

class ExtraperheadPackage {
  int? eindianAdult,
      eindianStudent,
      eforeignAdult,
      eforeignStudent,
      ebonafiedStudent,
      echildren,
      eforeigner,
      eindian;
  ExtraperheadPackage({
    this.ebonafiedStudent,
    this.echildren,
    this.eforeignAdult,
    this.eforeignStudent,
    this.eforeigner,
    this.eindian,
    this.eindianAdult,
    this.eindianStudent,
  });
  ExtraperheadPackage.fromJson(Map<String, dynamic> json) {
    eindianAdult = json['indianAdult'];
    eindianStudent = json['indianStudent'];
    eforeignAdult = json['foreignAdult'];
    eforeignStudent = json['foreignStudent'];
    ebonafiedStudent = json['bonafiedStudent'];
    echildren = json['children'];
    eforeigner = json['foreigner'];
    eindian = json['indian'];
  }
}

class HolydaysPackage {
  int? hindianAdult,
      hindianStudent,
      hforeignAdult,
      hforeignStudent,
      hbonafiedStudent,
      hchildren,
      hforeigner,
      hindian;
  HolydaysPackage({
    this.hbonafiedStudent,
    this.hchildren,
    this.hforeignAdult,
    this.hforeignStudent,
    this.hforeigner,
    this.hindian,
    this.hindianAdult,
    this.hindianStudent,
  });
  HolydaysPackage.fromJson(Map<String, dynamic> json) {
    hindianAdult = json['indianAdult'];
    hindianStudent = json['indianStudent'];
    hforeignAdult = json['foreignAdult'];
    hforeignStudent = json['foreignStudent'];
    hbonafiedStudent = json['bonafiedStudent'];
    hchildren = json['children'];
    hforeigner = json['foreigner'];
    hindian = json['indian'];
  }
}

class WeekendPackage {
  int? windianAdult,
      windianStudent,
      wforeignAdult,
      wforeignStudent,
      wbonafiedStudent;
  WeekendPackage({
    this.wbonafiedStudent,
    this.wforeignAdult,
    this.wforeignStudent,
    this.windianAdult,
    this.windianStudent,
  });
  WeekendPackage.fromJson(Map<String, dynamic> json) {
    windianAdult = json['indianAdult'];
    windianStudent = json['indianStudent'];
    wforeignAdult = json['foreignAdult'];
    wforeignStudent = json['foreignStudent'];
    wbonafiedStudent = json['bonafiedStudent'];
  }
}

class ProgrammData {
  //List<String>? photos;
  BookingAvailability? bookingAvailability;
  Cottage? cottage;
  bool? started, isCottage;
  int? minGuest, maxGuest, maxAge, minAge;
  num? duration;
  String? status,
      id,
      progName,
      coverImage,
      category,
      caption,
      reportingTime,
      rules,
      startPoint,
      endPoint;
  ProgrammData({
    this.id,
    this.isCottage,
    this.progName,
    this.started,
    this.status,
    // this.photos,
    this.coverImage,
    this.bookingAvailability,
    this.caption,
    this.category,
    this.cottage,
    this.duration,
    this.endPoint,
    this.maxAge,
    this.maxGuest,
    this.minAge,
    this.minGuest,
    this.reportingTime,
    this.rules,
    this.startPoint,
  });
  ProgrammData.fromJson(Map<String, dynamic> json) {
    minGuest = json['minGuest'];
    maxGuest = json['maxGuest'];
    maxAge = json['maxAge'];
    minAge = json['minAge'];
    reportingTime = json['reportingTime'];
    rules = json['rules'];

    caption = json['caption'];
    startPoint = json['startPoint'];
    endPoint = json['endPoint'];
    duration = json['duration'] == null ? 0 : json['duration'];
    category = json['category'];

    started = json['started'];
    isCottage = json['isCottage'];
    status = json['status'];
    id = json['_id'];
    progName = json['progName'];
    coverImage = json['coverImage'];
    //   photos = json['photos'].cast<String>();
    bookingAvailability = json['bookingAvailability'] != null
        ? BookingAvailability.fromJson(json['bookingAvailability'])
        : null;
    cottage =
        json['cottage'] != null ? Cottage.fromJson(json['cottage']) : null;
  }

  Map<String, dynamic> toMap() {
    return {
      'started': started,
      'isCottage': isCottage,
      'status': status,
      'idString': id,
      'progName': progName,
      'coverImage': coverImage,
      'bookingAvailability': bookingAvailability!.toMap(),
      'cottage': cottage!.toMap(),
    };
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
  Cottage(
      {this.guestPerRoom,
      this.maxExtraChildrenCount,
      this.maxExtraForeignerCount,
      this.maxExtraGuestCount,
      this.maxExtraIndianCount,
      this.maxTotalChildren,
      this.maxTotalForeigners,
      this.maxTotalGuests,
      this.maxTotalIndians});
  Cottage.fromJson(Map<String, dynamic> json) {
    maxExtraGuestCount = json['maxExtraGuestCount'];
    maxExtraIndianCount = json['maxExtraIndianCount'];
    maxExtraForeignerCount = json['maxExtraForeignerCount'];
    maxExtraChildrenCount = json['maxExtraChildrenCount'];
    guestPerRoom = json['guestPerRoom'];
    maxTotalGuests = json['maxTotalGuests'];
    maxTotalIndians = json['maxTotalIndians'];
    maxTotalForeigners = json['maxTotalForeigners'];
    maxTotalChildren = json['maxTotalChildren'];
  }

  Map<String, dynamic> toMap() {
    return {
      'cottagemaxExtraGuestCount': maxExtraGuestCount,
      'cottagemaxExtraIndianCount': maxExtraIndianCount,
      'cottagemaxExtraForeignerCount': maxExtraForeignerCount,
      'cottagemaxExtraChildrenCount': maxExtraChildrenCount,
      'guestPerRoom': guestPerRoom,
      'maxTotalGuests': maxTotalGuests,
      'maxTotalIndians': maxTotalIndians,
      'maxTotalForeigners': maxTotalForeigners,
      'maxTotalChildren': maxTotalChildren,
    };
  }
}

class BookingAvailability {
  bool? indian, foreigner, children;
  BookingAvailability({this.children, this.foreigner, this.indian});
  BookingAvailability.fromJson(Map<String, dynamic> json) {
    indian = json['indian'];
    foreigner = json['foreigner'];
    children = json['children'];
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingAvailabilityindian': indian,
      'bookingAvailabilityforeigner': foreigner,
      'bookingAvailabilitychildren': children,
    };
  }
}


// // To parse this JSON data, do
// //
// //     final programmz = programmzFromJson(jsonString);

// import 'dart:convert';

// Programmz programmzFromJson(String str) => Programmz.fromJson(json.decode(str));

// String programmzToJson(Programmz data) => json.encode(data.toJson());

// class Programmz {
//   Programmz({
//     this.status,
//     this.data,
//   });

//   bool? status;
//   List<Datum>? data;

//   factory Programmz.fromJson(Map<String, dynamic> json) => Programmz(
//         status: json["status"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   Datum({
//     this.bookingAvailability,
//     this.cottage,
//     this.started,
//     this.isCottage,
//     this.addons,
//     this.photos,
//     this.status,
//     this.id,
//     this.inactiveStatus,
//     this.caption,
//     this.progName,
//     this.description,
//     this.startPoint,
//     this.endPoint,
//     this.duration,
//     this.minGuest,
//     this.maxGuest,
//     this.maxAge,
//     this.minAge,
//     this.reportingTime,
//     this.rules,
//     this.v,
//     this.category,
//     this.onlinePercent,
//     this.notes,
//     this.coverImage,
//   });

//   BookingAvailability? bookingAvailability;
//   Cottage? cottage;
//   bool? started;
//   bool? isCottage;
//   List<dynamic>? addons;
//   List<String>? photos;
//   String? status;
//   String? id;
//   List<dynamic>? inactiveStatus;
//   String? caption;
//   String? progName;
//   String? description;
//   String? startPoint;
//   String? endPoint;
//   int? duration;
//   int? minGuest;
//   int? maxGuest;
//   int? maxAge;
//   int? minAge;
//   String? reportingTime;
//   String? rules;
//   int? v;
//   String? category;
//   int? onlinePercent;
//   String? notes;
//   String? coverImage;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         bookingAvailability:
//             BookingAvailability.fromJson(json["bookingAvailability"]),
//         cottage: Cottage.fromJson(json["cottage"]),
//         started: json["started"],
//         isCottage: json["isCottage"],
//         addons: List<dynamic>.from(json["addons"].map((x) => x)),
//         photos: List<String>.from(json["photos"].map((x) => x)),
//         status: statusValues.map[json["status"]],
//         id: json["_id"],
//         inactiveStatus:
//             List<dynamic>.from(json["inactiveStatus"].map((x) => x)),
//         caption: json["caption"],
//         progName: json["progName"],
//         description: json["description"],
//         startPoint: json["startPoint"],
//         endPoint: json["endPoint"],
//         duration: json["duration"],
//         minGuest: json["minGuest"] == null ? null : json["minGuest"],
//         maxGuest: json["maxGuest"] == null ? null : json["maxGuest"],
//         maxAge: json["maxAge"],
//         minAge: json["minAge"],
//         reportingTime: json["reportingTime"],
//         rules: json["rules"],
//         v: json["__v"],
//         category: json["category"] == null ? null : json["category"],
//         onlinePercent:
//             json["onlinePercent"] == null ? null : json["onlinePercent"],
//         notes: json["notes"] == null ? null : json["notes"],
//         coverImage: json["coverImage"] == null ? null : json["coverImage"],
//       );

//   Map<String, dynamic> toJson() => {
//         "bookingAvailability": bookingAvailability!.toJson(),
//         "cottage": cottage!.toJson(),
//         "started": started,
//         "isCottage": isCottage,
//         "addons": List<dynamic>.from(addons!.map((x) => x)),
//         "photos": List<dynamic>.from(photos!.map((x) => x)),
//         "status": statusValues.reverse[status],
//         "_id": id,
//         "inactiveStatus": List<dynamic>.from(inactiveStatus!.map((x) => x)),
//         "caption": caption,
//         "progName": progName,
//         "description": description,
//         "startPoint": startPoint,
//         "endPoint": endPoint,
//         "duration": duration,
//         "minGuest": minGuest == null ? null : minGuest,
//         "maxGuest": maxGuest == null ? null : maxGuest,
//         "maxAge": maxAge,
//         "minAge": minAge,
//         "reportingTime": reportingTime,
//         "rules": rules,
//         "__v": v,
//         "category": category == null ? null : category,
//         "onlinePercent": onlinePercent == null ? null : onlinePercent,
//         "notes": notes == null ? null : notes,
//         "coverImage": coverImage == null ? null : coverImage,
//       };
// }

// class BookingAvailability {
//   BookingAvailability({
//     this.indian,
//     this.foreigner,
//     this.children,
//   });

//   bool? indian;
//   bool? foreigner;
//   bool? children;

//   factory BookingAvailability.fromJson(Map<String, dynamic> json) =>
//       BookingAvailability(
//         indian: json["indian"],
//         foreigner: json["foreigner"],
//         children: json["children"],
//       );

//   Map<String, dynamic> toJson() => {
//         "indian": indian,
//         "foreigner": foreigner,
//         "children": children,
//       };
// }

// class Cottage {
//   Cottage({
//     this.maxExtraGuestCount,
//     this.maxExtraIndianCount,
//     this.maxExtraForeignerCount,
//     this.maxExtraChildrenCount,
//     this.activities,
//     this.guestPerRoom,
//     this.schedule,
//   });

//   int? maxExtraGuestCount;
//   int? maxExtraIndianCount;
//   int? maxExtraForeignerCount;
//   int? maxExtraChildrenCount;
//   List<String>? activities;
//   int? guestPerRoom;
//   String? schedule;

//   factory Cottage.fromJson(Map<String, dynamic> json) => Cottage(
//         maxExtraGuestCount: json["maxExtraGuestCount"],
//         maxExtraIndianCount: json["maxExtraIndianCount"],
//         maxExtraForeignerCount: json["maxExtraForeignerCount"],
//         maxExtraChildrenCount: json["maxExtraChildrenCount"],
//         activities: List<String>.from(json["activities"].map((x) => x)),
//         guestPerRoom:
//             json["guestPerRoom"] == null ? null : json["guestPerRoom"],
//         schedule: json["schedule"] == null ? null : json["schedule"],
//       );

//   Map<String, dynamic> toJson() => {
//         "maxExtraGuestCount": maxExtraGuestCount,
//         "maxExtraIndianCount": maxExtraIndianCount,
//         "maxExtraForeignerCount": maxExtraForeignerCount,
//         "maxExtraChildrenCount": maxExtraChildrenCount,
//         "activities": List<dynamic>.from(activities!.map((x) => x)),
//         "guestPerRoom": guestPerRoom == null ? null : guestPerRoom,
//         "schedule": schedule == null ? null : schedule,
//       };
// }

// enum Status { ACTIVE }

// final statusValues = EnumValues({"Active": Status.ACTIVE});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     // if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     // }
//     return reverseMap;
//   }
// }

// // class Booking {
// //   bool? status;
// //   Data? data;
// //   Booking({this.data, this.status});
// //   Booking.fromJson(Map<String, dynamic> json) {
// //     status = json['status'];
// //     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
// //   }
// // }

// // class Data {
// //   List<Upcoming>? upcoming;
// //   Data({this.upcoming});
// //   Data.fromJson(Map<String, dynamic>json){

// //   }
// // }

// // class Upcoming{

// // }