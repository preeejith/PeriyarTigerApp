import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class Pendin2OfflineBloc extends Bloc<Event2Pending, State2Pending> {
  Pendin2OfflineBloc() : super(State2Pending()) {
    on<GetOffline2Data>(_getOffline2Data);
  }
/////
  Future<FutureOr<void>> _getOffline2Data(
      GetOffline2Data event, Emitter<State2Pending> emit) async {
    emit(GettingOfflineData());
    List items = await getAllIbProgramdata();
    List items2 = await getAllIbProgramslotdata();
    List items3 = await getAllIbHolidaysdata();
    List items5 = await getAllIbgetReservationlist();
  
    emit(OfflineDataReceived2(
      items: items,
      items2: items2,
      items3: items3,
      items5: items5,
    ));
  }
}

class Event2Pending {}

class GetOffline2Data extends Event2Pending {}

class State2Pending {}

class GettingOfflineData extends State2Pending {}

class OfflineDataReceived2 extends State2Pending {
  final List? items;
  final List? items2;
  final List? items3;
  final List? items5;
  OfflineDataReceived2({this.items, this.items2, this.items3, this.items5});
}
