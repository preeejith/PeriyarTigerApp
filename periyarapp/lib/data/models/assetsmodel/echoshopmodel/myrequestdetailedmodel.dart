////Dont't Chnage the model

// class MyrequestDetailedModel {
//   MyrequestDetailedModel({
//       this.status,
//       this.msg,
//       this.data,});

//   MyrequestDetailedModel.fromJson(dynamic json) {
//     status = json['status'];
//     msg = json['msg'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(Data.fromJson(v));
//       });
//     }
//   }
//   bool? status;
//   String? msg;
//   List<Data>? data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['msg'] = msg;
//     if (data != null) {
//       map['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }

// }

// class Data {
//   Data({
//       this.quantity,
//       this.status,
//       this.requestStatus,
//       this.id,
//       this.requestId,
//       this.typeOfRequest,
//       this.remark,
//       this.name,
//       this.createDate,
//       this.updateDate,
//       this.v,});

//   Data.fromJson(dynamic json) {
//     quantity = json['quantity'];
//     status = json['status'];
//     requestStatus = json['requestStatus'];
//     id = json['_id'];
//     requestId = json['requestId'] != null ? RequestId.fromJson(json['requestId']) : null;
//     typeOfRequest = json['typeOfRequest'];
//     remark = json['remark'];
//     name = json['name'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     v = json['__v'];
//   }
//   int? quantity;
//   String? status;
//   String? requestStatus;
//   String? id;
//   RequestId? requestId;
//   String? typeOfRequest;
//   String? remark;
//   String? name;
//   String? createDate;
//   String? updateDate;
//   int? v;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['quantity'] = quantity;
//     map['status'] = status;
//     map['requestStatus'] = requestStatus;
//     map['_id'] = id;
//     if (requestId != null) {
//       map['requestId'] = requestId?.toJson();
//     }
//     map['typeOfRequest'] = typeOfRequest;
//     map['remark'] = remark;
//     map['name'] = name;
//     map['create_date'] = createDate;
//     map['update_date'] = updateDate;
//     map['__v'] = v;
//     return map;
//   }

// }

// class RequestId {
//   RequestId({
//       this.productIds,
//       this.status,
//       this.id,
//       this.empId,
//       this.unitId,
//       this.createDate,
//       this.updateDate,
//       this.v,});

//   RequestId.fromJson(dynamic json) {
//     productIds = json['productIds'] != null ? json['productIds'].cast<String>() : [];
//     status = json['status'];
//     id = json['_id'];
//     empId = json['empId'];
//     unitId = json['unitId'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     v = json['__v'];
//   }
//   List<String>? productIds;
//   String? status;
//   String? id;
//   String? empId;
//   String? unitId;
//   String? createDate;
//   String? updateDate;
//   int? v;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['productIds'] = productIds;
//     map['status'] = status;
//     map['_id'] = id;
//     map['empId'] = empId;
//     map['unitId'] = unitId;
//     map['create_date'] = createDate;
//     map['update_date'] = updateDate;
//     map['__v'] = v;
//     return map;
//   }

// }

////second
// class MyrequestDetailedModel {
//   MyrequestDetailedModel({
//       this.status,
//       this.msg,
//       this.data,});

//   MyrequestDetailedModel.fromJson(dynamic json) {
//     status = json['status'];
//     msg = json['msg'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(Data.fromJson(v));
//       });
//     }
//   }
//   bool? status;
//   String? msg;
//   List<Data>? data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['msg'] = msg;
//     if (data != null) {
//       map['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }

// }

// class Data {
//   Data({
//       this.quantity,
//       this.status,
//       this.requestStatus,
//       this.id,
//       this.requestId,
//       this.typeOfRequest,
//       this.remark,
//       this.productId,
//       this.name,
//       this.createDate,
//       this.updateDate,
//       this.v,});

//   Data.fromJson(dynamic json) {
//     quantity = json['quantity'];
//     status = json['status'];
//     requestStatus = json['requestStatus'];
//     id = json['_id'];
//     requestId = json['requestId'] != null ? RequestId.fromJson(json['requestId']) : null;
//     typeOfRequest = json['typeOfRequest'];
//     remark = json['remark'];
//     productId = json['productId'] != null ? ProductId.fromJson(json['productId']) : null;
//     name = json['name'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     v = json['__v'];
//   }
//   int? quantity;
//   String? status;
//   String? requestStatus;
//   String? id;
//   RequestId? requestId;
//   String? typeOfRequest;
//   String? remark;
//   ProductId? productId;
//   String? name;
//   String? createDate;
//   String? updateDate;
//   int? v;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['quantity'] = quantity;
//     map['status'] = status;
//     map['requestStatus'] = requestStatus;
//     map['_id'] = id;
//     if (requestId != null) {
//       map['requestId'] = requestId?.toJson();
//     }
//     map['typeOfRequest'] = typeOfRequest;
//     map['remark'] = remark;
//     if (productId != null) {
//       map['productId'] = productId?.toJson();
//     }
//     map['name'] = name;
//     map['create_date'] = createDate;
//     map['update_date'] = updateDate;
//     map['__v'] = v;
//     return map;
//   }

// }

// class ProductId {
//   ProductId({
//       this.status,
//       this.id,
//       this.name,
//       this.type,
//       this.productType,
//       this.createDate,
//       this.updateDate,
//       this.v,
//       this.description,});

