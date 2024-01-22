/////////////////add assets multiple data
///ultimatehelper///////
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectid/objectid.dart';

import 'package:parambikulam/bloc/assets/new/addassetsmainbloc/addassetsmainevent.dart';
import 'package:parambikulam/bloc/assets/new/addassetsmainbloc/addassetsmainstate.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';

import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/transferwithoutrequestmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/transferwithrequestmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/purchaseorderviewmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

//////all ready waiting for up the server
//////////

class GetAddAssetsmainBloc
    extends Bloc<AddAssetsmainEvent, AddAssetsmainState> {
  GetAddAssetsmainBloc() : super(AddAssetsmainState()) {
    on<GetAddAssetsmain>(_getAddAssetsmain);
    on<FetchAddAssetsmain>(_fetchAddAssetsmain);

    on<RefreshAddAssetsmain>(_refreshAddAssetsmain);
  }

  Future<FutureOr<void>> _getAddAssetsmain(
      GetAddAssetsmain event, Emitter<AddAssetsmainState> emit) async {
    dynamic response;
    String? assetidid = ObjectId().toString();

    String? purchaseidid = ObjectId().toString();
    int? totalQuantity = 0;
    bool? checkon = false;
    bool? checkok = false;

    ViewassetsModel viewassetsModel = ViewassetsModel();
    AssetMasterTable assetMasterTable = AssetMasterTable();

    PurchaseOrder purchaseOrder = PurchaseOrder();
    PurchaseData purchaseData = PurchaseData();
    DatabaseHelper? db = DatabaseHelper.instance;
///////
    Map map = {
      "assetidid": assetidid,
      "purchaseidid": purchaseidid,
      "purchaseId": event.purchaseId,
      "totalAmount": event.totalAmount,
      "discount": event.discount,
      "assets": [
        for (int i = 0; i < event.addassetslist.length; i++)
          {
            "localid": event.addassetslist[i].localid,
            "name": event.addassetslist[i].assetsname,
            "assetId": event.addassetslist[i].assetsid,
            "productType": event.addassetslist[i].producttype,
            "purchaseAmount": event.addassetslist[i].purchaseamount,
            "quantity": event.addassetslist[i].quantity,
            "description": event.addassetslist[i].remark,
          }
      ]
    };

    response = map;

    ///tempoff
    await db.addICAddAssetsListdata(jsonEncode(response));
    ////chnged utc
    String datetime = DateTime.now().toString();
    checkok = true;
    for (int j = 0; j < event.addassetslist.length; j++) {
      if (event.addassetslist[j].assetidtaken == "true") {
        viewassetsModel = await db.getassetquantityDownloadData(
            event.addassetslist[j].assetsid.toString());
        print(viewassetsModel.quantity);
        totalQuantity = (int.parse(viewassetsModel.quantity.toString()) +
            int.parse(event.addassetslist[j].quantity.toString()));

        print(totalQuantity);

        await db.updateassetsquantitydata(totalQuantity.toString(),
            event.addassetslist[j].assetsid.toString());
        if (event.addassetslist[j].remark != "") {
          await db.updateassetsdescriptiondata(event.addassetslist[j].remark,
              event.addassetslist[j].assetsid.toString());
        }
/////for adding new add stock addec to the stock
        viewassetsModel.quantity = event.addassetslist[j].quantity;
        viewassetsModel.assetid = assetidid;
        viewassetsModel.price = event.addassetslist[j].purchaseamount;

        viewassetsModel.name = event.addassetslist[j].assetsname;
        viewassetsModel.discount = event.discount;
        viewassetsModel.status = "active11";
        viewassetsModel.id = event.purchaseId;
        viewassetsModel.checkon = "false";
        viewassetsModel.createDate = datetime;
        viewassetsModel.unitId = event.totalAmount;
        viewassetsModel.edited = "false";
        viewassetsModel.added = "true";
        viewassetsModel.assetidtaken = "true";
        viewassetsModel.purchaseid = event.purchaseId;

        assetMasterTable.id = assetidid;
        assetMasterTable.status = "active11";
        assetMasterTable.name = event.addassetslist[j].assetsname;

        assetMasterTable.productType = event.addassetslist[j].producttype;
        assetMasterTable.description = event.addassetslist[j].remark;
        assetMasterTable.createDate = datetime;
//////
        await db.addViewAssetsdata(viewassetsModel);
        await db.addViewAssetMasterTabledata(assetMasterTable);

////ended///
        // await db.updateassetmasterdata(
        //     event.name, event.description, event.assetId);

        ///for adding to purchase order
        // ///////
        if (checkok == true) {
          checkok = false;
          purchaseOrder.status = "active";
          purchaseOrder.id = purchaseidid;
          purchaseOrder.employeeId = "123";
          purchaseOrder.purchaseId = event.purchaseId;
          purchaseOrder.assetId = event.addassetslist[j].assetsid.toString();

          purchaseOrder.assetname = event.addassetslist[0].assetsname;

          purchaseOrder.totalAmount = event.totalAmount;
          purchaseOrder.discount = event.discount;
          purchaseOrder.billAmount = ((int.parse(event.totalAmount.toString()) -
                  (int.parse(event.discount.toString())))
              .toString());
          purchaseOrder.createDate = datetime;
          purchaseOrder.quantity = "0";

          purchaseOrder.purchaseAmount = "0";
          await db.addPurchaseassetsdata(purchaseOrder);
        }

        purchaseData.purchaseid = purchaseidid;
        purchaseData.name = event.addassetslist[j].assetsname;
        purchaseData.purchaseAmount = event.addassetslist[j].purchaseamount;

        purchaseData.quantity = event.addassetslist[j].quantity;
        purchaseData.assetId = event.addassetslist[j].assetsid.toString();

        await db.addPurchasedata(purchaseData);
      }
    }

    checkon = true;
    for (int m = 0; m < event.addassetslist.length; m++) {
      if (event.addassetslist[m].assetidtaken != "true") {
        String? assetididid = ObjectId().toString();
        viewassetsModel.quantity = event.addassetslist[m].quantity;
        viewassetsModel.assetid = event.addassetslist[m].localid;
        viewassetsModel.price = event.addassetslist[m].purchaseamount;

        viewassetsModel.name = event.addassetslist[m].assetsname;
        viewassetsModel.discount = event.discount;
        viewassetsModel.status = "active11";
        viewassetsModel.id = event.purchaseId;
        viewassetsModel.checkon = "false";
        viewassetsModel.createDate = datetime;
        viewassetsModel.unitId = event.totalAmount;
        viewassetsModel.edited = "false";
        viewassetsModel.added = "true";
        viewassetsModel.assetidtaken = "false";
        viewassetsModel.purchaseid = event.purchaseId;

        assetMasterTable.id = assetididid;
        assetMasterTable.status = "active11";
        assetMasterTable.name = event.addassetslist[m].assetsname;

        assetMasterTable.productType = event.addassetslist[m].producttype;
        assetMasterTable.description = event.addassetslist[m].remark;
        assetMasterTable.createDate = datetime;

        await db.addViewAssetsdata(viewassetsModel);
        await db.addViewAssetMasterTabledata(assetMasterTable);
        purchaseData.purchaseid = purchaseidid;
        purchaseData.name = event.addassetslist[m].assetsname;
        purchaseData.purchaseAmount = event.addassetslist[m].purchaseamount;

        purchaseData.quantity = event.addassetslist[m].quantity;
        purchaseData.assetId = assetididid;

        await db.addPurchasedata(purchaseData);
        if (checkon == true) {
          checkon = false;
          purchaseOrder.status = "active";
          purchaseOrder.id = purchaseidid;
          purchaseOrder.employeeId = "123";
          purchaseOrder.purchaseId = event.purchaseId;
          purchaseOrder.assetId = event.addassetslist[m].localid;

          purchaseOrder.assetname = event.addassetslist[m].assetsname;

          purchaseOrder.totalAmount = event.totalAmount;
          purchaseOrder.discount = event.discount;
          purchaseOrder.billAmount = ((int.parse(event.totalAmount.toString()) -
                  (int.parse(event.discount.toString())))
              .toString());

          purchaseOrder.createDate = datetime;
          purchaseOrder.quantity = "0";

          purchaseOrder.purchaseAmount = "0";
          await db.addPurchaseassetsdata(purchaseOrder);
        }
      }
    }

//////purchase list addd
    // for (int j = 0; j < event.addassetslist.length; j++) {
    //   purchaseOrder.status = "active";
    //   purchaseOrder.id = purchaseidid;
    //   purchaseOrder.employeeId = "123";
    //   purchaseOrder.purchaseId = event.purchaseId;
    //   purchaseOrder.assetId = assetidid;

    //   purchaseOrder.assetname = event.addassetslist[0].assetsname;

    //   purchaseOrder.totalAmount = event.totalAmount;
    //   purchaseOrder.discount = event.discount;
    //   purchaseOrder.billAmount = ((int.parse(event.totalAmount.toString()) -
    //           (int.parse(event.discount.toString())))
    //       .toString());

    //   purchaseOrder.createDate = datetime;
    //   purchaseOrder.quantity = "0";

    //   purchaseOrder.purchaseAmount = "0";

    //   purchaseData.purchaseid = purchaseidid;
    //   purchaseData.name = event.addassetslist[j].assetsname;
    //   purchaseData.purchaseAmount = event.addassetslist[j].purchaseamount;

    //   purchaseData.quantity = event.addassetslist[j].quantity;
    //   purchaseData.assetId = assetidid;

    //   await db.addPurchasedata(purchaseData);

    //   await db.addPurchaseassetsdata(purchaseOrder);
    // }
  }

  /////
}

