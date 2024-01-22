// class AddProductImageModel {
//   AddProductImageModel({
//       this.status,
//       this.id,
//       this.data,
//       this.msg,});

//   AddProductImageModel.fromJson(dynamic json) {
//     status = json['status'];
//     id = json['id'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     msg = json['msg'];
//   }
//   bool? status;
//   String? id;
//   Data? data;
//   String? msg;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['id'] = id;
//     if (data != null) {
//       map['data'] = data?.toJson();
//     }
//     map['msg'] = msg;
//     return map;
//   }

// }

// class Data {
//   Data({
//       this.images,
//       this.weight,
//       this.unitType,
//       this.status,
//       this.id,
//       this.productname,
//       this.description,
//       this.speciality,
//       this.createDate,
//       this.v,});

//   Data.fromJson(dynamic json) {
//     images = json['images'] != null ? json['images'].cast<String>() : [];
//     weight = json['weight'];
//     unitType = json['unitType'];
//     status = json['status'];
//     id = json['_id'];
//     productname = json['productname'];
//     description = json['description'];
//     speciality = json['speciality'];
//     createDate = json['create_date'];
//     v = json['__v'];
//   }
//   List<String>? images;
//   int? weight;
//   String? unitType;
//   String? status;
//   String? id;
//   String? productname;
//   String? description;
//   String? speciality;
//   String? createDate;
//   int? v;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['images'] = images;
//     map['weight'] = weight;
//     map['unitType'] = unitType;
//     map['status'] = status;
//     map['_id'] = id;
//     map['productname'] = productname;
//     map['description'] = description;
//     map['speciality'] = speciality;
//     map['create_date'] = createDate;
//     map['__v'] = v;
//     return map;
//   }

// }

class AddProductImageModel {
  AddProductImageModel({
    this.status,
    this.id,
    this.data,
    this.msg,
  });

  AddProductImageModel.fromJson(dynamic json) {
    status = json['status'] == null ? "" : json['status'];
    id = json['id'] == null ? "" : json['id'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'] == null ? "" : json['msg'];
  }
  bool? status;
  String? id;
  Data? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['id'] = id;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['msg'] = msg;
    return map;
  }
}

class Data {
  Data({
    this.images,
    this.weight,
    this.unitType,
    this.status,
    this.id,
    this.productname,
    this.description,
    this.speciality,
    this.createDate,
    this.v,
    this.coverImage,
  });

  Data.fromJson(dynamic json) {
    images = json['images'] != null ? json['images'].cast<String>() : [];
    coverImage =
        json['coverImage'] != null ? json['coverImage'].cast<String>() : [];
    weight = json['weight'];
    unitType = json['unitType'];
    status = json['status'];
    id = json['_id'];
    productname = json['productname'];
    description = json['description'];
    speciality = json['speciality'];
    createDate = json['create_date'];
    v = json['__v'];
    // coverImage = json['coverImage'];
  }
  List<String>? images;
  List<String>? coverImage;
  int? weight;
  String? unitType;
  String? status;
  String? id;
  String? productname;
  String? description;
  String? speciality;
  String? createDate;
  int? v;
  // String? coverImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['images'] = images;
    map['coverImage'] = coverImage;
    map['weight'] = weight;
    map['unitType'] = unitType;
    map['status'] = status;
    map['_id'] = id;
    map['productname'] = productname;
    map['description'] = description;
    map['speciality'] = speciality;
    map['create_date'] = createDate;
    map['__v'] = v;
    // map['coverImage'] = coverImage;
    return map;
  }
}
