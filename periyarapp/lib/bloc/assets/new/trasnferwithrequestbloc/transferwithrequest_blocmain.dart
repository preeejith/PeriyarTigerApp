// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/new/trasnferwithrequestbloc/transferwithrequest_eventmain.dart';
import 'package:parambikulam/bloc/assets/new/trasnferwithrequestbloc/transferwithrequest_statemain.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/transferwithrequestmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

/////////new request //damage //repair
class GetTransferwithRequestBloc
    extends Bloc<TransferwithRequestEvent, TransferwithRequestState> {
  GetTransferwithRequestBloc() : super(TransferwithRequestState()) {
    on<GetTransferwithRequest>(_getTransferwithRequest);

    on<FetchTransferwithRequest>(_fetchTransferwithRequest);
  }

  Future<FutureOr<void>> _getTransferwithRequest(GetTransferwithRequest event,
      Emitter<TransferwithRequestState> emit) async {
    emit(TransferwithRequesting());
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

///////

    for (int k = 0; k < event.requestlist.length; k++) {
      if (event.requestlist[k].added == "false") {
        Map map = {
          "requestId": event.requestId,
          "asset": [
            {
              "assetId": event.requestlist[k].assetId,
              "quantity": event.requestlist[k].quantity,
              "itemId": event.requestlist[k].itemid,
            }
          ]
        };

        response = map;
        await db.addICNewRequestTransferListdata(jsonEncode(response));
      } else if (event.requestlist[k].added == "true") {
        Map map3 = {
          "requestId": event.requestId,
          "assetId": event.requestlist[k].assetId,
          "quantity": event.requestlist[k].quantity,
          "itemId": event.requestlist[k].itemid,
          "date": DateTime.now().toString(),
          "assetname": event.requestlist[k].mainstatus,
        };
        await insertnewrequestnewassets(map3);
        // response = map2;
        // await db.addICNewRequestTransferListdata(jsonEncode(map2));
      }
    }

    for (int i = 0; i < event.requestlist.length; i++) {
      int quantitytotal = int.parse(event.requestlist[i].quantity2.toString()) -
          int.parse(event.requestlist[i].quantity.toString());
      print(quantitytotal.toString() + "hello ");
      print(event.requestlist[i].assetId);
      // print(event.requestlist2[i].idno.toString());

      await db.updateassetsquantitydata(
          quantitytotal, event.requestlist[i].assetId);

      await getupdatenewpurchasedata("transfered", "true",
          event.requestlist[i].quantity, event.requestlist[i].idno);

      await getupdatemastertabledata(
          "transfered", event.requestlist[i].mainstatus);
    }
  }

  Future<FutureOr<void>> _fetchTransferwithRequest(
      FetchTransferwithRequest event,
      Emitter<TransferwithRequestState> emit) async {
    emit(TransferwithRequesting());

    DatabaseHelper? db = DatabaseHelper.instance;

    TransferWithRequestMainModel transferWithRequestMainModel;

    List items26 = [];
////
    items26 = await db.getICNewRequestTransferListDownloadData();
    print(items26);
    if (items26.isNotEmpty) {
      for (int k = 0; k < items26.length; k++) {
        transferWithRequestMainModel = await AuthRepository()
            .transferwithrequest(
                url: '/asset/transfer/with/requestv2',
                data: jsonDecode(items26[k]['data']));

        if (transferWithRequestMainModel.status == true) {
          await db.deleteICNewRequestTransferListdata(
              int.parse(items26[k]['id'].toString()));

          // emit(TransferwithRequestsuccess(
          //     transferWithRequestMainModel: transferWithRequestMainModel));
        } else if (transferWithRequestMainModel.status == false) {
          ///important to remove
          await db.deleteICNewRequestTransferListdata(
              int.parse(items26[k]['id'].toString()));
          emit(TransferwithRequestError(
              error: transferWithRequestMainModel.msg.toString()));
        }
      }
      emit(RefreshTransfer());
      emit(TransferwithRequestsuccess());
    } else {
      emit(RefreshTransfer());
      emit(TransferwithRequestsuccess());
    }
  }
}