/////for sync we initiated another bloc

Future<FutureOr<void>> _fetchAddAssetsmain(
    FetchAddAssetsmain event, Emitter<AddAssetsmainState> emit) async {
  DatabaseHelper? db = DatabaseHelper.instance;
  List items62 = [];
  List items63 = [];
  List items21 = [];
  AddAssetMainModel addAssetMainModel;
  TransferwithoutrequestmainModel transferwithoutrequestmainModel;
  TransferWithRequestMainModel transferWithRequestMainModel;
  items21 = await db.getICAddAssetsListDownloadData();
  print(items21);
//
  if (items21.isNotEmpty) {
    for (int k = 0; k < items21.length; k++) {
      addAssetMainModel = await AuthRepository().addassetsmain(
          url: '/add/asset/icv1', data: jsonDecode(items21[k]['data']));

      if (addAssetMainModel.status == true) {
        if (items21.isNotEmpty) {
          await db.deletealldata2(int.parse(items21[k]['id'].toString()));
        }

        items62 = await getassetswithoutrequestdata();
        items63 = await getnewrequestnewassetsdata();
        if (items62.isNotEmpty) {
          for (int k = 0; k < items62.length; k++) {
            for (int l = 0; l < addAssetMainModel.bill!.purchase!.length; l++) {
              if (addAssetMainModel.bill!.purchase![l].assetId!.localId ==
                  items62[k]['assetId']) {
                Map map2 = {
                  "transferedtoId": items62[k]['transferedtoId'],
                  "asset": [
                    {
                      "assetId":
                          addAssetMainModel.bill!.purchase![l].assetId!.id,
                      "quantity": items62[k]['quantity'],
                      "remark": items62[k]['remark']
                    }
                  ]
                };

                transferwithoutrequestmainModel = await AuthRepository()
                    .transferwithoutrequestmain(
                        url: '/transfer/assetv1', data: map2);

                if (transferwithoutrequestmainModel.status == true) {
                  if (items62.isNotEmpty) {
                    await deleteassetswithoutrequest(k);
                  }
                  // emit(AssetsWithoutRequestsuccess(
                  //     transferwithoutrequestmainModel:
                  //         transferwithoutrequestmainModel));
                } else if (transferwithoutrequestmainModel.status == false) {
                  await deleteassetswithoutrequest(k);
                  emit(UnitsError(
                      error: transferwithoutrequestmainModel.msg.toString()));
                }
              }
            }
          }
        }

        if (items63.isNotEmpty) {
          for (int j = 0; j < items63.length; j++) {
            for (int l = 0; l < addAssetMainModel.bill!.purchase!.length; l++) {
              if (addAssetMainModel.bill!.purchase![l].assetId!.localId ==
                  items63[j]['assetId']) {
                Map map3 = {
                  "requestId": items63[j]['requestId'],
                  "asset": [
                    {
                      "assetId":
                          addAssetMainModel.bill!.purchase![l].assetId!.id,
                      "quantity": items63[j]['quantity'],
                      "itemId": items63[j]['itemId'],
                    }
                  ]
                };

                transferWithRequestMainModel = await AuthRepository()
                    .transferwithrequest(
                        url: '/asset/transfer/with/requestv2', data: map3);

                if (transferWithRequestMainModel.status == true) {
                  await deletenewrequestnewassets(j);

                  // emit(TransferwithRequestsuccess(
                  //     transferWithRequestMainModel: transferWithRequestMainModel));
                } else if (transferWithRequestMainModel.status == false) {
                  ///important to remove
                  // await db.deleteICNewRequestTransferListdata(
                  //     int.parse(items26[k]['id'].toString()));

                }
              }
            }
          }
        }
      }

      ///changed
      else if (addAssetMainModel.status == false) {
        if (items21.isNotEmpty) {
          await db.deletealldata2(int.parse(items21[k]['id'].toString()));
        }
        emit(UnitsError(error: addAssetMainModel.msg.toString()));
      }
    }
    emit(RefreshAssests());
    emit(AddAssetsmainsuccess());
    // emit(RefreshAssests());
  } else {
    emit(RefreshAssests());
    emit(AddAssetsmainsuccess());
    // emit(RefreshAssests());
    // Fluttertoast.showToast(msg: "No assest Available ");
  }
}

Future<FutureOr<void>> _refreshAddAssetsmain(
    RefreshAddAssetsmain event, Emitter<AddAssetsmainState> emit) async {
  emit(RefreshAssests());
}
