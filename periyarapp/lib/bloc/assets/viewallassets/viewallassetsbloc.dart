import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectid/objectid.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsevent.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsstate.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/viewallassetsmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

////////
class GetViewallAssetsBloc
    extends Bloc<ViewallAssetsEvent, ViewallAssetsState> {
  GetViewallAssetsBloc() : super(ViewallAssetsState()) {
    on<GetViewallAssetsEvent>(_getViewallAssetsEvent);
    on<FetchViewallAssetsEvent>(_fetchViewallAssetsEvent);

    on<FetchAssetsdataEvent>(_fetchAssetsEvent);
    on<RefreshViewallAssetsEvent>(_refreshViewallAssetsEvent);
    on<GetUnitSearchAssets>(_getUnitSearchAssets);
    //  on<RefreshingUnitSearchAssets>(_refreshingUnitSearchAssets);
  }

  Future<FutureOr<void>> _getViewallAssetsEvent(
      GetViewallAssetsEvent event, Emitter<ViewallAssetsState> emit) async {
    emit(RefreshStateDownload());
    DatabaseHelper? db = DatabaseHelper.instance;
    ViewAllAssetsModel viewAllAssetsModel;
    String? purchaseidid = ObjectId().toString();

    ViewassetsModel viewassetsModel = ViewassetsModel();
    AssetMasterTable assetMasterTable = AssetMasterTable();

    viewAllAssetsModel =
        await AuthRepository().viewallassets(url: '/view/all/assets');
//
    if (viewAllAssetsModel.status == true) {
      await db.deleteViewAssetsdata();
      await db.deleteViewAssetMasterTabledata();

      for (int i = 0; i < viewAllAssetsModel.data.length; i++) {
        viewassetsModel.quantity =
            viewAllAssetsModel.data[i].quantity.toString();
        viewassetsModel.assetid =
            viewAllAssetsModel.data[i].assetId.id.toString();
        viewassetsModel.price = viewAllAssetsModel.data[i].price.toString();

        viewassetsModel.name =
            viewAllAssetsModel.data[i].assetId.name.toString();
        viewassetsModel.discount =
            viewAllAssetsModel.data[i].discount.toString();
        viewassetsModel.status = "true";
        viewassetsModel.id = viewAllAssetsModel.data[i].id;
        viewassetsModel.checkon = viewAllAssetsModel.data[i].checkon.toString();
        viewassetsModel.createDate = viewAllAssetsModel.data[i].createDate;
        viewassetsModel.unitId = viewAllAssetsModel.data[i].unitId;
        viewassetsModel.edited = "false";
        viewassetsModel.added = "false";
        viewassetsModel.assetidtaken = "false";
        viewassetsModel.purchaseid = purchaseidid;

        assetMasterTable.id = viewAllAssetsModel.data[i].assetId.id.toString();
        assetMasterTable.status =
            viewAllAssetsModel.data[i].assetId.status.toString();
        assetMasterTable.name =
            viewAllAssetsModel.data[i].assetId.name.toString();

        assetMasterTable.productType =
            viewAllAssetsModel.data[i].assetId.productType.toString();
        assetMasterTable.description =
            viewAllAssetsModel.data[i].assetId.description.toString();
        assetMasterTable.createDate =
            viewAllAssetsModel.data[i].assetId.createDate.toString();

        await db.addViewAssetsdata(viewassetsModel);
        await db.addViewAssetMasterTabledata(assetMasterTable);
      }

      emit(DownloadedSuccess());
    }

    //  print(viewassetsModel.assetId.toString());

    // await db.addViewAssetsdata(viewassetsModel);

    // if (viewassetsModel. == true) {
    //   viewassetsModel = viewAllAssetsModel.data.cast<ViewassetsModel>();
    //   print(viewassetsModel);
    // }

    // if (response['status'] == true) {
    //   await db.addICAssetsListdata(jsonEncode(response));
    // } else {
    //   emit(ViewallAssetsError());
    // }
  }

// ///
  Future<FutureOr<void>> _fetchViewallAssetsEvent(
      FetchViewallAssetsEvent event, Emitter<ViewallAssetsState> emit) async {
    // ViewAllAssetsModel viewAllAssetsModel;
    List<ViewassetsModel> viewassetsModel = [];
    List<AssetMasterTable> assetMasterTable = [];
////
    // AssetId assetId;
    DatabaseHelper? db = DatabaseHelper.instance;
    viewassetsModel = await db.getViewAssetsDownloadData();
    print(viewassetsModel);
    assetMasterTable = await db.getAssetMasterTableDownloadData();
    print(assetMasterTable);
    // emit(ViewallAssetsSuccess(viewAllAssetsModel: viewAllAssetsModel));
    // viewAllAssetsModel = await db.getICAssetsListDownloadData();

    // emit(RefreshStateCommon());
    // viewAllAssetsModel.toString() == null.toString()
    //     ? emit(NoDataStateCommon())
    //     :
    // emit(ViewallAssetsSuccess(viewAllAssetsModel: viewAllAssetsModel));
  }

  ViewallAssetsState get initialState => ViewallAssetsInitial();

  Future<FutureOr<void>> _refreshViewallAssetsEvent(
      RefreshViewallAssetsEvent event, Emitter<ViewallAssetsState> emit) async {
    emit(RefreshStateCommon());
  }

  Future<FutureOr<void>> _fetchAssetsEvent(
      FetchAssetsdataEvent event, Emitter<ViewallAssetsState> emit) async {
    ///////
    List<ViewassetsModel> viewassetsModel = [];
    List<AssetMasterTable> assetMasterTable = [];
//////////
    DatabaseHelper? db = DatabaseHelper.instance;
    /////
    viewassetsModel = await db.getViewAssetsDownloadData();
    // print(viewassetsModel);
    assetMasterTable = await db.getAssetMasterTableDownloadData();
    // print(assetMasterTable);
    emit(FetchAssetsSuccess(
        viewassetsModel: viewassetsModel, assetMasterTable: assetMasterTable));
    // viewAllAssetsModel = await db.getICAssetsListDownloadData();

    // emit(RefreshStateCommon());
    // viewAllAssetsModel.toString() == null.toString()
    //     ? emit(NoDataStateCommon())
    //     :
    // emit(ViewallAssetsSuccess(viewAllAssetsModel: viewAllAssetsModel));
  }

  ///for search the assets
  ///
  Future<FutureOr<void>> _getUnitSearchAssets(
      GetUnitSearchAssets event, Emitter<ViewallAssetsState> emit) async {
    emit(SearchAssetsing());
    DatabaseHelper? db = DatabaseHelper.instance;

    List<ViewassetsModel> viewassetsModel = [];
    List<AssetMasterTable> assetMasterTable = [];

//////
    viewassetsModel = await db.getViewAssetsDownloadData();
    // print(viewassetsModel);

    assetMasterTable = await db.getAssetMasterTableDownloadData();
    String query = event.keyword.toString();

    List<AssetMasterTable> assetMasterSuggestion = [];
    List<ViewassetsModel> viewassetssearchModel = [];
    assetMasterTable = await db.getAssetMasterTableDownloadData();
/////
    viewassetssearchModel = viewassetsModel
        .where(
          (data) =>
              data.name!.toLowerCase().contains(query.toLowerCase()) ||
              data.name!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    if (viewassetssearchModel.length != 0) {
      for (int k = 0; k < viewassetssearchModel.length; k++) {
        String query2 = viewassetssearchModel[k].assetid.toString();

        assetMasterSuggestion = assetMasterTable
            .where(
              (data) =>
                  data.id!.toLowerCase().contains(query2.toLowerCase()) ||
                  data.name!.toLowerCase().contains(query2.toLowerCase()),
            )
            .toList();
      }
    }

    print(viewassetssearchModel);

    query.isNotEmpty
        ? emit(SearchAssetssuccess(
            viewassetssearchModel: viewassetssearchModel,
            assetMasterSuggestion: assetMasterSuggestion))
        : SizedBox();
/////////////////
    //  emit(SearchAssetssuccess(assetsIdSearchModel: assetsIdSearchModel));

    // assetsIdSearchModel =
    //     await AuthRepository().searchassetid(url: '/asset/search', data: map);

    // if (assetsIdSearchModel.status == true) {
    //   emit(SearchAssetssuccess(assetsIdSearchModel: assetsIdSearchModel));
    // } else if (assetsIdSearchModel.status == false) {
    //   emit(UnitsError(error: ''));
    // }
  }
}
