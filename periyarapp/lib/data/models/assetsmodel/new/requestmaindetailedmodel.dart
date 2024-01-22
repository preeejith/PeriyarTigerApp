// class RequestMainDetailedModel {
//   bool? status;
//   Request? request;
//   String? msg;

//   RequestMainDetailedModel({this.status, this.request, this.msg});

//   RequestMainDetailedModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     request =
//         json['request'] != null ? new Request.fromJson(json['request']) : null;
//     msg = json['msg'];
//   }
// }

// class Request {
//   List<ProductIds>? productIds;
//   String? status;
//   String? sId;
//   String? empId;
//   UnitId? unitId;
//   String? createDate;
//   String? updateDate;
//   int? iV;

//   Request(
//       {this.productIds,
//       this.status,
//       this.sId,
//       this.empId,
//       this.unitId,
//       this.createDate,
//       this.updateDate,
//       this.iV});

//   Request.fromJson(Map<String, dynamic> json) {
//     if (json['productIds'] != null) {
//       productIds = <ProductIds>[];
//       json['productIds'].forEach((v) {
//         productIds!.add(new ProductIds.fromJson(v));
//       });
//     }
//     status = json['status'];
//     sId = json['_id'];
//     empId = json['empId'];
//     unitId =
//         json['unitId'] != null ? new UnitId.fromJson(json['unitId']) : null;
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     iV = json['__v'];
//   }
// }

// class ProductIds {
//   int? quantity;
//   String? status;
//   String? requestStatus;
//   String? sId;
//   String? requestId;
//   String? typeOfRequest;
//   String? remark;
//   String? productId;
//   String? createDate;
//   String? updateDate;
//   int? iV;

//   ProductIds(
//       {this.quantity,
//       this.status,
//       this.requestStatus,
//       this.sId,
//       this.requestId,
//       this.typeOfRequest,
//       this.remark,
//       this.productId,
//       this.createDate,
//       this.updateDate,
//       this.iV});

//   ProductIds.fromJson(Map<String, dynamic> json) {
//     quantity = json['quantity'];
//     status = json['status'];
//     requestStatus = json['requestStatus'];
//     sId = json['_id'];
//     requestId = json['requestId'];
//     typeOfRequest = json['typeOfRequest'];
//     remark = json['remark'];
//     productId = json['productId'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     iV = json['__v'];
//   }
// }

// class UnitId {
//   List<Null>? location;
//   String? status;
//   List<Null>? unitincharge;
//   String? sId;
//   String? type;
//   String? name;
//   String? description;
//   String? unitUnderIc;
//   String? createDate;
//   String? updateDate;
//   int? iV;

//   UnitId(
//       {this.location,
//       this.status,
//       this.unitincharge,
//       this.sId,
//       this.type,
//       this.name,
//       this.description,
//       this.unitUnderIc,
//       this.createDate,
//       this.updateDate,
//       this.iV});

//   UnitId.fromJson(Map<String, dynamic> json) {
//     //   if (json['location'] != null) {
//     //     location = <Null>[];
//     //     json['location'].forEach((v) {
//     //       location!.add(new Null.fromJson(v));
//     //     });
//     //   }
//     status = json['status'];
//     // if (json['unitincharge'] != null) {
//     //   unitincharge = <Null>[];
//     //   json['unitincharge'].forEach((v) {
//     //     unitincharge!.add((v));
//     //   });
//     // }
//     sId = json['_id'];
//     type = json['type'];
//     name = json['name'];
//     description = json['description'];
//     unitUnderIc = json['unitUnderIc'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     iV = json['__v'];
//   }
// }
import 'package:flutter/material.dart';

//////second
// class RequestMainDetailedModel {
//   RequestMainDetailedModel({
//     required this.status,
//     required this.msg,
//     required this.data,
//   });
//   late final bool status;
//   late final String msg;
//   late final List<Data> data;

//   RequestMainDetailedModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['msg'] = msg;
//     _data['data'] = data.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class Data {
//   Data({
//     required this.quantity,
//     required this.status,
//     required this.requestStatus,
//     required this.id,
//     required this.requestId,
//     required this.typeOfRequest,
//     required this.remark,
//     required this.productId,
//     required this.createDate,
//     required this.updateDate,
//     required this.V,
//     required this.myStock,
//   });
//   late final int quantity;
//   late final String status;
//   late final String requestStatus;
//   late final String id;
//   late final String requestId;
//   late final String typeOfRequest;
//   late final String remark;
//   late final ProductId productId;
//   late final String createDate;
//   late final String updateDate;
//   late final int V;
//   late final List<MyStock> myStock;

