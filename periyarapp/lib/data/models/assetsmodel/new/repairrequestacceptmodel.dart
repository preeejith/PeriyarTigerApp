class RepairRequestAcceptModel {
  RepairRequestAcceptModel({
    this.status,
    this.msg,
    this.data,
  });

  RepairRequestAcceptModel.fromJson(dynamic json) {
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
    this.quantity,
    this.status,
    this.requestStatus,
    this.id,
    this.requestId,
    this.typeOfRequest,
    this.productId,
    this.createDate,
    this.updateDate,
    this.v,
    this.repairStatus,
  });

  Data.fromJson(dynamic json) {
    quantity = json['quantity'];
    status = json['status'];
    requestStatus = json['requestStatus'];
    id = json['_id'];
    requestId = json['requestId'] != null
        ? RequestId.fromJson(json['requestId'])
        : null;
    typeOfRequest = json['typeOfRequest'];
    productId = json['productId'] != null
        ? ProductId.fromJson(json['productId'])
        : null;
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    repairStatus = json['repairStatus'];
  }
  int? quantity;
  String? status;
  String? requestStatus;
  String? id;
  RequestId? requestId;
  String? typeOfRequest;
  ProductId? productId;
  String? createDate;
  String? updateDate;
  int? v;
  String? repairStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = quantity;
    map['status'] = status;
    map['requestStatus'] = requestStatus;
    map['_id'] = id;
    if (requestId != null) {
      map['requestId'] = requestId?.toJson();
    }
    map['typeOfRequest'] = typeOfRequest;
    if (productId != null) {
      map['productId'] = productId?.toJson();
    }
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    map['repairStatus'] = repairStatus;
    return map;
  }
}

class ProductId {
  ProductId({
    this.status,
    this.id,
    this.name,
    this.type,
    this.productType,
    this.createDate,
    this.updateDate,
    this.v,
  });

  ProductId.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    name = json['name'];
    type = json['type'];
    productType = json['productType'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  String? status;
  String? id;
  String? name;
  String? type;
  String? productType;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['productType'] = productType;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

class RequestId {
  RequestId({
    this.productIds,
    this.status,
    this.id,
    this.empId,
    this.unitId,
    this.description,
    this.createDate,
    this.updateDate,
    this.v,
  });

  RequestId.fromJson(dynamic json) {
    productIds =
        json['productIds'] != null ? json['productIds'].cast<String>() : [];
    status = json['status'];
    id = json['_id'];
    empId = json['empId'];
    unitId = json['unitId'];
    description = json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  List<String>? productIds;
  String? status;
  String? id;
  String? empId;
  String? unitId;
  String? description;
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
    map['description'] = description;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}
