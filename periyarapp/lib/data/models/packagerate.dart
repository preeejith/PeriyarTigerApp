class PackageRate {
  bool? status;
  Data? data;
  List<Package>? package;

  PackageRate({this.status, this.data, this.package});

  PackageRate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['package'] != null) {
      package = <Package>[];
      json['package'].forEach((v) {
        package!.add(new Package.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.package != null) {
      data['package'] = this.package!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  BookingAvailability? bookingAvailability;
  Cottage? cottage;
  bool? started;
  bool? isCottage;
  List<Null>? addons;
  List<String>? photos;
  String? status;
  String? sId;
  List<Null>? inactiveStatus;
  Category? category;
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

  Data(
      {this.bookingAvailability,
      this.cottage,
      this.started,
      this.isCottage,
      this.addons,
      this.photos,
      this.status,
      this.sId,
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
      this.coverImage});

  Data.fromJson(Map<String, dynamic> json) {
    bookingAvailability = json['bookingAvailability'] != null
        ? new BookingAvailability.fromJson(json['bookingAvailability'])
        : null;
    cottage =
        json['cottage'] != null ? new Cottage.fromJson(json['cottage']) : null;
    started = json['started'];
    isCottage = json['isCottage'];
    if (json['addons'] != null) {
      addons = <Null>[];
      // json['addons'].forEach((v) {
      //   addons!.add(new Null.fromJson(v));
      // });
    }
    photos = json['photos'].cast<String>();
    status = json['status'];
    sId = json['_id'];
    // if (json['inactiveStatus'] != null) {
    //   inactiveStatus = <Null>[];
    //   json['inactiveStatus'].forEach((v) {
    //     inactiveStatus!.add(new Null.fromJson(v));
    //   });
    // }
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingAvailability != null) {
      data['bookingAvailability'] = this.bookingAvailability!.toJson();
    }
    if (this.cottage != null) {
      data['cottage'] = this.cottage!.toJson();
    }
    data['started'] = this.started;
    data['isCottage'] = this.isCottage;
    // if (this.addons != null) {
    //   data['addons'] = this.addons!.map((v) => v.toJson()).toList();
    // }
    data['photos'] = this.photos;
    data['status'] = this.status;
    data['_id'] = this.sId;
    // if (this.inactiveStatus != null) {
    //   data['inactiveStatus'] =
    //       this.inactiveStatus!.map((v) => v.toJson()).toList();
    // }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['caption'] = this.caption;
    data['progName'] = this.progName;
    data['description'] = this.description;
    data['startPoint'] = this.startPoint;
    data['endPoint'] = this.endPoint;
    data['duration'] = this.duration;
    data['onlinePercent'] = this.onlinePercent;
    data['minGuest'] = this.minGuest;
    data['maxGuest'] = this.maxGuest;
    data['maxAge'] = this.maxAge;
    data['minAge'] = this.minAge;
    data['reportingTime'] = this.reportingTime;
    data['rules'] = this.rules;
    data['notes'] = this.notes;
    data['__v'] = this.iV;
    data['coverImage'] = this.coverImage;
    return data;
  }
}

class BookingAvailability {
  bool? indian;
  bool? foreigner;
  bool? children;

  BookingAvailability({this.indian, this.foreigner, this.children});

  BookingAvailability.fromJson(Map<String, dynamic> json) {
    indian = json['indian'];
    foreigner = json['foreigner'];
    children = json['children'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['indian'] = this.indian;
    data['foreigner'] = this.foreigner;
    data['children'] = this.children;
    return data;
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
  List<Null>? activities;

  Cottage({
    this.activities,
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
    maxExtraGuestCount = json['maxExtraGuestCount'];
    maxExtraIndianCount = json['maxExtraIndianCount'];
    maxExtraForeignerCount = json['maxExtraForeignerCount'];
    maxExtraChildrenCount = json['maxExtraChildrenCount'];
    guestPerRoom = json['guestPerRoom'];
    maxTotalGuests = json['maxTotalGuests'];
    maxTotalIndians = json['maxTotalIndians'];
    maxTotalForeigners = json['maxTotalForeigners'];
    maxTotalChildren = json['maxTotalChildren'];

    if (json['activities'] != null) {
      activities = <Null>[];
      // json['activities'].forEach((v) {
      //   activities!.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maxExtraGuestCount'] = this.maxExtraGuestCount;
    data['maxExtraIndianCount'] = this.maxExtraIndianCount;
    data['maxExtraForeignerCount'] = this.maxExtraForeignerCount;
    data['maxExtraChildrenCount'] = this.maxExtraChildrenCount;
    // if (this.activities != null) {
    //   data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Category {
  String? status;
  String? sId;
  String? name;
  int? iV;

  Category({this.status, this.sId, this.name, this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['__v'] = this.iV;
    return data;
  }
}

class Package {
  Holidays? holidays;
  Weekend? weekend;
  Extraperhead? extraperhead;
  List<String>? packageFacility;
  bool? isExtraPerHeadAvailable;
  String? sId;
  String? fromDate;
  String? toDate;
  int? indian;
  int? children;
  int? foreigner;
  String? programme;
  int? iV;

  Package(
      {this.holidays,
      this.weekend,
      this.extraperhead,
      this.packageFacility,
      this.isExtraPerHeadAvailable,
      this.sId,
      this.fromDate,
      this.toDate,
      this.indian,
      this.children,
      this.foreigner,
      this.programme,
      this.iV});

  Package.fromJson(Map<String, dynamic> json) {
    holidays = json['holidays'] != null
        ? new Holidays.fromJson(json['holidays'])
        : null;
    extraperhead = json['extraperhead'] != null
        ? new Extraperhead.fromJson(json['extraperhead'])
        : null;
    weekend =
        json['weekend'] != null ? new Weekend.fromJson(json['weekend']) : null;
    packageFacility = json['packageFacility'].cast<String>();
    isExtraPerHeadAvailable = json['isExtraPerHeadAvailable'];
    sId = json['_id'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    indian = json['indian'];
    children = json['children'];
    foreigner = json['foreigner'];
    programme = json['programme'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.holidays != null) {
      data['holidays'] = this.holidays!.toJson();
    }
    // if (this.extraperhead != null) {
    //   data['extraperhead'] = this.extraperhead!.toJson();
    // }
    data['packageFacility'] = this.packageFacility;
    data['isExtraPerHeadAvailable'] = this.isExtraPerHeadAvailable;
    data['_id'] = this.sId;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['indian'] = this.indian;
    data['children'] = this.children;
    data['foreigner'] = this.foreigner;
    data['programme'] = this.programme;
    data['__v'] = this.iV;
    return data;
  }
}

class Extraperhead {
  int? indianAdult,
      indianStudent,
      foreignAdult,
      foreignStudent,
      bonafiedStudent,
      children,
      foreigner,
      indian;
  Extraperhead({
    this.bonafiedStudent,
    this.children,
    this.foreignAdult,
    this.foreignStudent,
    this.foreigner,
    this.indian,
    this.indianAdult,
    this.indianStudent,
  });
  Extraperhead.fromJson(Map<String, dynamic> json) {
    indianAdult = json['indianAdult'];
    indianStudent = json['indianStudent'];
    foreignAdult = json['foreignAdult'];
    foreignStudent = json['foreignStudent'];
    bonafiedStudent = json['bonafiedStudent'];
    children = json['children'];
    indian = json['indian'];
    foreigner = json['foreigner'];
  }
}

class Weekend {
  int? indianAdult,
      indianStudent,
      foreignAdult,
      foreignStudent,
      bonafiedStudent;
  Weekend(
      {this.bonafiedStudent,
      this.foreignAdult,
      this.foreignStudent,
      this.indianAdult,
      this.indianStudent});
  Weekend.fromJson(Map<String, dynamic> json) {
    indianAdult = json['indianAdult'];
    indianStudent = json['indianStudent'];
    foreignAdult = json['foreignAdult'];
    foreignStudent = json['foreignStudent'];
    bonafiedStudent = json['bonafiedStudent'];
  }
}

class Holidays {
  int? indian,
      children,
      foreigner,
      indianAdult,
      indianStudent,
      foreignAdult,
      foreignStudent,
      bonafiedStudent;

  Holidays({
    this.indian,
    this.children,
    this.foreigner,
    this.bonafiedStudent,
    this.foreignAdult,
    this.foreignStudent,
    this.indianAdult,
    this.indianStudent,
  });

  Holidays.fromJson(Map<String, dynamic> json) {
    indian = json['indian'];
    children = json['children'];
    foreigner = json['foreigner'];
    bonafiedStudent = json['bonafiedStudent'];
    foreignAdult = json['foreignAdult'];
    foreignStudent = json['foreignStudent'];
    indianAdult = json['indianAdult'];
    indianStudent = json['indianStudent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['indian'] = this.indian;
    data['children'] = this.children;
    data['foreigner'] = this.foreigner;
    return data;
  }
}
