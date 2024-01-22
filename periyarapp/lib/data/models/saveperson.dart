class SavePersonResponse {
  bool? status;
  String? id;
  SavePersonResponseData? data;
  List<String>? cartGuests;
  String? msg;

  SavePersonResponse(
      {this.status, this.id, this.data, this.cartGuests, this.msg});

  SavePersonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    data = json['data'] != null ? new SavePersonResponseData.fromJson(json['data']) : null;
    cartGuests = json['cartGuests'].cast<String>();
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['cartGuests'] = this.cartGuests;
    data['msg'] = this.msg;
    return data;
  }
}

class SavePersonResponseData {
  String? status;
  String? sId;
  String? name;
  String? guestType;
  String? addedBy;
  String? dob;
  int? iV;

  SavePersonResponseData(
      {this.status,
      this.sId,
      this.name,
      this.guestType,
      this.addedBy,
      this.dob,
      this.iV});

  SavePersonResponseData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    guestType = json['guestType'];
    addedBy = json['addedBy'];
    dob = json['dob'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['guestType'] = this.guestType;
    data['addedBy'] = this.addedBy;
    data['dob'] = this.dob;
    data['__v'] = this.iV;
    return data;
  }
}
