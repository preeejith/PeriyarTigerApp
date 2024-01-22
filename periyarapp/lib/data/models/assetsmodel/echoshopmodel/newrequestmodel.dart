////new Request

class NewRequestModel {
  NewRequestModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String msg;
  late final List<Data> data;
  
  NewRequestModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    msg = json['msg'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.typeOfRequest,
    required this.quantity,
    required this.type,
    required this.assetName,
    required this.productId,
    required this.remark,
  });
  late final String typeOfRequest;
  late final String quantity;
  late final String type;
  late final String assetName;
  late final String productId;
  late final String remark;
  
  Data.fromJson(Map<String, dynamic> json){
    typeOfRequest = json['typeOfRequest'];
    quantity = json['quantity'];
    type = json['type'];
    assetName = json['assetName']==null?"":json['assetName'];
    productId = json['productId']==null?"":json['productId'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['typeOfRequest'] = typeOfRequest;
    _data['quantity'] = quantity;
    _data['type'] = type;
    _data['assetName'] = assetName;
    _data['productId'] = productId;
    _data['remark'] = remark;
    return _data;
  }
}