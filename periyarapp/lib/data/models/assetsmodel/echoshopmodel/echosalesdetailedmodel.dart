class SalesdetailedModel {
  bool? status;
  Bill? bill;
  List<Data>? data;
  String? msg;

  SalesdetailedModel({this.status, this.bill, this.data, this.msg});

  SalesdetailedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bill = json['bill'] != null ? new Bill.fromJson(json['bill']) : null;
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
    if (this.bill != null) {
      data['bill'] = this.bill!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Bill {
  bool? isEmployee;
  String? status;
  String? sId;
  String? unitId;
  String? employeeId;
  String? totalAmount;
  String? createDate;
  String? updateDate;
  int? iV;

  Bill(
      {this.isEmployee,
      this.status,
      this.sId,
      this.unitId,
      this.employeeId,
      this.totalAmount,
      this.createDate,
      this.updateDate,
      this.iV});

  Bill.fromJson(Map<String, dynamic> json) {
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

class Data {
  String? status;
  String? itemName;
  String? sId;
  String? saleId;
  String? stockId;
  int? quantity;
  int? salesPrice;
  int? discount;
  String? createDate;
  String? updateDate;
  int? iV;

  Data(
      {this.status,
      this.sId,
      this.itemName,
      this.saleId,
      this.stockId,
      this.quantity,
      this.salesPrice,
      this.discount,
      this.createDate,
      this.updateDate,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    itemName = json['itemName'];
    sId = json['_id'];
    saleId = json['saleId'];
    stockId = json['stockId'];
    quantity = json['quantity'];
    salesPrice = json['salesPrice'];
    discount = json['discount'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['itemName'] = this.itemName;
    data['_id'] = this.sId;
    data['saleId'] = this.saleId;
    data['stockId'] = this.stockId;
    data['quantity'] = this.quantity;
    data['salesPrice'] = this.salesPrice;
    data['discount'] = this.discount;
    data['create_date'] = this.createDate;
    data['update_date'] = this.updateDate;
    data['__v'] = this.iV;
    return data;
  }
}
