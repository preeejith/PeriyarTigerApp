class IbReservationModel {
  IbReservationModel({
    this.status,
    this.data,
    this.msg,
  });

  IbReservationModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  bool? status;
  Data? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['msg'] = msg;
    return map;
  }
}

class Data {
  Data({
    this.reserved,
    this.status,
    this.foodPreference,
    this.vehicleNumbers,
    this.id,
    this.bookingDate,
    this.slotDetail,
    this.guestName,
    this.numberOfAccompanyigPersons,
    this.guestPhone,
    this.referee,
    this.refereePhone,
    this.email,
    this.numberOfVehicles,
    this.details,
    this.v,
  });

  Data.fromJson(dynamic json) {
    reserved = json['reserved'];
    status = json['status'];
    foodPreference = json['foodPreference'] != null
        ? json['foodPreference'].cast<String>()
        : [];
    vehicleNumbers = json['vehicleNumbers'] != null
        ? json['vehicleNumbers'].cast<String>()
        : [];
    id = json['_id'];
    bookingDate = json['bookingDate'];
    slotDetail = json['slotDetail'];
    guestName = json['guestName'];
    numberOfAccompanyigPersons = json['numberOfAccompanyigPersons'];
    guestPhone = json['guestPhone'];
    referee = json['referee'];
    refereePhone = json['refereePhone'];
    email = json['email'];
    numberOfVehicles = json['numberOfVehicles'];
    details = json['details'];
    v = json['__v'];
  }
  int? reserved;
  String? status;
  List<String>? foodPreference;
  List<String>? vehicleNumbers;
  String? id;
  String? bookingDate;
  String? slotDetail;
  String? guestName;
  int? numberOfAccompanyigPersons;
  String? guestPhone;
  String? referee;
  String? refereePhone;
  String? email;
  int? numberOfVehicles;
  String? details;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reserved'] = reserved;
    map['status'] = status;
    map['foodPreference'] = foodPreference;
    map['vehicleNumbers'] = vehicleNumbers;
    map['_id'] = id;
    map['bookingDate'] = bookingDate;
    map['slotDetail'] = slotDetail;
    map['guestName'] = guestName;
    map['numberOfAccompanyigPersons'] = numberOfAccompanyigPersons;
    map['guestPhone'] = guestPhone;
    map['referee'] = referee;
    map['refereePhone'] = refereePhone;
    map['email'] = email;
    map['numberOfVehicles'] = numberOfVehicles;
    map['details'] = details;
    map['__v'] = v;
    return map;
  }
}
