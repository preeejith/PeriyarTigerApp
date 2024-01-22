import 'package:json_annotation/json_annotation.dart';

part 'guestinfomodel.g.dart';

@JsonSerializable()
class GuestInfoModel {
  String? name, label, dob, type, id, personUniqueID, phoneNumber, email,guestId,gender,idproofs,charge;
  String? photo,visaproof,passportproof,visaNumber,visaValidTo,passportValidationDate,bookingDate;
  int? count, number, roomNumber;
  bool? isDetailsAdded, isEdStarted;
  

  List? statusList;
  bool? status;
  // List<InnerListIndividual>? innerListIndividual;
  GuestInfoModel({
    this.count,
    this.name,this.gender,
    this.id,this.charge,this.passportValidationDate,this.visaValidTo,this.visaNumber,
    this.personUniqueID,
    this.status,
    this.email,this.bookingDate,
    this.phoneNumber,this.idproofs,
    this.dob,this.guestId,
    this.passportproof,
    this.visaproof,
    this.isEdStarted,
    
    this.roomNumber,
    this.photo,
    this.type,
    this.label,
    this.number,
    // this.innerListIndividual,
    this.isDetailsAdded,
    this.statusList,
  });
  factory GuestInfoModel.fromJson(Map<String, dynamic> data) =>
      _$GuestInfoModelFromJson(data);

  Map<String, dynamic> toJson() => _$GuestInfoModelToJson(this);
}

