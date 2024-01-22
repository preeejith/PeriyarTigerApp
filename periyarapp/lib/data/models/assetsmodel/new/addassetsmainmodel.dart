// ///

// class AddAssetMainModel {
//   AddAssetMainModel({
//     required this.status,
//     required this.msg,
//     required this.bill,
//   });
//   late final bool status;
//   late final String msg;
//   late final Bill bill;

//   AddAssetMainModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     bill = Bill.fromJson(json['bill']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['msg'] = msg;
//     _data['bill'] = bill.toJson();
//     return _data;
//   }
// }

// class Bill {
//   Bill({
//     required this.id,
//     required this.purchase,
//     required this.employeeId,
//     required this.purchaseId,
//     required this.totalAmount,
//     required this.discount,
//     required this.createDate,
//     required this.updateDate,
//     required this.V,
//   });
//   late final String id;
//   late final List<Purchase> purchase;
//   late final String employeeId;
//   late final String purchaseId;
//   late final int totalAmount;
//   late final String discount;
//   late final String createDate;
//   late final String updateDate;
//   late final int V;

//   Bill.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     purchase =
//         List.from(json['purchase']).map((e) => Purchase.fromJson(e)).toList();
//     employeeId = json['employeeId'];
//     purchaseId = json['purchaseId'];
//     totalAmount = json['totalAmount'];
//     discount = json['discount'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     V = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['_id'] = id;
//     _data['purchase'] = purchase.map((e) => e.toJson()).toList();
//     _data['employeeId'] = employeeId;
//     _data['purchaseId'] = purchaseId;
//     _data['totalAmount'] = totalAmount;
//     _data['discount'] = discount;
//     _data['create_date'] = createDate;
//     _data['update_date'] = updateDate;
//     _data['__v'] = V;
//     return _data;
//   }
// }

// class Purchase {
//   Purchase({
//     required this.id,
//     required this.assetId,
//     required this.purchaseAmount,
//   });
//   late final String id;
//   late final String assetId;
//   late final int purchaseAmount;

//   Purchase.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     assetId = json['assetId'];
//     purchaseAmount = json['purchaseAmount'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['_id'] = id;
//     _data['assetId'] = assetId;
//     _data['purchaseAmount'] = purchaseAmount;
//     return _data;
//   }
// }
// ///////////

class AddAssetMainModel {
  AddAssetMainModel({
    this.status,
    this.msg,
    this.bill,
  });

  AddAssetMainModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    bill = json['bill'] != null ? Bill.fromJson(json['bill']) : null;
  }
  bool? status;
  String? msg;
  Bill? bill;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (bill != null) {
      map['bill'] = bill?.toJson();
    }
    return map;
  }
}

class Bill {
  Bill({
    this.status,
    this.id,
    this.purchase,
    this.employeeId,
    this.purchaseId,
    this.totalAmount,
    this.discount,
    this.purchaseBy,
    this.billAmount,
    this.createDate,
    this.updateDate,
    this.v,
  });

  Bill.fromJson(dynamic json) {
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
    purchaseBy = json['purchaseBy'];
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
  String? purchaseBy;
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
    map['purchaseBy'] = purchaseBy;
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
    this.localId,
    this.name,
    this.assetype,
    this.productType,
    this.createDate,
    this.updateDate,
    this.v,
  });

  AssetId.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    localId = json['localId'] == null ? "" : json['localId'];
    name = json['name'];
    assetype = json['assetype'];
    productType = json['productType'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  String? status;
  String? id;
  String? localId;
  String? name;
  String? assetype;
  String? productType;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    map['localId'] = localId;
    map['name'] = name;
    map['assetype'] = assetype;
    map['productType'] = productType;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}
