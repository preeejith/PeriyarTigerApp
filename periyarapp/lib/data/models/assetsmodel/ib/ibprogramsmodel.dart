///model chnaged

// class IbProgramsModel {
//   IbProgramsModel({
//     this.status,
//     this.data,
//     this.package,
//     this.dateType,
//   });

//   IbProgramsModel.fromJson(dynamic json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(Data.fromJson(v));
//       });
//     }
//     package = json['package'];
//     dateType = json['dateType'];
//   }
//   bool? status;
//   List<Data>? data;
//   dynamic package;
//   dynamic dateType;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     if (data != null) {
//       map['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     map['package'] = package;
//     map['dateType'] = dateType;
//     return map;
//   }
// }

// class Data {
//   Data({
//     this.bookingAvailability,
//     this.cottage,
//     this.started,
//     this.isCottage,
//     this.addons,
//     this.photos,
//     this.status,
//     this.id,
//     this.inactiveStatus,
//     this.category,
//     this.caption,
//     this.progName,
//     this.description,
//     this.startPoint,
//     this.endPoint,
//     this.duration,
//     this.onlinePercent,
//     this.minGuest,
//     this.maxGuest,
//     this.maxAge,
//     this.minAge,
//     this.reportingTime,
//     this.rules,
//     this.notes,
//     this.v,
//     this.coverImage,
//   });

//   Data.fromJson(dynamic json) {
//     bookingAvailability = json['bookingAvailability'] != null
//         ? BookingAvailability.fromJson(json['bookingAvailability'])
//         : null;
//     cottage =
//         json['cottage'] != null ? Cottage.fromJson(json['cottage']) : null;
//     started = json['started'];
//     isCottage = json['isCottage'];
//     if (json['addons'] != null) {
//       addons = [];
//       json['addons'].forEach((v) {
//         addons?.add((v));
//       });
//     }
//     photos = json['photos'] != null ? json['photos'].cast<String>() : [];
//     status = json['status'];
//     id = json['_id'];
//     if (json['inactiveStatus'] != null) {
//       inactiveStatus = [];
//       json['inactiveStatus'].forEach((v) {
//         inactiveStatus?.add((v));
//       });
//     }
//     category = json['category'];
//     caption = json['caption'];
//     progName = json['progName'];
//     description = json['description'];
//     startPoint = json['startPoint'];
//     endPoint = json['endPoint'];
//     duration = json['duration'];
//     onlinePercent = json['onlinePercent'];
//     minGuest = json['minGuest'];
//     maxGuest = json['maxGuest'];
//     maxAge = json['maxAge'];
//     minAge = json['minAge'];
//     reportingTime = json['reportingTime'];
//     rules = json['rules'];
//     notes = json['notes'];
//     v = json['__v'];
//     coverImage = json['coverImage'];
//   }
//   BookingAvailability? bookingAvailability;
//   Cottage? cottage;
//   bool? started;
//   bool? isCottage;
//   List<dynamic>? addons;
//   List<String>? photos;
//   String? status;
//   String? id;
//   List<dynamic>? inactiveStatus;
//   String? category;
//   String? caption;
//   String? progName;
//   String? description;
//   String? startPoint;
//   String? endPoint;
//   int? duration;
//   int? onlinePercent;
//   int? minGuest;
//   int? maxGuest;
//   int? maxAge;
//   int? minAge;
//   String? reportingTime;
//   String? rules;
//   String? notes;
//   int? v;
//   String? coverImage;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (bookingAvailability != null) {
//       map['bookingAvailability'] = bookingAvailability?.toJson();
//     }
//     if (cottage != null) {
//       map['cottage'] = cottage?.toJson();
//     }
//     map['started'] = started;
//     map['isCottage'] = isCottage;
//     if (addons != null) {
//       map['addons'] = addons?.map((v) => v.toJson()).toList();
//     }
//     map['photos'] = photos;
//     map['status'] = status;
//     map['_id'] = id;
//     if (inactiveStatus != null) {
//       map['inactiveStatus'] = inactiveStatus?.map((v) => v.toJson()).toList();
//     }
//     map['category'] = category;
//     map['caption'] = caption;
//     map['progName'] = progName;
//     map['description'] = description;
//     map['startPoint'] = startPoint;
//     map['endPoint'] = endPoint;
//     map['duration'] = duration;
//     map['onlinePercent'] = onlinePercent;
//     map['minGuest'] = minGuest;
//     map['maxGuest'] = maxGuest;
//     map['maxAge'] = maxAge;
//     map['minAge'] = minAge;
//     map['reportingTime'] = reportingTime;
//     map['rules'] = rules;
//     map['notes'] = notes;
//     map['__v'] = v;
//     map['coverImage'] = coverImage;
//     return map;
//   }
// }

