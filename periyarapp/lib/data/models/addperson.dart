class AddPerson {
  bool? status;
  String? id;
  AddPersonData? data;
  String? msg;
  AddPerson({this.data, this.id, this.msg, this.status});
  AddPerson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    data =
        json['data'] != null ? new AddPersonData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
}

class AddPersonData {
  AddPersonData.fromJson(json);
}
