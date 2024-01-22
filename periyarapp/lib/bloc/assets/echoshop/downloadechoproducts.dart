import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofilebloc.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofileevent.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:parambikulam/data/models/echoshopdownloadmodel.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';
import 'package:parambikulam/ui/assets/local/model/echoshopsalesrpeortmodel.dart';
import 'package:parambikulam/utils/navigatorservice.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

/////////
class GetEchoShopProductBloc
    extends Bloc<EchoShopProductEvent, EchoShopProductState> {
  GlobalKey scafolldKey = NavigatorService.navigatorKey;
  Directory? newPath2;
  GetEchoShopProductBloc() : super(EchoShopProductState()) {
    on<GetProductsandDownload>(_getEcoShopProductsAndDownload);

    on<GetSalesReport>(_getSalesReport);
    on<OnlineProductsandDownload>(_onlineProductsandDownload);

    on<FetchProductsandDownload>(_fetchProductsandDownload);
    on<ImageDownloadProduct>(_imageDownloadProduct);
  }

  Future<FutureOr<void>> _getEcoShopProductsAndDownload(
      GetProductsandDownload event, Emitter<EchoShopProductState> emit) async {
    emit(ViewingProduct());
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;
    response = await AuthRepository()
        .downloadeEchoProducts(url: '/product/detail/offline');
    if (response['status'] == true) {
      await db.addEchoData(jsonEncode(response));
      emit(ProductDownloadedSuccess());
      // Fluttertoast.showToast(msg: "Download Success");
    } else {
      emit(EchoShopProductError());
    }
  }

  ///major work
  Future<FutureOr<void>> _getSalesReport(
      GetSalesReport event, Emitter<EchoShopProductState> emit) async {
    emit(ViewingSaleReport());
    dynamic response;
    SalesReport salesReport;

    DatabaseHelper? db = DatabaseHelper.instance;
    salesReport =
        await AuthRepository().downloadsalesreport(url: '/sales/report');
    if (salesReport.status == true) {
      await db.addEchoSalesDetaileddeleteallReport();
      for (int i = 0; i < salesReport.data!.length; i++) {
        Map map = {
          "index": i.toString(),
          "isEmployee": salesReport.data![i].isEmployee.toString(),
          "status": salesReport.data![i].status,
          "_id": salesReport.data![i].sId,
          "unitId": salesReport.data![i].unitId,
          "employeeId": salesReport.data![i].employeeId,
          "totalAmount": salesReport.data![i].totalAmount,
          "create_date": salesReport.data![i].createDate,
        };

        await db.addEchoSalesReport(map);

        BlocProvider.of<GetViewProfileBloc>(scafolldKey.currentContext!).add(
            GetSalesDetailedEvent(
                salesid: salesReport.data![i].sId, count: "2"));
      }

      // checkAndCreateEchoShopSalesReport()
      emit(SalereportDownloadedSuccess());
      // Fluttertoast.showToast(msg: "Download Success");
    } else {
      emit(SalesReportError());
    }
  }
/////
  ///for ic  product download

  Future<FutureOr<void>> _onlineProductsandDownload(
      OnlineProductsandDownload event,
      Emitter<EchoShopProductState> emit) async {
    emit(ViewingProduct());
    EchoShopProductDownloadModel echoShopProductDownloadModel;

    echoShopProductDownloadModel = await AuthRepository()
        .downloadeOnlineProducts(url: '/product/detail/offline');
    if (echoShopProductDownloadModel.status == true) {
      await deletefullproductstock();
      await deletefullproductsubunit();
      await deletefullproductunit();
      await deletefullproductmastertable();

      for (int i = 0; i < echoShopProductDownloadModel.data!.length; i++) {
        final pid = echoShopProductDownloadModel.data![i].id.toString();
        final productname =
            echoShopProductDownloadModel.data![i].productname.toString();
        final description =
            echoShopProductDownloadModel.data![i].description.toString();
        final unittype =
            echoShopProductDownloadModel.data![i].unitType.toString();
        final status = echoShopProductDownloadModel.data![i].status.toString();
        final date =
            echoShopProductDownloadModel.data![i].createDate.toString();
        final hasUnit =
            echoShopProductDownloadModel.data![i].hasUnit.toString();
        final image = echoShopProductDownloadModel.data![i].images == null
            ? ""
            : echoShopProductDownloadModel.data![i].images![0].toString();
        final coverimage = echoShopProductDownloadModel.data![i].images == null
            ? ""
            : echoShopProductDownloadModel.data![i].images![0].toString();

        final weight = echoShopProductDownloadModel.data![i].weight == null
            ? ""
            : echoShopProductDownloadModel.data![i].weight;
        final totalQuantity =
            echoShopProductDownloadModel.data![i].details![0].product == null
                ? ""
                : echoShopProductDownloadModel
                    .data![i].details![0].product![0].totalQuantity;
        final availableQuantity =
            echoShopProductDownloadModel.data![i].details![0].product == null
                ? ""
                : echoShopProductDownloadModel
                    .data![i].details![0].product![0].availableQuantity;
        final price =
            echoShopProductDownloadModel.data![i].details![0].product == null
                ? ""
                : echoShopProductDownloadModel
                    .data![i].details![0].product![0].price;
        final speciality =
            echoShopProductDownloadModel.data![i].speciality == null
                ? ""
                : echoShopProductDownloadModel.data![i].speciality;
        final unitcount = echoShopProductDownloadModel.data![i].hasUnit == true
            ? echoShopProductDownloadModel.data![i].details!.length
            : 0;
        // final refunitid=echoShopProductDownloadModel.data![i].hasUnit == true
        // ?  echoShopProductDownloadModel.data![i].details![j].unit!.id
        // : 0;

        if (echoShopProductDownloadModel.data![i].hasUnit == true) {
          for (int j = 0;
              j < echoShopProductDownloadModel.data![i].details!.length;
              j++) {
            final uid =
                echoShopProductDownloadModel.data![i].details![j].unit!.id;
            final productid =
                echoShopProductDownloadModel.data![i].details![j].unit!.product;
            final unitName = echoShopProductDownloadModel
                .data![i].details![j].unit!.unitName;
            final status =
                echoShopProductDownloadModel.data![i].details![j].unit!.status;
            final date = echoShopProductDownloadModel
                .data![i].details![j].unit!.createDate;
            final hassubUnit = echoShopProductDownloadModel
                .data![i].details![j].hasSubUnit
                .toString();
            // final subunticount=echoShopProductDownloadModel.data![i].details![j].hasSubUnit ==
            // true?echoShopProductDownloadModel.data![i].details![j].hasSubUnit ==

            if (echoShopProductDownloadModel.data![i].details![j].hasSubUnit ==
                true) {
              // for (int k = 0;
              //     k <
              //         echoShopProductDownloadModel
              //             .data![i].details![j].product!.length;
              //     k++) {
              ///here
              final suid = echoShopProductDownloadModel
                  .data![i].details![j].product![0].subUnit!.id;
              final productid = echoShopProductDownloadModel
                  .data![i].details![j].product![0].subUnit!.product;
              final subunitid =
                  echoShopProductDownloadModel.data![i].details![j].unit!.id;
              final unitName = echoShopProductDownloadModel
                  .data![i].details![j].product![0].subUnit!.subUnitName;
              final date = echoShopProductDownloadModel
                  .data![i].details![j].product![0].subUnit!.createDate;

              final weight = echoShopProductDownloadModel
                  .data![i].details![j].product![0].weight
                  .toString();
              final totalQuantity = echoShopProductDownloadModel
                  .data![i].details![j].product![0].totalQuantity
                  .toString();

              final availableQuantity = echoShopProductDownloadModel
                  .data![i].details![j].product![0].availableQuantity
                  .toString();

              final price = echoShopProductDownloadModel
                  .data![i].details![j].product![0].price
                  .toString();

              Map map1 = {
                "_id": suid,
                "productid": productid,
                "subunitid": subunitid,
                "unitName": unitName,
                "date": date
              };
              print(map1);
              insertproductsubunitsonline(map1);

              Map map6 = {
                "_id": suid,
                "productid": productid,
                "weight": weight,
                "totalQuantity": totalQuantity,
                "availableQuantity": availableQuantity,
                "price": price,
                "date": date
              };
              print(map6);
              insertproductstocksonline(map6);
              // }
            } else if (echoShopProductDownloadModel
                    .data![i].details![j].hasSubUnit ==
                false) {
              // for (int a = 0;
              //     a <
              //         echoShopProductDownloadModel
              //             .data![i].details![j].product!.length;
              //     a++) {

              final weight2 = echoShopProductDownloadModel
                  .data![i].details![j].product![0].weight
                  .toString();
              final totalQuantity2 = echoShopProductDownloadModel
                  .data![i].details![j].product![0].totalQuantity
                  .toString();

              final availableQuantity2 = echoShopProductDownloadModel
                  .data![i].details![j].product![0].availableQuantity
                  .toString();

              final price2 = echoShopProductDownloadModel
                  .data![i].details![j].product![0].price
                  .toString();

              Map map5 = {
                "_id": uid,
                "productid": productid,
                "weight": weight2,
                "totalQuantity": totalQuantity2,
                "availableQuantity": availableQuantity2,
                "price": price2,
                "date": date,
              };
              print(map5);
              insertproductstocksonline(map5);
              // }
            }

            Map map2 = {
              "_id": uid,
              "productid": productid,
              "unitName": unitName,
              "status": status,
              "date": date,
              "hassubUnit": hassubUnit,
            };

            insertproductunitonline(map2);
          }
        } else {
          Map map4 = {
            "_id": pid,
            "productid": pid,
            "weight": weight,
            "totalQuantity": totalQuantity,
            "availableQuantity": availableQuantity,
            "price": price,
            "date": date,
          };

          insertproductstocksonline(map4);
        }

        Map map3 = {
          "_id": pid,
          "productname": productname,
          "description": description,
          "unittype": unittype,
          "status": status,
          "date": date,
          "hasUnit": hasUnit,
          "image": image,
          "coverimage": coverimage,
          "speciality": speciality,
          "change": "false",
          "edit": "false",
          "remove": "false",
          "added": "false",
          "unitcount": unitcount.toString(),
        };

        insertproductdetailsonline(map3);
      }

        emit(ProductDownloadedechoSucces());
    } else {
      emit(EchoShopProductError());
    }
  }

////
  Future<FutureOr<void>> _fetchProductsandDownload(
      FetchProductsandDownload event,
      Emitter<EchoShopProductState> emit) async {
    List items51 = [];

    items51 = await getproductmastertabletabledata();
    print(items51);
    List items52 = await getproductunittabledata();
    print(items52);
    List items53 = await getproductsubunittabledata();
    print(items53);
    List items54 = await getproductstocktabledata();
    print(items54);

    if (items54.isNotEmpty) {
      for (int i = 0; i < items54.length; i++) {
        if (items54[i]['productid'] == "csdc") {}
      }
    }
  }

  Future<FutureOr<void>> _imageDownloadProduct(
      ImageDownloadProduct event, Emitter<EchoShopProductState> emit) async {
    EchoShopProductDownloadModel echoShopProductDownloadModel;

    echoShopProductDownloadModel = await AuthRepository()
        .downloadeOnlineProducts(url: '/product/detail/offline');
    if (echoShopProductDownloadModel.status == true) {
      await deletefullproductimages();
      await createFolder2(scafolldKey.currentContext!);
      for (int i = 0; i < echoShopProductDownloadModel.data!.length; i++) {
        final pid = echoShopProductDownloadModel.data![i].id.toString();
        final images = echoShopProductDownloadModel.data![i].images == null
            ? "1653625411711.jpg"
            : echoShopProductDownloadModel.data![i].images!.isNotEmpty
                ? echoShopProductDownloadModel.data![i].images![0]
                : '';
        var coverImage3 =
            await downloadImage2(scafolldKey.currentContext!, images);

        final images2 = coverImage3;

        Map map5 = {"productid": pid, "imageurl": images2};
        print(map5);
        coverImage3 == null ? "" : insertproductimage(map5);
      }

      emit(EchoShopProductDownloadsuccess());
    } else {
      emit(EchoShopProductDownloadError());
      // emit(EchoShopProductError());
    }
  }

  createFolder2(BuildContext context) async {
    var path;

    var status = await Permission.storage.status;
    print(status);
    if (status == PermissionStatus.denied) {
      await Permission.storage.request();
      status = await Permission.storage.status;
      print("now the status is + " + status.toString());
    }
    if (status == PermissionStatus.granted) {
      Directory directory = await getApplicationDocumentsDirectory();
      path = directory.path.toString() + "/parambikulamproduct/";

      newPath2 = Directory(path);
      bool isExists = await newPath2!.exists();
      print(newPath2);
      if (isExists) {
        newPath2!.deleteSync(recursive: true);
        newPath2!.create();
      } else {
        await newPath2!.create();
        print("false");
      }
    }
  }

  downloadImage2(BuildContext? context, String? coverimage2) async {
    var thePath;
    try {
      var url = WebClient.imageIp + coverimage2!;
      http.Response response = await http.get(Uri.parse(url));
      print(url);
      print(coverimage2);

      var filePathAndName = '${newPath2!.path}$coverimage2';
      print(filePathAndName);

      if (response.statusCode == 200) {
        File imageFile = File(filePathAndName);
        imageFile.writeAsBytesSync(response.bodyBytes);
        thePath = imageFile.path;
        print(imageFile.path);
      } else {
        thePath = null;
      }
    } catch (e) {
      print("Image download exception $e");
      thePath = null;
    }
    return thePath;
  }
}
////
//events

class EchoShopProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProductsandDownload extends EchoShopProductEvent {
  @override
  List<Object> get props => [];
}

class GetSalesReport extends EchoShopProductEvent {
  @override
  List<Object> get props => [];
}

class OnlineProductsandDownload extends EchoShopProductEvent {
  @override
  List<Object> get props => [];
}

class FetchProductsandDownload extends EchoShopProductEvent {
  @override
  List<Object> get props => [];
}

//states
//ImageDownloadProduct
class ImageDownloadProduct extends EchoShopProductEvent {
  @override
  List<Object> get props => [];
}

class EchoShopProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class EchoShopProductInitial extends EchoShopProductState {}

class ViewingProduct extends EchoShopProductState {}

class ViewingSaleReport extends EchoShopProductState {}

class ProductDownloadedSuccess extends EchoShopProductState {}

class SalereportDownloadedSuccess extends EchoShopProductState {}

class EchoShopProductSuccess extends EchoShopProductState {
  @override
  List<Object> get props => [];
}

class EchoShopProductEmpty extends EchoShopProductState {
  @override
  List<Object> get props => [];
}

class EchoShopProductError extends EchoShopProductState {
  @override
  List<Object> get props => [];
}

class ProductDownloadedechoSucces extends EchoShopProductState {
  @override
  List<Object> get props => [];
}

class EchoShopProductDownloadsuccess extends EchoShopProductState {
  @override
  List<Object> get props => [];
}

class EchoShopProductDownloadError extends EchoShopProductState {
  @override
  List<Object> get props => [];
}

class SalesReportError extends EchoShopProductState {
  @override
  List<Object> get props => [];
}