// class Cottage {
//   Cottage({
//     this.maxExtraGuestCount,
//     this.maxExtraIndianCount,
//     this.maxExtraForeignerCount,
//     this.maxExtraChildrenCount,
//     this.activities,
//   });

//   Cottage.fromJson(dynamic json) {
//     maxExtraGuestCount = json['maxExtraGuestCount'];
//     maxExtraIndianCount = json['maxExtraIndianCount'];
//     maxExtraForeignerCount = json['maxExtraForeignerCount'];
//     maxExtraChildrenCount = json['maxExtraChildrenCount'];
//     if (json['activities'] != null) {
//       activities = [];
//       json['activities'].forEach((v) {
//         activities?.add((v));
//       });
//     }
//   }
//   int? maxExtraGuestCount;
//   int? maxExtraIndianCount;
//   int? maxExtraForeignerCount;
//   int? maxExtraChildrenCount;
//   List<dynamic>? activities;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['maxExtraGuestCount'] = maxExtraGuestCount;
//     map['maxExtraIndianCount'] = maxExtraIndianCount;
//     map['maxExtraForeignerCount'] = maxExtraForeignerCount;
//     map['maxExtraChildrenCount'] = maxExtraChildrenCount;
//     if (activities != null) {
//       map['activities'] = activities?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

// class BookingAvailability {
//   BookingAvailability({
//     this.indian,
//     this.foreigner,
//     this.children,
//   });

//   BookingAvailability.fromJson(dynamic json) {
//     indian = json['indian'];
//     foreigner = json['foreigner'];
//     children = json['children'];
//   }
//   bool? indian;
//   bool? foreigner;
//   bool? children;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['indian'] = indian;
//     map['foreigner'] = foreigner;
//     map['children'] = children;
//     return map;
//   }
// }
//

class IbProgramsModel {
  IbProgramsModel({
    this.status,
    this.data,
    this.programData,
  });

  IbProgramsModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    if (json['programData'] != null) {
      programData = [];
      json['programData'].forEach((v) {
        programData?.add(ProgramData.fromJson(v));
      });
    }
  }
  bool? status;
  List<Data>? data;
  List<ProgramData>? programData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (programData != null) {
      map['programData'] = programData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProgramData {
  ProgramData({
    this.bookingAvailability,
    this.cottage,
    this.started,
    this.isCottage,
    this.addons,
    this.photos,
    this.status,
    this.id,
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
    this.v,
    this.coverImage,
  });

  ProgramData.fromJson(dynamic json) {
    bookingAvailability = json['bookingAvailability'] != null
        ? BookingAvailability.fromJson(json['bookingAvailability'])
        : null;
    cottage =
        json['cottage'] != null ? Cottage.fromJson(json['cottage']) : null;
    started = json['started'];
    isCottage = json['isCottage'];
    if (json['addons'] != null) {
      addons = [];
      json['addons'].forEach((v) {
        addons?.add((v));
      });
    }
    photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    status = json['status'];
    id = json['_id'];
    if (json['inactiveStatus'] != null) {
      inactiveStatus = [];
      json['inactiveStatus'].forEach((v) {
        inactiveStatus?.add((v));
      });
    }
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
    v = json['__v'];
    coverImage = json['coverImage'];
  }
  BookingAvailability? bookingAvailability;
  Cottage? cottage;
  bool? started;
  bool? isCottage;
  List<dynamic>? addons;
  List<String>? photos;
  String? status;
  String? id;
  List<dynamic>? inactiveStatus;
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
  int? v;
  String? coverImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (bookingAvailability != null) {
      map['bookingAvailability'] = bookingAvailability?.toJson();
    }
    if (cottage != null) {
      map['cottage'] = cottage?.toJson();
    }
    map['started'] = started;
    map['isCottage'] = isCottage;
    if (addons != null) {
      map['addons'] = addons?.map((v) => v.toJson()).toList();
    }
    map['photos'] = photos;
    map['status'] = status;
    map['_id'] = id;
    if (inactiveStatus != null) {
      map['inactiveStatus'] = inactiveStatus?.map((v) => v.toJson()).toList();
    }
    map['category'] = category;
    map['caption'] = caption;
    map['progName'] = progName;
    map['description'] = description;
    map['startPoint'] = startPoint;
    map['endPoint'] = endPoint;
    map['duration'] = duration;
    map['onlinePercent'] = onlinePercent;
    map['minGuest'] = minGuest;
    map['maxGuest'] = maxGuest;
    map['maxAge'] = maxAge;
    map['minAge'] = minAge;
    map['reportingTime'] = reportingTime;
    map['rules'] = rules;
    map['notes'] = notes;
    map['__v'] = v;
    map['coverImage'] = coverImage;
    return map;
  }
}

