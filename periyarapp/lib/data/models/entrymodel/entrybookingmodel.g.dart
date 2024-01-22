// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrybookingmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryBookingModel _$EntryBookingModelFromJson(Map<String, dynamic> json) =>
    EntryBookingModel(
      ticketId: json['ticketId'] as String?,
      id: json['id'] as int?,
      bookingData: json['bookingData'] as String?,
    );

Map<String, dynamic> _$EntryBookingModelToJson(EntryBookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticketId': instance.ticketId,
      'bookingData': instance.bookingData,
    };
