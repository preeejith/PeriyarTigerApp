///product Edit changing
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/producteditbloc/producteditevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/producteditbloc/producteditstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';

import 'package:parambikulam/data/models/assetsmodel/productmain/producteditmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';
import 'package:parambikulam/ui/assets/products/productmaindetailedview.dart';

//
class GetProductMainEditBloc
    extends Bloc<ProductMainEditEvent, ProductMainEditState> {
  GetProductMainEditBloc() : super(ProductMainEditState()) {
    on<GetProductMainEdit>(_getProductMainEdit);
    on<FetchProductMainEdit>(_fetchProductMainEdit);
  }

  Future<FutureOr<void>> _getProductMainEdit(
      GetProductMainEdit event, Emitter<ProductMainEditState> emit) async {
    emit(ProductMainEditing());
    dynamic respose;
    List<ProductunitdataModel> productunitdatalist = [];
//import
    List<ProductsubunitdataModel> productsubunitdatalist = [];

    List<ProductsubunitModel> productsubunitunitlist = [];

    ///
    List<Product2UnitModel> product2UnitModellist = [];
    ProductEditModeldart productEditModeldart;
    List items51 = await getproductmastertabletabledata();
    print(items51);
    List items54 = await getproductstocktabledata();
    print(items54);
    List items52 = await getproductunittabledata();
    print(items52);
    List items53 = await getproductsubunittabledata();
    print(items53);
    productunitdatalist.clear();
    productunitunitlist.clear();
    productsubunitdatalist.clear();
    productsubunitunitlist.clear();

    for (int q = 0; q < items51.length; q++) {
      if (items51[q]['hasUnit'] == "true") {
        for (int k = 0; k < items52.length; k++) {
          if (items51[q]['_id'] == items52[k]['_id'] &&
              items51[q]['_id'] == items52[k]['productid']) {
            productunitdatalist.add(ProductunitdataModel(
              productid: items52[k]['productid'],
              hassubunit: items52[k]['hassubUnit'],
              unitName: items52[k]['unitName'],
              date: items52[k]['date'],
            ));
          }

          ///3
          if (items52[k]['hassubUnit'] == "false") {
            for (int q = 0; q < items54.length; q++) {
              if (items52[k]['_id'] == items54[q]['_id'] &&
                  items52[k]['productid'] == items54[q]['productid']) {
                productunitunitlist.add(ProductunitModel(
                  availablequantity: items54[q]['availableQuantity'],
                  productid: items54[q]['productid'],
                  date: items54[q]['date'],
                  unitid: items54[q]['_id'],
                  productprice: items54[q]['price'],
                  productweight: items54[q]['weight'],
                  totalquantity: items54[q]['totalQuantity'],
                ));
              }
            }
          }

          ///2
          if (items52[k]['hassubUnit'] == "true") {
            for (int b = 0; b < items53.length; b++) {
              if (items51[q]['_id'] == items53[b]['productid'] &&
                  items53[b]['subunitid'] == items52[k]['_id']) {
                productsubunitdatalist.add(
                  ProductsubunitdataModel(
                    id: items53[b]['_id'],
                    productid: items53[b]['productid'],
                    subunitid: items53[b]['subunitid'],
                    unitName: items53[b]['unitName'],
                    date: items53[b]['date'],
                  ),
                );
              }

              print(productsubunitdatalist);
              for (int l = 0; l < items54.length; l++) {
                if (items51[q]['_id'] == items54[l]['productid'] &&
                    items53[b]['_id'] == items54[l]['_id']) {
                  productsubunitunitlist.add(ProductsubunitModel(
                    availablequantity: items54[l]['availableQuantity'],
                    productprice: items54[l]['price'],
                    productweight: items54[l]['weight'],
                    totalquantity: items54[l]['totalQuantity'],
                    productid: items54[l]['productid'],
                    subunitid: items54[l]['_id'],
                    date: items54[l]['date'],
                  ));
                }
              }
              //1
              print(productsubunitunitlist);
            }
          }
        }
      } else {
        productunitdatalist.add(ProductunitdataModel(date: "23e2"));
      }
    }
    if (productunitdatalist.isNotEmpty) {
      for (int i = 0; i < items51.length; i++) {
        if (items51[i]['change'] == "true" && items51[i]['added'] == "false"
            //  &&
            // items51[i]['hasUnit'] == "false"
            ) {
          Map map = {
            "productId": items51[i]['_id'],
            "productname": items51[i]['productname'],
            "description": items51[i]['description'],
            "speciality": items51[i]['speciality'],
            "weight": await _getweight(items51[i]['_id']),
            "totalQuantity": await _getquantity(items51[i]['_id']),
            "price": await _getprice(items51[i]['_id']),
            "unitType": items51[i]['unittype'],
            "units": [
              for (int k = 0; k < int.parse(items51[i]['unitcount']); k++)
                {
                  "unitname":
                      await _getunitname(items51[i]['_id'], items52[k]['_id']),
                  "unitid":
                      // productunitdatalist[k].id,
                      await _getunitid(items51[i]['_id'],
                          productunitdatalist[k].id.toString()),
                  "price": await _getunitprice(
                      productunitdatalist[k].productid.toString(),
                      productunitdatalist[k].id.toString()),
                  "quantity": await _getunitquantity(
                      productunitdatalist[k].productid.toString(),
                      productunitdatalist[k].id.toString()),
                  "subUnits": [
                    for (int j = 0; j < 0; j++)
                      {
                        "subUnitId":
                            productsubunitdatalist[j].subunitid.toString(),

                        // await _getsubunitid(
                        //     items51[i]['_id'], items52[k]['_id']),
                        "subUnitName":
                            productsubunitdatalist[j].unitName.toString(),

                        // await _getsubunitname(
                        //     items51[i]['_id'], items52[k]['_id']),
                        "price": await _getsubunitprice(
                            productsubunitdatalist[j].productid.toString(),
                            productsubunitdatalist[j].subunitid.toString()),
                        "quantity": await _getsubunitquantity(
                            productsubunitdatalist[j].productid.toString(),
                            productsubunitdatalist[j].subunitid.toString())
                      }
                  ]
                }
            ],
          };
          respose = map;
          print("Map Done");
          print(map);

          // productEditModeldart = await AuthRepository()
          //     .productedit(url: '/v3/edit/product/', data: map);

          // if (productEditModeldart.status == true) {
          //   emit(ProductMainEditsuccess(
          //       productEditModeldart: productEditModeldart));
          // } else if (productEditModeldart.status == false) {
          //   emit(ProductMainEditError(
          //       error: productEditModeldart.msg.toString()));
          // }
        }
      }
    }
  }

/////for upload data
  Future<FutureOr<void>> _fetchProductMainEdit(
      FetchProductMainEdit event, Emitter<ProductMainEditState> emit) async {
    emit(ProductMainEditing());
    dynamic respose;
    List items69 = [];
    DatabaseHelper? db = DatabaseHelper.instance;
    List<ProductunitdataModel> productunitdatalist = [];
//import
    List<ProductsubunitdataModel> productsubunitdatalist = [];

    List<ProductsubunitModel> productsubunitunitlist = [];

    ///
    List<Product2UnitModel> product2UnitModellist = [];
    ProductEditModeldart productEditModeldart;

    items69 = await db.getICAddProductEditListDownloadData();

    if (items69.isNotEmpty) {
      for (int l = 0; l < items69.length; l++) {
        // print(items69[l]['data']);
        // print(jsonDecode(items69[l]['data']));
        productEditModeldart = await AuthRepository().productedit(
            url: '/v3/edit/product/', data: jsonDecode(items69[l]['data']));

        if (productEditModeldart.status == true) {
          await db.deleteICAddProductEditListdata(
              int.parse(items69[l]['id'].toString()));

          emit(ProductMainEditsuccess(
              productEditModeldart: productEditModeldart));
        } else if (productEditModeldart.status == false) {
          await db.deleteICAddProductEditListdata(
              int.parse(items69[l]['id'].toString()));
          emit(
              ProductMainEditError(error: productEditModeldart.msg.toString()));
        }
      }
    }
  }
}

