// class IcViewUnitsModel {
//   IcViewUnitsModel({
//     required this.status,
//     required this.msg,
//     required this.user,
//   });
//   late final bool status;
//   late final String msg;
//   late final List<User> user;

//   IcViewUnitsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     user = List.from(json['user']).map((e) => User.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['msg'] = msg;
//     _data['user'] = user.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class User {
//   User({
//     required this.location,
//     required this.status,
//     required this.unitincharge,
//     required this.id,
//     required this.type,
//     required this.name,
//     required this.description,
//     required this.createDate,
//     required this.updateDate,
//     required this.V,
//     required this.unitUnderIc,
//   });
//   late final List<dynamic> location;
//   late final String status;
//   late final List<dynamic> unitincharge;
//   late final String id;
//   late final String type;
//   late final String name;
//   late final String description;
//   late final String createDate;
//   late final String updateDate;
//   late final int V;
//   late final String unitUnderIc;

//   User.fromJson(Map<String, dynamic> json) {
//     location = List.castFrom<dynamic, dynamic>(json['location']);
//     status = json['status'];

//     if (json['unitincharge'] != null) {
//       unitincharge = List.castFrom<dynamic, dynamic>(json['unitincharge']);
//     }

//     id = json['_id'];
//     type = json['type'] == null?"":json['type'];
//     name = json['name'];
//     description = json['description'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     V = json['__v'];
//     unitUnderIc = json['unitUnderIc'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['location'] = location;
//     _data['status'] = status;
//     _data['unitincharge'] = unitincharge;
//     _data['_id'] = id;
//     _data['type'] = type;
//     _data['name'] = name;
//     _data['description'] = description;
//     _data['create_date'] = createDate;
//     _data['update_date'] = updateDate;
//     _data['__v'] = V;
//     _data['unitUnderIc'] = unitUnderIc;
//     return _data;
//   }
// }
//////////////////////////////////////////////////////2//////////////////////////2//////////////////////////////////////
// class IcViewUnitsModel {
//   IcViewUnitsModel({
//     this.status,
//     this.msg,
//     this.user,
//   });

//   IcViewUnitsModel.fromJson(dynamic json) {
//     status = json['status'];
//     msg = json['msg'];
//     if (json['user'] != null) {
//       user = [];
//       json['user'].forEach((v) {
//         user?.add(User.fromJson(v));
//       });
//     }
//   }
//   bool? status;
//   String? msg;
//   List<User>? user;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['msg'] = msg;
//     if (user != null) {
//       map['user'] = user?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

// class User {
//   User({
//     this.location,
//     this.status,
//     this.unitincharge,
//     this.id,
//     this.type,
//     this.name,
//     this.description,
//     this.unitUnderIc,
//     this.createDate,
//     this.updateDate,
//     this.v,
//     this.assets,
//   });

//   User.fromJson(dynamic json) {
//     if (json['location'] != null) {
//       location = [];
//       json['location'].forEach((v) {
//         location?.add((v));
//       });
//     }
//     status = json['status'];
//     unitincharge =
//         json['unitincharge'] != null ? json['unitincharge'].cast<String>() : [];
//     id = json['_id'];
//     type = json['type'];
//     name = json['name'];
//     description = json['description'];
//     unitUnderIc = json['unitUnderIc'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     v = json['__v'];
//     if (json['assets'] != null) {
//       assets = [];
//       json['assets'].forEach((v) {
//         assets?.add(Assets.fromJson(v));
//       });
//     }
//   }
//   List<dynamic>? location;
//   String? status;
//   List<String>? unitincharge;
//   String? id;
//   String? type;
//   String? name;
//   String? description;
//   String? unitUnderIc;
//   String? createDate;
//   String? updateDate;
//   int? v;
//   List<Assets>? assets;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (location != null) {
//       map['location'] = location?.map((v) => v.toJson()).toList();
//     }
//     map['status'] = status;
//     map['unitincharge'] = unitincharge;
//     map['_id'] = id;
//     map['type'] = type;
//     map['name'] = name;
//     map['description'] = description;
//     map['unitUnderIc'] = unitUnderIc;
//     map['create_date'] = createDate;
//     map['update_date'] = updateDate;
//     map['__v'] = v;
//     if (assets != null) {
//       map['assets'] = assets?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

