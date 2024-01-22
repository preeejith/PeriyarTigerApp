class AddRoom {
  bool? status;
  String? id, msg;
  AddRoomData? data;
  AddRoom({this.status, this.id, this.msg, this.data});
  AddRoom.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    msg = json['msg'];
    data = json['data'] != null ? new AddRoomData.fromJson(json['data']) : null;
  }
}

class AddRoomData {
  AddRoomData.fromJson(json);
}