//   Data.fromJson(Map<String, dynamic> json) {
//     quantity = json['quantity'];
//     status = json['status'];
//     requestStatus = json['requestStatus'];
//     id = json['_id'];
//     requestId = json['requestId'];
//     typeOfRequest = json['typeOfRequest'];
//     remark = json['remark'];

//     if (json['productId'] != null) {
//       productId = ProductId.fromJson(json['productId']);
//     }

//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     V = json['__v'];

//     if(  json['myStock']!=null){

//     myStock =
//         List.from(json['myStock']).map((e) => MyStock.fromJson(e)).toList();
//     }

//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['quantity'] = quantity;
//     _data['status'] = status;
//     _data['requestStatus'] = requestStatus;
//     _data['_id'] = id;
//     _data['requestId'] = requestId;
//     _data['typeOfRequest'] = typeOfRequest;
//     _data['remark'] = remark;
//     _data['productId'] = productId.toJson();
//     _data['create_date'] = createDate;
//     _data['update_date'] = updateDate;
//     _data['__v'] = V;
//     _data['myStock'] = myStock.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class ProductId {
//   ProductId({
//     required this.status,
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.productType,
//     required this.createDate,
//     required this.updateDate,
//     required this.V,
//     required this.description,
//   });
//   late final String status;
//   late final String id;
//   late final String name;
//   late final String type;
//   late final String productType;
//   late final String createDate;
//   late final String updateDate;
//   late final int V;
//   late final String description;

//   ProductId.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     id = json['_id'];
//     name = json['name'];
//     type = json['type'];
//     productType = json['productType'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     V = json['__v'];
//     description = json['description'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['_id'] = id;
//     _data['name'] = name;
//     _data['type'] = type;
//     _data['productType'] = productType;
//     _data['create_date'] = createDate;
//     _data['update_date'] = updateDate;
//     _data['__v'] = V;
//     _data['description'] = description;
//     return _data;
//   }
// }

// class MyStock {
//   MyStock({
//     required this.quantity,
//     required this.price,
//     required this.salePrice,
//     required this.purchaseId,
//     required this.discount,
//     required this.status,
//     required this.purchaseAmount,
//     required this.id,
//     required this.assetId,
//     required this.unitId,
//     required this.createDate,
//     required this.updateDate,
//     required this.V,
//   });
//   late final int quantity;
//   late final int price;
//   late final int salePrice;
//   late final List<dynamic> purchaseId;
//   late final int discount;
//   late final String status;
//   late final int purchaseAmount;
//   late final String id;
//   late final AssetId assetId;
//   late final UnitId unitId;
//   late final String createDate;
//   late final String updateDate;
//   late final int V;

//   MyStock.fromJson(Map<String, dynamic> json) {
//     quantity = json['quantity'];
//     price = json['price'];
//     salePrice = json['salePrice'];
//     purchaseId = List.castFrom<dynamic, dynamic>(json['purchaseId']);
//     discount = json['discount'];
//     status = json['status'];
//     purchaseAmount = json['purchaseAmount'];
//     id = json['_id'];
//     assetId = AssetId.fromJson(json['assetId']);
//     unitId = UnitId.fromJson(json['unitId']);
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     V = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['quantity'] = quantity;
//     _data['price'] = price;
//     _data['salePrice'] = salePrice;
//     _data['purchaseId'] = purchaseId;
//     _data['discount'] = discount;
//     _data['status'] = status;
//     _data['purchaseAmount'] = purchaseAmount;
//     _data['_id'] = id;
//     _data['assetId'] = assetId.toJson();
//     _data['unitId'] = unitId.toJson();
//     _data['create_date'] = createDate;
//     _data['update_date'] = updateDate;
//     _data['__v'] = V;
//     return _data;
//   }
// }

// class AssetId {
//   AssetId({
//     required this.status,
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.productType,
//     required this.createDate,
//     required this.updateDate,
//     required this.V,
//     required this.description,
//   });
//   late final String status;
//   late final String id;
//   late final String name;
//   late final String type;
//   late final String productType;
//   late final String createDate;
//   late final String updateDate;
//   late final int V;
//   late final String description;

//   AssetId.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     id = json['_id'];
//     name = json['name'];
//     type = json['type'];
//     productType = json['productType'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     V = json['__v'];
//     description = json['description'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['_id'] = id;
//     _data['name'] = name;
//     _data['type'] = type;
//     _data['productType'] = productType;
//     _data['create_date'] = createDate;
//     _data['update_date'] = updateDate;
//     _data['__v'] = V;
//     _data['description'] = description;
//     return _data;
//   }
// }

