//real Page
// ignore_for_file: unnecessary_statements

import 'dart:io';

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/echoshop/echoShopCartManagementbloc.dart';

import 'package:parambikulam/data/models/echoshopdownloadmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/echoshoppages/productsale/components/cartDetails.dart';
import 'package:parambikulam/ui/assets/echoshoppages/productsale/components/addProductModal.dart';
import 'package:parambikulam/ui/assets/echoshoppages/productsale/echoshopcart.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class EchoShopProducts extends StatefulWidget {
  const EchoShopProducts({Key? key}) : super(key: key);

  @override
  State<EchoShopProducts> createState() => _EchoShopProducts();
}

class _EchoShopProducts extends State<EchoShopProducts> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController producttypecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();

  final TextEditingController salepricecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController discountcontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();
  EchoShopProductDownloadModel echoShopProductDownloadModel =
      EchoShopProductDownloadModel();
  List items58 = [];
  DatabaseHelper db = DatabaseHelper.instance;

  @override
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() async {
    items58 = await getproductimagesdata();
    print(items58);
    echoShopProductDownloadModel = await db.getEchoDownloadData();
    setState(() {});
  }

  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CartDetails(),
      backgroundColor: Color(0xfff1F1F1F),
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text('Products'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: InkWell(
              child: badge.Badge(
                badgeColor: Color(0XFF53A874),
                position: badge.BadgePosition.topEnd(top: 3, end: -6),
                padding: const EdgeInsets.all(5.0),
                badgeContent: Text(
                  context
                      .read<GetEchoShopCartManagementBloc>()
                      .cartData!
                      .length
                      .toString(),
                  // style: TextStyle(color: Colors.black),
                ),
                child: Icon(Icons.shopping_bag_outlined),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EchoShopCart()));
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            echoShopProductDownloadModel.data == null
                ? Center(
                    child: SizedBox(
                      height: 28.0,
                      width: 28.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: echoShopProductDownloadModel.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              title: InkWell(
                            child: Column(children: [
                              InkWell(
                                child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 2,
                                      // height: MediaQuery.of(context).size.height / 3.5,
                                      decoration: BoxDecoration(
                                        color: Color(0xfff292929),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 4,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Column(children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    items58.isNotEmpty
                                                        ? index > items58.length
                                                            ? Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    6,
                                                                width: 100,
                                                                decoration:
                                                                    new BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  image:
                                                                      DecorationImage(
                                                                    image: AssetImage(
                                                                        "assets/echobag.png"),
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    6,
                                                                width: 100,
                                                                decoration:
                                                                    new BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  image: items58
                                                                              .isNotEmpty &&
                                                                          items58.length >
                                                                              index &&
                                                                          items58.length <
                                                                              index &&
                                                                          items58[index]['imageurl'] ==
                                                                              null
                                                                      ? DecorationImage(
                                                                          image:
                                                                              AssetImage("assets/echobag.png"),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        )
                                                                      : DecorationImage(
                                                                          image:
                                                                              FileImage(
                                                                            File(
                                                                              items58[index]['imageurl'],
                                                                            ),
                                                                          ),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),

                                                                  //     DecorationImage(
                                                                  //   image:
                                                                  //       FileImage(
                                                                  //     File(
                                                                  //       echoShopProductDownloadModel.data![index].images.toString(),
                                                                  //     ),
                                                                  //   ),
                                                                  //   fit: BoxFit
                                                                  //       .cover,
                                                                  // ),
                                                                ),
                                                              )
                                                        : Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                6,
                                                            width: 100,
                                                            decoration:
                                                                new BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              image:
                                                                  DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/echobag.png"),
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .40,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  echoShopProductDownloadModel
                                                                      .data![
                                                                          index]
                                                                      .productname
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              echoShopProductDownloadModel
                                                                  .data![index]
                                                                  .speciality
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              d1.format(DateTime.parse(echoShopProductDownloadModel
                                                                          .data![
                                                                              index]
                                                                          .createDate
                                                                          .toString())
                                                                      .toLocal()) +
                                                                  " | " +
                                                                  d2.format(DateTime.parse(echoShopProductDownloadModel
                                                                          .data![
                                                                              index]
                                                                          .createDate
                                                                          .toString())
                                                                      .toLocal()),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    echoShopProductDownloadModel
                                                                .data![index]
                                                                .quantity !=
                                                            0
                                                        ? Column(
                                                            children: [
                                                              Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xfff292929),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.3),
                                                                        spreadRadius:
                                                                            4,
                                                                        blurRadius:
                                                                            4,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            0.0),
                                                                    child: Row(
                                                                      children: [
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              echoShopProductDownloadModel.data![index].quantity = echoShopProductDownloadModel.data![index].quantity! - 1;
                                                                              setState(() {});
                                                                              addData(echoShopProductDownloadModel.data![index].details![0].product![0].id, echoShopProductDownloadModel.data![index].quantity!, echoShopProductDownloadModel.data![index].details![0].product![0].price!, echoShopProductDownloadModel.data![index].productname);
                                                                            },
                                                                            child:
                                                                                Icon(Icons.remove)),
                                                                        Text(
                                                                          echoShopProductDownloadModel
                                                                              .data![index]
                                                                              .quantity
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 16),
                                                                        ),
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              if (echoShopProductDownloadModel.data![index].details![0].product![0].availableQuantity! > echoShopProductDownloadModel.data![index].quantity! + 1) {
                                                                                echoShopProductDownloadModel.data![index].quantity = echoShopProductDownloadModel.data![index].quantity! + 1;
                                                                                setState(() {});
                                                                                addData(echoShopProductDownloadModel.data![index].details![0].product![0].id, echoShopProductDownloadModel.data![index].quantity!, echoShopProductDownloadModel.data![index].details![0].product![0].price!, echoShopProductDownloadModel.data![index].productname);
                                                                              } else {
                                                                                Fluttertoast.showToast(msg: "Stock Limit reached");
                                                                              }
                                                                            },
                                                                            child:
                                                                                Icon(Icons.add)),
                                                                      ],
                                                                    ),
                                                                  )),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                            ],
                                                          )
                                                        : Column(
                                                            children: [
                                                              InkWell(
                                                                  child:
                                                                      Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(0xfff292929),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.grey.withOpacity(0.3),
                                                                                spreadRadius: 4,
                                                                                blurRadius: 4,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text("ADD +"),
                                                                          )),
                                                                  onTap: () {
                                                                    if (echoShopProductDownloadModel
                                                                            .data![index]
                                                                            .details![0]
                                                                            .isVarient ==
                                                                        false) {
                                                                      echoShopProductDownloadModel
                                                                          .data![
                                                                              index]
                                                                          .quantity = 1;
                                                                      addData(
                                                                          echoShopProductDownloadModel
                                                                              .data![
                                                                                  index]
                                                                              .details![
                                                                                  0]
                                                                              .product![
                                                                                  0]
                                                                              .id,
                                                                          echoShopProductDownloadModel
                                                                              .data![
                                                                                  index]
                                                                              .quantity!,
                                                                          echoShopProductDownloadModel
                                                                              .data![index]
                                                                              .details![0]
                                                                              .product![0]
                                                                              .price!,
                                                                          echoShopProductDownloadModel.data![index].productname);
                                                                      setState(
                                                                          () {});
                                                                      //   inCart = true;
                                                                    } else {
                                                                      showModalBottomSheet<
                                                                          void>(
                                                                        context:
                                                                            context,
                                                                        clipBehavior:
                                                                            Clip.antiAlias,
                                                                        isScrollControlled:
                                                                            true,
                                                                        shape:
                                                                            const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(12),
                                                                            topRight:
                                                                                Radius.circular(12),
                                                                          ),
                                                                        ),
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return HelperComponents().modalVarient(
                                                                              context,
                                                                              // items58.isNotEmpty ? items58[index]['imageurl'] : '',
                                                                              '',
                                                                              echoShopProductDownloadModel.data![index].images!.isNotEmpty ? echoShopProductDownloadModel.data![index].images![0] : '',
                                                                              echoShopProductDownloadModel.data![index]);
                                                                        },
                                                                      ).then((value) =>
                                                                          setState(
                                                                            () {},
                                                                          ));
                                                                    }
                                                                  }),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              !echoShopProductDownloadModel
                                                                      .data![
                                                                          index]
                                                                      .hasUnit!
                                                                  ? Container()
                                                                  : Text(
                                                                      "Customizable",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              8),
                                                                    )
                                                            ],
                                                          )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ])),
                                    )),
                                onTap: () {
//
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
                  )
          ],
        ),
      ),
    );
  }

  addData(id, quantity, price, name) {
    var contain = context
        .read<GetEchoShopCartManagementBloc>()
        .cartData!
        .where((element) => element['itemId'] == id);

    if (contain.isNotEmpty) {
      for (int i = 0;
          i < context.read<GetEchoShopCartManagementBloc>().cartData!.length;
          i++) {
        if (context.read<GetEchoShopCartManagementBloc>().cartData![i]
                ['itemId'] ==
            id) {
          quantity != 0
              ? context.read<GetEchoShopCartManagementBloc>().cartData![i]
                  ['quantity'] = quantity
              : context
                  .read<GetEchoShopCartManagementBloc>()
                  .cartData!
                  .removeAt(i);
          setState(
            () {},
          );
        }
      }
      setState(() {});
    } else {
      quantity != 0
          ? context.read<GetEchoShopCartManagementBloc>().cartData!.add({
              "itemId": id,
              "quantity": quantity,
              "totalamount": price,
              "productName": name
            })
          : {};
      setState(
        () {},
      );
    }
  }
}
