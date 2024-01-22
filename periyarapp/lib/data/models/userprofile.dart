class UserProfileModel {
  bool? status;
  String? msg, profileStatus;
  int? cartcount, level;
  List<UserData>? userdata;
  UserProfileModel({
    this.cartcount,
    this.level,
    this.msg,
    this.profileStatus,
    this.status,
    this.userdata,
  });
  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    profileStatus = json['profileStatus'];
    cartcount = json['cartcount'];
    level = json['level'];
    if (json['userdata'] != null) {
      userdata = <UserData>[];
      json['userdata'].forEach((v) {
        userdata!.add(new UserData.fromJson(v));
      });
    }
  }
}

class UserData {
  List<UserInProfile>? user;
  UserData({this.user});

  UserData.fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      user = <UserInProfile>[];
      json['user'].forEach((v) {
        user!.add(new UserInProfile.fromJson(v));
      });
    }
  }
}

class UserInProfile {
  String? role, phone, email;
  UserInProfile({this.email, this.phone, this.role});
  UserInProfile.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    phone = json['phone'];
    email = json['email'];
  }
}
