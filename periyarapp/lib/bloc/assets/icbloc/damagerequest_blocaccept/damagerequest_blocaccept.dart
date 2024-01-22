// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/damagerequest_blocaccept/damagerequest_eventaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/damagerequest_blocaccept/damagerequest_stateaccept.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/damagerequestacceptmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

//////all ready waiting for up the server
///111111
class GetDamageRequestAcceptBloc
    extends Bloc<DamageRequestAcceptEvent, DamageRequestAcceptState> {
  GetDamageRequestAcceptBloc() : super(DamageRequestAcceptState()) {
    on<GetDamageRequestAccept>(_getDamageRequestAccept);

    on<FetchDamageRequestAccept>(_fetchDamageRequestAccept);
  }

  Future<FutureOr<void>> _getDamageRequestAccept(GetDamageRequestAccept event,
      Emitter<DamageRequestAcceptState> emit) async {
    emit(DamageRequestAccepting());
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

    Map map = {
      "requestId": event.requestId,
      "assetId": event.assetId,
      "remark": event.remark,
    };

    await getupdatedamagedata("damaged", "true", event.idno);
    await getupdatemastertabledata("damaged", event.statusmain);

    response = map;
    await db.addICDamageacceptedListdata(jsonEncode(response));
  }

  Future<FutureOr<void>> _fetchDamageRequestAccept(
      FetchDamageRequestAccept event,
      Emitter<DamageRequestAcceptState> emit) async {
    emit(DamageRequestAccepting());

    DatabaseHelper? db = DatabaseHelper.instance;

    DamageRequestAcceptModel damageRequestAcceptModel;

    List items33 = [];
/////////
    items33 = await db.getICDamageacceptedListDownloadData();

    if (items33.isNotEmpty) {
      for (int k = 0; k < items33.length; k++) {
        damageRequestAcceptModel = await AuthRepository().damagerequestaccept(
            url: '/accept/damage/request',
            data: jsonDecode(items33[k]['data']));

        if (damageRequestAcceptModel.status == true) {
          await db.deleteICDamageacceptedListdata(
              int.parse(items33[k]['id'].toString()));

          emit(DamageRequestAcceptsuccess(
              damageRequestAcceptModel: damageRequestAcceptModel));
        } else if (damageRequestAcceptModel.status == false) {
          await db.deleteICDamageacceptedListdata(
              int.parse(items33[k]['id'].toString()));
          emit(UnitsError(error: damageRequestAcceptModel.msg.toString()));
        }
      }
    }
  }
}
