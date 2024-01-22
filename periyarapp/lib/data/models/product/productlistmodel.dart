class ProductListModel {
  bool? status;
  List<ProductModel>? productModel;
  String? msg;

  ProductListModel({this.status, this.productModel, this.msg});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      productModel = <ProductModel>[];
      json['data'].forEach((v) {
        productModel!.add(new ProductModel.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.productModel != null) {
      data['data'] = this.productModel!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class ProductModel {
  List<String>? images;
  List<String>? speciality;
  int? weight;
  String? unitType;
  String? status;
  bool? isShownOnline;
  String? sId;
  String? name;
  List<Units>? units;
  String? createDate;
  int? price;
  int? totalQuantity;
  int? availableQuantity;
  String? unitId;
  String? description;
  int? iV;
  String? productId;

  ProductModel(
      {this.images,
      this.speciality,
      this.weight,
      this.unitType,
      this.status,
      this.isShownOnline,
      this.sId,
      this.name,
      this.units,
      this.createDate,
      this.price,
      this.totalQuantity,
      this.availableQuantity,
      this.unitId,
      this.description,
      this.iV,
      this.productId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    speciality = json['speciality'].cast<String>();
    weight = json['weight'];
    unitType = json['unitType'];
    status = json['status'];
    isShownOnline = json['isShownOnline'];
    sId = json['_id'];
    name = json['name'];
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(new Units.fromJson(v));
      });
    }
    createDate = json['create_date'];
    price = json['price'];
    totalQuantity = json['totalQuantity'];
    availableQuantity = json['availableQuantity'];
    unitId = json['unitId'];
    description = json['description'];
    iV = json['__v'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['speciality'] = this.speciality;
    data['weight'] = this.weight;
    data['unitType'] = this.unitType;
    data['status'] = this.status;
    data['isShownOnline'] = this.isShownOnline;
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.units != null) {
      data['units'] = this.units!.map((v) => v.toJson()).toList();
    }
    data['create_date'] = this.createDate;
    data['price'] = this.price;
    data['totalQuantity'] = this.totalQuantity;
    data['availableQuantity'] = this.availableQuantity;
    data['unitId'] = this.unitId;
    data['description'] = this.description;
    data['__v'] = this.iV;
    data['productId'] = this.productId;
    return data;
  }
}

class Units {
  int? stock;
  int? price;
  int? weight;
  String? sId;
  String? type;
  List<Size>? size;

  Units({this.stock, this.price, this.weight, this.sId, this.type, this.size});

  Units.fromJson(Map<String, dynamic> json) {
    stock = json['stock'];
    price = json['price'];
    weight = json['weight'];
    sId = json['_id'];
    type = json['type'];
    if (json['size'] != null) {
      size = <Size>[];
      json['size'].forEach((v) {
        size!.add(new Size.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stock'] = this.stock;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['_id'] = this.sId;
    data['type'] = this.type;
    if (this.size != null) {
      data['size'] = this.size!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Size {
  int? price;
  int? stock;
  int? weight;
  String? sId;
  String? sizename;

  Size({this.price, this.stock, this.weight, this.sId, this.sizename});

  Size.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    stock = json['stock'];
    weight = json['weight'];
    sId = json['_id'];
    sizename = json['sizename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['weight'] = this.weight;
    data['_id'] = this.sId;
    data['sizename'] = this.sizename;
    return data;
  }
}
