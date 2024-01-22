// class UnitsDetailedViewModel {
//   UnitsDetailedViewModel({
//     required this.status,
//     required this.msg,
//     required this.user,
//   });
//   late final bool status;
//   late final String msg;
//   late final User user;

//   UnitsDetailedViewModel.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     msg = json['msg'];
//     user = User.fromJson(json['user']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['msg'] = msg;
//     _data['user'] = user.toJson();
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

//   User.fromJson(Map<String, dynamic> json){
//     location = List.castFrom<dynamic, dynamic>(json['location']);
//     status = json['status'];
//     unitincharge = List.castFrom<dynamic, dynamic>(json['unitincharge']);
//     id = json['_id'];
//     type = json['type'];
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

class UnitsDetailedViewModel {
  UnitsDetailedViewModel({
    this.status,
    this.msg,
    this.user,
  });

  UnitsDetailedViewModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? status;
  String? msg;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (user != null) {
      map['user'] = user?.toJson();
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
    this.createDate,
    this.updateDate,
    this.v,
    this.unitUnderIc,
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
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    unitUnderIc = json['unitUnderIc'];
  }
  List<dynamic>? location;
  String? status;
  List<Unitincharge>? unitincharge;
  String? id;
  String? type;
  String? name;
  String? description;
  String? createDate;
  String? updateDate;
  int? v;
  String? unitUnderIc;

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
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    map['unitUnderIc'] = unitUnderIc;
    return map;
  }
}

class Unitincharge {
  Unitincharge({
    this.status,
    this.id,
    this.phoneNumber,
    this.role,
    this.password,
    this.userName,
    this.dob,
    this.gender,
    this.createDate,
    this.updateDate,
    this.v,
    this.assiginedUnitId,
    this.assignedTo,
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
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    assiginedUnitId = json['assiginedUnitId'];
    assignedTo = json['assignedTo'];
  }
  String? status;
  String? id;
  int? phoneNumber;
  String? role;
  String? password;
  String? userName;
  String? dob;
  String? gender;
  String? createDate;
  String? updateDate;
  int? v;
  String? assiginedUnitId;
  String? assignedTo;

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
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    map['assiginedUnitId'] = assiginedUnitId;
    map['assignedTo'] = assignedTo;
    return map;
  }
}
