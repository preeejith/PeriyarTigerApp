// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectid/objectid.dart';

import 'package:parambikulam/bloc/assets/sendrequestbloc/requestupdationbloc/requestupdationevent.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/requestupdationbloc/requestupdationstate.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/newrequestmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

/////////all ready waiting for up the server
///2 stock updation///////
class GetRequestUpdationBloc
    extends Bloc<RequestUpdationEvent, RequestUpdationState> {
  GetRequestUpdationBloc() : super(RequestUpdationState()) {
    on<GetRequestUpdation>(_getRequestUpdation);

    on<FetchRequestUpdation>(_fetchRequestUpdation);
  }

  Future<FutureOr<void>> _getRequestUpdation(
      GetRequestUpdation event, Emitter<RequestUpdationState> emit) async {
    dynamic response;
    int? totalQuantity = 0;
    var now = DateTime.now();
    String? productid = ObjectId().toString();
    DatabaseHelper? db = DatabaseHelper.instance;
/////
    Map map = {
      "request": [
        for (int i = 0; i < event.assetrequestcartlist.length; i++)
          {
            "typeOfRequest": event.assetrequestcartlist[i].typeofrequest,
            "quantity": event.assetrequestcartlist[i].quantity,
            "type": event.assetrequestcartlist[i].type,
            "remark": event.assetrequestcartlist[i].remark,
            "productId": event.assetrequestcartlist[i].productid
          }
      ],
      "description": event.description
    };
    if (event.assetrequestcartlist[0].typeofrequest != "stock Updation") {
      for (int h = 0; h < event.assetrequestcartlist.length; h++) {
        ////for updating the count

        totalQuantity = (int.parse(
                event.assetrequestcartlist[h].productquantity.toString()) -
            int.parse(event.assetrequestcartlist[h].quantity.toString()));

        print(totalQuantity);

        await db.updateassetsquantitydata(
            totalQuantity.toString(), event.assetrequestcartlist[h].productid);
      }
    }

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

    Map map2 = {
      "id": productid,
      "requesttype": event.assetrequestcartlist[0].typeofrequest,
      "status": "pending",
      "count": event.assetrequestcartlist.length.toString(),
      "date": now.toString(),
    };
    await insertproductionunitrequestmain(map2);

    response = map;
    await db.addICRequestSendingListdata(jsonEncode(response));
  }

  ///2
  Future<FutureOr<void>> _fetchRequestUpdation(
      FetchRequestUpdation event, Emitter<RequestUpdationState> emit) async {
    DatabaseHelper? db = DatabaseHelper.instance;
    List items31 = [];
    NewRequestModel newRequestModel;

    items31 = await db.getICRequestSendingListDownloadData();

    if (items31.isNotEmpty) {
      for (int k = 0; k < items31.length; k++) {
        newRequestModel = await AuthRepository().sendnewrequest(
            url: '/send/requestv1', data: jsonDecode(items31[k]['data']));

        if (newRequestModel.status == true) {
          await db.delICRequestSendingListdata(
              int.parse(items31[k]['id'].toString()));

          emit(RequestUpdationsuccess(newRequestModel: newRequestModel));
        } else if (newRequestModel.status == false) {
          emit(RequestUpdationError(error: newRequestModel.msg));
        }
      }
    } else {
      // Fluttertoast.showToast(
      //   msg: "No stock data",
      // );
    }
  }
}
