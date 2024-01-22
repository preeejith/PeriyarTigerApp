///pagination in the previous commit now chnaging to offline

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/iclogmainbloc/iclogmainevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/iclogmainbloc/iclogmainstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/iclogmodel.dart';

import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class GetIcLogmainBloc extends Bloc<IcLogmainEvent, IcLogmainState> {
  GetIcLogmainBloc() : super(IcLogmainState()) {
    on<GetIcLogmain>(_getIcLogmain);
    on<FetchIcLogmain>(_fetchIcLogmain);
    on<RefreshIcLogmain>(_refreshIcLogmain);
  }

  Future<FutureOr<void>> _getIcLogmain(
      GetIcLogmain event, Emitter<IcLogmainState> emit) async {
    IcLogModel icLogModel;

    Map map = {};
//////////
    icLogModel =
        await AuthRepository().iclogmain(url: '/log/assets', data: map);

    if (icLogModel.status == true) {
      print(icLogModel);

      await deletefulltranferlog();

      for (int i = 0; i < icLogModel.data!.length; i++) {
        final assetname = icLogModel.data![i].assetId != null
            ? icLogModel.data![i].assetId!.name
            : "testdata";
        final quantity = icLogModel.data![i].stock;
        final unitname = icLogModel.data![i].toinventoryId != null
            ? icLogModel.data![i].toinventoryId!.name
            : "";
        final date = icLogModel.data![i].createDate;
        final unitid = icLogModel.data![i].toinventoryId == null
            ? ""
            : icLogModel.data![i].toinventoryId!.id;
        final employeename = icLogModel.data![i].employeeId == null
            ? ""
            : icLogModel.data![i].employeeId!.userName;

        if (unitid!.isEmpty) {
          return 0;
        } else {
          Map data = {
            'assetname': assetname,
            'quantity': quantity,
            'unitname': unitname,
            'date': date,
            'unitid': unitid,
            'change': "false",
            'employeename': employeename
          };
          print(data);
          transferlog(data);
          /////
        }
      }
    }

////
    // await db.addICLOGListdata(jsonEncode(response));
  }

  Future<FutureOr<void>> _fetchIcLogmain(
      FetchIcLogmain event, Emitter<IcLogmainState> emit) async {
    // emit(IcLogmaining());

    List items35 = await getAlltransferlogdata();

    // icLogModel = await db.getICLOGListDownloadData();
    emit(IcLogmainsuccess(items35: items35));
  }

  Future<FutureOr<void>> _refreshIcLogmain(
      RefreshIcLogmain event, Emitter<IcLogmainState> emit) async {
    emit(IcRefreshLogmainsuccess());
  }
}
