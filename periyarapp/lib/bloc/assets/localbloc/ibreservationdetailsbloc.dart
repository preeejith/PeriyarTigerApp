import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

//////
class Ibreservation2datauploadBloc
    extends Bloc<EventIbreservation2dataupload, StateIbreservation2dataupload> {
  DateTime dateOne = DateTime.now(), dateTwo = DateTime.now();
  List items7 = [];
  Ibreservation2datauploadBloc() : super(StateIbreservation2dataupload()) {
    on<GetIbreservation2datauploadData>(_getIbreservation2datauploadData);
    on<RefreshIbreservation2datauploadData>(
        _refreshIbreservation2datauploadData);
    on<SortList>(_sortList);
  }
//
  Future<FutureOr<void>> _getIbreservation2datauploadData(
      GetIbreservation2datauploadData event,
      Emitter<StateIbreservation2dataupload> emit) async {
    emit(GettingRecivingData());
    List items = await getAllIbProgramdata();
    List items2 = await getAllIbProgramslotdata();
    List items4 = await getAllReservationdata();
    List items5 = await getAllIbgetReservationlist();
    items7 = await getReservationListOnlinedata();

    //  List items5 = await getAllIbgetReservationlist();
    emit(ReservationdataRecived(
      items: items,
      items2: items2,
      items4: items4,
      items5: items5,
      items7: items7,
    ));
  }

  Future<FutureOr<void>> _refreshIbreservation2datauploadData(
      RefreshIbreservation2datauploadData event,
      Emitter<StateIbreservation2dataupload> emit) async {
    emit(Refreshstate());
  }

  FutureOr<void> _sortList(
      SortList event, Emitter<StateIbreservation2dataupload> emit) {
    DateFormat format = DateFormat('yyy-MM-dd');
    //  List newList = [];
    print(items7);
    DateTime one = DateTime.parse(format.format(dateOne));
    print(items7[0]['bookingdate']);
    //DateTime two = DateTime.parse(format.format(items7[0]['bookingdate']));

    //print(two);
    for (int i = 0; i < items7.length; i++) {
      if (DateTime.parse(
                  format.format(DateTime.parse(items7[i]['bookingdate'])))
              .isAfter(DateTime.parse(format.format(dateOne))) ||
          DateTime.parse(
                  format.format(DateTime.parse(items7[i]['bookingdate'])))
              .isBefore(DateTime.parse(format.format(dateTwo)))) {
        print("${items7[i]['bookingdate']} is before $dateOne");
      }
    }

    emit(ReservationdataRecived());
  }
}

class EventIbreservation2dataupload {}

class SortList extends EventIbreservation2dataupload {}

class GetIbreservation2datauploadData extends EventIbreservation2dataupload {}

class RefreshIbreservation2datauploadData
    extends EventIbreservation2dataupload {}

class StateIbreservation2dataupload {}

class GettingRecivingData extends StateIbreservation2dataupload {}

class Refreshstate extends StateIbreservation2dataupload {}

class ReservationdataRecived extends StateIbreservation2dataupload {
  final List? items4;
  final List? items;
  final List? items2;
  final List? items5;
  final List? items7;
  ReservationdataRecived(
      {this.items4, this.items5, this.items, this.items7, this.items2});
}
////