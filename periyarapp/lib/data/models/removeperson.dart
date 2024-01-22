class RemovePersonModel {
  bool? status;
  String? msg;
  RemovePersonModel({this.msg, this.status});
  RemovePersonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }
}
