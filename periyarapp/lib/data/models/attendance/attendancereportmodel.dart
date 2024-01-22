class AttendanceReportModel {
  AttendanceReportModel({
    this.status,
    this.data,
    this.msg,
  });

  AttendanceReportModel.fromJson(dynamic json) {
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
    this.id,
    this.attandance,
    this.count,
  });

  Data.fromJson(dynamic json) {
    id = json['_id'];
    if (json['attandance'] != null) {
      attandance = [];
      json['attandance'].forEach((v) {
        attandance?.add(Attandance.fromJson(v));
      });
    }
    count = json['count'];
  }
  String? id;
  List<Attandance>? attandance;
  int? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (attandance != null) {
      map['attandance'] = attandance?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }
}

class Attandance {
  Attandance({
    this.id,
    this.isPresent,
    this.leaveType,
    this.isSpecialDay,
    this.status,
    this.empId,
    this.attandanceDate,
    this.description,
    this.createDate,
    this.updateDate,
    this.v,
  });

  Attandance.fromJson(dynamic json) {
    id = json['_id'];
    isPresent = json['isPresent'];
    leaveType = json['leaveType'] == null ? "" : json['leaveType'];
    isSpecialDay = json['isSpecialDay'];
    status = json['status'];
    empId = json['empId'] != null ? EmpId.fromJson(json['empId']) : null;
    attandanceDate =
        json['attandanceDate'] == null ? "" : json['attandanceDate'];
    description = json['description'] == null ? "" : json['description'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
  }
  String? id;
  bool? isPresent;
  String? leaveType;
  bool? isSpecialDay;
  String? status;
  EmpId? empId;
  String? attandanceDate;
  String? description;
  String? createDate;
  String? updateDate;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['isPresent'] = isPresent;
    map['leaveType'] = leaveType;
    map['isSpecialDay'] = isSpecialDay;
    map['status'] = status;
    if (empId != null) {
      map['empId'] = empId?.toJson();
    }
    map['attandanceDate'] = attandanceDate;
    map['description'] = description;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    return map;
  }
}

class EmpId {
  EmpId({
    this.id,
    this.status,
    this.phoneNumber,
    this.role,
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

  EmpId.fromJson(dynamic json) {
    id = json['_id'];
    status = json['status'];
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
  String? id;
  String? status;
  int? phoneNumber;
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
    map['_id'] = id;
    map['status'] = status;
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
