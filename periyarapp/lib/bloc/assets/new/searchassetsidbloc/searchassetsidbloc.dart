// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/new/searchassetsidbloc/searchassetsidevent.dart';
import 'package:parambikulam/bloc/assets/new/searchassetsidbloc/searchassetsidstate.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';

import 'package:parambikulam/local/db/dbhelper.dart';

class GetSearchAssetsBloc extends Bloc<SearchAssetsEvent, SearchAssetsState> {
  GetSearchAssetsBloc() : super(SearchAssetsState()) {
    on<GetSearchAssets>(_getSearchAssets);
    on<GetUnitSearchAssets>(_getUnitSearchAssets);
  }
//////
  Future<FutureOr<void>> _getSearchAssets(
      GetSearchAssets event, Emitter<SearchAssetsState> emit) async {
    emit(SearchAssetsing());
    DatabaseHelper? db = DatabaseHelper.instance;

    List<AssetMasterTable> assetMasterTable = [];

    assetMasterTable = await db.getAssetMasterTableDownloadData();
    String query = event.keyword.toString();

    List<AssetMasterTable> assetMasterSuggestion = [];
/////
    assetMasterSuggestion = assetMasterTable
        .where(
          (data) =>
              data.name!.toLowerCase().contains(query.toLowerCase()) ||
              data.name!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    print(assetMasterSuggestion);
    query.isNotEmpty
        ? emit(
            SearchAssetssuccess(assetMasterSuggestion: assetMasterSuggestion))
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

  /////for search inside the units
  ///
  Future<FutureOr<void>> _getUnitSearchAssets(
      GetUnitSearchAssets event, Emitter<SearchAssetsState> emit) async {
    emit(SearchAssetsing());
    DatabaseHelper? db = DatabaseHelper.instance;

    List<AssetMasterTable> assetMasterTable = [];

    assetMasterTable = await db.getAssetMasterTableDownloadData();
    String query = event.keyword.toString();

    List<AssetMasterTable> assetMasterSuggestion = [];
/////
    assetMasterSuggestion = assetMasterTable
        .where(
          (data) =>
              data.name!.toLowerCase().contains(query.toLowerCase()) ||
              data.name!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    print(assetMasterSuggestion);
    query.isNotEmpty
        ? emit(
            SearchAssetssuccess(assetMasterSuggestion: assetMasterSuggestion))
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
