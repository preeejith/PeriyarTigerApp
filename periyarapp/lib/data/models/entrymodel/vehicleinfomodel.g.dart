// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicleinfomodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleInfoModel _$VehicleInfoModelFromJson(Map<String, dynamic> json) =>
    VehicleInfoModel(
      type: json['type'] as String?,
      amount: json['amount'] as int?,
      id: json['id'] as String?,
      number: json['number'] as int?,
      vehicleNumber: json['vehicleNumber'] as String?,
      vehiclecharge: json['vehiclecharge'] as String?,
      bookingDate: json['bookingDate'] as String?,
    );

Map<String, dynamic> _$VehicleInfoModelToJson(VehicleInfoModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'type': instance.type,
      'bookingDate': instance.bookingDate,
      'amount': instance.amount,
      'id': instance.id,
      'vehicleNumber': instance.vehicleNumber,
      'vehiclecharge': instance.vehiclecharge,
    };
