class DamageRequestAcceptModel {
  DamageRequestAcceptModel({
      this.status, 
      this.msg, 
      this.data,});

  DamageRequestAcceptModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? msg;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.productIds, 
      this.status, 
      this.id, 
      this.empId, 
      this.unitId, 
      this.createDate, 
      this.updateDate, 
      this.v,});

  Data.fromJson(dynamic json) {
    productIds = json['productIds'] != null ? json['productIds'].cast<String>() : [];
    status = json['status'];
    id = json['_id'];
    empId = json['empId'];
    unitId = json['unitId'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  List<String>? productIds;
  String? status;
  String? id;
  String? empId;
  String? unitId;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productIds'] = productIds;
    map['status'] = status;
    map['_id'] = id;
    map['empId'] = empId;
    map['unitId'] = unitId;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }

}