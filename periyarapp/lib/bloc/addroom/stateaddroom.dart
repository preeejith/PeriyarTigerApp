import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/ui/app/booking/bookingsummary.dart';

class StateAddRoom extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AddRoomInitial extends StateAddRoom {}

class RoomAdded extends StateAddRoom {
  final OfflineBooking? offlineBooking;
  final List<OfflineRoomModel>? offlineRoomModel;
  final int? currentIndex;
  RoomAdded({this.currentIndex, this.offlineBooking, this.offlineRoomModel});
}

class RoomNotAdded extends StateAddRoom {
  final String? msg;
  RoomNotAdded({this.msg});
}
