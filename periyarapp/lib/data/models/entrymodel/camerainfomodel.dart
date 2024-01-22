import 'package:json_annotation/json_annotation.dart';

part 'camerainfomodel.g.dart';

@JsonSerializable()
class CameraInfoModel {
  int? number;
  String? type,bookingDate;
  int? amount;
  String? id;

  CameraInfoModel({this.type, this.amount, this.id, this.number,this.bookingDate});
  factory CameraInfoModel.fromJson(Map<String, dynamic> data) =>
      _$CameraInfoModelFromJson(data);

  Map<String, dynamic> toJson() => _$CameraInfoModelToJson(this);
}
