//mainpage
///todya///

import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';

import 'package:parambikulam/data/models/assetsmodel/productmain/viewproductmainmodel.dart';

import 'package:parambikulam/data/models/product/productlistmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

import 'package:parambikulam/ui/assets/bottomnav.dart';

import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class ProductEditMain extends StatefulWidget {
  final ViewProductMainModel? viewProductMainModel;
  final String? productname;
  final String? description;
  final String? productid;
  final String? speciality;

  final int index;
  const ProductEditMain({
    Key? key,
    this.viewProductMainModel,
    this.productid,
    this.speciality,
    this.description,
    this.productname,
    required this.index,
  }) : super(key: key);

  ///
  @override
  State<ProductEditMain> createState() => _ProductDetailedMainViewState();
}

///
var d1 = DateFormat('dd-MMM-yyyy');
var d2 = DateFormat('hh:mm a');
bool? editon = true;

final TextEditingController productnamecontroller = TextEditingController();

final TextEditingController descriptioncontroller = TextEditingController();
final TextEditingController productpricecontroller = TextEditingController();
final TextEditingController specialitycontroller = TextEditingController();
final TextEditingController productquantitycontroller = TextEditingController();

///
final TextEditingController productunitunitcontroller = TextEditingController();
// final TextEditingController specialitycontroller = TextEditingController();
// ProductsModel? productsModel;
bool? interneton = false;
List items51 = [];
bool? hassubunit = false;
List items58 = [];
dynamic response;
List<ProductunitModel> productlist = [];
List<ProductunitModel> productunitunitlist = [];
ProductModel productModel = ProductModel(units: []);

List<ProductunitdataModel> productunitdatalist = [];
// List<TextEditingController> _productunitlist = [];
// List<String> _product2unitlist = [];
//import
List<ProductsubunitdataModel> productsubunitdatalist = [];

List<ProductsubunitModel> productsubunitunitlist = [];

///
List<Product2UnitModel> product2UnitModellist = [];

class _ProductDetailedMainViewState extends State<ProductEditMain> {
  @override
  void initState() {
    // setState(() {});
    fetcher2();
    testinternet();
    fetcher();

    super.initState();
  }

  final TextEditingController remarkcontroller = TextEditingController();
  DatabaseHelper? db = DatabaseHelper.instance;
  void fetcher2() async {
    productnamecontroller.text = widget.productname.toString();

    descriptioncontroller.text = widget.description.toString();
    specialitycontroller.text = widget.speciality.toString();
    setState(() {});
  }

