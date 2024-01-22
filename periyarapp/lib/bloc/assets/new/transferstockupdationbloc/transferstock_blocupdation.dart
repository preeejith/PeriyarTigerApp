import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/new/transferstockupdationbloc/transferstock_eventupdation.dart';
import 'package:parambikulam/bloc/assets/new/transferstockupdationbloc/transferstock_stateupdation.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/transferstockupdationmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

////issue page
class GetTransferStockUpdationBloc
    extends Bloc<TransferStockUpdationEvent, TransferStockUpdationState> {
  GetTransferStockUpdationBloc() : super(TransferStockUpdationState()) {
    on<GetTransferStockUpdation>(_getTransferStockUpdation);

    on<FetchTransferStockUpdation>(_fetchTransferStockUpdation);
    on<RefreshTransferStockUpdation>(_refreshTransferStockUpdation);
  }
//////
  Future<FutureOr<void>> _getTransferStockUpdation(
      GetTransferStockUpdation event,
      Emitter<TransferStockUpdationState> emit) async {
    emit(TransferStockUpdationing());
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

    Map map = {
      "requestId": event.requestId,
      "transferedtoId": event.transferedtoId,
      "asset": [
        for (int i = 0; i < event.requestlist2.length; i++)
          {
            "assetId": event.requestlist2[i].assetId,
            "quantity": event.requestlist2[i].quantity,
          }
      ]
    };

    response = map;
////
    ///for stock updation sync
    await db.addICStockUpdateTransferListdata(jsonEncode(response));
    for (int i = 0; i < event.requestlist2.length; i++) {
      int quantitytotal =
          int.parse(event.requestlist2[i].totalQuantity.toString()) -
              int.parse(event.requestlist2[i].quantity.toString());
      print(quantitytotal.toString() + "hello ");
      print(event.requestlist2[i].idno.toString());

      await db.updateassetsquantitydata(
          quantitytotal, event.requestlist2[i].assetId);

      await getupdatestockupdationdata(
          "transfered", "true", event.requestlist2[i].idno);
////
      await getupdatemastertabledata(
          "transfered", event.requestlist2[i].statusmain);
    }

//
  }

  Future<FutureOr<void>> _fetchTransferStockUpdation(
      FetchTransferStockUpdation event,
      Emitter<TransferStockUpdationState> emit) async {
    emit(TransferStockUpdationing());

    DatabaseHelper? db = DatabaseHelper.instance;
    TransgferStockUpdationModel transgferStockUpdationModel;

    List items25 = [];

    items25 = await db.getICStockUpdateTransferListDownloadData();
    print(items25);
    // print("some issue");

/////
    if (items25.isNotEmpty) {
      for (int k = 0; k < items25.length; k++) {
        transgferStockUpdationModel = await AuthRepository()
            .transferstockupdation(
                url: '/transfer/assetv1/stockupdation',
                data: jsonDecode(items25[k]['data']));

        if (transgferStockUpdationModel.status == true) {
          await db.deleteICStockUpdateTransferListdata(
              int.parse(items25[k]['id'].toString()));
          // emit(TransferStockUpdationsuccess(
          //     transgferStockUpdationModel: transgferStockUpdationModel));
        } else if (transgferStockUpdationModel.status == false) {
          await db.deleteICStockUpdateTransferListdata(
              int.parse(items25[k]['id'].toString()));
          // await db.deleteICStockUpdateTransferListdata(
          //     int.parse(items25[k]['id'].toString()));
          emit(TransferStockUpdationError(
              error: transgferStockUpdationModel.msg.toString()));
        }
      }
      emit(RefreshStock());
      emit(TransferStockUpdationsuccess());
      // emit(RefreshStock());
    } else {
      emit(RefreshStock());
      emit(TransferStockUpdationsuccess());
      // emit(RefreshStock());
      // Fluttertoast.showToast(msg: "No Data for stock updation ");
    }
  }

  Future<FutureOr<void>> _refreshTransferStockUpdation(
      RefreshTransferStockUpdation event,
      Emitter<TransferStockUpdationState> emit) async {
    emit(RefreshStock());
  }
}
