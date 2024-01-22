import 'package:flutter/material.dart';

/////
class ViewRequestMainModel {
  ViewRequestMainModel({
    this.status,
    this.msg,
    this.data,
  });

  ViewRequestMainModel.fromJson(dynamic json) {
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
  Data(
      {this.productIds,
      this.status,
      this.id,
      this.empId,
      this.unitId,
      this.forIc,
      this.createDate,
      this.updateDate,
      this.v,
      this.mainstatus,
      this.description});

  Data.fromJson(dynamic json) {
    if (json['productIds'] != null) {
      productIds = [];
      json['productIds'].forEach((v) {
        productIds?.add(ProductIds.fromJson(v));
      });
    }
    status = json['status'];
    id = json['_id'];
    empId = json['empId'];
    unitId = json['unitId'] != null ? UnitId.fromJson(json['unitId']) : null;
    forIc = json['forIc'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    mainstatus = json['mainstatus'];
    description = json['description'] == null ? "" : json['description'];
  }
  List<ProductIds>? productIds;
  String? status;
  String? id;
  String? empId;

  UnitId? unitId;
  String? forIc;
  String? createDate;
  String? updateDate;
  int? v;
  String? mainstatus;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (productIds != null) {
      map['productIds'] = productIds?.map((v) => v.toJson()).toList();
    }
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
    map['mainstatus'] = mainstatus;
    map['description'] = description;
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

class ProductIds {
  ProductIds({
    this.myStock,
    this.quantity,
    this.status,
    this.requestStatus,
    this.id,
    this.count,
    this.chooseType,
    this.change,
    this.dropdown,
    this.dropdown2,
    this.start,
    this.requestId,
    this.productId,
    this.typeOfRequest,
    this.remark,
    this.name,
    this.createDate,
    this.updateDate,
    this.v,
  });

  ProductIds.fromJson(dynamic json) {
    quantity = json['quantity'];
    status = json['status'];

    if (json['myStock'] != null) {
      myStock = [];
      json['myStock'].forEach((v) {
        myStock!.add(MyStock.fromJson(v));
      });
    }
    requestStatus = json['requestStatus'];
    id = json['_id'];
    requestId = json['requestId'];
    productId = json['productId'] == null ? "" : json['productId'];
    typeOfRequest = json['typeOfRequest'];
    remark = json['remark'];
    name = json['name'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  int? quantity;
  String? status;
  List<MyStock>? myStock;
  String? requestStatus;
  String? id;
  var requestidcontroller = TextEditingController();
  var assetsidcontroller = TextEditingController();
  String? chooseType;
  int? count = 0;
  bool? dropdown = false;
  bool? dropdown2 = false;
  bool? change = false;

  bool? start = false;
  String? requestId;
  String? productId;
  String? typeOfRequest;
  String? remark;
  String? name;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = quantity;

    if (myStock != null) {
      map['myStock'] = myStock!.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['requestStatus'] = requestStatus;
    map['_id'] = id;
    map['requestId'] = requestId;
    map['productId'] = productId;
    map['typeOfRequest'] = typeOfRequest;
    map['remark'] = remark;
    map['name'] = name;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

////My Stock
class MyStock {
  MyStock({
    this.quantity,
    this.assetId,
    this.id,
  });

  MyStock.fromJson(dynamic json) {
    quantity = json['quantity'];
    assetId =
        json['assetId'] != null ? AssetId.fromJson(json['assetId']) : null;
    // if (json['assetId'] != null) {
    //   assetId = [];
    //   json['assetId']!.forEach((v) {
    //     assetId!.add(AssetId.fromJson(v));
    //   });
    // }

    id = json['_id'];
  }
  int? quantity;
  AssetId? assetId;

  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = quantity;

    if (assetId != null) {
      map['assetId'] = assetId?.toJson();
    }

    // if (assetId != null) {
    //   map['assetId'] = assetId!.map((v) => v.toJson()).toList();
    // }

    map['_id'] = id;

    return map;
  }
}

///My stock end
///////AssetId
class AssetId {
  AssetId({
    this.name,
    this.productType,
    this.id,
  });

  AssetId.fromJson(dynamic json) {
    name = json['name'];

    productType = json['productType'];

    id = json['_id'];
  }

  String? id;
  String? name;

  String? productType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;

    map['productType'] = productType;

    map['_id'] = id;

    return map;
  }
}
///Assetid end