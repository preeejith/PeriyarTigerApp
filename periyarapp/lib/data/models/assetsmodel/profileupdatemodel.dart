class ViewProfileUpdateModel {
  ViewProfileUpdateModel({
    required this.status,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String msg;
  late final Data data;
  
  ViewProfileUpdateModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
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
    required this.createDate,
    required this.updateDate,
    required this.V,
    required this.assiginedUnitId,
  });
  late final String status;
  late final String id;
  late final int phoneNumber;
  late final String role;
  late final String password;
  late final String userName;
  late final String dob;
  late final String gender;
  late final String createDate;
  late final String updateDate;
  late final int V;
  late final String assiginedUnitId;
  
  Data.fromJson(Map<String, dynamic> json){
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
    V = json['__v'];
    assiginedUnitId = json['assiginedUnitId'];
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
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    _data['assiginedUnitId'] = assiginedUnitId;
    return _data;
  }
}