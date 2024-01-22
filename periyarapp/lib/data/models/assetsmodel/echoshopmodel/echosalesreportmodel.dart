class EchoSalesReportModel {
  EchoSalesReportModel({
    required this.status,
    required this.msg,
    required this.data,
    required this.totalSales,
    required this.totalAmount,
  });
  late final bool status;
  late final String msg;
  late final List<Data> data;
  late final int totalSales;
  late final int totalAmount;

  EchoSalesReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    totalSales = json['totalSales'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['totalSales'] = totalSales;
    _data['totalAmount'] = totalAmount;
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
    required this.employeeId,
    required this.ticketNo,
  });
  late final bool sales;
  late final String status;
  late final String id;
  late final String unitId;
  late final String totalAmount;
  late final String createDate;
  late final String updateDate;
  late final int V;
  late final String employeeId;
  late final String ticketNo;

  Data.fromJson(Map<String, dynamic> json) {
    sales = json['sales'];
    status = json['status'];
    id = json['_id'];
    unitId = json['unitId'];
    totalAmount = json['totalAmount'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
    employeeId = json['employeeId']==null?"":json['employeeId'];
    ticketNo = json['ticketNo']==null?"":json['ticketNo'];
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
    _data['employeeId'] = employeeId;
    _data['ticketNo'] = ticketNo;
    return _data;
  }
}
