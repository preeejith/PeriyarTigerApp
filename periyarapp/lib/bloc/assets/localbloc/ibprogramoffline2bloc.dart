import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class Pendin3OfflineBloc extends Bloc<Event3Pending, State3Pending> {
  Pendin3OfflineBloc() : super(State3Pending()) {
    on<GetOffline3Data>(_getOffline3Data);
  }
/////
  Future<FutureOr<void>> _getOffline3Data(
      GetOffline3Data event, Emitter<State3Pending> emit) async {
    emit(GettingOfflineData());
    List items = await getAllIbProgramdata();
    List items2 = await getAllIbProgramslotdata();
    List items3 = await getAllIbHolidaysdata();
    List items5 = await getAllIbgetReservationlist();
    emit(OfflineDataReceived3(
      items: items,
      items2: items2,
      items3: items3,
      items5: items5,
    ));
  }
}

class Event3Pending {}

class GetOffline3Data extends Event3Pending {}

class State3Pending {}

class GettingOfflineData extends State3Pending {}

class OfflineDataReceived3 extends State3Pending {
  final List? items;
  final List? items2;
  final List? items3;
  final List? items5;
  OfflineDataReceived3({this.items, this.items2, this.items3, this.items5});
}
