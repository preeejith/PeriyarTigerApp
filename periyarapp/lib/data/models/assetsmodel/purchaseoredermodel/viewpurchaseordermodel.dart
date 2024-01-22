class ViewPurchaseListModel {
  ViewPurchaseListModel({
    this.status,
    this.msg,
    this.data,
  });
/////
  ViewPurchaseListModel.fromJson(dynamic json) {
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

/////
class Data {
  Data({
    this.status,
    this.id,
    this.purchase,
    this.employeeId,
    this.purchaseId,
    this.totalAmount,
    this.discount,
    this.billAmount,
    this.createDate,
    this.updateDate,
    this.v,
  });

  Data.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    if (json['purchase'] != null) {
      purchase = [];
      json['purchase'].forEach((v) {
        purchase?.add(Purchase.fromJson(v));
      });
    }
    employeeId = json['employeeId'];
    purchaseId = json['purchaseId'];
    totalAmount = json['totalAmount'];
    discount = json['discount'];
    billAmount = json['billAmount'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  String? status;
  String? id;
  List<Purchase>? purchase;
  String? employeeId;
  String? purchaseId;
  int? totalAmount;
  String? discount;
  int? billAmount;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    if (purchase != null) {
      map['purchase'] = purchase?.map((v) => v.toJson()).toList();
    }
    map['employeeId'] = employeeId;
    map['purchaseId'] = purchaseId;
    map['totalAmount'] = totalAmount;
    map['discount'] = discount;
    map['billAmount'] = billAmount;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

class Purchase {
  Purchase({
    this.id,
    this.assetId,
    this.purchaseAmount,
    this.quantity,
  });

  Purchase.fromJson(dynamic json) {
    id = json['_id'];
    assetId =
        json['assetId'] != null ? AssetId.fromJson(json['assetId']) : null;
    purchaseAmount = json['purchaseAmount'];
    quantity = json['quantity'];
  }
  String? id;
  AssetId? assetId;
  int? purchaseAmount;
  int? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (assetId != null) {
      map['assetId'] = assetId?.toJson();
    }
    map['purchaseAmount'] = purchaseAmount;
    map['quantity'] = quantity;
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
  });

  AssetId.fromJson(dynamic json) {
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
