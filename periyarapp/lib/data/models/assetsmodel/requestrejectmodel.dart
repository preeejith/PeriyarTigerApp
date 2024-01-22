class RequestRejectModel {
  RequestRejectModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String msg;
  late final Data data;

  RequestRejectModel.fromJson(Map<String, dynamic> json) {
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
    required this.status,
    required this.requestStatus,
    required this.id,
    required this.empId,
    required this.unitId,
    required this.typeOfRequest,
    required this.quantity,
    required this.remark,
    required this.productId,
    required this.createDate,
    required this.updateDate,
    required this.V,
    required this.rejectRemark,
  });
  late final String status;
  late final String requestStatus;
  late final String id;
  late final String empId;
  late final String unitId;
  late final String typeOfRequest;
  late final int quantity;
  late final String remark;
  late final String productId;
  late final String createDate;
  late final String updateDate;
  late final int V;
  late final String rejectRemark;

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    requestStatus = json['requestStatus'];
    id = json['_id'];
    empId = json['empId'];
    unitId = json['unitId'];
    typeOfRequest = json['typeOfRequest'];
    quantity = json['quantity'];
    remark = json['remark'];
    productId = json['productId'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
    rejectRemark = json['rejectRemark'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['requestStatus'] = requestStatus;
    _data['_id'] = id;
    _data['empId'] = empId;
    _data['unitId'] = unitId;
    _data['typeOfRequest'] = typeOfRequest;
    _data['quantity'] = quantity;
    _data['remark'] = remark;
    _data['productId'] = productId;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    _data['rejectRemark'] = rejectRemark;
    return _data;
  }
}
