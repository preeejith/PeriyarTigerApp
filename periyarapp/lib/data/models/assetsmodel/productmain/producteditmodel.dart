class ProductEditModeldart {
  ProductEditModeldart({
      this.status, 
      this.data, 
      this.msg,});

  ProductEditModeldart.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'];
    msg = json['msg'];
  }
  bool? status;
  String? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['data'] = data;
    map['msg'] = msg;
    return map;
  }

}