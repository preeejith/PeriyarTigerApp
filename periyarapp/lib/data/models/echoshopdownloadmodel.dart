class EchoShopProductDownloadModel {
  EchoShopProductDownloadModel({
    this.status,
    this.data,
    this.msg,
  });
//
  EchoShopProductDownloadModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }
  bool? status;
  List<Data>? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['msg'] = msg;
    return map;
  }
}

class Data {
  Data({
    this.images,
    this.coverImage,
    this.weight,
    this.unitType,
    this.status,
    this.id,
    this.productname,
    this.description,
    this.speciality,
    this.stockIn,
    this.hasUnit,
    this.quantity,
    this.createDate,
    this.v,
    this.details,
  });

  Data.fromJson(dynamic json) {
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['coverImage'] != null) {
      coverImage = [];
      json['coverImage'].forEach((v) {
        coverImage?.add((v));
      });
    }
    hasUnit = json['hasUnit'];
    weight = json['weight'].toString();
    unitType = json['unitType'];
    status = json['status'];
    id = json['_id'];
    productname = json['productname'];
    description = json['description'];
    speciality = json['speciality'];
    stockIn = json['stockIn'];
    createDate = json['create_date'];
    v = json['__v'];
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(Details.fromJson(v));
      });
    }
  }
  List<String>? images = [];
  List<dynamic>? coverImage;
  String? weight;

  String? unitType;
  String? status;
  String? id;
  String? productname;
  String? description;
  String? speciality;
  String? stockIn;
  num? quantity = 0;
  String? createDate;
  int? v;
  bool? hasUnit;
  List<Details>? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (images != null) {
      map['images'] = images;
    }

    if (coverImage != null) {
      map['coverImage'] = coverImage?.map((v) => v.toJson()).toList();
    }
    map['weight'] = weight;
    map['unitType'] = unitType;
    map['status'] = status;
    map['_id'] = id;
    map['productname'] = productname;
    map['description'] = description;
    map['speciality'] = speciality;
    map['stockIn'] = stockIn;
    map['create_date'] = createDate;
    map['__v'] = v;
    if (details != null) {
      map['details'] = details?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Details {
  Details({
    this.unit,
    this.hasSubUnit,
    this.product,
  });

  ///
  Details.fromJson(dynamic json) {
    unit = json['unit'] != null ? Unit.fromJson(json['unit']) : null;
    isVarient = json['unit'] == null ? false : true;
    hasSubUnit = json['hasSubUnit'];
    if (json['product'] != null) {
      product = [];
      json['product'].forEach((v) {
        product?.add(Product.fromJson(v));
      });
    }
  }
  Unit? unit;
  bool? hasSubUnit;
  List<Product>? product;
  bool? isVarient = true;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (unit != null) {
      map['unit'] = unit?.toJson();
    }
    if (product != null) {
      map['product'] = product?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Product {
  Product({
    this.id,
    this.status,
    this.stockIn,
    this.product,
    this.unitId,
    this.subUnit,
    this.totalQuantity,
    this.availableQuantity,
    this.price,
    this.weight,
    this.createDate,
    this.v,
  });

  Product.fromJson(dynamic json) {
    id = json['_id'];
    status = json['status'];
    stockIn = json['stockIn'];
    product = json['product'];
    unitId = json['unitId'] != null ? UnitId.fromJson(json['unitId']) : null;
    subUnit =
        json['subUnit'] != null ? SubUnit.fromJson(json['subUnit']) : null;
    totalQuantity = json['totalQuantity'];
    availableQuantity = json['availableQuantity'];
    price = json['price'];
    weight = json['weight'];

    createDate = json['create_date'];
    v = json['__v'];
  }
  String? id;
  String? status;
  String? stockIn;
  String? product;
  UnitId? unitId;
  SubUnit? subUnit;
  int? totalQuantity;
  int? availableQuantity;
  num? price;
  num? weight;
  String? createDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['status'] = status;
    map['stockIn'] = stockIn;
    map['product'] = product;
    if (unitId != null) {
      map['unitId'] = unitId?.toJson();
    }
    if (subUnit != null) {
      map['subUnit'] = subUnit?.toJson();
    }
    map['totalQuantity'] = totalQuantity;
    map['availableQuantity'] = availableQuantity;
    map['price'] = price;
    map['weight'] = weight;
    map['create_date'] = createDate;
    map['__v'] = v;
    return map;
  }
}

class SubUnit {
  SubUnit({
    this.id,
    this.weight,
    this.status,
    this.quantity,
    this.product,
    this.unitId,
    this.subUnitName,
    this.createDate,
    this.v,
  });

  SubUnit.fromJson(dynamic json) {
    id = json['_id'];
    weight = json['weight'];
    status = json['status'];
    product = json['product'];
    unitId = json['unitId'];
    subUnitName = json['subUnitName'];
    createDate = json['create_date'];
    v = json['__v'];
  }
  String? id;
  int? weight;
  num? quantity = 0;
  String? status;
  String? product;
  String? unitId;
  String? subUnitName;
  String? createDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['weight'] = weight;
    map['status'] = status;
    map['product'] = product;
    map['unitId'] = unitId;
    map['subUnitName'] = subUnitName;
    map['create_date'] = createDate;
    map['__v'] = v;
    return map;
  }
}

class UnitId {
  UnitId({
    this.id,
    this.weight,
    this.status,
    this.product,
    this.unitName,
    this.createDate,
    this.v,
  });

  UnitId.fromJson(dynamic json) {
    id = json['_id'];
    weight = json['weight'];
    status = json['status'];
    product = json['product'];
    unitName = json['unitName'];
    createDate = json['create_date'];
    v = json['__v'];
  }
  String? id;
  int? weight;
  String? status;
  String? product;
  String? unitName;
  String? createDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['weight'] = weight;
    map['status'] = status;
    map['product'] = product;
    map['unitName'] = unitName;
    map['create_date'] = createDate;
    map['__v'] = v;
    return map;
  }
}

class Unit {
  Unit({
    this.id,
    this.weight,
    this.status,
    this.product,
    this.unitName,
    this.createDate,
    this.quantity,
    this.v,
  });

  Unit.fromJson(dynamic json) {
    id = json['_id'];
    weight = json['weight'];
    status = json['status'];
    product = json['product'];
    unitName = json['unitName'];
    createDate = json['create_date'];
    v = json['__v'];
  }
  String? id;
  num? quantity = 0;
  int? weight;
  String? status;
  String? product;
  String? unitName;
  String? createDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['weight'] = weight;
    map['status'] = status;
    map['product'] = product;
    map['unitName'] = unitName;
    map['create_date'] = createDate;
    map['__v'] = v;
    return map;
  }
}