  void fetcher() async {
    productsubunitdatalist.clear();
    productsubunitunitlist.clear();
    productunitdatalist.clear();
    productunitunitlist.clear();
    productlist.clear();

    items58 = await getproductimagesdata();
    print(items58);
    items51 = await getproductmastertabletabledata();
    print(items51);
    List items54 = await getproductstocktabledata();
    print(items54);
    List items52 = await getproductunittabledata();
    print(items52);
    List items53 = await getproductsubunittabledata();
    print(items53);

    if (items51.isNotEmpty) {
      if (items51[widget.index]['hasUnit'] != "true") {
        if (items54.isNotEmpty) {
          for (int i = 0; i < items54.length; i++) {
            if (items51[widget.index]['_id'] == items54[i]['productid'] &&
                items54[i]['_id'] == items51[widget.index]['_id']) {
              productlist.add(ProductunitModel(
                  availablequantity: items54[i]['availableQuantity'],
                  idno: items54[i]['idno'].toString(),
                  productprice: items54[i]['price'],
                  productweight: items54[i]['weight'],
                  totalquantity: items54[i]['totalQuantity'],
                  productid: items54[i]['productid'],
                  date: items54[i]['date'],
                  unitid: items54[i]['_id']));
            }
          }
        }
      } else if (items51[widget.index]['hasUnit'] == "true") {
        for (int k = 0; k < items52.length; k++) {
          if (items51[widget.index]['_id'] == items52[k]['productid']) {
            // productunitunitcontroller.clear();
            // setState(() {
            //   productunitunitcontroller.text = items52[k]['unitName'];
            // });

            // hassubunit = true;
            setState(() {
              productunitdatalist.add(ProductunitdataModel(
                unitnamecontroller: productnamecontroller,
                idno: items52[k]['idno'].toString(),
                id: items52[k]['_id'].toString(),
                productid: items52[k]['productid'],
                hassubunit: items52[k]['hassubUnit'],
                unitName: items52[k]['unitName'],
                date: items52[k]['date'],
              ));
              // setState(() {
              //   _product2unitlist.add(items52[k]['unitName']);
              //   _productunitlist.add(productunitunitcontroller);
              // });
            });
          }
          if (items52[k]['hassubUnit'] == "false") {
            for (int q = 0; q < items54.length; q++) {
              if (items52[k]['_id'] == items54[q]['_id']) {
                productunitunitlist.add(ProductunitModel(
                  idno: items54[q]['idno'].toString(),
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
          if (items52[k]['hassubUnit'] == "true") {
            for (int b = 0; b < items53.length; b++) {
              if (items51[widget.index]['_id'] == items53[b]['productid'] &&
                  items53[b]['subunitid'] == items52[k]['_id']) {
                productsubunitdatalist.add(
                  ProductsubunitdataModel(
                    idno: items53[b]['idno'].toString(),
                    id: items53[b]['_id'],
                    productid: items53[b]['productid'],
                    subunitid: items53[b]['subunitid'],
                    unitName: items53[b]['unitName'],
                    date: items53[b]['date'],
                  ),
                );
              }

              // print(productsubunitdatalist);
              for (int l = 0; l < items54.length; l++) {
                if (items51[widget.index]['_id'] == items54[l]['productid'] &&
                    items53[b]['_id'] == items54[l]['_id']) {
                  productsubunitunitlist.add(ProductsubunitModel(
                    idno: items54[l]['idno'].toString(),
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
              // print(productsubunitunitlist);
            }
          }
        }
        setState(() {});
      }
    }

    if (productlist.isNotEmpty) {
      setState(() {
        productpricecontroller.text = productlist[0].productprice.toString();
        productquantitycontroller.text =
            productlist[0].availablequantity.toString();
      });
    }

    // if (productunitdatalist.isNotEmpty) {
    //   setState(() {
    //     productunitunitcontroller.clear();
    //     _productunitlist.clear();
    //   });

    //   for (int i = 0; i < productunitdatalist.length; i++) {
    //     setState(() {
    //       productunitunitcontroller.clear();
    //     });
    //     setState(() {
    //       productunitunitcontroller.text =
    //           productunitdatalist[i].unitName.toString();
    //     });

    //     if (productunitunitcontroller.text.isNotEmpty) {
    //       setState(() {
    //         print(i.toString() + "qwer");
    //         _product2unitlist.add(productunitdatalist[i].unitName.toString());
    //       });
    //     }
    //   }
    // }
    // print(_productunitlist[0]);
    setState(() {});
  }

  void testinternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      interneton = false;
    } else if (connectivityResult != ConnectivityResult.none) {
      interneton = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: AppBar(
        title: Text("Edit "),
        actions: <Widget>[],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MaterialButton(
          color: Colors.green,
          child: Text("SAVE CHANGES"),
          onPressed: () async {
            Map map = {
              "productId": items51[widget.index]['_id'],
              "productname": productnamecontroller.text.toString(),
              "description": descriptioncontroller.text.toString(),
              "speciality": specialitycontroller.text.toString(),
              "weight": productunitdatalist.isNotEmpty
                  ? "10"
                  : productquantitycontroller.text.toString(),
              "totalQuantity": productunitdatalist.isNotEmpty
                  ? ""
                  : productquantitycontroller.text.toString(),
              "price": productunitdatalist.isNotEmpty
                  ? ""
                  : productpricecontroller.text.toString(),
              "unitType": "Grams",
              "units": [
                for (int k = 0; k < productunitdatalist.length; k++)
                  {
                    "unitname": productunitdatalist[k].unitName.toString(),
                    "unitid": productunitdatalist[k].id.toString(),
                    "price":
                        productunitdatalist[k].hassubunit.toString() == "true"
                            ? ""
                            : productunitunitlist[k].productprice.toString(),

                    // productsubunitdatalist.isNotEmpty
                    //     ? productunitunitlist[k].productprice.toString()
                    // : "",
                    "quantity": productunitdatalist[k].hassubunit.toString() ==
                            "true"
                        ? ""
                        : productunitunitlist[k].availablequantity.toString(),

                    "subUnits": [
                      for (int j = 0; j < productsubunitdatalist.length; j++)
                        {
                          "subUnitId": productsubunitdatalist.isNotEmpty
                              ? productsubunitdatalist[k].id.toString()
                              : "",

                          // await _getsubunitid(
                          //     items51[i]['_id'], items52[k]['_id']),
                          "subUnitName": productsubunitdatalist.isNotEmpty
                              ? productsubunitdatalist[k].unitName.toString()
                              : "",

                          // await _getsubunitname(
                          //     items51[i]['_id'], items52[k]['_id']),
                          "price": productsubunitunitlist.isNotEmpty
                              ? productsubunitunitlist[k]
                                  .productprice
                                  .toString()
                              : "",
                          "quantity": productsubunitunitlist.isNotEmpty
                              ? productsubunitunitlist[k]
                                  .totalquantity
                                  .toString()
                              : "",
                        }
                    ]
                  }
              ],
            };
            response = map;
            print(map);

            await db!.addICAddProductEditListdata(jsonEncode(response));

            validate();
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    //some problems
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: productnamecontroller,
                            autocorrect: true,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Product Name',
                            ),
                            onChanged: (String value) async {
                              getupdateproductmastertabledata(
                                  productnamecontroller.text,
                                  descriptioncontroller.text,
                                  specialitycontroller.text,
                                  "true",
                                  items51[widget.index]['idno']);
                            }),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: descriptioncontroller,
                            autocorrect: true,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                            onChanged: (String value) async {
                              getupdateproductmastertabledata(
                                  productnamecontroller.text,
                                  descriptioncontroller.text,
                                  specialitycontroller.text,
                                  "true",
                                  items51[widget.index]['idno']);
                            }),
                      ),
//specialitycontroller
                      items51.isEmpty
                          ? SizedBox()
                          : items51[widget.index]['hasUnit'] == "true"
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      controller: productpricecontroller,
                                      autocorrect: true,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        labelText: 'Price',
                                      ),
                                      onChanged: (String value) async {
                                        getchangestatusproductmastertabledata(
                                            "true",
                                            items51[widget.index]['idno']);
                                        getupdateproductstockdata(
                                          productpricecontroller.text,
                                          productquantitycontroller.text,
                                          productlist[0].idno.toString(),
                                        );
                                      }),
                                ),

                      // items51.isEmpty
                      //     ? SizedBox()
                      //     : items51[widget.index]['hasUnit'] == "true"
                      //         ? Container()
                      //         : Padding(
                      //             padding: const EdgeInsets.all(12.0),
                      //             child: TextFormField(
                      //                 textInputAction: TextInputAction.next,
                      //                 controller: productquantitycontroller,
                      //                 autocorrect: true,
                      //                 keyboardType: TextInputType.text,
                      //                 decoration: const InputDecoration(
                      //                   labelText: 'Quantity',
                      //                 ),
                      //                 onChanged: (String value) async {
                      //                   getchangestatusproductmastertabledata(
                      //                       "true",
                      //                       items51[widget.index]['idno']);
                      //                   getupdateproductstockdata(
                      //                     productpricecontroller.text,
                      //                     productquantitycontroller.text,
                      //                     productlist[0].idno.toString(),
                      //                   );
                      //                 }),
                      //           ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: specialitycontroller,
                            autocorrect: true,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Speciality',
                            ),
                            onChanged: (String value) async {
                              getupdateproductmastertabledata(
                                  productnamecontroller.text,
                                  descriptioncontroller.text,
                                  specialitycontroller.text,
                                  "true",
                                  items51[widget.index]['idno']);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              items51.isEmpty
                  ? SizedBox()
                  : items51.isEmpty
                      ? SizedBox()
                      : items51[widget.index]['hasUnit'] != "true"
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Product Types",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
              items51.isEmpty
                  ? SizedBox()
                  : items51.isEmpty
                      ? SizedBox()
                      : items51[widget.index]['hasUnit'] != "true"
                          ? Container()
                          : Container(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: productunitdatalist.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      TextEditingController
                                          productnameController =
                                          TextEditingController();

                                      TextEditingController
                                          availablequantitycontroller =
                                          TextEditingController();
                                      TextEditingController
                                          totalquantitycontroller =
                                          TextEditingController();
                                      TextEditingController pricecontroller =
                                          TextEditingController();
                                      TextEditingController
                                          productsubunitnamecontroller =
                                          TextEditingController();

                                      TextEditingController
                                          productsubunitquantitycontroller =
                                          TextEditingController();

                                      TextEditingController
                                          productsubunitpricecontroller =
                                          TextEditingController();

                                      TextEditingController
                                          productsubunitweightcontroller =
                                          TextEditingController();

                                      productnameController.text =
                                          productunitdatalist[index]
                                              .unitName
                                              .toString();

                                      availablequantitycontroller.text =
                                          productunitunitlist.isNotEmpty
                                              ? productunitunitlist[index]
                                                  .availablequantity
                                                  .toString()
                                              : "";

                                      totalquantitycontroller.text =
                                          productunitunitlist.isNotEmpty
                                              ? productunitunitlist[index]
                                                  .totalquantity
                                                  .toString()
                                              : "";

                                      pricecontroller.text =
                                          productunitunitlist.isNotEmpty
                                              ? productunitunitlist[index]
                                                  .productprice
                                                  .toString()
                                              : "";

                                      productsubunitnamecontroller.text =
                                          productsubunitdatalist.isNotEmpty
                                              ? productsubunitdatalist[index]
                                                  .unitName
                                                  .toString()
                                              : "";

                                      productsubunitquantitycontroller.text =
                                          productsubunitunitlist.isNotEmpty
                                              ? productsubunitunitlist[index]
                                                  .totalquantity
                                                  .toString()
                                              : "";

                                      productsubunitpricecontroller.text =
                                          productsubunitunitlist.isNotEmpty
                                              ? productsubunitunitlist[index]
                                                  .productprice
                                                  .toString()
                                              : "";

                                      productsubunitweightcontroller.text =
                                          productsubunitunitlist.isNotEmpty
                                              ? productsubunitunitlist[index]
                                                  .totalquantity
                                                  .toString()
                                              : "";

                                      return ListTile(
                                          title: InkWell(
                                        child: Column(children: [
                                          InkWell(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    2,
                                                decoration: BoxDecoration(
                                                  color: Color(0xfff292929),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 4,
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child:
                                                                  TextFormField(
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .done,
                                                                      controller:
                                                                          productnameController,
                                                                      autocorrect:
                                                                          true,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        labelText:
                                                                            'Product Name',
                                                                      ),
                                                                      onChanged:
                                                                          (String
                                                                              value) async {
                                                                        getchangestatusproductmastertabledata(
                                                                            "true",
                                                                            items51[widget.index]['idno']);
                                                                        getupdateproductunitdata(
                                                                            productnameController.text,
                                                                            productunitdatalist[index].idno.toString());

                                                                        productunitdatalist[index].unitName = productnameController
                                                                            .text
                                                                            .toString();
                                                                      }),
                                                            ),
                                                            productunitdatalist[
                                                                            index]
                                                                        .hassubunit
                                                                        .toString() ==
                                                                    "true"
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        12.0),
                                                                    child: TextFormField(
                                                                        textInputAction: TextInputAction.done,
                                                                        controller: availablequantitycontroller,
                                                                        autocorrect: true,
                                                                        keyboardType: TextInputType.text,
                                                                        decoration: const InputDecoration(
                                                                          labelText:
                                                                              'Weight',
                                                                        ),
                                                                        onChanged: (String value) async {
                                                                          getchangestatusproductmastertabledata(
                                                                              "true",
                                                                              items51[widget.index]['idno']);
                                                                          getupdateproductstockunitdata(
                                                                              pricecontroller.text,
                                                                              totalquantitycontroller.text,
                                                                              productunitunitlist[index].idno.toString());

                                                                          productunitunitlist[index].availablequantity = availablequantitycontroller
                                                                              .text
                                                                              .toString();
                                                                        }),
                                                                  ),
                                                            // productunitdatalist[
                                                            //                 index]
                                                            //             .hassubunit
                                                            //             .toString() ==
                                                            //         "true"
                                                            //     ? Container()
                                                            //     : Padding(
                                                            //         padding: const EdgeInsets
                                                            //                 .all(
                                                            //             12.0),
                                                            //         child: TextFormField(
                                                            //             textInputAction: TextInputAction.done,
                                                            //             controller: totalquantitycontroller,
                                                            //             autocorrect: true,
                                                            //             keyboardType: TextInputType.text,
                                                            //             decoration: const InputDecoration(
                                                            //               labelText:
                                                            //                   'Total Quantity',
                                                            //             ),
                                                            //             onChanged: (String value) async {
                                                            //               getchangestatusproductmastertabledata(
                                                            //                   "true",
                                                            //                   items51[widget.index]['idno']);
                                                            //               getupdateproductstockunitdata(
                                                            //                   pricecontroller.text,
                                                            //                   totalquantitycontroller.text,
                                                            //                   productunitunitlist[index].idno.toString());

                                                            //               productunitunitlist[index].totalquantity = totalquantitycontroller
                                                            //                   .text
                                                            //                   .toString();
                                                            //             }),
                                                            //       ),
                                                            productunitdatalist[
                                                                            index]
                                                                        .hassubunit
                                                                        .toString() ==
                                                                    "true"
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        12.0),
                                                                    child: TextFormField(
                                                                        textInputAction: TextInputAction.done,
                                                                        controller: pricecontroller,
                                                                        autocorrect: true,
                                                                        keyboardType: TextInputType.text,
                                                                        decoration: const InputDecoration(
                                                                          labelText:
                                                                              'Price',
                                                                        ),
                                                                        onChanged: (String value) async {
                                                                          getchangestatusproductmastertabledata(
                                                                              "true",
                                                                              items51[widget.index]['idno']);
                                                                          getupdateproductstockunitdata(
                                                                              pricecontroller.text,
                                                                              totalquantitycontroller.text,
                                                                              productunitunitlist[index].idno.toString());

                                                                          productunitunitlist[index].productprice = pricecontroller
                                                                              .text
                                                                              .toString();
                                                                        }),
                                                                  ),
                                                            productunitdatalist[
                                                                            index]
                                                                        .hassubunit
                                                                        .toString() !=
                                                                    "true"
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        12.0),
                                                                    child: TextFormField(
                                                                        textInputAction: TextInputAction.done,
                                                                        controller: productsubunitnamecontroller,
                                                                        autocorrect: true,
                                                                        keyboardType: TextInputType.text,
                                                                        decoration: const InputDecoration(
                                                                          labelText:
                                                                              'Name: ',
                                                                        ),
                                                                        onChanged: (String value) async {
                                                                          getchangestatusproductmastertabledata(
                                                                              "true",
                                                                              items51[widget.index]['idno']);
                                                                          getupdateproductsubunitdata(
                                                                            productsubunitnamecontroller.text,
                                                                            productsubunitdatalist[index].idno.toString(),
                                                                          );

                                                                          productsubunitdatalist[index].unitName = productsubunitnamecontroller
                                                                              .text
                                                                              .toString();
                                                                        }),
                                                                  ),
                                                            // productunitdatalist[
                                                            //                 index]
                                                            //             .hassubunit
                                                            //             .toString() !=
                                                            //         "true"
                                                            //     ? Container()
                                                            //     : Padding(
                                                            //         padding:
                                                            //             const EdgeInsets
                                                            //                     .all(
                                                            //                 12.0),
                                                            //         child:
                                                            //             TextFormField(
                                                            //                 textInputAction:
                                                            //                     TextInputAction
                                                            //                         .next,
                                                            //                 controller:
                                                            //                     productsubunitweightcontroller,
                                                            //                 autocorrect:
                                                            //                     true,
                                                            //                 keyboardType:
                                                            //                     TextInputType
                                                            //                         .text,
                                                            //                 decoration:
                                                            //                     const InputDecoration(
                                                            //                   labelText:
                                                            //                       'Weight: ',
                                                            //                 ),
                                                            //                 onChanged:
                                                            //                     (String
                                                            //                         value) async {
                                                            //                   getupdateproductsubunitdata(
                                                            //                     productsubunitnamecontroller.text,
                                                            //                     productsubunitdatalist[index].idno.toString(),
                                                            //                   );
                                                            //                 }),
                                                            //       ),
                                                            // productunitdatalist[
                                                            //                 index]
                                                            //             .hassubunit
                                                            //             .toString() !=
                                                            //         "true"
                                                            //     ? Container()
                                                            //     : Padding(
                                                            //         padding: const EdgeInsets
                                                            //                 .all(
                                                            //             12.0),
                                                            //         child: TextFormField(
                                                            //             textInputAction: TextInputAction.done,
                                                            //             controller: productsubunitquantitycontroller,
                                                            //             // _productunitlist[
                                                            //             //     index],
                                                            //             autocorrect: true,
                                                            //             keyboardType: TextInputType.text,
                                                            //             decoration: const InputDecoration(
                                                            //               labelText:
                                                            //                   'Total Quantity: ',
                                                            //             ),
                                                            //             onChanged: (String value) async {
                                                            //               getchangestatusproductmastertabledata(
                                                            //                   "true",
                                                            //                   items51[widget.index]['idno']);
                                                            //               getupdateproductstocksubunitdata(
                                                            //                 productsubunitunitlist[index].productprice.toString(),
                                                            //                 productsubunitquantitycontroller.text,
                                                            //                 productsubunitunitlist[index].idno.toString(),
                                                            //               );

                                                            //               productsubunitunitlist[index].totalquantity = productsubunitquantitycontroller
                                                            //                   .text
                                                            //                   .toString();
                                                            //             }),
                                                            //       ),
                                                            productunitdatalist[
                                                                            index]
                                                                        .hassubunit
                                                                        .toString() !=
                                                                    "true"
                                                                ? Container()
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        12.0),
                                                                    child: TextFormField(
                                                                        textInputAction: TextInputAction.done,
                                                                        controller: productsubunitpricecontroller,
                                                                        // _productunitlist[
                                                                        //     index],
                                                                        autocorrect: true,
                                                                        keyboardType: TextInputType.text,
                                                                        decoration: const InputDecoration(
                                                                          labelText:
                                                                              'Price: ',
                                                                        ),
                                                                        onChanged: (String value) async {
                                                                          getchangestatusproductmastertabledata(
                                                                              "true",
                                                                              items51[widget.index]['idno']);
                                                                          getupdateproductstocksubunitdata(
                                                                            productsubunitpricecontroller.text,
                                                                            productsubunitunitlist[index].totalquantity.toString(),
                                                                            productsubunitunitlist[index].idno.toString(),
                                                                          );

                                                                          productsubunitunitlist[index].productprice = productsubunitpricecontroller
                                                                              .text
                                                                              .toString();
                                                                        }),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                        ]),
                                      ));
                                    },
                                  ),
                                ],
                              ),
                            )
            ],
          ),
        ),
      ),
    );
  }

  Widget addedunitlist(List<Units>? units) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: units!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(units[index].type.toString()),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Quantity  :",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      units[index].stock.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Price  :",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      units[index].price.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Weight  :",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      units[index].weight.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ]),
                            ),
                            units[index].type != null
                                ? addedSubUnitslist(units[index].size)
                                : SizedBox.shrink(),
                          ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.white,
                ),
              ],
            );
          }),
    );
  }

  Widget addedSubUnitslist(List<Size>? subUnits) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: subUnits!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(subUnits[index].sizename.toString()),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: const Text(
                                    "SubType Quantity  :",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    subUnits[index].stock.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: const Text(
                                    "SubType Price  :",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    subUnits[index].price.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: const Text(
                                    "SubType Weight  :",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    subUnits[index].weight.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            );
          }),
    );
  }

  Future<void> validate() async {
    Fluttertoast.showToast(
        textColor: Colors.black,
        backgroundColor: Colors.white,
        msg: "Product Edited");

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => CustomerBottomNavigation()));
    // if (guestnamecontroller.text.isEmpty) {
    //   Fluttertoast.showToast(
    //       backgroundColor: Colors.white,
    //       msg: "please enter guestname",
    //       textColor: Colors.black);
    // } else if (noofpersonaccompanyingcontroller.text.isEmpty) {
    //   Fluttertoast.showToast(
    //       textColor: Colors.black,
    //       backgroundColor: Colors.white,
    //       msg: "please enter no. of person accompanying");
    // } else if (guestphonenumbercontroler.text.isEmpty) {
    //   Fluttertoast.showToast(
    //       textColor: Colors.black,
    //       backgroundColor: Colors.white,
    //       msg: "please enter guest phone number");
    // } else if (guestphonenumbercontroler.text.length != 10) {
    //   Fluttertoast.showToast(
    //       textColor: Colors.black,
    //       backgroundColor: Colors.white,
    //       msg: "please enter a valid phone number ");
    // } else if (referredbycontroller.text.isEmpty) {
    //   Fluttertoast.showToast(
    //       textColor: Colors.black,
    //       backgroundColor: Colors.white,
    //       msg: "please enter the refered person");
    // } else if (refpersonphonecontroller.text.isEmpty) {
    //   Fluttertoast.showToast(
    //       textColor: Colors.black,
    //       backgroundColor: Colors.white,
    //       msg: "please enter no. of refered person phone number");
    // } else if (refpersonphonecontroller.text.length != 10) {
    //   Fluttertoast.showToast(
    //       textColor: Colors.black,
    //       backgroundColor: Colors.white,
    //       msg: "please enter a valid phone number");
    // } else if (refpersonphonecontroller.text.isEmpty) {
    //   Fluttertoast.showToast(
    //       textColor: Colors.black,
    //       backgroundColor: Colors.white,
    //       msg: "please enter no. of refered person phone number");
    // } else {
    //   await updatereservationonlinedata(
    //       foodpreferencecontroller.text.toString(),
    //       vehiclenumbercontroller.text.toString(),
    //       guestnamecontroller.text.toString(),
    //       noofpersonaccompanyingcontroller.text.toString(),
    //       guestphonenumbercontroler.text.toString(),
    //       referredbycontroller.text.toString(),
    //       refpersonphonecontroller.text.toString(),
    //       emailcontroller.text.toString(),
    //       noofvehiclecontroller.text.toString(),
    //       detailscontroller.text.toString(),
    //       edited,
    //       removed,
    //       int.parse(widget.state.items7![widget.index]['id'].toString()));
    //   Navigator.pushReplacement(context,
    //       MaterialPageRoute(builder: (context) => ReservationOnlineDetails()));
    // }
  }

  String convert(String uTCTime) {
    var dateFormat =
        DateFormat("dd-MM-yyyy hh:mm"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(uTCTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    // String createdDate = dateFormat.format(DateTime.parse(localDate));
    return localDate;
  }
}

class ProductModel {
  String? productname;
  String? id;
  String? description;
  String? unittype;
  String? status;
  String? date;
  String? hasUnit;
  String? speciality;
  String? totalQuatity;
  String? totalPrice;
  String? totalWeight;
  late List<Product2UnitModel> units = [];
  List<String>? image;
  List<String>? coverImage;
  // String? coverImage;

  ProductModel(
      {this.productname,
      this.id,
      this.status,
      this.date,
      this.hasUnit,
      this.description,
      this.totalPrice,
      this.totalQuatity,
      this.totalWeight,
      this.speciality,
      this.unittype,
      required this.units,
      this.image,
      this.coverImage});
}

class Product2UnitModel {
  String? unitName;
  String? stock;
  String? weight;
  String? price;
  List<Product2SubUnitModel>? subUnits = [];

  Product2UnitModel(
      {this.unitName, this.stock, this.weight, this.price, this.subUnits});
}

class Product2SubUnitModel {
  String? subUnitName;
  String? stock;
  String? weight;
  String? price;

  Product2SubUnitModel({
    this.subUnitName,
    this.stock,
    this.weight,
    this.price,
  });
}
/////////////////////////////

class ProductunitdataModel {
  String? id;
  // String? totalquantity;
  // String? availablequantity;
  // String? productprice;
  // String? productweight;
  String? productid;
  String? idno;
  String? hassubunit;
  String? unitName;
  var unitnamecontroller = TextEditingController();
  String? date;

  ProductunitdataModel({
    this.id,
    this.idno,
    required this.unitnamecontroller,
    // this.totalquantity,
    // this.availablequantity,
    // this.productprice,
    // this.productweight,
    this.productid,
    this.hassubunit,
    this.unitName,
    this.date,
  });
}

class ProductsubunitdataModel {
  String? id;
  String? idno;
  String? productid;
  String? subunitid;
  String? unitName;
  String? date;
  ProductsubunitdataModel({
    this.id,
    this.idno,
    this.productid,
    this.subunitid,
    this.unitName,
    this.date,
  });
}

class ProductunitModel {
  String? totalquantity;
  String? unitid;
  String? idno;
  String? productid;
  String? date;
  String? availablequantity;
  String? productprice;
  String? productweight;

  ProductunitModel(
      {this.availablequantity,
      this.productprice,
      this.idno,
      this.productid,
      this.unitid,
      this.date,
      this.productweight,
      this.totalquantity});
}

class ProductsubunitModel {
  String? totalquantity;
  String? idno;
  String? subunitid;
  String? productid;
  String? date;
  String? availablequantity;
  String? productprice;
  String? productweight;

  ProductsubunitModel(
      {this.availablequantity,
      this.productprice,
      this.idno,
      this.productid,
      this.subunitid,
      this.date,
      this.productweight,
      this.totalquantity});
}