_getweight(String productid) async {
  List items54 = await getproductstocktabledata();
  print(items54);
  bool? weighttrue = false;
  bool? weighttrue2 = false;

  for (int j = 0; j < items54.length; j++) {
    weighttrue2 = true;
    if (items54[j]['_id'] == productid.toString() &&
        items54[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items54[j]['weight']);
      String weight = items54[j]['weight'];
      return weight;
    }
  }

  if (weighttrue2 == true && weighttrue == false) {
    return "";
  }
}

_getquantity(String productid) async {
  bool? weighttrue = false;
  bool? weighttrue2 = false;

  List items54 = await getproductstocktabledata();
  print(items54);

  for (int j = 0; j < items54.length; j++) {
    weighttrue2 = true;
    if (items54[j]['_id'] == productid.toString() &&
        items54[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items54[j]['totalQuantity']);
      return items54[j]['totalQuantity'];
    }
  }
  if (weighttrue2 == true) {
    if (weighttrue == false) {
      return "";
    }
  }
}

_getprice(String productid) async {
  bool? weighttrue = false;
  bool? weighttrue2 = false;
  List items54 = await getproductstocktabledata();
  print(items54);

  for (int j = 0; j < items54.length; j++) {
    weighttrue2 = true;
    if (items54[j]['_id'] == productid.toString() &&
        items54[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items54[j]['price']);
      return items54[j]['price'];
    }
  }
  if (weighttrue2 == true && weighttrue == false) {
    return "";
  }
}

