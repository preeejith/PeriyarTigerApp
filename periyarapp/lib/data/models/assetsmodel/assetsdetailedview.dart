// class AssetsDetailedViewModel {
//   AssetsDetailedViewModel({
//     required this.status,
//     required this.msg,
//     required this.data,
//   });
//   late final bool status;
//   late final String msg;
//   late final Data data;

//   AssetsDetailedViewModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     data = Data.fromJson(json['data']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['msg'] = msg;
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }

// class Data {
//   Data({
//     required this.quantity,
//     required this.price,
//     required this.discount,
//     required this.status,
//     required this.id,
//     required this.assetId,
//     required this.unitId,
//     required this.createDate,
//     required this.updateDate,
//     required this.V,
//   });
//   late final int quantity;
//   late final int price;
//   late final int discount;
//   late final String status;
//   late final String id;
//   late final AssetId assetId;
//   late final String unitId;
//   late final String createDate;
//   late final String updateDate;
//   late final int V;

//   Data.fromJson(Map<String, dynamic> json) {
//     quantity = json['quantity'];

//     if (json['price'] != null) {
//       price = json['price'];
//     }
//     if (json['discount'] != null) {
//       discount = json['discount'];
//     }
//     //  price = json['price'];
//     //  discount = json['discount'];
//     status = json['status'];
//     id = json['_id'];

//     if (json['assetId'] != null) {
//       assetId = AssetId.fromJson(json['assetId']);
//     }
//     // assetId = AssetId.fromJson(json['assetId']);
//     unitId = json['unitId'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     V = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['quantity'] = quantity;
//     _data['price'] = price;
//     _data['discount'] = discount;
//     _data['status'] = status;
//     _data['_id'] = id;
//     _data['assetId'] = assetId.toJson();
//     _data['unitId'] = unitId;
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
//     required this.productType,
//     required this.description,
//     required this.createDate,
//     required this.updateDate,
//     required this.V,
//   });
//   late final String status;
//   late final String id;
//   late final String name;
//   late final String productType;
//   late final String description;
//   late final String createDate;
//   late final String updateDate;
//   late final int V;

//   AssetId.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     id = json['_id'];
//     name = json['name'];
//     productType = json['productType'];
//     description = json['description'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     V = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['_id'] = id;
//     _data['name'] = name;
//     _data['productType'] = productType;
//     _data['description'] = description;
//     _data['create_date'] = createDate;
//     _data['update_date'] = updateDate;
//     _data['__v'] = V;
//     return _data;
//   }
// }
class AssetsDetailedViewModel {
  AssetsDetailedViewModel({
    this.status,
    this.msg,
    this.data,
  });

  AssetsDetailedViewModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? msg;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
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
    this.v,
  });

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
    assetId =
        json['assetId'] != null ? AssetId.fromJson(json['assetId']) : null;
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
