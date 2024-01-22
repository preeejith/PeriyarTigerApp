class GetIbHolidaysModel {
  GetIbHolidaysModel({
    this.status,
    this.data,
    this.msg,
  });

  GetIbHolidaysModel.fromJson(dynamic json) {
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
    this.name,
    this.status,
    this.id,
    this.addedBy,
    this.start,
    this.end,
    this.v,
  });

  Data.fromJson(dynamic json) {
    name = json['name'];
    status = json['status'];
    id = json['_id'];
    addedBy = json['addedBy'];
    start = json['start'];
    end = json['end'];
    v = json['__v'];
  }
  String? name;
  String? status;
  String? id;
  String? addedBy;
  String? start;
  String? end;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['status'] = status;
    map['_id'] = id;
    map['addedBy'] = addedBy;
    map['start'] = start;
    map['end'] = end;
    map['__v'] = v;
    return map;
  }
}
