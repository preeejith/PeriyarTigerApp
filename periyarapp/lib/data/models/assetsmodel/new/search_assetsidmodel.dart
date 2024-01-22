class AssetsIdSearchModel {
  AssetsIdSearchModel({
    required this.status,
    required this.data,
    required this.msg,
  });
  late final bool status;
  late final List<Data> data;
  late final String msg;

  AssetsIdSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    if (json['data'] != null) {
      data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    }

    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['msg'] = msg;
    return _data;
  }
}

class Data {
  Data({
    required this.status,
    required this.id,
    required this.name,
    required this.type,
    required this.productType,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final String status;
  late final String id;
  late final String name;
  late final String type;
  late final String productType;
  late final String createDate;
  late final String updateDate;
  late final int V;

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['_id'];
    name = json['name'];
    type = json['type'] == null ? "" : json['type'];
    productType = json['productType'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['_id'] = id;
    _data['name'] = name;
    _data['type'] = type;
    _data['productType'] = productType;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}
