import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectid/objectid.dart';

import 'package:parambikulam/bloc/assets/icbloc/product/addproductbloc/addproductevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/addproductbloc/addproductstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/addproductimagemodel.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/addproductmainmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

////////////////add product bloc////////////////////
///chnage the productid to the bloc for removal purpose
class GetAddProductMainBloc
    extends Bloc<AddProductMainEvent, AddProductMainState> {
  GetAddProductMainBloc() : super(AddProductMainState()) {
    on<GetAddProductMain>(_getAddProductMain);

    on<FetchAddProductMain>(_fetchAddProductMain);

    on<RefreshAddProductMain>(_refreshAddProductMain);
  }

  Future<FutureOr<void>> _getAddProductMain(
      GetAddProductMain event, Emitter<AddProductMainState> emit) async {
    emit(AddProductMaining());
    String? productidid = ObjectId().toString();
    String? unitidid = ObjectId().toString();
    String? subunitidid = ObjectId().toString();
    dynamic response;
    var now = DateTime.now();
    DatabaseHelper? db = DatabaseHelper.instance;

    Map map = {
      "productidid": productidid,
      "productname": event.productsModel.productname,
      "description": event.productsModel.description,
      "speciality": event.productsModel.speciality,
      "weight": event.productsModel.totalWeight,
      "totalQuantity": event.productsModel.totalQuatity,
      "price": event.productsModel.totalPrice,
      "unitType": event.productsModel.unitType,
      "units": [
        for (int k = 0; k < event.productsModel.units.length; k++)
          {
            "unitname": event.productsModel.units[k].unitName,
            "price": event.productsModel.units[k].price,
            "quantity": event.productsModel.units[k].stock,
            "subUnits": [
              for (int i = 0;
                  i < event.productsModel.units[k].subUnits!.length;
                  i++)
                {
                  "subUnitName":
                      event.productsModel.units[k].subUnits![i].subUnitName,
                  "price": event.productsModel.units[k].subUnits![i].price,
                  "quantity": event.productsModel.units[k].subUnits![i].stock
                }
            ]
          }
      ],
    };
/////
    response = map;
    await db.addICAddProductListdata(jsonEncode(response));
    Map data2 = {
      "images": [
        for (int k = 0; k < event.productsModel.photos!.length; k++)
          {
            "image": event.productsModel.photos![k].toString(),
            "coverimage": event.productsModel.coverImage!.isEmpty
                ? ""
                : event.productsModel.coverImage![k].toString(),
          }
      ]
    };

    await db.addICAddProductImgListdata(jsonEncode(data2));
    print(data2);

/////for including the product list in to the local list
    ///
    final pid = productidid;
    final productname = event.productsModel.productname;
    final description = event.productsModel.description;
    final unittype = event.productsModel.unitType;
    final status = "Active";
    final date = now.toString();
    final hasUnit = event.productsModel.units.length != 0 ? "true" : "false";
    final image = "";
    final coverimage = "";

    final weight = event.productsModel.totalWeight;
    final totalQuantity = event.productsModel.totalQuatity;
    final availableQuantity = event.productsModel.totalQuatity;
    final price = event.productsModel.totalPrice;
    final speciality = event.productsModel.speciality;

    final images = event.productsModel.photos!.length != 0
        ? event.productsModel.photos![0]
        : "";
    final unitcount = event.productsModel.units.length != 0
        ? event.productsModel.units.length
        : 0;
        final refunitid=event.productsModel.units.length != 0
        ? unitidid
        : 0;
    if (event.productsModel.units.length != 0) {
      for (int m = 0; m < event.productsModel.units.length; m++) {
        if (event.productsModel.units[m].subUnits!.length != 0) {
          for (int q = 0;
              q < event.productsModel.units[m].subUnits!.length;
              q++) {
            final uid = unitidid;
            final productid = productidid;
            final unitName = event.productsModel.units[m].unitName;
            final status = "Active";
            final date = now.toString();
            final hassubUnit =
                event.productsModel.units[m].subUnits!.length != 0
                    ? "true"
                    : "false";

            ///for subunt  input
            ///
            final suid = unitidid;
            // final productid = productidid;
            final subunitid = subunitidid;
            final sunitName =
                event.productsModel.units[m].subUnits![q].subUnitName;
            // final date = now.toString();

            final weight = event.productsModel.totalWeight;
            final totalQuantity =
                event.productsModel.units[m].subUnits![q].stock;

            final availableQuantity =
                event.productsModel.units[m].subUnits![q].stock;

            final price = event.productsModel.units[m].subUnits![q].price;

            Map map1 = {
              "_id": subunitid,
              "productid": productid,
              "subunitid": suid,
              "unitName": sunitName,
              "date": date
            };
            print(map1);
            await insertproductsubunitsonline(map1);

            Map map6 = {
              "_id": subunitid,
              "productid": productid,
              "weight": weight,
              "totalQuantity": totalQuantity,
              "availableQuantity": availableQuantity,
              "price": price,
              "date": date
            };
            print(map6);
            await insertproductstocksonline(map6);

            ///for unit with subunit
            Map map2 = {
              "_id": uid,
              "productid": productid,
              "unitName": unitName,
              "status": status,
              "date": date,
              "hassubUnit": hassubUnit,
            };

            await insertproductunitonline(map2);
          }
        } else if (event.productsModel.units[m].subUnits!.length == 0) {
          final uid = unitidid;
          final productid = productidid;
          final unitName = event.productsModel.units[m].unitName;
          final status = "Active";
          final date = now.toString();
          final hassubUnit = event.productsModel.units[m].subUnits!.length != 0
              ? "true"
              : "false";

          Map map2 = {
            "_id": uid,
            "productid": productid,
            "unitName": unitName,
            "status": status,
            "date": date,
            "hassubUnit": hassubUnit,
          };

          await insertproductunitonline(map2);

          final weight = event.productsModel.totalWeight;
          final totalQuantity = event.productsModel.units[m].stock;

          final availableQuantity = event.productsModel.units[m].stock;

          final price = event.productsModel.units[m].stock;

          Map map5 = {
            "_id": uid,
            "productid": productid,
            "weight": weight,
            "totalQuantity": totalQuantity,
            "availableQuantity": availableQuantity,
            "price": price,
            "date": date,
          };
          print(map5);
          await insertproductstocksonline(map5);
        }

        // final uid = unitidid;
        // final productid = productidid;
        // final unitName = event.productsModel.units[m].unitName;
        // final status = "Active";
        // final date = now.toString();
        // final hassubUnit = event.productsModel.units[m].subUnits!.length != 0
        //     ? "true"
        //     : "false";

        // if (event.productsModel.units[m].subUnits!.length != 0) {
        //   for (int n = 0;
        //       n < event.productsModel.units[m].subUnits!.length;
        //       n++) {
        //     ///pls not this
        //     final suid = unitidid;
        //     final productid = productidid;
        //     final subunitid = subunitidid;
        //     final unitName =
        //         event.productsModel.units[m].subUnits![n].subUnitName;
        //     final date = now.toString();

        //     final weight = event.productsModel.totalWeight;
        //     final totalQuantity =
        //         event.productsModel.units[m].subUnits![n].stock;

        //     final availableQuantity =
        //         event.productsModel.units[m].subUnits![n].stock;

        //     final price = event.productsModel.units[m].subUnits![n].price;

        //     Map map1 = {
        //       "_id": subunitid,
        //       "productid": productid,
        //       "subunitid": suid,
        //       "unitName": unitName,
        //       "date": date
        //     };
        //     print(map1);
        //     insertproductsubunitsonline(map1);

        //     Map map6 = {
        //       "_id": subunitid,
        //       "productid": productid,
        //       "weight": weight,
        //       "totalQuantity": totalQuantity,
        //       "availableQuantity": availableQuantity,
        //       "price": price,
        //       "date": date
        //     };
        //     print(map6);
        //     insertproductstocksonline(map6);
        //   }
        // } else if (event.productsModel.units[m].subUnits!.length == 0) {
        //   final weight = event.productsModel.totalWeight;
        //   final totalQuantity = event.productsModel.units[m].stock;

        //   final availableQuantity = event.productsModel.units[m].stock;

        //   final price = event.productsModel.units[m].stock;

        //   Map map5 = {
        //     "_id": uid,
        //     "productid": productid,
        //     "weight": weight,
        //     "totalQuantity": totalQuantity,
        //     "availableQuantity": availableQuantity,
        //     "price": price,
        //     "date": date,
        //   };
        //   print(map5);
        //   insertproductstocksonline(map5);
        // }

        // Map map2 = {
        //   "_id": uid,
        //   "productid": productid,
        //   "unitName": unitName,
        //   "status": status,
        //   "date": date,
        //   "hassubUnit": hassubUnit,
        // };

        // insertproductunitonline(map2);
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

      await insertproductstocksonline(map4);
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
      "added": "true",
      "unitcount": unitcount.toString()
    };

    ///
    await insertproductdetailsonline(map3);

    Map map5 = {"productid": pid, "imageurl": images};
    print(map5);

    await insertproductimage(map5);
  }
}

Future<FutureOr<void>> _fetchAddProductMain(
    FetchAddProductMain event, Emitter<AddProductMainState> emit) async {
  emit(AddProductMaining());
/////need to chnage here
  ///taking step to prevent the deleted product from add
  DatabaseHelper? db = DatabaseHelper.instance;
  bool? permit = false;
  bool? permit2 = false;
  List items27 = [];
  List items59 = [];

  AddProductMainModel addProductMainModel;
  AddProductImageModel? addProductImageModel;

  items59 = await getproductdeletedata();
  items27 = await db.getICAddProductListDownloadData();
  print(items27);

  if (items27.isNotEmpty) {
    for (int k = 0; k < items27.length; k++) {
      permit = false;

      var data = jsonDecode(items27[k]['data']);

      if (items59.isNotEmpty) {
        for (int i = 0; i < items59.length; i++) {
          if (items59[i]['added'] == "true" &&
              items59[i]['productid'] == data['productidid']) {
            permit = true;
          } else {}
          permit2 = true;
        }
        if (permit == true) {
          if (permit2 == true) {
            await db.deleteICAddProductListdata(
                int.parse(items27[k]['id'].toString()));

            await db.deleteICAddProductImgListdata(k);
          }
        }
        if (permit == false) {
          if (permit2 == true) {
            permit = false;
            addProductMainModel = await AuthRepository().addproductmain(
                url: '/v3/add/product/', data: jsonDecode(items27[k]['data']));

            if (addProductMainModel.status == true) {
              var items28 = jsonDecode(
                  (await db.getICAddProductImgListDownloadData())[k]['data']);
              print(items28);

              if (items28 != null) {
                for (int j = 0; j < items28['images'].length; j++) {
                  addProductImageModel = await AuthRepository().addproductimage(
                      url: '/product/imagesv2',
                      id: addProductMainModel.data.toString(),
                      image: items28['images'][j]['image'].toString(),
                      coverimage: "");
                }

                if (addProductImageModel!.status == true) {
                  await db.deleteICAddProductListdata(
                      int.parse(items27[k]['id'].toString()));

                  await db.deleteICAddProductImgListdata(k);
                }
              }
            } else if (addProductMainModel.status == false) {
              emit(AddProductMainError(
                  error: addProductMainModel.msg.toString()));
            }
          }
        }
      } else {
        addProductMainModel = await AuthRepository().addproductmain(
            url: '/v3/add/product/', data: jsonDecode(items27[k]['data']));

        if (addProductMainModel.status == true) {
          var items28 = jsonDecode(
              (await db.getICAddProductImgListDownloadData())[k]['data']);
          print(items28);

          if (items28 != null) {
            for (int j = 0; j < items28['images'].length; j++) {
              addProductImageModel = await AuthRepository().addproductimage(
                  url: '/product/imagesv2',
                  id: addProductMainModel.data.toString(),
                  image: items28['images'][j]['image'].toString(),
                  coverimage: "");
            }

            if (addProductImageModel!.status == true) {
              await db.deleteICAddProductListdata(
                  int.parse(items27[k]['id'].toString()));

              await db.deleteICAddProductImgListdata(k);
            }
          }
        } else if (addProductMainModel.status == false) {
          emit(AddProductMainError(error: addProductMainModel.msg.toString()));
        }
      }

      // addProductMainModel = await AuthRepository().addproductmain(
      //     url: '/v3/add/product/', data: jsonDecode(items27[k]['data']));

      // if (addProductMainModel.status == true) {
      //   var items28 = jsonDecode(
      //       (await db.getICAddProductImgListDownloadData())[k]['data']);
      //   print(items28);

      //   if (items28 != null) {
      //     for (int j = 0; j < items28['images'].length; j++) {
      //       addProductImageModel = await AuthRepository().addproductimage(
      //           url: '/product/imagesv2',
      //           id: addProductMainModel.data.toString(),
      //           image: items28['images'][j]['image'].toString(),
      //           coverimage: "");
      //     }

      //     if (addProductImageModel!.status == true) {
      //       await db.deleteICAddProductListdata(
      //           int.parse(items27[k]['id'].toString()));

      //       await db.deleteICAddProductImgListdata(k);

      //     }
      //   }

      // } else if (addProductMainModel.status == false) {
      //   emit(AddProductMainError(error: addProductMainModel.msg.toString()));
      // }
    }
    emit(Refreshproduct());
    emit(AddProductMainsuccess());
    // emit(Refreshproduct());
  } else {
    emit(Refreshproduct());
    emit(AddProductMainsuccess());
    // emit(Refreshproduct());

    // Fluttertoast.showToast(msg: "No products  Available2222222 ");
  }

  // data = await db.getICAddProductListDownloadData();
}

Future<FutureOr<void>> _refreshAddProductMain(
    RefreshAddProductMain event, Emitter<AddProductMainState> emit) async {
  emit(Refreshproduct());
}
