class ViewUnitsRequesttypeModel {
  ViewUnitsRequesttypeModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String msg;
  late final List<Data> data;

  ViewUnitsRequesttypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.map((e) => e.toJson()).toList();
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
    required this.assetName,
    required this.productId,
    required this.rejectRemark,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final String status;
  late final String requestStatus;
  late final String id;
  late final String empId;
  late final UnitId unitId;
  late final String typeOfRequest;
  late final int quantity;
  late final String remark;
  late final String assetName;
  late final String productId;
  late final String rejectRemark;
  late final String createDate;
  late final String updateDate;
  late final int V;

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    requestStatus = json['requestStatus'];
    id = json['_id'];
    empId = json['empId'];
    //  unitId = UnitId.fromJson(json['unitId']);
   unitId = UnitId.fromJson(json['unitId']==null?"":json['unitId']);
    typeOfRequest = json['typeOfRequest'];
    quantity = json['quantity'];
    remark = json['remark'];

    assetName = json['assetName'] == null ? "" : json['assetName'];
    // assetName = json['assetName'];
    productId = json['productId'] == null ? "" : json['productId'];
    rejectRemark = json['rejectRemark'] == null ? "" : json['rejectRemark'];
    // assetName = json['assetName'];
    //  productId = json['productId'];
    // rejectRemark = json['rejectRemark'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['requestStatus'] = requestStatus;
    _data['_id'] = id;
    _data['empId'] = empId;
    _data['unitId'] = unitId.toJson();
    _data['typeOfRequest'] = typeOfRequest;
    _data['quantity'] = quantity;
    _data['remark'] = remark;
    _data['assetName'] = assetName;
    _data['productId'] = productId;
    _data['rejectRemark'] = rejectRemark;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}

class UnitId {
  UnitId({
    required this.location,
    required this.status,
    required this.unitincharge,
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.createDate,
    required this.updateDate,
    required this.V,
    required this.unitUnderIc,
  });
  late final List<dynamic> location;
  late final String status;
  late final List<dynamic> unitincharge;
  late final String id;
  late final String type;
  late final String name;
  late final String description;
  late final String createDate;
  late final String updateDate;
  late final int V;
  late final String unitUnderIc;

  UnitId.fromJson(Map<String, dynamic> json) {
    location = List.castFrom<dynamic, dynamic>(json['location']);
    status = json['status'];
    unitincharge = List.castFrom<dynamic, dynamic>(json['unitincharge']);
    id = json['_id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];

    
    unitUnderIc = json['unitUnderIc'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['location'] = location;
    _data['status'] = status;
    _data['unitincharge'] = unitincharge;
    _data['_id'] = id;
    _data['type'] = type;
    _data['name'] = name;
    _data['description'] = description;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    _data['unitUnderIc'] = unitUnderIc;
    return _data;
  }
}