// class Assets {
//   Assets({
//     this.quantity,
//     this.price,
//     this.salePrice,
//     this.purchaseId,
//     this.discount,
//     this.status,
//     this.purchaseAmount,
//     this.id,
//     this.assetId,
//     this.unitId,
//     this.createDate,
//     this.updateDate,
//     this.v,
//   });

//   Assets.fromJson(dynamic json) {
//     quantity = json['quantity'];
//     price = json['price'];
//     salePrice = json['salePrice'];
//     if (json['purchaseId'] != null) {
//       purchaseId = [];
//       json['purchaseId'].forEach((v) {
//         purchaseId?.add((v));
//       });
//     }
//     discount = json['discount'];
//     status = json['status'];
//     purchaseAmount = json['purchaseAmount'];
//     id = json['_id'];
//     assetId =
//         json['assetId'] != null ? AssetId.fromJson(json['assetId']) : null;
//     unitId = json['unitId'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     v = json['__v'];
//   }
//   int? quantity;
//   int? price;
//   int? salePrice;
//   List<dynamic>? purchaseId;
//   int? discount;
//   String? status;
//   int? purchaseAmount;
//   String? id;
//   AssetId? assetId;
//   String? unitId;
//   String? createDate;
//   String? updateDate;
//   int? v;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['quantity'] = quantity;
//     map['price'] = price;
//     map['salePrice'] = salePrice;
//     if (purchaseId != null) {
//       map['purchaseId'] = purchaseId?.map((v) => v.toJson()).toList();
//     }
//     map['discount'] = discount;
//     map['status'] = status;
//     map['purchaseAmount'] = purchaseAmount;
//     map['_id'] = id;
//     if (assetId != null) {
//       map['assetId'] = assetId?.toJson();
//     }
//     map['unitId'] = unitId;
//     map['create_date'] = createDate;
//     map['update_date'] = updateDate;
//     map['__v'] = v;
//     return map;
//   }
// }

// class AssetId {
//   AssetId({
//     this.status,
//     this.id,
//     this.name,
//     this.assetype,
//     this.productType,
//     this.createDate,
//     this.updateDate,
//     this.v,
//   });

//   AssetId.fromJson(dynamic json) {
//     status = json['status'];
//     id = json['_id'];
//     name = json['name'];
//     assetype = json['assetype'];
//     productType = json['productType'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     v = json['__v'];
//   }
//   String? status;
//   String? id;
//   String? name;
//   String? assetype;
//   String? productType;
//   String? createDate;
//   String? updateDate;
//   int? v;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['_id'] = id;
//     map['name'] = name;
//     map['assetype'] = assetype;
//     map['productType'] = productType;
//     map['create_date'] = createDate;
//     map['update_date'] = updateDate;
//     map['__v'] = v;
//     return map;
//   }
// }
//////////////////////////////////////////////////////2//////////////////////////2//////////////////////////////////////
///
///
////////
class IcViewUnitsModel {
  IcViewUnitsModel({
    this.status,
    this.msg,
    this.user,
  });

  IcViewUnitsModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    if (json['user'] != null) {
      user = [];
      json['user'].forEach((v) {
        user?.add(User.fromJson(v));
      });
    }
  }
  bool? status;
  String? msg;
  List<User>? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (user != null) {
      map['user'] = user?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class User {
  User({
    this.location,
    this.status,
    this.unitincharge,
    this.id,
    this.type,
    this.name,
    this.description,
    this.unitUnderIc,
    this.createDate,
    this.updateDate,
    this.v,
    this.assets,
  });

  User.fromJson(dynamic json) {
    if (json['location'] != null) {
      location = [];
      json['location'].forEach((v) {
        location?.add((v));
      });
    }
    status = json['status'];
    if (json['unitincharge'] != null) {
      unitincharge = [];
      json['unitincharge'].forEach((v) {
        unitincharge?.add(Unitincharge.fromJson(v));
      });
    }
    id = json['_id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    unitUnderIc = json['unitUnderIc'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    if (json['assets'] != null) {
      assets = [];
      json['assets'].forEach((v) {
        assets?.add(Assets.fromJson(v));
      });
    }
  }
  List<dynamic>? location;
  String? status;
  List<Unitincharge>? unitincharge;
  String? id;
  String? type;
  String? name;
  String? description;
  String? unitUnderIc;
  String? createDate;
  String? updateDate;
  int? v;
  List<Assets>? assets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    if (unitincharge != null) {
      map['unitincharge'] = unitincharge?.map((v) => v.toJson()).toList();
    }
    map['_id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['description'] = description;
    map['unitUnderIc'] = unitUnderIc;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    if (assets != null) {
      map['assets'] = assets?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Assets {
  Assets({
    this.quantity,
    this.price,
    this.salePrice,
    this.purchaseId,
    this.discount,
    this.status,
    this.purchaseAmount,
    this.id,
    this.assetId,
    this.unitId,
    this.createDate,
    this.updateDate,
    this.v,
  });

  Assets.fromJson(dynamic json) {
    quantity = json['quantity'];
    price = json['price'];
    salePrice = json['salePrice'];
    if (json['purchaseId'] != null) {
      purchaseId = [];
      json['purchaseId'].forEach((v) {
        purchaseId?.add((v));
      });
    }
    discount = json['discount'];
    status = json['status'];
    purchaseAmount = json['purchaseAmount'];
    id = json['_id'];
    assetId =
        json['assetId'] != null ? AssetId.fromJson(json['assetId']) : null;
    unitId = json['unitId'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  int? quantity;
  int? price;
  int? salePrice;
  List<dynamic>? purchaseId;
  int? discount;
  String? status;
  int? purchaseAmount;
  String? id;
  AssetId? assetId;
  String? unitId;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quantity'] = quantity;
    map['price'] = price;
    map['salePrice'] = salePrice;
    if (purchaseId != null) {
      map['purchaseId'] = purchaseId?.map((v) => v.toJson()).toList();
    }
    map['discount'] = discount;
    map['status'] = status;
    map['purchaseAmount'] = purchaseAmount;
    map['_id'] = id;
    if (assetId != null) {
      map['assetId'] = assetId?.toJson();
    }
    map['unitId'] = unitId;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

class AssetId {
  AssetId({
    this.status,
    this.id,
    this.name,
    this.assetype,
    this.productType,
    this.createDate,
    this.updateDate,
    this.v,
    this.description,
  });

  AssetId.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    name = json['name'];
    assetype = json['assetype'];
    productType = json['productType'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    description = json['description'];
  }
  String? status;
  String? id;
  String? name;
  String? assetype;
  String? productType;
  String? createDate;
  String? updateDate;
  int? v;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    map['name'] = name;
    map['assetype'] = assetype;
    map['productType'] = productType;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    map['description'] = description;
    return map;
  }
}

class Unitincharge {
  Unitincharge({
    this.status,
    this.id,
    this.phoneNumber,
    this.role,
    this.present2,
    this.password,
    this.userName,
    this.dob,
    this.gender,
    this.assiginedUnitId,
    this.assignedTo,
    this.createDate,
    this.updateDate,
    this.v,
  });

  Unitincharge.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    password = json['password'];
    userName = json['userName'];
    dob = json['dob'];
    gender = json['gender'];
    assiginedUnitId = json['assiginedUnitId'];
    assignedTo = json['assignedTo'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  String? status;
  String? id;
  bool? removeincharge = false;

  int? phoneNumber;
  bool? present2 = true;
  String? role;
  String? password;
  String? userName;
  String? dob;
  String? gender;
  String? assiginedUnitId;
  String? assignedTo;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    map['phoneNumber'] = phoneNumber;
    map['role'] = role;
    map['password'] = password;
    map['userName'] = userName;
    map['dob'] = dob;
    map['gender'] = gender;
    map['assiginedUnitId'] = assiginedUnitId;
    map['assignedTo'] = assignedTo;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}
