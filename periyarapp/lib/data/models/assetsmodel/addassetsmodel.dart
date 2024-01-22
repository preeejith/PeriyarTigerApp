class AddAssetsModel {
  AddAssetsModel({
    required this.status,
    required this.msg,
    required this.data,
    required this.asset,
  });
  late final bool status;
  late final String msg;
  late final Data data;
  late final Asset asset;

  AddAssetsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
    asset = Asset.fromJson(json['asset']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    _data['asset'] = asset.toJson();
    return _data;
  }
}

class Data {
  Data({
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

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['_id'];
    name = json['name'];
    productType = json['productType'];
    description = json['description'];
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

class Asset {
  Asset({
    required this.quantity,
    // required this.price,
    // required this.discount,
    required this.status,
    required this.id,
    required this.assetId,
    required this.unitId,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final int quantity;
  // late final int price;
  // late final int discount;
  late final String status;
  late final String id;
  late final String assetId;
  late final String unitId;
  late final String createDate;
  late final String updateDate;
  late final int V;

  Asset.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    // price = json['price'];
    // discount = json['discount'];
    status = json['status'];
    id = json['_id'];
    assetId = json['assetId'];
    unitId = json['unitId'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['quantity'] = quantity;
    // _data['price'] = price;
    // _data['discount'] = discount;
    _data['status'] = status;
    _data['_id'] = id;
    _data['assetId'] = assetId;
    _data['unitId'] = unitId;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}