// class UnitId {
//   UnitId({
//     required this.location,
//     required this.status,
//     required this.unitincharge,
//     required this.id,
//     required this.type,
//     required this.name,
//     required this.description,
//     required this.createDate,
//     required this.updateDate,
//     required this.V,
//   });
//   late final List<dynamic> location;
//   late final String status;
//   late final List<String> unitincharge;
//   late final String id;
//   late final String type;
//   late final String name;
//   late final String description;
//   late final String createDate;
//   late final String updateDate;
//   late final int V;

//   UnitId.fromJson(Map<String, dynamic> json) {
//     location = List.castFrom<dynamic, dynamic>(json['location']);
//     status = json['status'];
//     unitincharge = List.castFrom<dynamic, String>(json['unitincharge']);
//     id = json['_id'];
//     type = json['type'];
//     name = json['name'];
//     description = json['description'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     V = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['location'] = location;
//     _data['status'] = status;
//     _data['unitincharge'] = unitincharge;
//     _data['_id'] = id;
//     _data['type'] = type;
//     _data['name'] = name;
//     _data['description'] = description;
//     _data['create_date'] = createDate;
//     _data['update_date'] = updateDate;
//     _data['__v'] = V;
//     return _data;
//   }
// }
//
class RequestMainDetailedModel {
  RequestMainDetailedModel({
    this.status,
    this.msg,
    this.data,
  });

  RequestMainDetailedModel.fromJson(dynamic json) {
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
    this.name,
    this.status,
    this.requestStatus,
    this.id,
    this.count,
    this.start,
    required this.requestidcontroller,
    required this.assetsidcontroller,
    this.color,
    this.dropdown,
    this.dropdown2,
    this.change,
    this.dropdownvalue,
    this.dropdownname,
    this.requestId,
    this.typeOfRequest,
    this.remark,
    this.productId,
    this.createDate,
    this.updateDate,
    this.v,
    this.myStock,
  });

  Data.fromJson(dynamic json) {
    quantity = json['quantity'];
    name = json['name'] == null ? "" : json['name'];
    status = json['status'];
    requestStatus = json['requestStatus'];
    id = json['_id'];
    requestId = json['requestId'];
    typeOfRequest = json['typeOfRequest'];
    remark = json['remark'];
    productId = json['productId'] != null
        ? ProductId.fromJson(json['productId'])
        : null;
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    if (json['myStock'] != null) {
      myStock = [];
      json['myStock'].forEach((v) {
        myStock?.add(MyStock.fromJson(v));
      });
    }
  }
  int? quantity;
  String? name;
  String? status;
  String? requestStatus;
  String? id;
  String? requestId;
  String? typeOfRequest;
  String? remark;
  ProductId? productId;
  String? createDate;
  var requestidcontroller = TextEditingController();
  var assetsidcontroller = TextEditingController();
  String? updateDate, chooseType;
  ///////
  int? count = 0;
  bool? color = false;
  bool? change = false;
  String? dropdownvalue;
  String? dropdownname;
  bool? dropdown = false;
  bool? dropdown2 = false;
  bool? start = false;
  int? v;
  List<MyStock>? myStock;

  ///
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = quantity;

    map['status'] = status;
    map['requestStatus'] = requestStatus;
    map['_id'] = id;
    map['requestId'] = requestId;
    map['typeOfRequest'] = typeOfRequest;
    map['remark'] = remark;
    if (productId != null) {
      map['productId'] = productId?.toJson();
    }
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    if (myStock != null) {
      map['myStock'] = myStock?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MyStock {
  MyStock({
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

  MyStock.fromJson(dynamic json) {
    quantity = json['quantity'];

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
    assetId =
        json['assetId'] != null ? AssetId.fromJson(json['assetId']) : null;
    unitId = json['unitId'] != null ? UnitId.fromJson(json['unitId']) : null;
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  int? quantity;
  int? price;
  int? salePrice;
  List<dynamic>? purchaseId;
  int? discount;
  String? status;
  int? purchaseAmount;
  String? id;
  AssetId? assetId;
  UnitId? unitId;
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
    if (assetId != null) {
      map['assetId'] = assetId?.toJson();
    }
    if (unitId != null) {
      map['unitId'] = unitId?.toJson();
    }
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
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

class AssetId {
  AssetId({
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

  AssetId.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    name = json['name'] != null ? json['name'] : "";
    type = json['type'];
    productType = json['productType'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    description = json['description'];
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
    description = json['description'];
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