//   ProductId.fromJson(dynamic json) {
//     status = json['status'];
//     id = json['_id'];
//     name = json['name'];
//     type = json['type'];
//     productType = json['productType'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     v = json['__v'];
//     description = json['description'];
//   }
//   String? status;
//   String? id;
//   String? name;
//   String? type;
//   String? productType;
//   String? createDate;
//   String? updateDate;
//   int? v;
//   String? description;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['_id'] = id;
//     map['name'] = name;
//     map['type'] = type;
//     map['productType'] = productType;
//     map['create_date'] = createDate;
//     map['update_date'] = updateDate;
//     map['__v'] = v;
//     map['description'] = description;
//     return map;
//   }

// }

// class RequestId {
//   RequestId({
//       this.productIds,
//       this.status,
//       this.id,
//       this.empId,
//       this.unitId,
//       this.createDate,
//       this.updateDate,
//       this.v,});

//   RequestId.fromJson(dynamic json) {
//     productIds = json['productIds'] != null ? json['productIds'].cast<String>() : [];
//     status = json['status'];
//     id = json['_id'];
//     empId = json['empId'];
//     unitId = json['unitId'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     v = json['__v'];
//   }
//   List<String>? productIds;
//   String? status;
//   String? id;
//   String? empId;
//   String? unitId;
//   String? createDate;
//   String? updateDate;
//   int? v;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['productIds'] = productIds;
//     map['status'] = status;
//     map['_id'] = id;
//     map['empId'] = empId;
//     map['unitId'] = unitId;
//     map['create_date'] = createDate;
//     map['update_date'] = updateDate;
//     map['__v'] = v;
//     return map;
//   }

// }

class MyrequestDetailedModel {
  MyrequestDetailedModel({
    this.status,
    this.msg,
    this.data,
  });

  MyrequestDetailedModel.fromJson(dynamic json) {
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
    this.quantity,
    this.status,
    this.requestStatus,
    this.id,
    this.requestId,
    this.typeOfRequest,
    this.remark,
    this.productId,
    this.name,
    this.createDate,
    this.updateDate,
    this.v,
    this.transferedItemId,
  });

  Data.fromJson(dynamic json) {
    quantity = json['quantity'] == null ? "" : json['quantity'];
    status = json['status'];
    requestStatus = json['requestStatus'];
    id = json['_id'];
    requestId = json['requestId'] != null
        ? RequestId.fromJson(json['requestId'])
        : null;
    typeOfRequest = json['typeOfRequest'];
    remark = json['remark'] == null ? "" : json['remark'];
    productId = json['productId'] != null
        ? ProductId.fromJson(json['productId'])
        : null;
    name = json['name'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    transferedItemId = json['transferedItemId'] != null
        ? TransferedItemId.fromJson(json['transferedItemId'])
        : null;
  }
  num? quantity;
  String? status;
  String? requestStatus;
  String? id;
  RequestId? requestId;
  String? typeOfRequest;
  String? remark;
  ProductId? productId;
  String? name;
  String? createDate;
  String? updateDate;
  int? v;
  TransferedItemId? transferedItemId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = quantity;
    // map['status'] = status;
    // map['requestStatus'] = requestStatus;
    // map['_id'] = id;
    // if (requestId != null) {
    //   map['requestId'] = requestId?.toJson();
    // }
    // map['typeOfRequest'] = typeOfRequest;
    // map['remark'] = remark;
    // if (productId != null) {
    //   map['productId'] = productId?.toJson();
    // }
    // map['name'] = name;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    if (transferedItemId != null) {
      map['transferedItemId'] = transferedItemId?.toJson();
    }
    return map;
  }
}

class TransferedItemId {
  TransferedItemId({
    this.quantity,
    this.price,
    this.salePrice,
    this.purchaseId,
    this.discount,
    this.status,
    this.purchaseAmount,
    this.id,
    this.assetId,
    this.unitId,
    this.createDate,
    this.updateDate,
    this.v,
  });

  TransferedItemId.fromJson(dynamic json) {
    quantity = json['quantity']==null?"":json['quantity'];
    price = json['price'];
    salePrice = json['salePrice'];
    if (json['purchaseId'] != null) {
      purchaseId = [];
      json['purchaseId'].forEach((v) {
        purchaseId?.add((v));
      });
    }
    discount = json['discount'];
    status = json['status'];
    purchaseAmount = json['purchaseAmount'];
    id = json['_id'];
    assetId = json['assetId'];
    unitId = json['unitId'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  num? quantity;
  int? price;
  int? salePrice;
  List<dynamic>? purchaseId;
  int? discount;
  String? status;
  int? purchaseAmount;
  String? id;
  String? assetId;
  String? unitId;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = quantity;
    map['price'] = price;
    map['salePrice'] = salePrice;
    if (purchaseId != null) {
      map['purchaseId'] = purchaseId?.map((v) => v.toJson()).toList();
    }
    map['discount'] = discount;
    map['status'] = status;
    map['purchaseAmount'] = purchaseAmount;
    map['_id'] = id;
    map['assetId'] = assetId;
    map['unitId'] = unitId;
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
    this.type,
    this.productType,
    this.createDate,
    this.updateDate,
    this.v,
    this.description,
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
    description = json['description'] == null ? "" : json['description'];
  }
  String? status;
  String? id;
  String? name;
  String? type;
  String? productType;
  String? createDate;
  String? updateDate;
  int? v;
  String? description;

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
    map['description'] = description;
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
    description = json['description'] == null ? "" : json['description'];
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
