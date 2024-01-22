class ViewProductMainModel {
  ViewProductMainModel({
    this.status,
    this.data,
    this.msg,
  });

  ViewProductMainModel.fromJson(dynamic json) {
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
    this.createDate,
    this.v,
  });

  Data.fromJson(dynamic json) {
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add((v));
      });
    }

    if (json['coverImage'] != null) {
      coverImage = [];
      json['coverImage'].forEach((v) {
        coverImage?.add((v));
      });
    }
    weight = json['weight'];
    unitType = json['unitType'];
    status = json['status'];
    id = json['_id'];
    productname = json['productname'];
    description = json['description'];
    speciality = json['speciality'];
    createDate = json['create_date'];
    v = json['__v'];
  }
  List<dynamic>? images;
  List<dynamic>? coverImage;
  int? weight;
  String? unitType;
  String? status;
  String? id;
  String? productname;
  String? description;
  String? speciality;
  String? createDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
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
    map['create_date'] = createDate;
    map['__v'] = v;
    return map;
  }
}
