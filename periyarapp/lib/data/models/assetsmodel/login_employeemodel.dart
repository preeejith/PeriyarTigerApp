class EmployeeloginModel {
  EmployeeloginModel({
    required this.status,
    required this.token,
    required this.data,
    required this.msg,
  });
  late final bool status;
  late final String token;
  late final Data data;
  late final String msg;

  EmployeeloginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'] == null ? "" : json['token'];
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }


    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['token'] = token;
    _data['data'] = data.toJson();
    _data['msg'] = msg;
    return _data;
  }
}

class Data {
  Data({
    required this.status,
    required this.id,
    required this.phoneNumber,
    required this.role,
    required this.userName,
    required this.dob,
    required this.gender,
    required this.createDate,
    required this.updateDate,
    required this.V,
  });
  late final String status;
  late final String id;
  late final int phoneNumber;
  late final String role;
  late final String userName;
  late final String dob;
  late final String gender;
  late final String createDate;
  late final String updateDate;
  late final int V;

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['_id'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    userName = json['userName'];
    dob = json['dob'];
    gender = json['gender'];
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
    _data['userName'] = userName;
    _data['dob'] = dob;
    _data['gender'] = gender;
    _data['create_date'] = createDate;
    _data['update_date'] = updateDate;
    _data['__v'] = V;
    return _data;
  }
}
