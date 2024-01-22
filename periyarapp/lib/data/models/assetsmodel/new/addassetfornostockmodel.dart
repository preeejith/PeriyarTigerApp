///

class AddAssetNoStockModel {
  AddAssetNoStockModel({
    required this.status,
    required this.msg,
    required this.bill,
  });
  late final bool status;
  late final String msg;
  late final Bill bill;

  AddAssetNoStockModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    bill = Bill.fromJson(json['bill']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['bill'] = bill.toJson();
    return _data;
  }
}

class Bill {
  Bill({
    required this.id,
    required this.purchase,
    required this.employeeId,
    required this.purchaseId,
    required this.totalAmount,
    required this.discount,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final String id;
  late final List<Purchase> purchase;
  late final String employeeId;
  late final String purchaseId;
  late final int totalAmount;
  late final String discount;
  late final String createDate;
  late final String updateDate;
  late final int V;

  Bill.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    purchase =
        List.from(json['purchase']).map((e) => Purchase.fromJson(e)).toList();
    employeeId = json['employeeId'];
    purchaseId = json['purchaseId'];
    totalAmount = json['totalAmount'];
    discount = json['discount'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['purchase'] = purchase.map((e) => e.toJson()).toList();
    _data['employeeId'] = employeeId;
    _data['purchaseId'] = purchaseId;
    _data['totalAmount'] = totalAmount;
    _data['discount'] = discount;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}

class Purchase {
  Purchase({
    required this.id,
    required this.assetId,
    required this.purchaseAmount,
  });
  late final String id;
  late final String assetId;
  late final int purchaseAmount;

  Purchase.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    assetId = json['assetId'];
    purchaseAmount = json['purchaseAmount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['assetId'] = assetId;
    _data['purchaseAmount'] = purchaseAmount;
    return _data;
  }
}
///////////