class Cottage {
  Cottage({
    this.maxExtraGuestCount,
    this.maxExtraIndianCount,
    this.maxExtraForeignerCount,
    this.maxExtraChildrenCount,
    this.activities,
    this.schedule,
    this.guestPerRoom,
    this.maxTotalGuests,
    this.maxTotalIndians,
    this.maxTotalForeigners,
    this.maxTotalChildren,
  });

  Cottage.fromJson(dynamic json) {
    maxExtraGuestCount = json['maxExtraGuestCount'];
    maxExtraIndianCount = json['maxExtraIndianCount'];
    maxExtraForeignerCount = json['maxExtraForeignerCount'];
    maxExtraChildrenCount = json['maxExtraChildrenCount'];
    activities =
        json['activities'] != null ? json['activities'].cast<String>() : [];
    schedule = json['schedule'];
    guestPerRoom = json['guestPerRoom'];
    maxTotalGuests = json['maxTotalGuests'];
    maxTotalIndians = json['maxTotalIndians'];
    maxTotalForeigners = json['maxTotalForeigners'];
    maxTotalChildren = json['maxTotalChildren'];
  }
  int? maxExtraGuestCount;
  int? maxExtraIndianCount;
  int? maxExtraForeignerCount;
  int? maxExtraChildrenCount;
  List<String>? activities;
  String? schedule;
  int? guestPerRoom;
  int? maxTotalGuests;
  int? maxTotalIndians;
  int? maxTotalForeigners;
  int? maxTotalChildren;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maxExtraGuestCount'] = maxExtraGuestCount;
    map['maxExtraIndianCount'] = maxExtraIndianCount;
    map['maxExtraForeignerCount'] = maxExtraForeignerCount;
    map['maxExtraChildrenCount'] = maxExtraChildrenCount;
    map['activities'] = activities;
    map['schedule'] = schedule;
    map['guestPerRoom'] = guestPerRoom;
    map['maxTotalGuests'] = maxTotalGuests;
    map['maxTotalIndians'] = maxTotalIndians;
    map['maxTotalForeigners'] = maxTotalForeigners;
    map['maxTotalChildren'] = maxTotalChildren;
    return map;
  }
}

class BookingAvailability {
  BookingAvailability({
    this.indian,
    this.foreigner,
    this.children,
  });

  BookingAvailability.fromJson(dynamic json) {
    indian = json['indian'];
    foreigner = json['foreigner'];
    children = json['children'];
  }
  bool? indian;
  bool? foreigner;
  bool? children;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['indian'] = indian;
    map['foreigner'] = foreigner;
    map['children'] = children;
    return map;
  }
}

class Data {
  Data({
    this.status,
    this.id,
    this.slot,
    this.startTime,
    this.endTime,
    this.availableNo,
    this.v,
  });

  Data.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    slot = json['slot'] != null ? Slot.fromJson(json['slot']) : null;
    startTime = json['startTime'];
    endTime = json['endTime'];
    availableNo = json['availableNo'];
    v = json['__v'];
  }
  String? status;
  String? id;
  Slot? slot;
  String? startTime;
  String? endTime;
  int? availableNo;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    if (slot != null) {
      map['slot'] = slot?.toJson();
    }
    map['startTime'] = startTime;
    map['endTime'] = endTime;
    map['availableNo'] = availableNo;
    map['__v'] = v;
    return map;
  }
}

class Slot {
  Slot({
    this.isDaywise,
    this.status,
    this.id,
    this.programme,
    this.fromDate,
    this.toDate,
    this.slotType,
    this.v,
  });

  Slot.fromJson(dynamic json) {
    if (json['isDaywise'] != null) {
      isDaywise = [];
      json['isDaywise'].forEach((v) {
        isDaywise?.add((v));
      });
    }
    status = json['status'];
    id = json['_id'];
    programme = json['programme'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    slotType = json['slotType'];
    v = json['__v'];
  }
  List<dynamic>? isDaywise;
  String? status;
  String? id;
  String? programme;
  String? fromDate;
  String? toDate;
  String? slotType;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (isDaywise != null) {
      map['isDaywise'] = isDaywise?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['_id'] = id;
    map['programme'] = programme;
    map['fromDate'] = fromDate;
    map['toDate'] = toDate;
    map['slotType'] = slotType;
    map['__v'] = v;
    return map;
  }
}
