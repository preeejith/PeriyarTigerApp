import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';

class EventEntranceCharge extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AlterEntranceCharge extends EventEntranceCharge {
  final bool? value;
  final int? entranceCharge;
  final OfflineBooking? offlineBooking;
  AlterEntranceCharge(
      {required this.entranceCharge,
      required this.offlineBooking,
      required this.value});
}

class RefreshBloc extends EventEntranceCharge {}
