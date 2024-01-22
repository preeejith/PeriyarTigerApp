class VehicleModified {

  bool? status;
  VehicleModifiedData? data;
  String? msg;
  VehicleModified({this.data, this.msg, this.status});
  VehicleModified.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null
        ? new VehicleModifiedData.fromJson(json['data'])
        : null;
    // if (json['data'] != null) {
    //   data = <VehicleData>[];
    //   json['data'].forEach((v) {
    //     data!.add(new VehicleData.fromJson(v));
    //   });
    // }
  }
}

class VehicleModifiedData {
  String? type;
  String? id;
  String? vehicle;
  VehicleModifiedData({this.id, this.type, this.vehicle});
  VehicleModifiedData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['_id'];
    vehicle = json['vehicle'];
  }
}
