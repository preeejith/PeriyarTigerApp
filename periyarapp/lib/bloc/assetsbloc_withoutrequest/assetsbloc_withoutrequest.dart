////////////important
import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
////

import 'package:parambikulam/bloc/assetsbloc_withoutrequest/assetsevent_withoutrequest.dart';
import 'package:parambikulam/bloc/assetsbloc_withoutrequest/assetsstate_withoutrequest.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';

import 'package:parambikulam/data/models/assetsmodel/new/transferwithoutrequestmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/viewprofilemodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class GetAssetsWithoutRequestBloc
    extends Bloc<AssetsWithoutRequestEvent, AssetsWithoutRequestState> {
  GetAssetsWithoutRequestBloc() : super(AssetsWithoutRequestState()) {
    on<GetAssetsWithoutRequest>(_getAssetsWithoutRequest);
    on<FetchAssetsWithoutRequest>(_fetchAssetsWithoutRequest);
    on<RefreshAssetsWithoutRequest>(_refreshAssetsWithoutRequest);
  }
/////
  Future<FutureOr<void>> _getAssetsWithoutRequest(GetAssetsWithoutRequest event,
      Emitter<AssetsWithoutRequestState> emit) async {
    emit(AssetsTransfering());
    ViewProfileModel viewProfileModel;
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

    viewProfileModel = await db.getIbProfileDownloadData();
    for (int j = 0; j < event.transferassetslislist.length; j++) {
      if (event.transferassetslislist[j].added == "false") {
        Map map = {
          "transferedtoId": event.transferedtoId,
          "asset": [
            {
              "assetId": event.transferassetslislist[j].assetId,
              "quantity": event.transferassetslislist[j].quantity,
              "remark": event.transferassetslislist[j].remark
            }
          ]
        };

        print(map);

        response = map;
        await db.addICAssetsTransferListdata(jsonEncode(response));
      } else if (event.transferassetslislist[j].added == null) {
        Map map2 = {
          "transferedtoId": event.transferedtoId,
          "asset": [
            {
              "assetId": event.transferassetslislist[j].assetId,
              "quantity": event.transferassetslislist[j].quantity,
              "remark": event.transferassetslislist[j].remark
            }
          ]
        };

        Map map3 = {
          "transferedtoId": event.transferedtoId,
          "assetId": event.transferassetslislist[j].assetId,
          "quantity": event.transferassetslislist[j].quantity,
          "remark": event.transferassetslislist[j].remark,
          "date": event.transferassetslislist[j].date,
          "assetname": event.transferassetslislist[j].assetName,
          "producttype": event.transferassetslislist[j].producttype
        };
        await insertassetswithoutrequest(map3);

        print(map2);
      }
    }
    // print(map);
    // Map map2 = {
    //   "transferedtoId": event.transferedtoId,
    //   "asset": [
    //     for (int i = 0; i < event.transferassetslislist.length; i++)
    //       {
    //         if (event.transferassetslislist[i].added == "true")
    //           {
    //             "assetId": event.transferassetslislist[i].assetId,
    //             "quantity": event.transferassetslislist[i].quantity,
    //             "remark": event.transferassetslislist[i].remark
    //           }
    //       }
    //   ]
    // };
    // print(map);
    // // print(map2);
    // response = map;
    for (int k = 0; k < event.transferassetslislist.length; k++) {
      int totalQuantity =
          int.parse(event.transferassetslislist[k].orgquantity.toString()) -
              int.parse(event.transferassetslislist[k].quantity.toString());
      print(totalQuantity);
      await db.updateassetsquantitydata(totalQuantity.toString(),
          event.transferassetslislist[k].assetId.toString());
    }

    //  await db.addICAssetsTransferListdata(jsonEncode(response));

    for (int i = 0; i < event.transferassetslislist.length; i++) {
      final assetname = event.transferassetslislist[i].assetId != null
          ? event.transferassetslislist[i].assetName
          : "";
      final quantity = event.transferassetslislist[i].quantity;
      final unitname = event.transferassetslislist[i].unitName;
      final date = event.transferassetslislist[i].date;
      final unitid = event.transferassetslislist[i].unitid;
      final employeename = viewProfileModel.data.userName;

      if (assetname!.isEmpty) {
        return 0;
      } else {
        Map data = {
          'assetname': assetname,
          'quantity': quantity,
          'unitname': unitname,
          'date': date,
          'unitid': unitid,
          'change': "true",
          'employeename': employeename
        };
        print(data);
        transferlog(data);
      }
    }
  }

///////
  Future<FutureOr<void>> _fetchAssetsWithoutRequest(
      FetchAssetsWithoutRequest event,
      Emitter<AssetsWithoutRequestState> emit) async {
    DatabaseHelper? db = DatabaseHelper.instance;
    TransferwithoutrequestmainModel transferwithoutrequestmainModel;

    List items23 = [];

    items23 = await db.getICAssetsTrasnferListDownloadData();
    print(items23);

    if (items23.isNotEmpty) {
      for (int k = 0; k < items23.length; k++) {
        transferwithoutrequestmainModel = await AuthRepository()
            .transferwithoutrequestmain(
                url: '/transfer/assetv1', data: jsonDecode(items23[k]['data']));

        if (transferwithoutrequestmainModel.status == true) {
          if (items23.isNotEmpty) {
            await db.deletgetICAssetsTrasnferList(
                int.parse(items23[k]['id'].toString()));
          }
          // emit(AssetsWithoutRequestsuccess(
          //     transferwithoutrequestmainModel:
          //         transferwithoutrequestmainModel));
        } else if (transferwithoutrequestmainModel.status == false) {
          emit(UnitsError(
              error: transferwithoutrequestmainModel.msg.toString()));

          await db.deletgetICAssetsTrasnferList(
              int.parse(items23[k]['id'].toString()));
        }
      }
      emit(RefreshAssetsRequest());
      emit(AssetsWithoutRequestsuccess());
      // emit(RefreshAssetsRequest());
    } else {
      emit(RefreshAssetsRequest());
      emit(AssetsWithoutRequestsuccess());
      // emit(RefreshAssetsRequest());
      // Fluttertoast.showToast(msg: "No Data for transfer ");
    }
  }

  Future<FutureOr<void>> _refreshAssetsWithoutRequest(
      RefreshAssetsWithoutRequest event,
      Emitter<AssetsWithoutRequestState> emit) async {
    emit(RefreshAssetsRequest());
  }
}
