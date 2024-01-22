import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class IBProgramdeleteBloc
    extends Bloc<EventIbProgramdelete, StateIbProgramdelete> {
  IBProgramdeleteBloc() : super(StateIbProgramdelete()) {
    on<GetIbdeleteData>(_getIbdeleteData);
  }
/////
  Future<FutureOr<void>> _getIbdeleteData(
      GetIbdeleteData event, Emitter<StateIbProgramdelete> emit) async {
    emit(GettingOfflineData());
    List items = await getAllIbProgramdata();
    List items2 = await getAllIbProgramslotdata();
    List items3 = await getAllIbHolidaysdata();
    List items5 = await getAllIbgetReservationlist();
    List items6 = await getAllEmployeeListdata();
    List items7 = await getReservationListOnlinedata();
    List items9 = await getAllMarkedAttendancedata();
    List items10 = await getAllDatedata();
    List items11 = await getAllDatedata2();
    List items12 = await getAllAttendanceDetailsdata();
    List items13 = await getAllHaltDetailsdata();

    List items14 = await getAllDatedata3();
    List items15 = await getAllDatedata4();

    List items16 = await getAllHaltReport();

    List items33 = await getAlltransfercountdata();
    List items35 = await getAlltransferlogdata();
    List items39 = await getAllremoveassignedemployeedata();
    //
    List items41 = await getAllstockquantitycountdata();
    emit(ProgramdataReceived(
      items: items,
      items2: items2,
      items3: items3,
      items5: items5,
      items6: items6,
      items7: items7,
      items9: items9,
      items10: items10,
      items11: items11,
      items12: items12,
      items13: items13,
      items14: items14,
      items15: items15,
      items16: items16,
      items33: items33,
      items35: items35,
      items39: items39,
      items41: items41,
    ));
//inuse

////////////ib Urget/////satrrt////////
    // if (items.isNotEmpty) {
    //   for (int i = 0; i < items.length; i++) {
    //     deletealldata(int.parse(items[i]['id'].toString()));
    //   }
    // }
/////////frm
    // if (items2.isNotEmpty) {
    //   for (int k = 0; k < items2.length; k++) {
    //     deletealldataslot(int.parse(items2[k]['id'].toString()));
    //   }
    // }
    // inuseend

    if (items5.isNotEmpty) {
      for (int r = 0; r < items5.length; r++) {
        deletegetreservationdata(int.parse(items5[r]['id'].toString()));
      }
    }

    if (items7.isNotEmpty) {
      for (int t = 0; t < items7.length; t++) {
        deleteonlinereservationalllistdata(
            int.parse(items7[t]['id'].toString()));
      }
    }

////////////ib Urget/////end////////

    // if (items3.isNotEmpty) {
    //   for (int j = 0; j < items3.length; j++) {
    //     deleteallholidays(int.parse(items3[j]['id'].toString()));
    //   }
    // }

    if (items6.isNotEmpty) {
      for (int m = 0; m < items6.length; m++) {
        deleteemployeelist(int.parse(items6[m]['id'].toString()));
      }
    }

    if (items9.isNotEmpty) {
      for (int p = 0; p < items9.length; p++) {
        deletemarkedattendence(int.parse(items9[p]['id'].toString()));
      }
    }

    /////to commentendstart
    // if (items10.isNotEmpty) {
    //   for (int q = 0; q < items10.length; q++) {
    //     deletedatechecktable(int.parse(items10[q]['id'].toString()));
    //   }
    // }

    // if (items11.isNotEmpty) {
    //   for (int r = 0; r < items11.length; r++) {
    //     deletedatechecktable2(int.parse(items11[r]['id'].toString()));
    //   }
    // }

    // if (items14.isNotEmpty) {
    //   for (int u = 0; u < items14.length; u++) {
    //     deletedatechecktable3(int.parse(items14[u]['id'].toString()));
    //   }
    // }

    // if (items15.isNotEmpty) {
    //   for (int v = 0; v < items15.length; v++) {
    //     deletedatechecktable4(int.parse(items15[v]['id'].toString()));
    //   }
    // }

    /////to commentend

    if (items12.isNotEmpty) {
      for (int s = 0; s < items12.length; s++) {
        deleteattendancedetails(int.parse(items12[s]['id'].toString()));
      }
    }

    if (items13.isNotEmpty) {
      for (int t = 0; t < items13.length; t++) {
        deletehaltdetails(int.parse(items13[t]['id'].toString()));
      }
    }

    if (items16.isNotEmpty) {
      for (int w = 0; w < items16.length; w++) {
        deletehaltreportdetails(int.parse(items16[w]['id'].toString()));
      }
    }

    if (items33.isNotEmpty) {
      print("Hello");
      for (int x = 0; x < items33.length; x++) {
        deletequantitycount(int.parse(items33[x]['id'].toString()));
      }
    }

    if (items35.isNotEmpty) {
      for (int z = 0; z < items35.length; z++) {
        deletetranferlog(int.parse(items35[z]['id'].toString()));
      }
    }
/////////frm
    if (items39.isNotEmpty) {
      for (int a = 0; a < items39.length; a++) {
        deleteremoveassignedemployee(int.parse(items39[a]['id'].toString()));
      }
    }

    if (items41.isNotEmpty) {
      for (int b = 0; b < items41.length; b++) {
        deletestockquantitycount(int.parse(items41[b]['id'].toString()));
      }
    }
//
  }
}

class EventIbProgramdelete {}

class GetIbdeleteData extends EventIbProgramdelete {}

class StateIbProgramdelete {}

class GettingOfflineData extends StateIbProgramdelete {}

class ProgramdataReceived extends StateIbProgramdelete {
  final List? items;
  final List? items2;
  final List? items3;
  final List? items5;
  final List? items6;
  final List? items7;
  final List? items9;
  final List? items10;
  final List? items11;
  final List? items12;
  final List? items13;
  final List? items14;
  final List? items15;
  final List? items16;
  final List? items33;
  final List? items35;
  final List? items39;
  final List? items41;

  ProgramdataReceived({
    this.items,
    this.items2,
    this.items3,
    this.items5,
    this.items6,
    this.items7,
    this.items9,
    this.items10,
    this.items11,
    this.items12,
    this.items13,
    this.items14,
    this.items15,
    this.items16,
    this.items33,
    this.items35,
    this.items39,
    this.items41,
  });
}
