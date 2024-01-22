// class ViewProductMainDetailedModel {
//   ViewProductMainDetailedModel({
//       this.status,
//       this.data,
//       this.msg,});

//   ViewProductMainDetailedModel.fromJson(dynamic json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(Data.fromJson(v));
//       });
//     }
//     msg = json['msg'];
//   }
//   bool? status;
//   List<Data>? data;
//   String? msg;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     if (data != null) {
//       map['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     map['msg'] = msg;
//     return map;
//   }

// }

// class Data {
//   Data({
//       this.unitId,
//       this.data1,});

//   Data.fromJson(dynamic json) {
//     unitId = json['unitId'] != null ? UnitId.fromJson(json['unitId']) : null;
//     if (json['data1'] != null) {
//       data1 = [];
//       json['data1'].forEach((v) {
//         data1?.add(Data1.fromJson(v));
//       });
//     }
//   }
//   UnitId? unitId;
//   List<Data1>? data1;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (unitId != null) {
//       map['unitId'] = unitId?.toJson();
//     }
//     if (data1 != null) {
//       map['data1'] = data1?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }

// }

// class Data1 {
//   Data1({
//       this.subUnit,
//       this.unitId,
//       this.data2,});

//   Data1.fromJson(dynamic json) {
//     subUnit = json['subUnit'] != null ? SubUnit.fromJson(json['subUnit']) : null;
//     unitId = json['unitId'] != null ? UnitId.fromJson(json['unitId']) : null;
//     if (json['data2'] != null) {
//       data2 = [];
//       json['data2'].forEach((v) {
//         data2?.add(Data2.fromJson(v));
//       });
//     }
//   }
//   SubUnit? subUnit;
//   UnitId? unitId;
//   List<Data2>? data2;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (subUnit != null) {
//       map['subUnit'] = subUnit?.toJson();
//     }
//     if (unitId != null) {
//       map['unitId'] = unitId?.toJson();
//     }
//     if (data2 != null) {
//       map['data2'] = data2?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }

// }

// class Data2 {
//   Data2({
//       this.id,
//       this.status,
//       this.stockIn,
//       this.product,
//       this.unitId,
//       this.subUnit,
//       this.totalQuantity,
//       this.price,
//       this.createDate,
//       this.v,});

//   Data2.fromJson(dynamic json) {
//     id = json['_id'];
//     status = json['status'];
//     stockIn = json['stockIn'];
//     product = json['product'];
//     unitId = json['unitId'] != null ? UnitId.fromJson(json['unitId']) : null;
//     subUnit = json['subUnit'] != null ? SubUnit.fromJson(json['subUnit']) : null;
//     totalQuantity = json['totalQuantity'];
//     price = json['price'];
//     createDate = json['create_date'];
//     v = json['__v'];
//   }
//   String? id;
//   String? status;
//   String? stockIn;
//   String? product;
//   UnitId? unitId;
//   SubUnit? subUnit;
//   int? totalQuantity;
//   int? price;
//   String? createDate;
//   int? v;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = id;
//     map['status'] = status;
//     map['stockIn'] = stockIn;
//     map['product'] = product;
//     if (unitId != null) {
//       map['unitId'] = unitId?.toJson();
//     }
//     if (subUnit != null) {
//       map['subUnit'] = subUnit?.toJson();
//     }
//     map['totalQuantity'] = totalQuantity;
//     map['price'] = price;
//     map['create_date'] = createDate;
//     map['__v'] = v;
//     return map;
//   }

// }

// class SubUnit {
//   SubUnit({
//       this.id,
//       this.weight,
//       this.status,
//       this.product,
//       this.unitId,
//       this.subUnitName,
//       this.createDate,
//       this.v,});

//   SubUnit.fromJson(dynamic json) {
//     id = json['_id'];
//     weight = json['weight'];
//     status = json['status'];
//     product = json['product'];
//     unitId = json['unitId'];
//     subUnitName = json['subUnitName'];
//     createDate = json['create_date'];
//     v = json['__v'];
//   }
//   String? id;
//   int? weight;
//   String? status;
//   String? product;
//   String? unitId;
//   String? subUnitName;
//   String? createDate;
//   int? v;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = id;
//     map['weight'] = weight;
//     map['status'] = status;
//     map['product'] = product;
//     map['unitId'] = unitId;
//     map['subUnitName'] = subUnitName;
//     map['create_date'] = createDate;
//     map['__v'] = v;
//     return map;
//   }

// }

// class UnitId {
//   UnitId({
//       this.id,
//       this.weight,
//       this.status,
//       this.product,
//       this.unitName,
//       this.createDate,
//       this.v,});

//   UnitId.fromJson(dynamic json) {
//     id = json['_id'];
//     weight = json['weight'];
//     status = json['status'];
//     product = json['product'];
//     unitName = json['unitName'];
//     createDate = json['create_date'];
//     v = json['__v'];
//   }
//   String? id;
//   int? weight;
//   String? status;
//   String? product;
//   String? unitName;
//   String? createDate;
//   int? v;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = id;
//     map['weight'] = weight;
//     map['status'] = status;
//     map['product'] = product;
//     map['unitName'] = unitName;
//     map['create_date'] = createDate;
//     map['__v'] = v;
//     return map;
//   }

