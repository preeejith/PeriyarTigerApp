
import 'userdata.dart';

class ServerResponseModel {
  bool? status;
  bool? alreadyExists;
  Userdata? userdata;
  String? role;
  String? profileStatus;
  int? level;
  String? msg;
  String? token;

  ServerResponseModel({
    this.status,
    this.alreadyExists,
    this.userdata,
    this.role,
    this.profileStatus,
    this.level,
    this.msg,
    this.token,
  });

  factory ServerResponseModel.fromJson(Map<String, dynamic> json) =>
      ServerResponseModel(
        status: json['status'] as bool?,
        alreadyExists: json['alreadyExists'] as bool?,
        userdata: json['userdata'] == null
            ? null
            : Userdata.fromJson(json['userdata'] as Map<String, dynamic>),
        role: json['role'] as String?,
        profileStatus: json['profileStatus'] as String?,
        level: json['level'] as int?,
        msg: json['msg'] as String?,
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'alreadyExists': alreadyExists,
        'userdata': userdata?.toJson(),
        'role': role,
        'profileStatus': profileStatus,
        'level': level,
        'msg': msg,
        'token': token,
      };
}
