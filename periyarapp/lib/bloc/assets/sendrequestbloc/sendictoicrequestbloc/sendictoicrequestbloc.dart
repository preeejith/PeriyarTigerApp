// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/sendictoicrequestbloc/sendictoicrequestevent.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/sendictoicrequestbloc/sendictoicrequeststate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/ictoicrequestmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

//////
class GetSendRequestIctoIcBloc
    extends Bloc<SendRequestIctoIcEvent, SendRequestIctoIcState> {
  GetSendRequestIctoIcBloc() : super(SendRequestIctoIcState()) {
    on<GetSendRequestIctoIc>(_getSendRequestIctoIc);
    on<FetchSendRequestIctoIc>(_fetchSendRequestIctoIc);
  }

  Future<FutureOr<void>> _getSendRequestIctoIc(
      GetSendRequestIctoIc event, Emitter<SendRequestIctoIcState> emit) async {
    emit(SendRequestIctoIcing());
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

    // IcToIcRequestModel icToIcRequestModel;

    Map map = {
      "description": event.remark,
      "request": [
        for (int i = 0; i < event.asseticrequestcartlist.length; i++)
          {
            "typeOfRequest": "New Purchase",
            "quantity": event.asseticrequestcartlist[i].quantity,
            "assetName": event.asseticrequestcartlist[i].assetname
          }
      ]
    };
    response = map;
    await db.addICICICRequestListdata(jsonEncode(response));
  }

  Future<FutureOr<void>> _fetchSendRequestIctoIc(FetchSendRequestIctoIc event,
      Emitter<SendRequestIctoIcState> emit) async {
    emit(SendRequestIctoIcing());
  
    DatabaseHelper? db = DatabaseHelper.instance;

    IcToIcRequestModel icToIcRequestModel;
    List items29 = [];

    items29 = await db.getICICICRequestListDownloadData();
    if (items29.isNotEmpty) {
      for (int k = 0; k < items29.length; k++) {
        icToIcRequestModel = await AuthRepository().ictoicrequest(
            url: '/send/request/for/ic', data: jsonDecode(items29[k]['data']));

        if (icToIcRequestModel.status == true) {
          await db.deleteICICICRequestListdata(
              int.parse(items29[k]['id'].toString()));

          emit(
              SendRequestIctoIcsuccess(icToIcRequestModel: icToIcRequestModel));
        } else if (icToIcRequestModel.status == false) {
          emit(
              SendRequestIctoIcError(error: icToIcRequestModel.msg.toString()));
        }
      }
    } else {
      // emit(
      //             SendRequestIctoIcsuccess());

    }
  }
}