_getunitname(String productid, String id) async {
  bool? weighttrue = false;
  bool? weighttrue2 = false;

  List items52 = await getproductunittabledata();
  print(items52);
  for (int j = 0; j < items52.length; j++) {
    weighttrue2 = true;
    if (items52[j]['_id'] == id.toString() &&
        items52[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items52[j]['unitName']);
      return items52[j]['unitName'];
    }
  }
  if (weighttrue2 == true && weighttrue == false) {
    return "";
  }
}

//_getsubunitid
_getsubunitid(String productid, String id) async {
  bool? weighttrue = false;
  bool? weighttrue2 = false;

  List items53 = await getproductsubunittabledata();
  print(items53);
  for (int j = 0; j < items53.length; j++) {
    weighttrue2 = true;
    if (items53[j]['_id'] == id.toString() &&
        items53[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items53[j]['subunitid']);
      String id = items53[j]['subunitid'];
      return id;
    }
  }
  if (weighttrue2 == true && weighttrue == false) {
    return "";
  }
}

//_getsubunitname
_getsubunitname(String productid, String id) async {
  bool? weighttrue = false;
  bool? weighttrue2 = false;

  List items53 = await getproductsubunittabledata();
  print(items53);
  for (int j = 0; j < items53.length; j++) {
    weighttrue2 = true;
    if (items53[j]['_id'] == id.toString() &&
        items53[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items53[j]['unitName']);
      return items53[j]['unitName'];
    }
  }
  if (weighttrue2 == true && weighttrue == false) {
    return "";
  }
}

//_getsubunitprice
_getsubunitprice(String productid, String id) async {
  bool? weighttrue = false;
  bool? weighttrue2 = false;
  List items54 = await getproductstocktabledata();
  print(items54);

  for (int j = 0; j < items54.length; j++) {
    weighttrue2 = true;
    if (items54[j]['_id'] == id.toString() &&
        items54[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items54[j]['price']);
      return items54[j]['price'];
    }
  }
  if (weighttrue2 == true && weighttrue == false) {
    return "";
  }
}

_getsubunitquantity(String productid, String id) async {
  bool? weighttrue = false;
  bool? weighttrue2 = false;
  List items54 = await getproductstocktabledata();
  print(items54);

  for (int j = 0; j < items54.length; j++) {
    weighttrue2 = true;
    if (items54[j]['_id'] == id.toString() &&
        items54[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items54[j]['totalQuantity']);
      return items54[j]['totalQuantity'];
    }
  }
  if (weighttrue2 == true && weighttrue == false) {
    return "";
  }
}

///_getunitid
_getunitid(String productid, String id) async {
  bool? weighttrue = false;
  bool? weighttrue2 = false;

  List items52 = await getproductunittabledata();
  print(items52);
  for (int j = 0; j < items52.length; j++) {
    weighttrue2 = true;
    if (items52[j]['_id'] == id.toString() &&
        items52[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items52[j]['_id']);
      return items52[j]['_id'];
    }
  }
  if (weighttrue2 == true && weighttrue == false) {
    return "";
  }
}

///_getunitquantity
_getunitquantity(String productid, String id) async {
  bool? weighttrue = false;
  bool? weighttrue2 = false;
  List items54 = await getproductstocktabledata();
  print(items54);

  for (int j = 0; j < items54.length; j++) {
    weighttrue2 = true;
    if (items54[j]['_id'] == id.toString() &&
        items54[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items54[j]['totalQuantity']);
      return items54[j]['totalQuantity'];
    }
  }
  if (weighttrue2 == true && weighttrue == false) {
    return "";
  }
}

///_getunitname
_getunitprice(String productid, String id) async {
  bool? weighttrue = false;
  bool? weighttrue2 = false;
  List items54 = await getproductstocktabledata();
  print(items54);

  for (int j = 0; j < items54.length; j++) {
    weighttrue2 = true;
    if (items54[j]['_id'] == id.toString() &&
        items54[j]['productid'] == productid.toString()) {
      weighttrue = true;
      print(items54[j]['price']);
      return items54[j]['price'];
    }
  }
  if (weighttrue2 == true && weighttrue == false) {
    return "";
  }
}
