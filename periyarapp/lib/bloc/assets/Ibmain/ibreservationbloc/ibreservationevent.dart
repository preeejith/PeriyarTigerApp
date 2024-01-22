import 'package:equatable/equatable.dart';

class IbReservationDetailedsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IbReservationDetailedEvent extends IbReservationDetailedsEvent {
  final String? programme;
  final String? slotDetail;
  final String? bookingDate;
  final String? numberOfRooms;
  final String? guestName;
  final String? numberOfAccompanyigPersons;
  final String? guestPhone;
  final String? referee;
  final String? refereePhone;
  final String? email;
  final String? foodPreference;
  final String? numberOfVehicles;
  final String? vehicleNumbers;
  final String? details;

  IbReservationDetailedEvent({
    this.programme,
    this.slotDetail,
    this.bookingDate,
    this.numberOfRooms,
    this.guestName,
    this.numberOfAccompanyigPersons,
    this.guestPhone,
    this.referee,
    this.refereePhone,
    this.email,
    this.foodPreference,
    this.numberOfVehicles,
    this.vehicleNumbers,
    this.details,
  });
  @override
  List<Object> get props => [];
}

class EditIbReservationEvent extends IbReservationDetailedsEvent {
  final dynamic data;

  EditIbReservationEvent({
    this.data,
  });
}


class RemoveIbReservationEvent extends IbReservationDetailedsEvent {
  final dynamic data;

  RemoveIbReservationEvent({
    this.data,
  });
}