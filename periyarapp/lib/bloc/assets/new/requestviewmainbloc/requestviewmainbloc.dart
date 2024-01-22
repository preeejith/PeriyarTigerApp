import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/new/requestviewmainbloc/requestviewmainevent.dart';
import 'package:parambikulam/bloc/assets/new/requestviewmainbloc/requestviewmainstate.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/requestviewmainmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class GetViewRequestMainBloc
    extends Bloc<ViewRequestMainEvent, ViewRequestMainState> {
  GetViewRequestMainBloc() : super(ViewRequestMainState()) {
    on<GetViewRequestMainEvent>(_getViewRequestMainEvent);

    on<FetchViewRequestMainEvent>(_fetchViewRequestMainEvent);
    on<RefreshViewRequestMainEvent>(_refreshViewRequestMainEvent);

    on<FetchofflineRequestMainEvent>(_fetchofflineRequestMainEvent);
    on<GetofflineRequestMainEvent>(_getofflineRequestMainEvent);
  }

  Future<FutureOr<void>> _getViewRequestMainEvent(
      GetViewRequestMainEvent event, Emitter<ViewRequestMainState> emit) async {
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

    Map map = {
      "filters": event.filters,
    };

//////////

    response = await AuthRepository()
        .viewrequestmain(url: '/view/all/requestv1', data: map);
    if (response['status'] == true) {
      await db.addICRequestViewListdata(jsonEncode(response));

      // Fluttertoast.showToast(msg: "Download Success");
    } else {}
  }

  Future<FutureOr<void>> _fetchViewRequestMainEvent(
      FetchViewRequestMainEvent event,
      Emitter<ViewRequestMainState> emit) async {
    ViewRequestMainModel viewRequestMainModel;

    DatabaseHelper? db = DatabaseHelper.instance;

    viewRequestMainModel = await db.getICRequestViewListDownloadData();
    // print(viewRequestMainModel.data![0].status.toString());
    emit(ViewRequestMainSuccess(viewRequestMainModel: viewRequestMainModel));
  }

  Future<FutureOr<void>> _refreshViewRequestMainEvent(
      RefreshViewRequestMainEvent event,
      Emitter<ViewRequestMainState> emit) async {
    // print(viewRequestMainModel.data![0].status.toString());
    emit(RefreshRequestMainEmpty());
  }

  Future<FutureOr<void>> _fetchofflineRequestMainEvent(
      FetchofflineRequestMainEvent event,
      Emitter<ViewRequestMainState> emit) async {
    ViewRequestMainModel viewRequestMainModel;
    Map map = {
      // "filters": "",
    };

    viewRequestMainModel = await AuthRepository()
        .viewrequestmain2(url: '/view/all/requestv1', data: map);

    if (viewRequestMainModel.data!.isNotEmpty) {
      deletemasterviewtable();

      await deletestockupdations();
      await deletenewpurchase();
      await deletedamage();
      await deleterepair();
      for (int i = 0; i < viewRequestMainModel.data!.length; i++) {
        final typeOfRequest =
            viewRequestMainModel.data![i].productIds!.isNotEmpty
                ? viewRequestMainModel.data![i].productIds![0].typeOfRequest
                : "damage";
        final untiId = viewRequestMainModel.data![i].unitId!.id.toString();
        final unitName = viewRequestMainModel.data![i].unitId!.name.toString();
        final date = viewRequestMainModel.data![i].createDate.toString();
        final status = viewRequestMainModel.data![i].mainstatus;

        final requestid = viewRequestMainModel.data![i].id;

        if (untiId.isEmpty) {
          return 0;
        } else {
          Map data = {
            "typeOfRequest": typeOfRequest,
            "untiId": untiId,
            "unitName": unitName,
            "date": date,
            "status": status,
            "requestid": requestid,
          };
          print(data);
          masterviewtableadd(data);
        }
      }

      ///for stock updation
      ///
      ///here we want to convert it into the type
      for (int i = 0; i < viewRequestMainModel.data!.length; i++) {
        if (viewRequestMainModel.data![i].productIds!.isNotEmpty) {
          if (viewRequestMainModel.data![i].productIds![0].typeOfRequest ==
              'stock Updation') {
            for (int j = 0;
                j < viewRequestMainModel.data![i].productIds!.length;
                j++) {
              for (int k = 0;
                  k <
                      viewRequestMainModel
                          .data![i].productIds![j].myStock!.length;
                  k++) {
                final typeOfRequest =
                    viewRequestMainModel.data![i].productIds![j].typeOfRequest;
                final untiId =
                    viewRequestMainModel.data![i].unitId!.id.toString();
                final unitName =
                    viewRequestMainModel.data![i].unitId!.name.toString();
                final date =
                    viewRequestMainModel.data![i].createDate.toString();
                final status =
                    viewRequestMainModel.data![i].productIds![j].requestStatus;

                final requestid =
                    viewRequestMainModel.data![i].productIds![0].requestId;
                final product = viewRequestMainModel
                    .data![i].productIds![j].myStock![k].assetId!.name;
                final quantity =
                    viewRequestMainModel.data![i].productIds![j].quantity;
                final productid = viewRequestMainModel
                    .data![i].productIds![j].myStock![k].assetId!.id;
                final change = "false";

                if (untiId.isEmpty) {
                  return 0;
                } else {
                  Map data = {
                    "typeOfRequest": typeOfRequest,
                    "untiId": untiId,
                    "unitName": unitName,
                    "date": date,
                    "status": status,
                    "requestid": requestid,
                    "product": product,
                    "quantity": quantity,
                    "assetid": productid,
                    "change": change,
                  };
                  print(data);
                  stockupdationviewtable(data);
                }
              }
            }
          }
        }
      }
      for (int i = 0; i < viewRequestMainModel.data!.length; i++) {
        if (viewRequestMainModel.data![i].productIds!.isNotEmpty) {
          if (viewRequestMainModel.data![i].productIds![0].typeOfRequest ==
              'New Purchase') {
            for (int j = 0;
                j < viewRequestMainModel.data![i].productIds!.length;
                j++) {
              // if (viewRequestMainModel.data![i].productIds![j].typeOfRequest ==
              //     'New Purchase') {

              final idid = viewRequestMainModel.data![i].productIds![j].id;
              final typeOfRequest =
                  viewRequestMainModel.data![i].productIds![j].typeOfRequest;
              final untiId =
                  viewRequestMainModel.data![i].unitId!.id.toString();
              final unitName =
                  viewRequestMainModel.data![i].unitId!.name.toString();
              final date = viewRequestMainModel.data![i].createDate.toString();
              final status = viewRequestMainModel.data![i].mainstatus;

              final requestid =
                  viewRequestMainModel.data![i].productIds![j].requestId;
              final product = viewRequestMainModel.data![i].productIds![j].name;
              final quantity =
                  viewRequestMainModel.data![i].productIds![j].quantity;
              final remark =
                  viewRequestMainModel.data![i].productIds![j].remark == null
                      ? ""
                      : viewRequestMainModel.data![i].productIds![j].remark;
              final change = "false";
              final quantity2 = "0";
              final assetname2 = "a";

              if (untiId.isEmpty) {
                return 0;
              } else {
                Map data = {
                  "typeOfRequest": typeOfRequest,
                  "untiId": untiId,
                  "unitName": unitName,
                  "date": date,
                  "status": status,
                  "requestid": requestid,
                  "product": product,
                  "quantity": quantity,
                  "change": change,
                  "quantity2": quantity2,
                  "assetname2": assetname2,
                  "remark": remark,
                  "idid": idid
                };
                print(data);
                newpurchasetableview(data);
              }
              // }
              /////
            }
          }
        }
      }

      for (int l = 0; l < viewRequestMainModel.data!.length; l++) {
        ///damage
        ///
        ///
        if (viewRequestMainModel.data![l].productIds!.isNotEmpty) {
          if (viewRequestMainModel.data![l].productIds![0].typeOfRequest ==
              'damage') {
            for (int j = 0;
                j < viewRequestMainModel.data![l].productIds!.length;
                j++) {
              // if (viewRequestMainModel.data![l].productIds![j].typeOfRequest ==
              //     'damage') {
              final typeOfRequest =
                  viewRequestMainModel.data![l].productIds![j].typeOfRequest;
              final untiId =
                  viewRequestMainModel.data![l].unitId!.id.toString();
              final unitName =
                  viewRequestMainModel.data![l].unitId!.name.toString();
              final date = viewRequestMainModel.data![l].createDate.toString();
              final status = viewRequestMainModel.data![l].mainstatus;

              final requestid =
                  viewRequestMainModel.data![l].productIds![j].requestId;
              final product = viewRequestMainModel.data![l].productIds![j].name;
              final quantity =
                  viewRequestMainModel.data![l].productIds![j].quantity;
              final description =
                  viewRequestMainModel.data![l].description == ""
                      ? ""
                      : viewRequestMainModel.data![l].description.toString();
              final change = "false";
              final assetid = viewRequestMainModel
                  .data![l].productIds![j].productId
                  .toString();

              if (untiId.isEmpty) {
                return 0;
              } else {
                Map data = {
                  "typeOfRequest": typeOfRequest,
                  "untiId": untiId,
                  "unitName": unitName,
                  "date": date,
                  "status": status,
                  "requestid": requestid,
                  "product": product,
                  "quantity": quantity,
                  "description": description,
                  "change": change,
                  "assetid": assetid
                };
                print(data);
                damageview(data);
              }
              // }
            }
          }
        }
      }
      for (int r = 0; r < viewRequestMainModel.data!.length; r++) {
        if (viewRequestMainModel.data![r].productIds!.isNotEmpty) {
          if (viewRequestMainModel.data![r].productIds![0].typeOfRequest ==
              'repair') {
            for (int j = 0;
                j < viewRequestMainModel.data![r].productIds!.length;
                j++) {
              // if (viewRequestMainModel.data![r].productIds![j].typeOfRequest ==
              //     'repair') {
              final typeOfRequest =
                  viewRequestMainModel.data![r].productIds![j].typeOfRequest;
              final untiId =
                  viewRequestMainModel.data![r].unitId!.id.toString();
              final unitName =
                  viewRequestMainModel.data![r].unitId!.name.toString();
              final date = viewRequestMainModel.data![r].createDate.toString();
              final status = viewRequestMainModel.data![r].mainstatus;

              final requestid =
                  viewRequestMainModel.data![r].productIds![j].requestId;
              final product = viewRequestMainModel.data![r].productIds![j].name;
              final quantity =
                  viewRequestMainModel.data![r].productIds![j].quantity;
              final description =
                  viewRequestMainModel.data![r].description == ""
                      ? ""
                      : viewRequestMainModel.data![r].description.toString();
              final change = "false";
              final assetid = viewRequestMainModel
                  .data![r].productIds![j].productId
                  .toString();

              if (untiId.isEmpty) {
                return 0;
              } else {
                Map data = {
                  "typeOfRequest": typeOfRequest,
                  "untiId": untiId,
                  "unitName": unitName,
                  "date": date,
                  "status": status,
                  "requestid": requestid,
                  "product": product,
                  "quantity": quantity,
                  "description": description,
                  "change": change,
                  "assetid": assetid
                };
                print(data);
                repairview(data);
              }
              // }
            }
          }
        }
      }

      //
      //else if (viewRequestMainModel
      //         .data![i].productIds![j].typeOfRequest ==
      //     'repair') {
      //   final typeOfRequest =
      //       viewRequestMainModel.data![i].productIds![j].typeOfRequest;
      //   final untiId =
      //       viewRequestMainModel.data![i].unitId!.id.toString();
      //   final unitName =
      //       viewRequestMainModel.data![i].unitId!.name.toString();
      //   final date = viewRequestMainModel.data![i].createDate.toString();
      //   final status = viewRequestMainModel.data![i].mainstatus;

      //   final requestid =
      //       viewRequestMainModel.data![i].productIds![j].requestId;
      //   final product = viewRequestMainModel.data![i].productIds![j].name;
      //   final quantity =
      //       viewRequestMainModel.data![i].productIds![j].quantity;
      //   final description =
      //       viewRequestMainModel.data![i].description == ""
      //           ? ""
      //           : viewRequestMainModel.data![i].description.toString();

      //   if (untiId.isEmpty) {
      //     return 0;
      //   } else {
      //     Map data = {
      //       "typeOfRequest": typeOfRequest,
      //       "untiId": untiId,
      //       "unitName": unitName,
      //       "date": date,
      //       "status": status,
      //       "requestid": requestid,
      //       "product": product,
      //       "quantity": quantity,
      //       "description": description
      //     };
      //     print(data);
      //     repairview(data);
      //   }
      // }
      emit(RequestDataDownloadedSuccesfully());
    }
  }

  Future<FutureOr<void>> _getofflineRequestMainEvent(
      GetofflineRequestMainEvent event,
      Emitter<ViewRequestMainState> emit) async {
    DatabaseHelper? db = DatabaseHelper.instance;

    List<ViewassetsModel> viewassetsModel = [];
    List<AssetMasterTable> assetMasterTable = [];
//////////

    /////
    viewassetsModel = await db.getViewAssetsDownloadData();
    // print(viewassetsModel);
    assetMasterTable = await db.getAssetMasterTableDownloadData();

///////////
    List items42 = await getAllmasterviewtabledata();
    print("hh");
    print(items42);
    List items43 = await getAllstockupdationdata();
    print(items43);
    List items44 = await getAllnewpurchasedata();
    print(items44);
    List items45 = await getAllrepairdata();
    print(items45);
    List items46 = await getAlldamagedata();
    print(items46);

    emit(GettingdataSuccess(
        items42: items42,
        items43: items43,
        items44: items44,
        items45: items45,
        items46: items46,
        viewassetsModel: viewassetsModel,
        assetMasterTable: assetMasterTable));
  }
}
