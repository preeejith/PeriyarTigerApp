class ViewassetsModel {
  ViewassetsModel(
      {this.quantity,

      this.assetid,
      this.name,
      this.price,
      this.discount,
      this.status,
      this.id,
      this.count,
      this.change,
      this.checkon,
      this.createDate,
      this.unitId,
      this.edited,
      this.added,
      this.assetidtaken,
      this.purchaseid});
  String? quantity;

  String? assetid;
  String? name;
  String? price;
  String? discount;
  String? status;
  String? id;
  String? assetidtaken;
  String? purchaseid;

  String? createDate;

  bool? change = false;
  bool? color = false;
  String? checkon = "false";

  int? count = 0;

  int? V;
  String? unitId;
  String? edited;
  String? added;

  ViewassetsModel.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'] == null ? "" : json['quantity'];
    assetid = json['assetid'] == null ? "" : json['assetid'];
    name = json['name'] == null ? "" : json['name'];

    if (json['price'] != null) {
      price = json['price'];
    } else {
      price = "0";
    }
    if (json['discount'] != null) {
      discount = json['discount'];
    } else {
      discount = "0";
    }
    status = json['status'].toString();
    id = json['id'] == null ? "" : json['id'];
    checkon = json['checkon'] == null ? "" : json['checkon'];

    createDate = json['createDate'];

    unitId = json['unitId'];
    edited = json['edited'];
    added = json['added'];
    assetidtaken = json['assetidtaken'];
    purchaseid = json['purchaseid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['quantity'] = quantity;
    _data['assetid'] = assetid;
    _data['name'] = name;
    _data['price'] = price;
    _data['discount'] = discount;

    _data['status'] = status;
    _data['id'] = id;
    _data['checkon'] = checkon;
    _data['createDate'] = createDate;

    _data['unitId'] = unitId;
    _data['edited'] = edited;
    _data['added'] = added;
    _data['assetidtaken'] = assetidtaken;
    _data['purchaseid'] = purchaseid;
    return _data;
  }
}

//////
class AssetMasterTable {
  AssetMasterTable({
    this.status,
    this.id,
    this.name,
    this.productType,
    this.description,
    this.createDate,
  });
  String? status;
  String? id;
  String? name;
  String? productType;
  String? description;
  String? createDate;

  AssetMasterTable.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    name = json['name'];
    productType = json['productType'];
    description = json['description'] == null ? "" : json['description'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['id'] = id;
    _data['name'] = name;
    _data['productType'] = productType;
    _data['description'] = description;
    _data['create_date'] = createDate;

    return _data;
  }
}

class AssetMasterSuggestion {
  AssetMasterSuggestion({
    this.status,
    this.id,
    this.name,
    this.productType,
    this.description,
    this.createDate,
  });
  String? status;
  String? id;
  String? name;
  String? productType;
  String? description;
  String? createDate;

  AssetMasterSuggestion.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    name = json['name'];
    productType = json['productType'];
    description = json['description'] == null ? "" : json['description'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['id'] = id;
    _data['name'] = name;
    _data['productType'] = productType;
    _data['description'] = description;
    _data['create_date'] = createDate;

    return _data;
  }
}

/////to sync data
class SyncassetdataModel {
  SyncassetdataModel({
    this.assetname,
    this.assetid,
    this.productType,
    this.purchaseId,
    this.totalAmount,
    this.discount,
    this.purchaseAmount,
    this.description,
    this.quantity,
  });
  String? assetname;
  String? assetid;
  String? name;
  String? purchaseAmount;

  String? purchaseId;
  String? totalAmount;
  String? discount;

  String? productType;
  String? description;
  String? quantity;
}
