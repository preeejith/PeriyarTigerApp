class VehicleModel {
  bool? status;
  VehicleData? data;
  VehicleModel({this.data, this.status});
  VehicleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new VehicleData.fromJson(json['data']) : null;
  }
}

class VehicleData {
  int? lightVehicleCharge,
      heavyVehicleCharge,
      entranceTicketCharge,
      indianEntranceCharge,
      foreignerEntraneCharge,
      childrenEntraneCharge,
      camera,
      moviecamera,
      tax;
  String? id;
  VehicleData({this.heavyVehicleCharge, this.lightVehicleCharge});
  VehicleData.fromJson(Map<String, dynamic> json) {
    lightVehicleCharge = json['lightVehicleCharge'];
    heavyVehicleCharge = json['heavyVehicleCharge'];
    entranceTicketCharge = json['entranceTicketCharge'];
    indianEntranceCharge = json['indianEntranceCharge'];
    foreignerEntraneCharge = json['foreignerEntraneCharge'];
    childrenEntraneCharge = json['childrenEntraneCharge'];
    camera = json['camera'];
    moviecamera = json['moviecamera'];
    tax = json['tax'];
    id = json['_id'];
  }
}
