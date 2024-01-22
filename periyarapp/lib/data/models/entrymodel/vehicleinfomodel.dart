import 'package:json_annotation/json_annotation.dart';
part 'vehicleinfomodel.g.dart';

@JsonSerializable()
class VehicleInfoModel {
  int? number;

  String? type,bookingDate;
  int? amount;
  String? id;
  String? vehicleNumber,vehiclecharge;
  

  VehicleInfoModel({this.type, this.amount, this.id, this.number,this.vehicleNumber,this.vehiclecharge,this.bookingDate});

  factory VehicleInfoModel.fromJson(Map<String, dynamic> data) =>
      _$VehicleInfoModelFromJson(data);

  Map<String, dynamic> toJson() => _$VehicleInfoModelToJson(this);
}
