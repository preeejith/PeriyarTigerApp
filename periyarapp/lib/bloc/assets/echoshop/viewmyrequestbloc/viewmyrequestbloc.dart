/////ui Not completed
/////
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequestevent.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequeststate.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/myrequestviewmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';

import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class GetViewMyRequestBloc
    extends Bloc<ViewMyRequestEvent, ViewMyRequestState> {
  GetViewMyRequestBloc() : super(ViewMyRequestState()) {
    on<GetViewMyRequestEvent>(_getViewMyRequestEvent);

    on<FetchViewMyRequestEvent>(_fetchViewMyRequestEvent);

    on<RefreshViewMyRequestEvent>(_refreshViewMyRequestEvent);

    on<OnlinedataViewMyRequestEvent>(_onlinedataViewMyRequestEvent);
  }

  Future<FutureOr<void>> _getViewMyRequestEvent(
      GetViewMyRequestEvent event, Emitter<ViewMyRequestState> emit) async {
    emit(Viewmyrequest());

    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;
    response =
        await AuthRepository().viewmyrequest(url: '/requests/view/units');

    if (response['status'] == true) {
      await db.addUnitsRequestViewData(jsonEncode(response));
      emit(ViewmyrequestDownloaded());
      // Fluttertoast.showToast(msg: "Download Success");
    } else {}
  }

///////ready for recive data
  Future<FutureOr<void>> _onlinedataViewMyRequestEvent(
      OnlinedataViewMyRequestEvent event,
      Emitter<ViewMyRequestState> emit) async {
    emit(Viewmyrequest());
    MyRequestViewModel myRequestViewModel;

    // DatabaseHelper? db = DatabaseHelper.instance;

    myRequestViewModel =
        await AuthRepository().viewmyrequest2(url: '/requests/view/units');
    if (myRequestViewModel.status == true) {
      await deletefullproductionunitrequestmain();
      await deletefullproductionunitrequestsub();

      for (int i = 0; i < myRequestViewModel.data!.length; i++) {
        for (int j = 0; j < myRequestViewModel.data![i].items!.length; j++) {
          Map map2 = {
            "id": myRequestViewModel.data![i].items![j].id,
            "mainid": myRequestViewModel.data![i].items![j].requestId!.id,
            "assetname": myRequestViewModel.data![i].items![j].name == null
                ? myRequestViewModel.data![i].items![j].productId!.name
                : myRequestViewModel.data![i].items![j].name,
            "quantity": myRequestViewModel.data![i].items![j].quantity,
            "remark": myRequestViewModel.data![i].items![j].remark,
            "requestatus": myRequestViewModel.data![i].items![j].requestStatus,
            "trasnferedquantity":
                myRequestViewModel.data![i].items![j].transferedQuantity,
          };
          await insertproductionunitrequestsub(map2);
        }
        Map map = {
          "id": myRequestViewModel.data![i].id,
          "requesttype": myRequestViewModel.data![i].requesttype,
          "status": myRequestViewModel.data![i].requeststatus,
          "count": myRequestViewModel.data![i].count,
          "date": myRequestViewModel.data![i].createDate,
        };
        await insertproductionunitrequestmain(map);
      }

      emit(ViewMyRequestSuccess2(myRequestViewModel: myRequestViewModel));
    } else {
      emit(ViewMyRequestError());
    }
  }

  Future<FutureOr<void>> _refreshViewMyRequestEvent(
      RefreshViewMyRequestEvent event, Emitter<ViewMyRequestState> emit) async {
    emit(Refreshmyrequest());
  }

  Future<FutureOr<void>> _fetchViewMyRequestEvent(
      FetchViewMyRequestEvent event, Emitter<ViewMyRequestState> emit) async {
    emit(Viewmyrequest());
    bool? stockdone = false;
    bool? newupdation = false;
    MyRequestViewModel myRequestViewModel;
    List items31 = [];
    List items29 = [];

    DatabaseHelper? db = DatabaseHelper.instance;
    List<OfflineRequestModel> offlineRequestlist = [];
    List<AssetMasterTable> assetMasterTable = [];
    var now = DateTime.now().toUtc();
    myRequestViewModel = await db.getUnitsRequestViewDownloadData();
    items31 = await db.getICRequestSendingListDownloadData();
    items29 = await db.getUnitNewRequestListDownloadData();
    // assetMasterTable = await db.getAssetMasterTableDownloadData();
    if (items29.isNotEmpty) {
      for (int i = 0; i < items29.length; i++) {
        var data = jsonDecode(
          items29[i]['data'],
        );
        for (int j = 0; j < data['request'].length; j++) {
          offlineRequestlist.add(OfflineRequestModel(
            name: data['request'][j]['assetName'],
            assetid: "0",
            length: data['request'].length.toString(),
            typeofrequest: data['request'][j]['typeOfRequest'],
            date: now.toString(),
            quantity: data['request'][j]['quantity'],
            remark: data['request'][j]['remark'],
            requeststatus: "pending",
          ));
        }
        newupdation = true;
      }
    }
    if (items31.isNotEmpty) {
      for (int k = 0; k < items31.length; k++) {
        var data2 = jsonDecode(
          items31[k]['data'],
        );
        for (int r = 0; r < data2['request'].length; r++) {
          offlineRequestlist.add(OfflineRequestModel(
            name: "nill",
            assetid: data2['request'][r]['productId'],
            length: data2['request'].length.toString(),
            typeofrequest: data2['request'][r]['typeOfRequest'],
            date: now.toString(),
            quantity: data2['request'][r]['quantity'],
            remark: data2['request'][r]['remark'],
            requeststatus: "pending",
          ));

          // for (int h = 0; h < assetMasterTable.length; h++) {
          //   if (assetMasterTable[h].id == data2['request'][r]['productId']) {
          //     offlineRequestlist.add(OfflineRequestModel(
          //       name: assetMasterTable[h].name,
          //       length: data2['request'].length.toString(),
          //       typeofrequest: data2['request'][r]['typeOfRequest'],
          //       date: now.toString(),
          //       quantity: data2['request'][r]['quantity'],
          //       remark: data2['request'][r]['remark'],
          //       requeststatus: "pending",
          //     ));
          //   }
          // }
        }

        stockdone = true;
      }
    }
    // print(offlineRequestlist);

    if (items31.isNotEmpty && items29.isNotEmpty) {
      if (myRequestViewModel.status == true) {
        emit(ViewMyRequestSuccess(
          offlineRequestlist: offlineRequestlist,
          myRequestViewModel: myRequestViewModel,
        ));
      } else {
        emit(ViewMyRequestError());
      }
    }

    if (items31.isEmpty && items29.isNotEmpty) {
      if (myRequestViewModel.status == true) {
        emit(ViewMyRequestSuccess(
          offlineRequestlist: offlineRequestlist,
          myRequestViewModel: myRequestViewModel,
        ));
      } else {
        emit(ViewMyRequestError());
      }
    }
    if (items31.isNotEmpty && items29.isEmpty) {
      if (myRequestViewModel.status == true) {
        emit(ViewMyRequestSuccess(
          offlineRequestlist: offlineRequestlist,
          myRequestViewModel: myRequestViewModel,
        ));
      } else {
        emit(ViewMyRequestError());
      }
    }

    if (offlineRequestlist.isEmpty) {
      if (myRequestViewModel.status == true) {
        emit(ViewMyRequestSuccess(
          offlineRequestlist: offlineRequestlist,
          myRequestViewModel: myRequestViewModel,
        ));
      } else {
        emit(ViewMyRequestError());
      }
    }
  }
}

class OfflineRequestModel {
  String? typeofrequest;
  String? length;
  String? assetid;
  String? date;
  String? name;
  String? quantity;
  String? remark;
  String? requeststatus;

  OfflineRequestModel({
    this.typeofrequest,
    this.date,
    this.assetid,
    this.length,
    this.name,
    this.quantity,
    this.remark,
    this.requeststatus,
  });
}
