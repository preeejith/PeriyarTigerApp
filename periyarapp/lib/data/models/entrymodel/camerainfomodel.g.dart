// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camerainfomodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CameraInfoModel _$CameraInfoModelFromJson(Map<String, dynamic> json) =>
    CameraInfoModel(
      type: json['type'] as String?,
      amount: json['amount'] as int?,
      id: json['id'] as String?,
      number: json['number'] as int?,
      bookingDate: json['bookingDate'] as String?,
    );

Map<String, dynamic> _$CameraInfoModelToJson(CameraInfoModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'type': instance.type,
      'bookingDate': instance.bookingDate,
      'amount': instance.amount,
      'id': instance.id,
    };
