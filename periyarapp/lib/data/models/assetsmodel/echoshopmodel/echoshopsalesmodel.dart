class EchoShopSaleModel {
  EchoShopSaleModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String msg;
  late final Data data;

  EchoShopSaleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.sales,
    required this.status,
    required this.id,
    required this.unitId,
    required this.totalAmount,
    required this.createDate,
    required this.updateDate,
    required this.V,
    required this.ticketNo,
    required this.employeeId,
  });
  late final bool sales;
  late final String status;
  late final String id;
  late final String unitId;
  late final String totalAmount;
  late final String createDate;
  late final String updateDate;
  late final int V;
  late final String ticketNo;
  late final String employeeId;

  Data.fromJson(Map<String, dynamic> json) {
    sales = json['sales'];
    status = json['status'];
    id = json['_id'];
    unitId = json['unitId'];
    totalAmount = json['totalAmount'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
    ticketNo = json['ticketNo'];
    employeeId = json['employeeId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sales'] = sales;
    _data['status'] = status;
    _data['_id'] = id;
    _data['unitId'] = unitId;
    _data['totalAmount'] = totalAmount;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    _data['ticketNo'] = ticketNo;
    _data['employeeId'] = employeeId;
    return _data;
  }
}
