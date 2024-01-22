import 'guest.dart';
import 'user.dart';

class Userdata {
  User? user;
  Guest? guest;

  Userdata({this.user, this.guest});

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        guest: json['guest'] == null
            ? null
            : Guest.fromJson(json['guest'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'guest': guest?.toJson(),
      };
}
