///new one for
class PurchaseOrder {
  PurchaseOrder(
      {this.status,
      this.id,
      this.employeeId,
      this.purchaseId,
      this.assetId,
      this.assetname,
      this.totalAmount,
      this.discount,
      this.billAmount,
      this.createDate,
      this.quantity,
      this.purchaseAmount});

  PurchaseOrder.fromJson(dynamic json) {
    status = json['status'];
    id = json['id'];

    employeeId = json['employeeId'];
    purchaseId = json['purchaseId'];
    assetId = json['assetId'];
    assetname = json['assetname'];
    totalAmount = json['totalAmount'];
    discount = json['discount'];
    billAmount = json['billAmount'];
    createDate = json['create_date'];
    quantity = json['quantity'];
    purchaseAmount = json['purchaseAmount'];
  }
  String? status;
  String? id;

  String? employeeId;
  String? purchaseId;
  String? assetId;
  String? assetname;
  String? totalAmount;
  String? discount;
  String? billAmount;
  String? createDate;
  String? quantity;
  String? purchaseAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['id'] = id;

    map['employeeId'] = employeeId;
    map['purchaseId'] = purchaseId;
    map['assetId'] = assetId;
    map['assetname'] = assetname;
    map['totalAmount'] = totalAmount;
    map['discount'] = discount;
    map['billAmount'] = billAmount;
    map['create_date'] = createDate;
    map['quantity'] = quantity;
    map['purchaseAmount'] = purchaseAmount;

    return map;
  }
}

class PurchaseData {
  PurchaseData({
    this.purchaseid,
    this.name,
    this.purchaseAmount,
    this.quantity,
    this.assetId,
  });

  PurchaseData.fromJson(dynamic json) {
    purchaseid = json['purchaseid'];
    name = json['name'];
    purchaseAmount = json['purchaseAmount'];
    quantity = json['quantity'];
    assetId = json['assetId'];
  }
  String? purchaseid;

  String? purchaseAmount;
  String? quantity;
  String? name;
  String? assetId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['purchaseid'] = purchaseid;
    map['name'] = quantity;
    map['purchaseAmount'] = purchaseAmount;
    map['quantity'] = quantity;
    map['assetId'] = assetId;

    return map;
  }
}
