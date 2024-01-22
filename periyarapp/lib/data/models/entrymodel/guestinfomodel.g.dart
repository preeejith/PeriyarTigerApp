// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guestinfomodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestInfoModel _$GuestInfoModelFromJson(Map<String, dynamic> json) =>
    GuestInfoModel(
      count: json['count'] as int?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      id: json['id'] as String?,
      charge: json['charge'] as String?,
      passportValidationDate: json['passportValidationDate'] as String?,
      visaValidTo: json['visaValidTo'] as String?,
      visaNumber: json['visaNumber'] as String?,
      personUniqueID: json['personUniqueID'] as String?,
      status: json['status'] as bool?,
      email: json['email'] as String?,
      bookingDate: json['bookingDate'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      idproofs: json['idproofs'] as String?,
      dob: json['dob'] as String?,
      guestId: json['guestId'] as String?,
      passportproof: json['passportproof'] as String?,
      visaproof: json['visaproof'] as String?,
      isEdStarted: json['isEdStarted'] as bool?,
      roomNumber: json['roomNumber'] as int?,
      photo: json['photo'] as String?,
      type: json['type'] as String?,
      label: json['label'] as String?,
      number: json['number'] as int?,
      isDetailsAdded: json['isDetailsAdded'] as bool?,
      statusList: json['statusList'] as List<dynamic>?,
    );

Map<String, dynamic> _$GuestInfoModelToJson(GuestInfoModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'dob': instance.dob,
      'type': instance.type,
      'id': instance.id,
      'personUniqueID': instance.personUniqueID,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'guestId': instance.guestId,
      'gender': instance.gender,
      'idproofs': instance.idproofs,
      'charge': instance.charge,
      'photo': instance.photo,
      'visaproof': instance.visaproof,
      'passportproof': instance.passportproof,
      'visaNumber': instance.visaNumber,
      'visaValidTo': instance.visaValidTo,
      'passportValidationDate': instance.passportValidationDate,
      'bookingDate': instance.bookingDate,
      'count': instance.count,
      'number': instance.number,
      'roomNumber': instance.roomNumber,
      'isDetailsAdded': instance.isDetailsAdded,
      'isEdStarted': instance.isEdStarted,
      'statusList': instance.statusList,
      'status': instance.status,
    };
