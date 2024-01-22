class TransferWithRequestMainModel {
  TransferWithRequestMainModel({
      this.status, 
      this.msg, 
      this.data,});

  TransferWithRequestMainModel.fromJson(dynamic json) {
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
      this.stock, 
      this.status, 
      this.id, 
      this.assetId, 
      this.frominventoryId, 
      this.toinventoryId, 
      this.type, 
      this.createDate, 
      this.updateDate, 
      this.v,});

  Data.fromJson(dynamic json) {
    stock = json['stock'];
    status = json['status'];
    id = json['_id'];
    assetId = json['assetId'];
    frominventoryId = json['frominventoryId'];
    toinventoryId = json['toinventoryId'];
    type = json['type'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  int? stock;
  String? status;
  String? id;
  String? assetId;
  String? frominventoryId;
  String? toinventoryId;
  String? type;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stock'] = stock;
    map['status'] = status;
    map['_id'] = id;
    map['assetId'] = assetId;
    map['frominventoryId'] = frominventoryId;
    map['toinventoryId'] = toinventoryId;
    map['type'] = type;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }

}