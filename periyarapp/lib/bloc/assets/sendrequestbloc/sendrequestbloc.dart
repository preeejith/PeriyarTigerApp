// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectid/objectid.dart';

import 'package:parambikulam/bloc/assets/sendrequestbloc/sendrequestevent.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/sendrequeststate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/newrequestmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

//1//new request
class GetSendRequestBloc extends Bloc<SendRequestEvent, SendRequestState> {
  GetSendRequestBloc() : super(SendRequestState()) {
    on<GetSendRequest>(_getSendRequest);

    on<FetchSendRequest>(_fetchSendRequest);
  }

  Future<FutureOr<void>> _getSendRequest(
      GetSendRequest event, Emitter<SendRequestState> emit) async {
    emit(SendRequesting());
/////
    var now = DateTime.now();
    String? productid = ObjectId().toString();
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

    Map map = {
      "request": [
        for (int i = 0; i < event.assetrequestcartlist.length; i++)
          {
            "typeOfRequest": event.assetrequestcartlist[i].typeofrequest,
            "quantity": event.assetrequestcartlist[i].quantity,
            "type": event.assetrequestcartlist[i].type,
            "remark": event.assetrequestcartlist[i].remark,
            "assetName": event.assetrequestcartlist[i].assetname
          }
      ]
    };

    for (int j = 0; j < event.assetrequestcartlist.length; j++) {
      Map map3 = {
        "id": productid,
        "mainid": productid,
        "assetname": event.assetrequestcartlist[j].assetname,
        "quantity": event.assetrequestcartlist[j].quantity,
        "remark": event.assetrequestcartlist[j].remark,
        "requestatus": "pending",
        "trasnferedquantity": "",
      };
      await insertproductionunitrequestsub(map3);
    }

    ///
    Map map2 = {
      "id": productid,
      "requesttype": event.assetrequestcartlist[0].typeofrequest,
      "status": "pending",
      "count": event.assetrequestcartlist.length.toString(),
      "date": now.toString(),
    };
    await insertproductionunitrequestmain(map2);

    response = map;
    await db.addUnitNewRequestListdata(jsonEncode(response));
  }

  ///1
  Future<FutureOr<void>> _fetchSendRequest(
      FetchSendRequest event, Emitter<SendRequestState> emit) async {
    emit(SendRequesting());

    DatabaseHelper? db = DatabaseHelper.instance;

    NewRequestModel newRequestModel;

    List items29 = [];
    items29 = await db.getUnitNewRequestListDownloadData();

    ///
    if (items29.isNotEmpty) {
      for (int k = 0; k < items29.length; k++) {
        newRequestModel = await AuthRepository().sendnewrequest(
            url: '/send/requestv1', data: jsonDecode(items29[k]['data']));

        if (newRequestModel.status == true) {
          await db.delUnitNewRequestListdata(
              int.parse(items29[k]['id'].toString()));
          emit(SendRequestsuccess(newRequestModel: newRequestModel));
        } else if (newRequestModel.status == false) {
          emit(SendRequestError(error: newRequestModel.msg));
        }
      }
    } else {
      // Fluttertoast.showToast(
      //   msg: "No New Purchase data",
      // );
    }
  }
}
