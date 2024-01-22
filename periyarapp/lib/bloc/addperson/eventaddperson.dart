import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';

class AddPersonEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SavePersonData extends AddPersonEvent {
  final int? entranceCharge;
  final String? dob,  date, name, guestType, cartId, phoneno, guestId, ticketId;
  final String? file, roomAllocationId;
  final int? currentIndex;
  final bool? isOffline;
  final OfflineBooking? offlineBooking;
  SavePersonData({
    this.entranceCharge,
    this.ticketId,
    this.cartId,
    this.guestId,
    this.date,
    this.dob,
    this.phoneno,
    this.roomAllocationId,
    this.file,
    this.guestType,
    this.currentIndex,
    this.isOffline,
    this.name,
    this.offlineBooking,
  });
}

class EditPersonData extends AddPersonEvent {
  final String dob, name, guestType, personId, phoneno, cartId;
  // final String file;
  final int? currentIndex;
  EditPersonData(
      {required this.personId,
      required this.dob,
      required this.phoneno,
      // required this.email,
      required this.cartId,
      required this.guestType,
      required this.currentIndex,
      required this.name});
}

class StartAddingPerson extends AddPersonEvent {}

class RefreshAddPersonBloc extends AddPersonEvent {}
