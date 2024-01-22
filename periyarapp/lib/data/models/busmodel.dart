class BusModel {
  bool? status;
  List<BusData>? data;
  String? msg;

  BusModel({this.status, this.data, this.msg});

  BusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BusData>[];
      json['data'].forEach((v) {
        data!.add(new BusData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class BusData {
  String? status;
  List<String>? unitincharge;
  String? sId, tripId;
  String? type;
  String? name;
  String? unitUnderIc;
  String? description;
  String? createDate;
  String? updateDate;
  int? iV;
  BusDetails? busDetails;

  BusData(
      {this.status,
      this.unitincharge,
      this.sId,
      this.type,
      this.name,
      this.unitUnderIc,
      this.description,
      this.createDate,
      this.updateDate,
      this.iV,
      this.busDetails});

  BusData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    unitincharge = json['unitincharge'].cast<String>();
    sId = json['_id'];
    type = json['type'];
    name = json['name'];
    unitUnderIc = json['unitUnderIc'];
    description = json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
    busDetails = json['busDetails'] != null
        ? new BusDetails.fromJson(json['busDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['unitincharge'] = this.unitincharge;
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['name'] = this.name;
    data['unitUnderIc'] = this.unitUnderIc;
    data['description'] = this.description;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    data['__v'] = this.iV;
    if (this.busDetails != null) {
      data['busDetails'] = this.busDetails!.toJson();
    }
    return data;
  }
}

class BusDetails {
  String? status;
  String? sId;
  String? busId, tripId;
  bool? isActive;
  int? tripCount;
  List<Tickets>? tickets;
  int? noOfPassengers;
  String? regNo;
  int? noOfSeats, noOfSeatsDummy;
  String? busName;
  String? createDate;
  String? updateDate;
  int? iV;

  BusDetails(
      {this.status,
      this.tripId,
      this.tickets,
      this.tripCount = 0,
      this.sId,
      this.isActive,
      this.noOfSeatsDummy,
      this.noOfPassengers = 0,
      this.busId,
      this.regNo,
      this.noOfSeats,
      this.busName,
      this.createDate,
      this.updateDate,
      this.iV});

  BusDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    busId = json['busId'];
    regNo = json['regNo'];
    noOfSeats = json['noOfSeats'];
    busName = json['busName'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['busId'] = this.busId;
    data['regNo'] = this.regNo;
    data['noOfSeats'] = this.noOfSeats;
    data['busName'] = this.busName;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    data['__v'] = this.iV;
    return data;
  }
}

class Tickets {
  String? ticketId, numberOfMembers;
  Tickets({
    this.ticketId,
    this.numberOfMembers,
  });
}
