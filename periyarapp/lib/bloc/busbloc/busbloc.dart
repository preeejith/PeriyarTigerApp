import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/data/models/busmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  bool? status = true;
  int totalMembers = 0, remaining = 0;
  int remainingPersons = 0;
  List<BusData> busDataList = [];
  List<BusData> busAllocated = [];
  DatabaseHelper? db = DatabaseHelper.instance;
  BusBloc() : super(BusState()) {
    on<SwitchEvent>(((event, emit) {
      status = event.status;
      emit(EventSwitched());
    }));
    on<EnableBus>(_enableBus);
    on<DisableBus>(_disableBus);
    on<GetRecentTrips>(_getRecentTrips);
    on<UpdateTrip>(_updateTrip);
    on<GetBusData>(_getBusData);
    on<BusChoosen>(_busChoosen);
    on<ClearChoosenData>((event, emit) {
      busAllocated.clear();
      emit(BusChoosed(busAllocated: busAllocated));
    });
    on<AddBSPerson>(_addBSPerson);
    on<RemoveBSPerson>(_removeBSPerson);
    // on<BookingSlotBlocInitial>(_bookingSlotBlocInitial);
  }

  FutureOr<void> _getBusData(GetBusData event, Emitter<BusState> emit) async {
    try {
      busDataList = await db!.queryAllBusRows();
      print(busDataList);
      if (busDataList.length != 0) {
        if (event.isFilter!) {
          busDataList = busDataList
              .where((element) =>
                  element.busDetails!.status != 'inactive' &&
                  element.busDetails!.noOfSeatsDummy != 0)
              .toList();
        }
        //
        busDataList.length != 0 ? status = true : status = false;
        emit(BusDataFetched(busDataList: busDataList, status: status));
      } else {
        emit(BusDataNotFound());
      }
    } catch (e) {
      print(e);
      emit(BusDataNotFound());
    }
  }

  FutureOr<void> _enableBus(EnableBus event, Emitter<BusState> emit) async {
    try {
      var busData;
      busData = await db!.updateBusData(event.index, 'active');
      //  await db!.updateBusAllocation(event.busId, 'true');
      // var result = await db!.queryAllocation();
      //  print('the result -- $result');
      if (busData == 1) {
        busDataList[event.index!].busDetails!.status = 'active';
      }
      // busDataList.sort(
      //     (a, b) => a.busDetails!.status!.compareTo(b.busDetails!.status!));
      emit(BusDataFetched(busDataList: busDataList, status: status));
    } catch (e) {
      print(e);
      // emit(BusDataNotFound());
    }
  }

  FutureOr<void> _disableBus(DisableBus event, Emitter<BusState> emit) async {
    try {
      var busData;
      busData = await db!.updateBusData(event.index, 'inactive');

      //await db!.updateBusAllocation(event.busId, 'false');
      // print(busAllocation);
      //   var result = await db!.queryAllocation();
      // print('the result -- $result');
      if (busData == 1) {
        busDataList[event.index!].busDetails!.status = 'inactive';
      }
      // busDataList.sort(
      //     (a, b) => a.busDetails!.status!.compareTo(b.busDetails!.status!));
      emit(BusDataFetched(busDataList: busDataList, status: status));
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> _busChoosen(BusChoosen event, Emitter<BusState> emit) {
    try {
      busAllocated.add(
        BusData(
          busDetails: BusDetails(
            tickets: [],
            tripId: event.choosenData!.busDetails!.tripId,
            tripCount: event.choosenData!.busDetails!.tripCount,
            busName: event.choosenData!.busDetails!.busName,
            busId: event.choosenData!.busDetails!.busId,
            isActive: true,
            noOfSeats: event.choosenData!.busDetails!.noOfSeats,
            noOfSeatsDummy: event.choosenData!.busDetails!.noOfSeats,
          ),
        ),
      );
      emit(BusChoosed(busAllocated: busAllocated));
    } catch (e) {}
  }

  FutureOr<void> _addBSPerson(AddBSPerson event, Emitter<BusState> emit) async {
    busAllocated[event.index!].busDetails!.noOfPassengers =
        busAllocated[event.index!].busDetails!.noOfPassengers! + 1;
    busDataList[event.index!].busDetails!.noOfSeatsDummy =
        busDataList[event.index!].busDetails!.noOfSeatsDummy! - 1;
    await db!.updateSeatCount(
      busDataList[event.index!].busDetails!.noOfSeatsDummy,
      busAllocated[event.index!].busDetails!.busId,
    );
     remainingPersons = remainingPersons + 1;
    emit(BSPersonAdded(seats: remaining));
  }

  FutureOr<void> _removeBSPerson(
      RemoveBSPerson event, Emitter<BusState> emit) async {
    busAllocated[event.index!].busDetails!.noOfPassengers =
        busAllocated[event.index!].busDetails!.noOfPassengers! - 1;
    busDataList[event.index!].busDetails!.noOfSeatsDummy =
        busDataList[event.index!].busDetails!.noOfSeatsDummy! + 1;
    await db!.updateSeatCount(
      busDataList[event.index!].busDetails!.noOfSeatsDummy,
      busAllocated[event.index!].busDetails!.busId,
    );
    remainingPersons = remainingPersons - 1;
    // busAllocated[event.index!].busDetails!.remaining =
    //     busAllocated[event.index!].busDetails!.noOfPassengers! + 1;
    emit(BSPersonRemoved(seats: remaining));
  }

  Future<FutureOr<void>> _updateTrip(
      UpdateTrip event, Emitter<BusState> emit) async {
    int tripCount =
        int.parse(busDataList[event.index!].busDetails!.tripCount.toString()) +
            1;
    print("Tripcount $tripCount");
    // try {
    var updateCount = await db!.updateTrip(
      busDataList[event.index!].busDetails!.noOfSeats,
      busDataList[event.index!].busDetails!.busId,
      tripCount.toString(),
    );
    if (updateCount == 1) {
      busDataList[event.index!].busDetails!.noOfSeatsDummy =
          busDataList[event.index!].busDetails!.noOfSeats;
      busDataList[event.index!].busDetails!.tripCount = tripCount;
    }
    emit(BusDataFetched(busDataList: busDataList, status: status));
    // } catch (e) {
    //   print(e);
    // }
  }

  FutureOr<void> _getRecentTrips(
      GetRecentTrips event, Emitter<BusState> emit) async {
    emit(GettingRecentTrips());
    try {
      List list = await db!.getBusFinalData();
      if (list.isNotEmpty) {
        emit(RecentTripsFetched(list: list));
      } else {
        emit(RecentTripsEmpty());
      }
    } catch (e) {
      emit(RecentTripsNotFetched());
    }
  }
}

class BusEvent {}

class GetBusData extends BusEvent {
  final bool? isFilter;
  GetBusData({required this.isFilter});
}

class EnableBus extends BusEvent {
  final int? index;
  final String? busId;
  EnableBus({required this.index, required this.busId});
}

class DisableBus extends BusEvent {
  final int? index;
  final String? busId;
  DisableBus({required this.index, required this.busId});
}

class UpdateTrip extends BusEvent {
  final int? index;
  final String? busId;
  UpdateTrip({required this.index, required this.busId});
}

class GettingBusData extends BusState {}

class BusDataFetched extends BusState {
  final List<BusData> busDataList;
  final bool? status;
  BusDataFetched({required this.busDataList, required this.status});
}

class BusDataNotFound extends BusState {}

class SwitchEvent extends BusEvent {
  final bool? status;
  SwitchEvent({required this.status});
}

class BusState {}

class EventSwitched extends BusState {}

class BusChoosen extends BusEvent {
  BusData? choosenData;
  BusChoosen({required this.choosenData});
}

class BusChoosed extends BusState {
  final List<BusData> busAllocated;
  BusChoosed({required this.busAllocated});
}

class ClearChoosenData extends BusEvent {}

class AddBSPerson extends BusEvent {
  final int? index;
  AddBSPerson({required this.index});
}

class RemoveBSPerson extends BusEvent {
  final int? index;
  RemoveBSPerson({required this.index});
}

class BSPersonRemoved extends BusState {
  final int? seats;
  BSPersonRemoved({this.seats});
}

class BSPersonAdded extends BusState {
  final int? seats;
  BSPersonAdded({this.seats});
}

class GetRecentTrips extends BusEvent {}

class GettingRecentTrips extends BusState {}

class RecentTripsFetched extends BusState {
  final List? list;
  RecentTripsFetched({required this.list});
}

class RecentTripsEmpty extends BusState {}

class RecentTripsNotFetched extends BusState {}

//