import 'package:flutter/material.dart';

//controllermodel
//////
class ViewAllAssetsModel {
  ViewAllAssetsModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String msg;
  late final List<Data> data;

  ViewAllAssetsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

//
class Data {
  Data({
    required this.quantity,
    required this.price,
    required this.discount,
    required this.status,
    required this.id,
    this.count,
    required this.checkon,
    this.change,
    this.color,
    required this.remarkcontroller,
    required this.quantity3controller,
    required this.assetId,
    required this.createDate,
    required this.updateDate,
    required this.V,
    required this.unitId,
  });
  num? quantity;
  late final int price;
  late final int discount;
  late final String status;
  late final String id;

  late final AssetId assetId;
  late final String createDate;
  late final String updateDate;
  bool? change = false;
  bool? color = false;
  bool? checkon = false;
  var remarkcontroller = TextEditingController();
  var quantity3controller = TextEditingController();

  int? count = 0;

  late final int? V;
  late final String? unitId;

  Data.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'] == null ? "" : json['quantity'];

    if (json['price'] != null) {
      price = json['price'];
    }
    if (json['discount'] != null) {
      discount = json['discount'];
    }

    status = json['status'];
    id = json['_id'];

    if (json['assetId'] != null) {
      assetId = AssetId.fromJson(json['assetId']);
    }

    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
    unitId = json['unitId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['quantity'] = quantity;
    // _data['price'] = price;
    // _data['discount'] = discount;
    _data['status'] = status;
    _data['_id'] = id;
    _data['assetId'] = assetId.toJson();
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    _data['unitId'] = unitId;
    return _data;
  }
}

class AssetId {
  AssetId({
    required this.status,
    required this.id,
    required this.name,
    required this.productType,
    required this.description,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final String status;
  late final String id;
  late final String name;
  late final String productType;
  late final String description;
  late final String createDate;
  late final String updateDate;
  late final int V;

  AssetId.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['_id'];
    name = json['name'];
    productType = json['productType'];
    description = json['description'] == null ? "" : json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['_id'] = id;
    _data['name'] = name;
    _data['productType'] = productType;
    _data['description'] = description;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}
