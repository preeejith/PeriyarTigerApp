// ignore_for_file: unnecessary_statements

import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/data/models/echoshopdownloadmodel.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class GetEchoShopPlaceOrderBloc
    extends Bloc<EchoShopPlaceOrderEvent, EchoShopPlaceOrderState> {
  DatabaseHelper db = DatabaseHelper.instance;
  GetEchoShopPlaceOrderBloc() : super(EchoShopPlaceOrderState()) {
    on<PlaceOrder>(_getEcoShopPlaceOrder);
  }

  Future<FutureOr<void>> _getEcoShopPlaceOrder(
      PlaceOrder event, Emitter<EchoShopPlaceOrderState> emit) async {
    emit(EchoShopPlacingOrder());
    var uploadData = await db.getPlaceorderData();

    for (int i = 0; i < uploadData.length; i++) {
      var response =
          await WebClient.post('/add/sales', jsonDecode(uploadData[i]['data']));
      if (response['status'] == true) {
        try {
          await db.deleteOneCartData(uploadData[i]['orderId']);
          //  await updateQuantity(jsonDecode(uploadData[i]['data']));
        } catch (e) {
          print(e);
        }
      } else {
        Fluttertoast.showToast(msg: response['msg']);
      }
    }
    uploadData.length != 0 ? Fluttertoast.showToast(msg: "Upload Success") : {};

    emit(UploadDone());
  }

  updateQuantity(items) async {
    EchoShopProductDownloadModel echoShopProductDownloadModel =
        await db.getEchoDownloadData();
    for (int i = 0; i < echoShopProductDownloadModel.data!.length; i++) {
      for (int j = 0;
          j < echoShopProductDownloadModel.data![i].details!.length;
          j++) {
        for (int k = 0;
            k <
                echoShopProductDownloadModel
                    .data![i].details![j].product!.length;
            k++) {
          for (int l = 0; l < items['items'].length; l++) {
            if (echoShopProductDownloadModel
                    .data![i].details![j].product![k].id ==
                items['items'][l]['itemId']) {
              echoShopProductDownloadModel.data![i].details![j].product![k]
                  .totalQuantity = (int.parse(echoShopProductDownloadModel
                          .data![i].details![j].product![k].totalQuantity
                          .toString()) -
                      int.parse(items['items'][l]['quantity'].toString()))
                  .toInt();
            }
          }
        }
      }
    }
    await db.addEchoData(jsonEncode(echoShopProductDownloadModel));
  }
}

//events

class EchoShopPlaceOrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaceOrder extends EchoShopPlaceOrderEvent {
  @override
  List<Object> get props => [];
  final Map? data;
  PlaceOrder({this.data});
}

//states

class EchoShopPlaceOrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class EchoShopPlaceOrderInitial extends EchoShopPlaceOrderState {}

class UploadDone extends EchoShopPlaceOrderState {}

class EchoShopPlacingOrder extends EchoShopPlaceOrderState {
  @override
  List<Object> get props => [];
}
