class IcToIcRequestModel {
  IcToIcRequestModel({
      this.status, 
      this.msg, 
      this.data,});

  IcToIcRequestModel.fromJson(dynamic json) {
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
      this.typeOfRequest, 
      this.quantity, 
      this.assetName,});

  Data.fromJson(dynamic json) {
    typeOfRequest = json['typeOfRequest'];
    quantity = json['quantity'];
    assetName = json['assetName'];
  }
  String? typeOfRequest;
  String? quantity;
  String? assetName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['typeOfRequest'] = typeOfRequest;
    map['quantity'] = quantity;
    map['assetName'] = assetName;
    return map;
  }

}