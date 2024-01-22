class Guest {
  String? status;
  String? id;
  String? uid;
  String? name;
  String? email;
  int? v;

  Guest({this.status, this.id, this.uid, this.name, this.email, this.v});

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
        status: json['status'] as String?,
        id: json['_id'] as String?,
        uid: json['uid'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        '_id': id,
        'uid': uid,
        'name': name,
        'email': email,
        '__v': v,
      };
}
