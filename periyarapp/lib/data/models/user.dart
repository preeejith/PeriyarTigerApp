class User {
  String? role;
  int? usertype;
  bool? phoneVerified;
  bool? emailVerified;
  String? status;
  int? level;
  String? accessPath;
  String? remarks;
  String? reset;
  String? deliveryaddressindex;
  String? id;
  String? phone;
  String? email;
  List<dynamic>? deliveryaddress;
  String? password;
  String? createDate;
  String? updateDate;
  int? v;

  User({
    this.role,
    this.usertype,
    this.phoneVerified,
    this.emailVerified,
    this.status,
    this.level,
    this.accessPath,
    this.remarks,
    this.reset,
    this.deliveryaddressindex,
    this.id,
    this.phone,
    this.email,
    this.deliveryaddress,
    this.password,
    this.createDate,
    this.updateDate,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        role: json['role'] as String?,
        usertype: json['usertype'] as int?,
        phoneVerified: json['phoneVerified'] as bool?,
        emailVerified: json['emailVerified'] as bool?,
        status: json['status'] as String?,
        level: json['level'] as int?,
        accessPath: json['accessPath'] as String?,
        remarks: json['remarks'] as String?,
        reset: json['reset'] as String?,
        deliveryaddressindex: json['deliveryaddressindex'] as String?,
        id: json['_id'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        deliveryaddress: json['deliveryaddress'] as List<dynamic>?,
        password: json['password'] as String?,
        createDate: json['create_date'] as String?,
        updateDate: json['update_date'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'role': role,
        'usertype': usertype,
        'phoneVerified': phoneVerified,
        'emailVerified': emailVerified,
        'status': status,
        'level': level,
        'accessPath': accessPath,
        'remarks': remarks,
        'reset': reset,
        'deliveryaddressindex': deliveryaddressindex,
        '_id': id,
        'phone': phone,
        'email': email,
        'deliveryaddress': deliveryaddress,
        'password': password,
        'create_date': createDate,
        'update_date': updateDate,
        '__v': v,
      };
}
