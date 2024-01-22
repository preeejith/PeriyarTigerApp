class RequestTransferModel {
  RequestTransferModel({
    required this.status,
    required this.msg,
    required this.data,
    required this.stockDetails,
  });
  late final bool status;
  late final String msg;
  late final Data data;
  late final StockDetails stockDetails;
  
  RequestTransferModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
    stockDetails = StockDetails.fromJson(json['stockDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    _data['stockDetails'] = stockDetails.toJson();
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
  late final String assetId;
  late final String unitId;
  late final String createDate;
  late final String updateDate;
  late final int V;
  
  Data.fromJson(Map<String, dynamic> json){
    quantity = json['quantity'];
    price = json['price'];
    discount = json['discount'];
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
    _data['price'] = price;
    _data['discount'] = discount;
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
  
  StockDetails.fromJson(Map<String, dynamic> json){
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