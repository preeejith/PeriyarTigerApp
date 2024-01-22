class AssetMasterTable {
  AssetMasterTable({
    required this.status,
    required this.id,
    required this.name,
    required this.productType,
    required this.description,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final String status;
  late final String id;
  late final String name;
  late final String productType;
  late final String description;
  late final String createDate;
  late final String updateDate;
  late final int V;

  AssetMasterTable.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['_id'];
    name = json['name'];
    productType = json['productType'];
    description = json['description'] == null ? "" : json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['_id'] = id;
    _data['name'] = name;
    _data['productType'] = productType;
    _data['description'] = description;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}
