//my chnages

class MyRequestViewModel {
  MyRequestViewModel({
    this.status,
    this.msg,
    this.data,
  });

  MyRequestViewModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  String? msg;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
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
    this.forIc,
    this.createDate,
    this.updateDate,
    this.v,
    this.count,
    this.requesttype,
    this.requeststatus,
    this.items,
  });

  Data.fromJson(dynamic json) {
    productIds =
        json['productIds'] != null ? json['productIds'].cast<String>() : [];
    status = json['status'];
    id = json['_id'];
    empId = json['empId'];
    unitId = json['unitId'] != null ? UnitId.fromJson(json['unitId']) : null;
    forIc = json['forIc'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    count = json['count'];
    requesttype = json['requesttype'];
    requeststatus = json['requeststatus'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }
  List<String>? productIds;
  String? status;
  String? id;
  String? empId;
  UnitId? unitId;
  String? forIc;
  String? createDate;
  String? updateDate;
  int? v;
  int? count;
  String? requesttype;
  String? requeststatus;
  List<Items>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productIds'] = productIds;
    map['status'] = status;
    map['_id'] = id;
    map['empId'] = empId;
    if (unitId != null) {
      map['unitId'] = unitId?.toJson();
    }
    map['forIc'] = forIc;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    map['count'] = count;
    map['requesttype'] = requesttype;
    map['requeststatus'] = requeststatus;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Items {
  Items(
      {this.quantity,
      this.status,
      this.requestStatus,
      this.transferedQuantity,
      this.id,
      this.productId,
      this.requestId,
      this.typeOfRequest,
      this.remark,
      this.name,
      this.createDate,
      this.updateDate,
      this.v,
      g});

  Items.fromJson(dynamic json) {
    quantity = json['quantity'];
    status = json['status'];
    transferedQuantity = json['transferedQuantity'] == null
        ? ""
        : json['transferedQuantity'].toString();
    requestStatus = json['requestStatus'];
    id = json['_id'];
    requestId = json['requestId'] != null
        ? RequestId.fromJson(json['requestId'])
        : null;
    productId = json['productId'] != null
        ? ProductId.fromJson(json['productId'])
        : null;
    typeOfRequest = json['typeOfRequest'];
    remark = json['remark'];
    name = json['name'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  int? quantity;
  String? status;
  String? requestStatus;
  String? transferedQuantity;
  String? id;
  ProductId? productId;
  RequestId? requestId;
  String? typeOfRequest;
  String? remark;
  String? name;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = quantity;
    map['status'] = status;
    map['requestStatus'] = requestStatus;
    map['transferedQuantity'] = transferedQuantity;
    map['_id'] = id;
    if (requestId != null) {
      map['requestId'] = requestId?.toJson();
    }
    map['typeOfRequest'] = typeOfRequest;
    map['remark'] = remark;
    map['name'] = name;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

class ProductId {
  ProductId({
    this.status,
    this.id,
    this.name,
    this.assetype,
    this.productType,
    this.createDate,
    this.updateDate,
    this.v,
  });

  ProductId.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    name = json['name'];
    assetype = json['assetype'];
    productType = json['productType'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }

  String? status;
  String? id;
  String? name;
  String? assetype;
  String? productType;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['status'] = status;
    map['_id'] = id;
    map['empId'] = name;
    map['unitId'] = assetype;
    map['forIc'] = productType;
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
    this.forIc,
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
    forIc = json['forIc'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  List<String>? productIds;
  String? status;
  String? id;
  String? empId;
  String? unitId;
  String? forIc;
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
    map['forIc'] = forIc;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

class UnitId {
  UnitId({
    this.location,
    this.status,
    this.unitincharge,
    this.id,
    this.type,
    this.name,
    this.description,
    this.unitUnderIc,
    this.createDate,
    this.updateDate,
    this.v,
  });

  UnitId.fromJson(dynamic json) {
    if (json['location'] != null) {
      location = [];
      json['location'].forEach((v) {
        location?.add((v));
      });
    }
    status = json['status'];
    unitincharge =
        json['unitincharge'] != null ? json['unitincharge'].cast<String>() : [];
    id = json['_id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    unitUnderIc = json['unitUnderIc'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  List<dynamic>? location;
  String? status;
  List<String>? unitincharge;
  String? id;
  String? type;
  String? name;
  String? description;
  String? unitUnderIc;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['unitincharge'] = unitincharge;
    map['_id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['description'] = description;
    map['unitUnderIc'] = unitUnderIc;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}
//////////////////////////////////333////////////
///
///
///
///
///
///
