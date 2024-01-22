import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/bookingsummaryall.dart';

class AddPersonState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddPersonBlocInitial extends AddPersonState {}

class PersonAdded extends AddPersonState {
  final int? currentIndex;
  final String? name, dob, type, id, phone, email;
  final BookingSummaryAll? bookingSummaryAll;
  PersonAdded(
      {this.bookingSummaryAll,
      this.currentIndex,
      this.dob,
      this.id,
      this.phone,
      this.email,
      this.name,
      this.type});
}

class AddingPerson extends AddPersonState {}

class UploadingFile extends AddPersonState {}

class FileNotUploaded extends AddPersonState {
  final String? msg;
  FileNotUploaded({this.msg});
}

class FileUploaded extends AddPersonState {}

class PersonNotAdded extends AddPersonState {
  final String? message;
  PersonNotAdded({this.message});
}

class EditingPerson extends AddPersonState {}

class PersonUpdated extends AddPersonState {
  final int? currentIndex;
  final String? name, dob, type, id, phone, email;
  final BookingSummaryAll? bookingSummaryAll;
  PersonUpdated(
      {this.bookingSummaryAll,
      this.currentIndex,
      this.dob,
      this.id,
      this.phone,
      this.email,
      this.name,
      this.type});
}

class PersonNotUpdated extends AddPersonState {
  final String? message;
  PersonNotUpdated({this.message});
}

class AddPersonBlocRefreshed extends AddPersonState {}
