import 'package:equatable/equatable.dart';

class StateEntranceCharge extends Equatable {
  @override
  List<Object?> get props =>[];
}

class BlocEntranceChargeInitial extends StateEntranceCharge {}

class EntranceChargeAdded extends StateEntranceCharge {
  final bool? value;
  final int? newEntrance;
  EntranceChargeAdded({this.value, this.newEntrance});
}

class EntranceChargeRemoved extends StateEntranceCharge {
  final bool? value;
  final int? newEntrance;
  EntranceChargeRemoved({this.value, this.newEntrance});
}

class RefreshState extends StateEntranceCharge {}
