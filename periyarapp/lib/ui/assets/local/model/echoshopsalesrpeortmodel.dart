class SalesReport {
  bool? status;
  List<Data>? data;
  String? msg;

  SalesReport({this.status, this.data, this.msg});

  SalesReport.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  bool? isEmployee;
  String? status;
  String? sId;
  String? unitId;
  String? employeeId;
  String? totalAmount;
  String? createDate;
  String? updateDate;
  int? iV;

  Data(
      {this.isEmployee,
      this.status,
      this.sId,
      this.unitId,
      this.employeeId,
      this.totalAmount,
      this.createDate,
      this.updateDate,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    isEmployee = json['isEmployee'];
    status = json['status'];
    sId = json['_id'];
    unitId = json['unitId'];
    employeeId = json['employeeId'];
    totalAmount = json['totalAmount'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isEmployee'] = this.isEmployee;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['unitId'] = this.unitId;
    data['employeeId'] = this.employeeId;
    data['totalAmount'] = this.totalAmount;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    data['__v'] = this.iV;
    return data;
  }
}
