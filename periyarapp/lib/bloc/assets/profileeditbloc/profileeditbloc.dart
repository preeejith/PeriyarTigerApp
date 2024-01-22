import 'package:equatable/equatable.dart';

class ProfileUpdateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProfileUpdate extends ProfileUpdateEvent {
  final String? name;
  final String? dob;
  final String? gender;
  final String? phonenumber;

  GetProfileUpdate({this.name, this.dob, this.gender, this.phonenumber});
  @override
  List<Object> get props => [];
}
