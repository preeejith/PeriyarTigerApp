import 'package:flutter/material.dart';

class ViewAllEmployeeModel {
  ViewAllEmployeeModel({
    this.status,
    this.msg,
    this.totalLength,
    this.pageNo,
    this.limit,
    this.data,
  });

  ViewAllEmployeeModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    totalLength = json['totalLength'];
    pageNo = json['pageNo'];
    limit = json['limit'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  String? msg;
  int? totalLength;
  int? pageNo;
  int? limit;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    map['totalLength'] = totalLength;
    map['pageNo'] = pageNo;
    map['limit'] = limit;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.status,
    this.id,
    this.phoneNumber,
    this.role,
    this.change,
    this.present,
    required this.assigndutycontroller,
    this.password,
    this.userName,
    this.dob,
    this.gender,
    this.taskAsseigned,
    this.assignedTo,
    this.createDate,
    this.updateDate,
    this.v,
    this.assiginedUnitId,
  });

  Data.fromJson(dynamic json) {
    status = json['status'];
    id = json['_id'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    password = json['password'];
    userName = json['userName'];
    dob = json['dob'];
    gender = json['gender'];
    taskAsseigned = json['taskAsseigned'] == null ? "" : json['taskAsseigned'];
    assignedTo = json['assignedTo'] == null ? "" : json['assignedTo'];
    createDate = json['create_date'];
    updateDate = json['update_date'];
    v = json['__v'];
    assiginedUnitId = json['assiginedUnitId'];
  }
  String? status;
  String? id;
  int? phoneNumber;
  String? role;
  String? password;
  String? userName;
  String? dob;
  bool? change = false;
  bool? present = true;

  var assigndutycontroller = TextEditingController();
  String? gender;
  String? taskAsseigned;
  String? assignedTo;
  String? createDate;
  String? updateDate;
  int? v;
  String? assiginedUnitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['_id'] = id;
    map['phoneNumber'] = phoneNumber;
    map['role'] = role;
    map['password'] = password;
    map['userName'] = userName;
    map['dob'] = dob;
    map['taskAsseigned'] = taskAsseigned;
    map['gender'] = gender;
    map['assignedTo'] = assignedTo;
    map['create_date'] = createDate;
    map['update_date'] = updateDate;
    map['__v'] = v;
    map['assiginedUnitId'] = assiginedUnitId;
    return map;
  }
}
