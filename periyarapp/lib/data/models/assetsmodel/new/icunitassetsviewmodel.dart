class IcUnitAssetsViewModel {
  IcUnitAssetsViewModel({
      this.status, 
      this.msg, 
      this.data,});

  IcUnitAssetsViewModel.fromJson(dynamic json) {
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
      this.v,});

  Data.fromJson(dynamic json) {
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
    assetId = json['assetId'] != null ? AssetId.fromJson(json['assetId']) : null;
    unitId = json['unitId'];
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
    if (assetId != null) {
      map['assetId'] = assetId?.toJson();
    }
    map['unitId'] = unitId;
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
      this.v,});

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