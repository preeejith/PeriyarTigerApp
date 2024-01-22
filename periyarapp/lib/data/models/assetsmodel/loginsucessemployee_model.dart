// class EmployeeLoginSuccessModel {
//   EmployeeLoginSuccessModel({
//     required this.status,
//     required this.msg,
//     required this.data,
//   });
//   late final bool status;
//   late final String msg;
//   late final Data data;

//   EmployeeLoginSuccessModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     msg = json['msg'];
//     data = Data.fromJson(json['data']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['msg'] = msg;
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }

// class Data {
//   Data({
//     required this.status,
//     required this.id,
//     required this.phoneNumber,
//     required this.role,
//     required this.password,
//     required this.userName,
//     required this.dob,
//     required this.gender,
//     required this.createDate,
//     required this.updateDate,
//     required this.V,
//   });
//   late final String status;
//   late final String id;
//   late final int phoneNumber;
//   late final String role;
//   late final String password;
//   late final String userName;
//   late final String dob;
//   late final String gender;
//   late final String createDate;
//   late final String updateDate;
//   late final int V;

//   Data.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     id = json['_id'];
//     phoneNumber = json['phoneNumber'];
//     role = json['role'];
//     password = json['password'];
//     userName = json['userName'];
//     dob = json['dob'];
//     gender = json['gender'];
//     createDate = json['create_date'];
//     updateDate = json['update_date'];
//     V = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['_id'] = id;
//     _data['phoneNumber'] = phoneNumber;
//     _data['role'] = role;
//     _data['password'] = password;
//     _data['userName'] = userName;
//     _data['dob'] = dob;
//     _data['gender'] = gender;
//     _data['create_date'] = createDate;
//     _data['update_date'] = updateDate;
//     _data['__v'] = V;
//     return _data;
//   }
// }

class EmployeeLoginSuccessModel {
  EmployeeLoginSuccessModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String msg;
  late final Data data;

  EmployeeLoginSuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.status,
    required this.id,
    required this.phoneNumber,
    required this.role,
    required this.password,
    required this.userName,
    required this.dob,
    required this.gender,
    required this.assiginedUnitId,
    required this.assignedTo,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final String status;
  late final String id;
  late final int phoneNumber;
  late final String role;
  late final String password;
  late final String userName;
  late final String dob;
  late final String gender;
  late final AssiginedUnitId assiginedUnitId;
  late final String assignedTo;
  late final String createDate;
  late final String updateDate;
  late final int V;

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['_id'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    password = json['password'];
    userName = json['userName'];
    dob = json['dob'];
    gender = json['gender'];
    assiginedUnitId = AssiginedUnitId.fromJson(json['assiginedUnitId']);

    assignedTo = json['assignedTo'] == null ? "" : json['assignedTo'];
    // assignedTo = json['assignedTo'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['_id'] = id;
    _data['phoneNumber'] = phoneNumber;
    _data['role'] = role;
    _data['password'] = password;
    _data['userName'] = userName;
    _data['dob'] = dob;
    _data['gender'] = gender;
    _data['assiginedUnitId'] = assiginedUnitId.toJson();
    _data['assignedTo'] = assignedTo;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}

class AssiginedUnitId {
  AssiginedUnitId({
    required this.location,
    required this.status,
    required this.unitincharge,
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final List<dynamic> location;
  late final String status;
  late final List<dynamic> unitincharge;
  late final String id;
  late final String type;
  late final String name;
  late final String description;
  late final String createDate;
  late final String updateDate;
  late final int V;

  AssiginedUnitId.fromJson(Map<String, dynamic> json) {
    location = List.castFrom<dynamic, dynamic>(json['location']);
    status = json['status'];
    unitincharge = List.castFrom<dynamic, String>(json['unitincharge']) == []
        ? [""]
        : List.castFrom<dynamic, String>(json['unitincharge']);
    id = json['_id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['location'] = location;
    _data['status'] = status;
    _data['unitincharge'] = unitincharge;
    _data['_id'] = id;
    _data['type'] = type;
    _data['name'] = name;
    _data['description'] = description;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}
