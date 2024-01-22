import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class DeleteIbProgramBloc extends Bloc<EventdeleteIbPrgm, StatedeleteIbPrgm> {
  DeleteIbProgramBloc() : super(StatedeleteIbPrgm()) {
    on<GetdeleteIbPrgm>(_getdeleteIbPrgm);
  }

  Future<FutureOr<void>> _getdeleteIbPrgm(
      GetdeleteIbPrgm event, Emitter<StatedeleteIbPrgm> emit) async {
    emit(GettingDeletingPrmData());
    List items = await getAllIbProgramdata();
    List items2 = await getAllIbProgramslotdata();

    emit(DeletingPrgm(
      items: items,
      items2: items2,
    ));
//inuse

////////////ib Urget/////satrrt////////
    if (items.isNotEmpty) {
      for (int i = 0; i < items.length; i++) {
        deletealldata(int.parse(items[i]['id'].toString()));
      }
    }

    if (items2.isNotEmpty) {
      for (int k = 0; k < items2.length; k++) {
        deletealldataslot(int.parse(items2[k]['id'].toString()));
      }
    }
    // inuseend

    // if (items5.isNotEmpty) {
    //   for (int r = 0; r < items5.length; r++) {
    //     deletegetreservationdata(int.parse(items5[r]['id'].toString()));
    //   }
    // }

    // if (items7.isNotEmpty) {
    //   for (int t = 0; t < items7.length; t++) {
    //     deleteonlinereservationalllistdata(
    //         int.parse(items7[t]['id'].toString()));
    //   }
    // }

//
  }
}

class EventdeleteIbPrgm {}

class GetdeleteIbPrgm extends EventdeleteIbPrgm {}

class StatedeleteIbPrgm {}

class GettingDeletingPrmData extends StatedeleteIbPrgm {}

class DeletingPrgm extends StatedeleteIbPrgm {
  final List? items;
  final List? items2;

  DeletingPrgm({
    this.items,
    this.items2,
  });
}
