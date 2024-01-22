import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/profilebloc/viewprofileevent.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofilestate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/viewprofilemodel.dart';
//////
import 'package:parambikulam/local/db/dbhelper.dart';

import '../../../data/models/assetsmodel/echoshopmodel/echosalesdetailedmodel.dart';

class GetViewProfileBloc extends Bloc<ViewProfileEvent, ViewProfileState> {
  GetViewProfileBloc() : super(ViewProfileState()) {
    on<GetViewProfileEvent>(_getViewProfileEvent);
    on<GetSalesDetailedEvent>(_getSalesDetailedEvent);
    on<FetchOfflineProfileData>(_fetchOfflineProfileData);
  }
//download profile data
  Future<FutureOr<void>> _getViewProfileEvent(
      GetViewProfileEvent event, Emitter<ViewProfileState> emit) async {
    dynamic response;

    emit(ProfileDownloadedRefresh());
    DatabaseHelper? db = DatabaseHelper.instance;

    response = await AuthRepository().viewprofile(url: '/employee/user/me');
    if (response['status'] == true) {
      await db.addIBProfileViewData(jsonEncode(response));

      emit(ProfileDownloadedSuccess());
    } else {}
  }

  Future<FutureOr<void>> _getSalesDetailedEvent(
      GetSalesDetailedEvent event, Emitter<ViewProfileState> emit) async {
    dynamic response;
    SalesdetailedModel salesdetailedModel;
    emit(SalesDetailedFetching());
    DatabaseHelper? db = DatabaseHelper.instance;
    Map map = {"salesId": event.salesid};
    salesdetailedModel = await AuthRepository()
        .salesdetailed(url: '/view/sales/details', data: map);
    if (salesdetailedModel.status == true) {
      for (int i = 0; i < salesdetailedModel.data!.length; i++) {
        Map map = {
          "index": event.count.toString(),
          "status": salesdetailedModel.data![i].status.toString(),
          "_id": salesdetailedModel.data![i].sId.toString(),
          "saleId": salesdetailedModel.data![i].saleId.toString(),
          "stockId": salesdetailedModel.data![i].stockId.toString(),
          "quantity": salesdetailedModel.data![i].quantity.toString(),
          "salesPrice": salesdetailedModel.data![i].salesPrice.toString(),
          "discount": salesdetailedModel.data![i].discount.toString(),
          "create_date": salesdetailedModel.data![i].createDate.toString(),
          "itemName": salesdetailedModel.data![i].itemName.toString()
        };
        await db.addEchoSalesDetailedReport(map);
      }

      // await db.addIBProfileViewData(jsonEncode(response));

      emit(SalesDetailedSuccess());
    } else {
      emit(SalesDetailedError());
    }
  }

/////get profile data from local db
  Future<FutureOr<void>> _fetchOfflineProfileData(
      FetchOfflineProfileData event, Emitter<ViewProfileState> emit) async {
    emit(Checking());
    ViewProfileModel viewProfileModel;

    DatabaseHelper? db = DatabaseHelper.instance;

    viewProfileModel = await db.getIbProfileDownloadData();
    emit(ViewProfileSuccess(viewProfileModel: viewProfileModel));
  }
}
