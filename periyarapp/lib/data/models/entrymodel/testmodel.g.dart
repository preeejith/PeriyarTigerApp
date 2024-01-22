// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestModel _$TestModelFromJson(Map<String, dynamic> json) => TestModel(
      type: json['type'] as String?,
      amount: json['amount'] as int?,
      id: json['id'] as String?,
      number: json['number'] as int?,
      bookingDate: json['bookingDate'] as String?,
    );

Map<String, dynamic> _$TestModelToJson(TestModel instance) => <String, dynamic>{
      'number': instance.number,
      'type': instance.type,
      'bookingDate': instance.bookingDate,
      'amount': instance.amount,
      'id': instance.id,
    };
