class AssetsWithOutRequestModel {
  AssetsWithOutRequestModel({
    required this.status,
    required this.msg,
    required this.data,
    required this.stockDetails,
    required this.log,
  });
  late final bool status;
  late final String msg;
  late final Data data;
  late final StockDetails stockDetails;
  late final Log log;

  AssetsWithOutRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = Data.fromJson(json ['data']==null?"":json ['data']);
    stockDetails = StockDetails.fromJson(json['stockDetails']);
    log = Log.fromJson(json['log']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    _data['stockDetails'] = stockDetails.toJson();
    _data['log'] = log.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.quantity,
    required this.price,
    required this.discount,
    required this.status,
    required this.id,
    required this.assetId,
    required this.unitId,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final int quantity;
  late final int price;
  late final int discount;
  late final String status;
  late final String id;
  late final AssetId assetId;
  late final String unitId;
  late final String createDate;
  late final String updateDate;
  late final int V;

  Data.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity']==null?"":json['quantity'];
    // price = json['price']==null?"":json['price'];
    // discount = json['discount']==null?"":json['discount'];
    status = json['status'];
    id = json['_id'];
    // assetId = AssetId.fromJson(json['assetId']);
    // unitId = json['unitId'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['quantity'] = quantity;
    _data['price'] = price;
    _data['discount'] = discount;
    _data['status'] = status;
    _data['_id'] = id;
    _data['assetId'] = assetId.toJson();
    _data['unitId'] = unitId;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
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

class StockDetails {
  StockDetails({
    required this.quantity,
    required this.price,
    required this.discount,
    required this.status,
    required this.id,
    required this.unitId,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final int quantity;
  late final int price;
  late final int discount;
  late final String status;
  late final String id;
  late final String unitId;
  late final String createDate;
  late final String updateDate;
  late final int V;

  StockDetails.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    price = json['price'];
    discount = json['discount'];
    status = json['status'];
    id = json['_id'];
    unitId = json['unitId'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['quantity'] = quantity;
    _data['price'] = price;
    _data['discount'] = discount;
    _data['status'] = status;
    _data['_id'] = id;
    _data['unitId'] = unitId;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}

class Log {
  Log({
    required this.stock,
    required this.status,
    required this.id,
    required this.assetId,
    required this.frominventoryId,
    required this.toinventoryId,
    required this.type,
    required this.remark,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final int stock;
  late final String status;
  late final String id;
  late final String assetId;
  late final String frominventoryId;
  late final String toinventoryId;
  late final String type;
  late final String remark;
  late final String createDate;
  late final String updateDate;
  late final int V;

  Log.fromJson(Map<String, dynamic> json) {
    stock = json['stock'];
    status = json['status'];
    id = json['_id'];
    assetId = json['assetId'];
    frominventoryId = json['frominventoryId'];
    toinventoryId = json['toinventoryId'];
    type = json['type'];
    remark = json['remark'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['stock'] = stock;
    _data['status'] = status;
    _data['_id'] = id;
    _data['assetId'] = assetId;
    _data['frominventoryId'] = frominventoryId;
    _data['toinventoryId'] = toinventoryId;
    _data['type'] = type;
    _data['remark'] = remark;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}
