// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';
///////////
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/new/sync/sync_icbloc/sync_icevent.dart';
import 'package:parambikulam/bloc/assets/new/sync/sync_icbloc/sync_icstate.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/assetseditmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/addassetfornostockmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';

import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class GetSyncOfflineDataBloc
    extends Bloc<SyncOfflineDataEvent, SyncOfflineDataState> {
  GetSyncOfflineDataBloc() : super(SyncOfflineDataState()) {
    on<GetSyncOfflineData>(_getSyncOfflineData);
    on<GetSyncAssetsEditData>(_getSyncAssetsEditData);
    on<FetchSyncOfflineData>(_fetchSyncOfflineData);
    on<FetchSyncallData>(_fetchSyncallData);
    on<GetProductEditData>(_getProductEditData);
  }

  Future<FutureOr<void>> _getSyncOfflineData(
      GetSyncOfflineData event, Emitter<SyncOfflineDataState> emit) async {
    emit(SyncOfflineDataing());
  }

  Future<FutureOr<void>> _fetchSyncOfflineData(
      FetchSyncOfflineData event, Emitter<SyncOfflineDataState> emit) async {
    List<ViewassetsModel> viewassetsModel = [];
    List<AssetMasterTable> assetMasterTable = [];

    List<SyncassetdataModel> syncassetdatalist = [];

    List<SyncassetdataModel> syncfilterassetdatalist = [];

    AddAssetMainModel addAssetMainModel;
    DatabaseHelper? db = DatabaseHelper.instance;
    viewassetsModel = await db.getViewAssetsDownloadData();
    print(viewassetsModel);

    AddAssetNoStockModel addAssetNoStockModel;
    assetMasterTable = await db.getAssetMasterTableDownloadData();
    syncassetdatalist.clear();

    ///newly added and it it its id not taken
    for (int i = 0; i < viewassetsModel.length; i++) {
      if (viewassetsModel[i].added == "true" &&
          viewassetsModel[i].assetidtaken == "false") {
        syncassetdatalist.add(SyncassetdataModel(
            assetid: "",
            assetname: assetMasterTable[i].name,
            productType: assetMasterTable[i].productType,
            purchaseId: viewassetsModel[i].id,
            totalAmount: viewassetsModel[i].price,
            discount: viewassetsModel[i].discount,
            purchaseAmount: viewassetsModel[i].price,
            description: assetMasterTable[i].description,
            quantity: viewassetsModel[i].quantity));
      }
    }
    for (int k = 0; k < syncassetdatalist.length; k++) {
      syncfilterassetdatalist.clear();

      for (int j = 0; j < viewassetsModel.length; j++) {
        if (viewassetsModel[j].id == syncassetdatalist[k].purchaseId) {
          syncfilterassetdatalist.add(SyncassetdataModel(
              assetid: "",
              assetname: syncassetdatalist[k].assetname,
              productType: assetMasterTable[j].productType,
              purchaseId: viewassetsModel[j].id,
              totalAmount: viewassetsModel[j].price,
              discount: viewassetsModel[j].discount,
              purchaseAmount: viewassetsModel[j].price,
              description: assetMasterTable[j].description,
              quantity: viewassetsModel[j].quantity));
        }
      }
      /////
      ////////
      if (syncfilterassetdatalist.isNotEmpty) {
        Map map = {
          "purchaseId": syncfilterassetdatalist[0].purchaseId,
          "totalAmount": syncfilterassetdatalist[0].totalAmount,
          "discount": syncfilterassetdatalist[0].discount,
          "assets": [
            for (int k = 0; k < syncfilterassetdatalist.length; k++)
              {
                "name": syncfilterassetdatalist[k].assetname,
                "assetId": "",
                "productType": syncfilterassetdatalist[k].productType,
                "purchaseAmount": syncfilterassetdatalist[k].purchaseAmount,
                "quantity": syncfilterassetdatalist[k].quantity,
                "description": syncfilterassetdatalist[k].description,
              }
          ]
        };
        print(map);
        addAssetMainModel = await AuthRepository()
            .addassetsmain(url: '/add/asset/icv1', data: map);
        print(addAssetMainModel);
      }
    }

    ///
//////for stock updation danger temp off
    // for (int i = 0; i < viewassetsModel.length; i++) {
    //   if (viewassetsModel[i].added == "true" &&
    //       viewassetsModel[i].assetidtaken == "true") {
    //     Map map = {
    //       "purchaseId": viewassetsModel[i].id,
    //       "totalAmount": viewassetsModel[i].price,
    //       "discount": viewassetsModel[i].discount,
    //       "assets": [
    //         {
    //           "name": viewassetsModel[i].name,
    //           "assetId": "",
    //           "productType": assetMasterTable[i].productType,
    //           "purchaseAmount": viewassetsModel[i].price,
    //           "quantity": viewassetsModel[i].quantity,
    //           "description": assetMasterTable[i].description,
    //         }
    //       ]
    //     };

    //     addAssetNoStockModel = await AuthRepository()
    //         .addassetsnostock(url: '/add/asset/icv1', data: map);

    //     if (addAssetNoStockModel.status == true) {
    //       for (int j = 0; j < viewassetsModel.length; j++) {
    //         if (addAssetNoStockModel.bill.purchaseId == viewassetsModel[j].id) {
    //           Map map = {
    //             "purchaseId": viewassetsModel[j].id,
    //             "totalAmount": viewassetsModel[j].price,
    //             "discount": viewassetsModel[j].discount,
    //             "assets": [
    //               for (int m = 0;
    //                   m < addAssetNoStockModel.bill.purchase.length;
    //                   m++)
    //                 {
    //                   "name": viewassetsModel[j].name,
    //                   "assetId": addAssetNoStockModel.bill.purchase[m].assetId,
    //                   "productType": assetMasterTable[j].productType,
    //                   "purchaseAmount": viewassetsModel[j].price,
    //                   "quantity": viewassetsModel[j].quantity,
    //                   "description": assetMasterTable[j].description,
    //                 }
    //             ]
    //           };

    //           addAssetMainModel = await AuthRepository()
    //               .addassetsmain(url: '/add/asset/icv1', data: map);
    //         }
    //       }
    //     }
    //   }
    // }
    ///temp off
    ///for stock updation of non stock
    ///danger

/////end
    ////for stock updation that their is stock
    for (int i = 0; i < viewassetsModel.length; i++) {
      if (viewassetsModel[i].added == "true" &&
          viewassetsModel[i].assetidtaken == "true") {
        Map map = {
          "purchaseId": viewassetsModel[i].id,
          "totalAmount": viewassetsModel[i].price,
          "discount": viewassetsModel[i].discount,
          "assets": [
            {
              "name": viewassetsModel[i].name,
              "assetId": viewassetsModel[i].assetid,
              "productType": assetMasterTable[i].productType,
              "purchaseAmount": viewassetsModel[i].price,
              "quantity": viewassetsModel[i].quantity,
              "description": assetMasterTable[i].description,
            }
          ]
        };

        addAssetMainModel = await AuthRepository()
            .addassetsmain(url: '/add/asset/icv1', data: map);
        // print(addAssetMainModel);
      }
    }

    emit(RefreshAssests());
    emit(SyncOfflineDatasuccess());
    // emit(RefreshAssests());
    // Fluttertoast.showToast(msg: "No assest Available ");
  }

/////for assets edits
  Future<FutureOr<void>> _getSyncAssetsEditData(
      GetSyncAssetsEditData event, Emitter<SyncOfflineDataState> emit) async {
    List<ViewassetsModel> viewassetsModel = [];
    List<AssetMasterTable> assetMasterTable = [];

    DatabaseHelper? db = DatabaseHelper.instance;
    viewassetsModel = await db.getViewAssetsDownloadData();
    print(viewassetsModel);

    AssetsEditModel assetsEditModel;

    assetMasterTable = await db.getAssetMasterTableDownloadData();
    for (int i = 0; i < viewassetsModel.length; i++) {
      if (viewassetsModel[i].edited == "true" &&
          viewassetsModel[i].added == "false") {
        Map map = {
          "assetId": assetMasterTable[i].id,
          "name": viewassetsModel[i].name,
          "description": assetMasterTable[i].description,
        };

        assetsEditModel =
            await AuthRepository().assetsedit(url: '/asset/edit', data: map);
        print(assetsEditModel);
      }
    }

    ///
    emit(RefreshAssests());
    emit(SyncOfflineDatasuccess());
    // emit(RefreshAssests());
    // Fluttertoast.showToast(msg: "No assest Available ");
  }

//////productsedit
  ///
  ///
  Future<FutureOr<void>> _getProductEditData(
      GetProductEditData event, Emitter<SyncOfflineDataState> emit) async {
    List items51 = await getproductmastertabletabledata();
    print(items51);
    List items54 = await getproductstocktabledata();
    print(items54);
    List items52 = await getproductunittabledata();
    print(items52);
    List items53 = await getproductsubunittabledata();
    print(items53);

    for (int i = 0; i < items51.length; i++) {
      if (items51[i]['change'] == "true") {


      }
    }

    ///
    emit(RefreshAssests());
    emit(SyncOfflineDatasuccess());
   
  }

//////////////////////////////////////////////////start the
////for sync full data
  Future<FutureOr<void>> _fetchSyncallData(
      FetchSyncallData event, Emitter<SyncOfflineDataState> emit) async {
    DatabaseHelper? db = DatabaseHelper.instance;
    List items21 = [];
    AddAssetMainModel addAssetMainModel;
    AssetsEditModel assetsEditModel;
    List<ViewassetsModel> viewassetsModel = [];
    List<AssetMasterTable> assetMasterTable = [];

    AddAssetNoStockModel addAssetNoStockModel;
    items21 = await db.getICAddAssetsListDownloadData();
    print(items21);

    if (items21.length != 0) {
      var data = jsonDecode(items21[0]['data']);
      print(items21.length.toString() + "length");
      print(data.length.toString() + "df");
      print(data['purchaseId']);
      print(data['assets'].length);
      print(data['assets'][0]['quantity']);

      List<ViewassetsModel> viewassetsModel = [];
      List<AssetMasterTable> assetMasterTable = [];

      viewassetsModel = await db.getViewAssetsDownloadData();
      // print(viewassetsModel);

      // for (int i = 0; i < viewassetsModel.length; i++) {
      //   for (int m = 0; m < items21.length; m++) {
      //     var data = jsonDecode(items21[m]['data']);

      //     if (data['purchaseId'] == viewassetsModel[i].purchaseid) {
      //       print(i);
      //       print("qwerty");

      //       addAssetMainModel = await AuthRepository().addassetsmain(
      //           url: '/add/asset/icv1', data: jsonDecode(items21[m]['data']));
      //     }
      //   }
      // }
      ///needed
      for (int a = 0; a < viewassetsModel.length; a++) {
        for (int n = 0; n < items21.length; n++) {
          if (viewassetsModel[a].added == "true" &&
              viewassetsModel[a].edited == "false" &&
              viewassetsModel[a].assetidtaken == "false") {
            var data = jsonDecode(items21[n]['data']);

            if (data['purchaseId'] == viewassetsModel[a].purchaseid) {
              print(a);
              print("qwerty");

              addAssetMainModel = await AuthRepository().addassetsmain(
                  url: '/add/asset/icv1', data: jsonDecode(items21[n]['data']));
            }
          }
        }
      }
//////newly added and assest id reused
      for (int a = 0; a < viewassetsModel.length; a++) {
        for (int n = 0; n < items21.length; n++) {
          if (viewassetsModel[a].added == "true" &&
              viewassetsModel[a].edited == "false" &&
              viewassetsModel[a].assetidtaken == "true") {
            var data = jsonDecode(items21[n]['data']);

            if (data['purchaseId'] == viewassetsModel[a].purchaseid) {
              print(a);
              print("qwerty");

              addAssetNoStockModel = await AuthRepository().addassetsnostock(
                  url: '/add/asset/icv1', data: jsonDecode(items21[n]['data']));

              if (addAssetNoStockModel.status == true) {
                if (addAssetNoStockModel.bill.purchaseId ==
                    viewassetsModel[a].purchaseid) {
                  Map map = {
                    "purchaseId": viewassetsModel[a].id,
                    "totalAmount": viewassetsModel[a].price,
                    "discount": viewassetsModel[a].discount,
                    "assets": [
                      for (int m = 0;
                          m < addAssetNoStockModel.bill.purchase.length;
                          m++)
                        {
                          "name": viewassetsModel[a].name,
                          "assetId":
                              addAssetNoStockModel.bill.purchase[m].assetId,
                          "productType": "Non consumable",
                          "purchaseAmount": viewassetsModel[a].price,
                          "quantity": viewassetsModel[a].quantity,
                          "description": "sckm",
                        }
                    ]
                  };

                  ///
                  addAssetMainModel = await AuthRepository()
                      .addassetsmain(url: '/add/asset/icv1', data: map);

                  if (addAssetMainModel.status == true) {
                    await db.updatenewassetsdata(
                        "false", "false", viewassetsModel[a].assetid);
                  }
                }
              }
            }
          }
        }
      }
    }

////newly added and edited
    ///
    // for (int a = 0; a < viewassetsModel.length; a++) {
    //   for (int n = 0; n < items21.length; n++) {
    //     if (viewassetsModel[a].added == "true" &&
    //         viewassetsModel[a].edited == "true" &&
    //         viewassetsModel[a].assetidtaken == "false") {
    //       var data = jsonDecode(items21[n]['data']);

    //       if (data['purchaseId'] == viewassetsModel[a].purchaseid) {
    //         print(a);
    //         print("qwerty");

    //         addAssetMainModel = await AuthRepository().addassetsmain(
    //             url: '/add/asset/icv1', data: jsonDecode(items21[n]['data']));
    //       }
    //     }
    //   }
    // }
/////only edited
    ///
    ///edit start
    viewassetsModel = await db.getViewAssetsDownloadData();
    assetMasterTable = await db.getAssetMasterTableDownloadData();
    for (int i = 0; i < viewassetsModel.length; i++) {
      if (viewassetsModel[i].edited == "truewe" &&
          viewassetsModel[i].added == "false" &&
          viewassetsModel[i].assetidtaken == "false") {
        Map map = {
          "assetId": assetMasterTable[i].id,
          "name": viewassetsModel[i].name,
          "description": assetMasterTable[i].description,
        };

        assetsEditModel =
            await AuthRepository().assetsedit(url: '/asset/edit', data: map);

        if (assetsEditModel.status == true) {
          await db.updateassetsdata(
              viewassetsModel[i].name, "false", assetMasterTable[i].id);
        }
      }
    }
/////
    ///edit end
    emit(RefreshAssests());
    emit(SyncOfflineDatasuccess());
  }
}
