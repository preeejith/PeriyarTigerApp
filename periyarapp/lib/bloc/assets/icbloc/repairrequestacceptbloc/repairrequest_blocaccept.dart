// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/repairrequestacceptbloc/repairrequest_eventaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/repairrequestacceptbloc/repairrequest_stateaccept.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/repairrequestacceptmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

//////all ready waiting for up the server
///
class GetRepairRequestAcceptBloc
    extends Bloc<RepairRequestAcceptEvent, RepairRequestAcceptState> {
  GetRepairRequestAcceptBloc() : super(RepairRequestAcceptState()) {
    on<GetRepairRequestAccept>(_getRepairRequestAccept);
    on<FetchRepairRequestAccept>(_fetchRepairRequestAccept);
  }

  Future<FutureOr<void>> _getRepairRequestAccept(GetRepairRequestAccept event,
      Emitter<RepairRequestAcceptState> emit) async {
    emit(RepairRequestAccepting());

    RepairRequestAcceptModel repairRequestAcceptModel;
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;
//////////
    Map map = {
      "requestId": event.requestId,
      "assetId": event.assetId,
    };

    await getupdaterepairdata("accepted", "true", event.idno);
    response = map;
    await db.addICrepairacceptedListdata(jsonEncode(response));

    // repairRequestAcceptModel = await AuthRepository()
    //     .repairrequestaccept(url: '/accept/repair/request', data: map);

    // if (repairRequestAcceptModel.status == true) {
    //   emit(RepairRequestAcceptsuccess(
    //       repairRequestAcceptModel: repairRequestAcceptModel));
    // } else if (repairRequestAcceptModel.status == false) {
    //   emit(UnitsError(error: ''));
    // }
  }

  Future<FutureOr<void>> _fetchRepairRequestAccept(
      FetchRepairRequestAccept event,
      Emitter<RepairRequestAcceptState> emit) async {
    emit(RepairRequestAccepting());

    RepairRequestAcceptModel repairRequestAcceptModel;
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

    List items62 = [];
/////////
    items62 = await db.getICrepairacceptedListDownloadData();
//////////
    if (items62.isNotEmpty) {
      for (int i = 0; i < items62.length; i++) {
        repairRequestAcceptModel = await AuthRepository().repairrequestaccept(
            url: '/accept/repair/request',
            data: jsonDecode(items62[i]['data']));

        if (repairRequestAcceptModel.status == true) {
          await db.deleteICrepairacceptedListdata(
              int.parse(items62[i]['id'].toString()));

          emit(RepairRequestAcceptsuccess(
              repairRequestAcceptModel: repairRequestAcceptModel));
        } else if (repairRequestAcceptModel.status == false) {
          await db.deleteICrepairacceptedListdata(
              int.parse(items62[i]['id'].toString()));
          emit(UnitsError(error: ''));
        }
      }
    }
  }
}
