import 'package:json_annotation/json_annotation.dart';
part 'entrybookingmodel.g.dart';

@JsonSerializable()
class EntryBookingModel {
  int? id;
  String? ticketId;

  String?   bookingData;

  EntryBookingModel({this.ticketId, this.id, this.bookingData});

  factory EntryBookingModel.fromJson(Map<String, dynamic> data) =>
      _$EntryBookingModelFromJson(data);

  Map<String, dynamic> toJson() => _$EntryBookingModelToJson(this);
}

