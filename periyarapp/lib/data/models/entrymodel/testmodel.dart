import 'package:json_annotation/json_annotation.dart';

part 'testmodel.g.dart';

@JsonSerializable()
class TestModel {
  int? number;
  String? type,bookingDate;
  int? amount;
  String? id;

  TestModel({this.type, this.amount, this.id, this.number,this.bookingDate});
  
  factory TestModel.fromJson(Map<String, dynamic> data) =>
      _$TestModelFromJson(data);

  Map<String, dynamic> toJson() => _$TestModelToJson(this);
}
