// class AddProductMainModel {
//   AddProductMainModel({
//       this.status,
//       this.msg,});

//   AddProductMainModel.fromJson(dynamic json) {
//     status = json['status'];
//     msg = json['msg'];
//   }
//   bool? status;
//   String? msg;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['msg'] = msg;
//     return map;
//   }

// }

class AddProductMainModel {
  AddProductMainModel({
    this.status,
    this.data,
    this.msg,
  });

  AddProductMainModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'];
    msg = json['msg'];
  }
  bool? status;
  String? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['data'] = data;
    map['msg'] = msg;
    return map;
  }
}
