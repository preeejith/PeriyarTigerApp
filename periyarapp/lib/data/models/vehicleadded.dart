class VehicleAdded {
  bool? status;
  List<VehicleData>? data;
  String? msg;
  VehicleAdded({this.data, this.msg, this.status});
  VehicleAdded.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <VehicleData>[];
      json['data'].forEach((v) {
        data!.add(new VehicleData.fromJson(v));
      });
    }
  }
}

class VehicleData {
  String? type;
  String? id;
  String? vehicle;
  VehicleData({this.id, this.type, this.vehicle});
  VehicleData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['_id'];
    vehicle = json['vehicle'];
  }
}
