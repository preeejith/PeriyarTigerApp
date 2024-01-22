import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewbloc/purchaseviewevent.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewbloc/purchaseviewstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';

import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/purchaseorderviewmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/viewpurchaseordermodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';

class GetViewPurchaseOrderBloc
    extends Bloc<ViewPurchaseOrderEvent, ViewPurchaseOrderState> {
  GetViewPurchaseOrderBloc() : super(ViewPurchaseOrderState()) {
    on<GetViewPurchaseOrderEvent>(_getViewPurchaseOrderEvent);
    on<FetchViewPurchaseOrderEvent>(_fetchViewPurchaseOrderEvent);
    on<FetchOfflinePurchaseOrderEvent>(_fetchOfflinePurchaseOrderEvent);
    on<RefreshOfflinePurchaseOrderEvent>(_refreshOfflinePurchaseOrderEvent);

    on<RefreshOfflinePurchaseOrder2Event>(_refreshOfflinePurchaseOrder2Event);
  }

  Future<FutureOr<void>> _getViewPurchaseOrderEvent(
      GetViewPurchaseOrderEvent event,
      Emitter<ViewPurchaseOrderState> emit) async {
    emit(PurchaseListing());
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

    response = await AuthRepository()
        .viewpurchaseorder(url: '/purchase/getlist/assets');
    if (response['status'] == true) {
      await db.addICPurchaseListdata(jsonEncode(response));
    } else {
      emit(ViewPurchaseOrderError());
    }
  }

////
  Future<FutureOr<void>> _fetchViewPurchaseOrderEvent(
      FetchViewPurchaseOrderEvent event,
      Emitter<ViewPurchaseOrderState> emit) async {
    ViewPurchaseListModel viewPurchaseListModel;
    DatabaseHelper? db = DatabaseHelper.instance;
    PurchaseOrder purchaseOrder = PurchaseOrder();
    PurchaseData purchaseData = PurchaseData();

    ///null value taking
    viewPurchaseListModel = await AuthRepository()
        .viewpurchaseorder(url: '/purchase/getlist/assets');

    if (viewPurchaseListModel.status = true) {
      await db.deletePurchasedata();
      await db.deletePurchaseassetsdata();

      if (viewPurchaseListModel.data != null) {
        ////root is not working
        for (int j = 0; j < viewPurchaseListModel.data!.length; j++) {
          purchaseOrder.status =
              viewPurchaseListModel.data![j].status.toString();
          purchaseOrder.id = viewPurchaseListModel.data![j].id.toString();
          purchaseOrder.employeeId =
              viewPurchaseListModel.data![j].employeeId.toString();
          purchaseOrder.purchaseId =
              viewPurchaseListModel.data![j].purchaseId.toString();
          purchaseOrder.assetId = "0";

          purchaseOrder.assetname = "0";

          purchaseOrder.totalAmount =
              viewPurchaseListModel.data![j].totalAmount.toString();
          purchaseOrder.discount =
              viewPurchaseListModel.data![j].discount.toString();
          purchaseOrder.billAmount =
              viewPurchaseListModel.data![j].billAmount.toString();
          purchaseOrder.createDate =
              viewPurchaseListModel.data![j].createDate.toString();
          purchaseOrder.quantity = "0";

          purchaseOrder.purchaseAmount = "0";
//////
          for (int k = 0;
              k < viewPurchaseListModel.data![j].purchase!.length;
              k++) {
            purchaseData.purchaseid =
                viewPurchaseListModel.data![j].id.toString();
            purchaseData.name = viewPurchaseListModel
                .data![j].purchase![k].assetId!.name
                .toString();
            purchaseData.purchaseAmount = viewPurchaseListModel
                .data![j].purchase![k].purchaseAmount
                .toString();
//////////
            purchaseData.quantity =
                viewPurchaseListModel.data![j].purchase![k].quantity.toString();
            purchaseData.assetId = viewPurchaseListModel
                .data![j].purchase![k].assetId!.id
                .toString();

            await db.addPurchasedata(purchaseData);
          }
          await db.addPurchaseassetsdata(purchaseOrder);
        }
      }
    }
    emit(FetchPurchaseSuccess());
  }

  ///
////for viewing datas

  Future<FutureOr<void>> _fetchOfflinePurchaseOrderEvent(
      FetchOfflinePurchaseOrderEvent event,
      Emitter<ViewPurchaseOrderState> emit) async {
    ViewPurchaseListModel viewPurchaseListModel;
    DatabaseHelper? db = DatabaseHelper.instance;
    viewPurchaseListModel = await db.getICPurchaseListDownloadData();
    emit(
        ViewPurchaseOrderSuccess(viewPurchaseListModel: viewPurchaseListModel));
  }

/////
  Future<FutureOr<void>> _refreshOfflinePurchaseOrderEvent(
      RefreshOfflinePurchaseOrderEvent event,
      Emitter<ViewPurchaseOrderState> emit) async {
    DatabaseHelper? db = DatabaseHelper.instance;

    List<PurchaseData> purchaseData = [];
    List<PurchaseOrder> purchaseOrder = [];
    List<AssetMasterTable> assetMasterTable = [];

    ///for showing the tables data
    ///

    purchaseData = await db.getPurchasedataDownloadData();
    // print(purchaseData);
    purchaseOrder = await db.getPurchaseassetsDownloadData();
    // print(purchaseOrder);
    assetMasterTable = await db.getAssetMasterTableDownloadData();
    // print(assetMasterTable);

    // emit(RefreshState());
    // for (int r = 0; r < purchaseOrder.length; r++) {

    //   viewPurchaseListModel.data=;
    //   viewPurchaseListModel.data![r].billAmount =
    //       int.parse(purchaseOrder[r].assetId.toString());
    //   viewPurchaseListModel.data![r].status = purchaseOrder[r].status;

    //       viewPurchaseListModel.data![r]. = purchaseOrder[r].status;
    //   ;
    // }
    ///
    emit(RefreshStateSucces(
        purchaseData: purchaseData,
        purchaseOrder: purchaseOrder,
        assetMasterTable: assetMasterTable));
  }

  /////for refresh
  ///
  Future<FutureOr<void>> _refreshOfflinePurchaseOrder2Event(
      RefreshOfflinePurchaseOrder2Event event,
      Emitter<ViewPurchaseOrderState> emit) async {
    emit(RefreshStateSucces2());
  }
}