// }

import 'package:flutter/material.dart';

class ViewProductMainDetailedModel {
  ViewProductMainDetailedModel({
    this.status,
    this.data,
    this.msg,
  });

  ViewProductMainDetailedModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  bool? status;
  List<Data>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }
}

class Data {
  Data({
    this.unit,
    this.product,
  });

  Data.fromJson(dynamic json) {
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    if (json['product'] != null) {
      product = [];
      json['product'].forEach((v) {
        product?.add(Product.fromJson(v));
      });
    }
  }
  Unit? unit;
  List<Product>? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (unit != null) {
      map['unit'] = unit?.toJson();
    }
    if (product != null) {
      map['product'] = product?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Product {
  Product({
    this.id,
    this.status,
    this.stockIn,
    this.product,
    this.unitId,
    this.subUnit,
    this.totalQuantity,
    this.price,
    this.createDate,
    this.v,
  });

  Product.fromJson(dynamic json) {
    id = json['_id'];
    status = json['status'];
    stockIn = json['stockIn'];
    product = json['product'];
    unitId = json['unitId'] != null ? UnitId.fromJson(json['unitId']) : null;
    subUnit =
        json['subUnit'] != null ? SubUnit.fromJson(json['subUnit']) : null;
    totalQuantity = json['totalQuantity'];
    price = json['price'];
    createDate = json['create_date'];
    v = json['__v'];
  }
  String? id;
  String? status;
  String? stockIn;
  String? product;
  UnitId? unitId;
  SubUnit? subUnit;
  int? totalQuantity;
  int? price;
  String? createDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['status'] = status;
    map['stockIn'] = stockIn;
    map['product'] = product;
    if (unitId != null) {
      map['unitId'] = unitId?.toJson();
    }
    if (subUnit != null) {
      map['subUnit'] = subUnit?.toJson();
    }
    map['totalQuantity'] = totalQuantity;
    map['price'] = price;
    map['create_date'] = createDate;
    map['__v'] = v;
    return map;
  }
}

class SubUnit {
  SubUnit({
    this.id,
    this.weight,
    this.status,
    this.product,
    this.unitId,
    this.subUnitName,
    required this.subunitnamecontroller,
    required this.subunitpricecontroller,
    required this.subunitweightcontroller,
    this.createDate,
    this.v,
  });

  SubUnit.fromJson(dynamic json) {
    id = json['_id'];
    weight = json['weight'];
    status = json['status'];
    product = json['product'];
    unitId = json['unitId'];
    subUnitName = json['subUnitName'];
    createDate = json['create_date'];
    v = json['__v'];
  }
  String? id;
  int? weight;
  String? status;

  String? product;
  String? unitId;
  String? subUnitName;
  var subunitnamecontroller = TextEditingController();
  var subunitweightcontroller = TextEditingController();
  var subunitpricecontroller = TextEditingController();
  String? createDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['weight'] = weight;
    map['status'] = status;
    map['product'] = product;
    map['unitId'] = unitId;
    map['subUnitName'] = subUnitName;
    map['create_date'] = createDate;
    map['__v'] = v;
    return map;
  }
}

class UnitId {
  UnitId({
    this.id,
    this.weight,
    this.status,
    this.product,
    this.unitName,
    this.createDate,
    this.v,
  });

  UnitId.fromJson(dynamic json) {
    id = json['_id'];
    weight = json['weight'];
    status = json['status'];
    product = json['product'];
    unitName = json['unitName'];
    createDate = json['create_date'];
    v = json['__v'];
  }
  String? id;
  int? weight;
  String? status;
  String? product;
  String? unitName;
  String? createDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['weight'] = weight;
    map['status'] = status;
    map['product'] = product;
    map['unitName'] = unitName;
    map['create_date'] = createDate;
    map['__v'] = v;
    return map;
  }
}

class Unit {
  Unit({
    this.id,
    this.weight,
    this.status,
    this.product,
    this.unitName,
    required this.unitnamecontroller,
    required this.weigthcontroller,
    required this.pricecontroller,
    required this.totalquantitycontroller,
    this.createDate,
    this.v,
  });

  Unit.fromJson(dynamic json) {
    id = json['_id'];
    weight = json['weight'];
    status = json['status'];
    product = json['product'];
    unitName = json['unitName'];
    createDate = json['create_date'];
    v = json['__v'];
  }
  String? id;
  int? weight;
  String? status;
  ////
  var unitnamecontroller = TextEditingController();
  var weigthcontroller = TextEditingController();
  var pricecontroller = TextEditingController();
  var totalquantitycontroller = TextEditingController();
  String? product;
  String? unitName;
  String? createDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['weight'] = weight;
    map['status'] = status;
    map['product'] = product;
    map['unitName'] = unitName;
    map['create_date'] = createDate;
    map['__v'] = v;
    return map;
  }
}
