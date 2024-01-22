// ignore_for_file: unnecessary_statements

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parambikulam/bloc/assets/echoshop/echoShopCartManagementbloc.dart';

import 'package:parambikulam/data/models/echoshopdownloadmodel.dart';

///////needed
class HelperComponents {
  // List<Map> context.read<GetEchoShopCartManagementBloc>().cartData! = [];
  modalVarient(BuildContext context, String image2, String image, Data data) {
    return StatefulBuilder(builder: (BuildContext context, setState) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * .7,
              child: Scaffold(
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      height: 52,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: HexColor("#53A874"),
                      minWidth: MediaQuery.of(context).size.width * .6,
                    ),
                  ),
                  body: ListView(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        image2.isNotEmpty
                            ? Container(
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.height,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(
                                        image2,
                                      ),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                height: MediaQuery.of(context).size.height / 6,
                                width: 100,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage("assets/echobag.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                data.productname!,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                data.description!,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.details!.length,
                      itemBuilder: (BuildContext context, int detailsIndex) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data.details![detailsIndex].unit!
                                          .unitName!,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    data.details![detailsIndex].hasSubUnit!
                                        ? SizedBox()
                                        : Container(
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        if (data
                                                                .details![
                                                                    detailsIndex]
                                                                .unit!
                                                                .quantity !=
                                                            0) {
                                                          data
                                                              .details![
                                                                  detailsIndex]
                                                              .unit!
                                                              .quantity = data
                                                                  .details![
                                                                      detailsIndex]
                                                                  .unit!
                                                                  .quantity! -
                                                              1;
                                                          setState(
                                                            () {},
                                                          );
                                                          addUnitData(
                                                              data,
                                                              detailsIndex,
                                                              setState,
                                                              data
                                                                  .details![
                                                                      detailsIndex]
                                                                  .unit!
                                                                  .quantity!,
                                                              context,
                                                              data.productname! +
                                                                  " - " +
                                                                  data
                                                                      .details![
                                                                          detailsIndex]
                                                                      .unit!
                                                                      .unitName!);
                                                          setState(
                                                            () {},
                                                          );
                                                        }
                                                      },
                                                      child:
                                                          Icon(Icons.remove)),
                                                  Text(
                                                    data.details![detailsIndex]
                                                        .unit!.quantity!
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        if (data
                                                                .details![
                                                                    detailsIndex]
                                                                .product![0]
                                                                .availableQuantity! >
                                                            data
                                                                    .details![
                                                                        detailsIndex]
                                                                    .unit!
                                                                    .quantity! +
                                                                1) {
                                                          data
                                                              .details![
                                                                  detailsIndex]
                                                              .unit!
                                                              .quantity = data
                                                                  .details![
                                                                      detailsIndex]
                                                                  .unit!
                                                                  .quantity! +
                                                              1;
                                                          setState(
                                                            () {},
                                                          );
                                                          addUnitData(
                                                              data,
                                                              detailsIndex,
                                                              setState,
                                                              data
                                                                  .details![
                                                                      detailsIndex]
                                                                  .unit!
                                                                  .quantity!,
                                                              context,
                                                              data.productname! +
                                                                  " - " +
                                                                  data
                                                                      .details![
                                                                          detailsIndex]
                                                                      .unit!
                                                                      .unitName!);
                                                          setState(
                                                            () {},
                                                          );
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Stock Limit reached");
                                                        }
                                                      },
                                                      child: Icon(Icons.add)),
                                                ],
                                              ),
                                            )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: data
                                      .details![detailsIndex].product!.length,
                                  itemBuilder: (BuildContext context,
                                      int productsindex) {
                                    return data
                                                .details![detailsIndex]
                                                .product![productsindex]
                                                .subUnit ==
                                            null
                                        ? SizedBox.shrink()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .5,
                                                    child: Text(data
                                                        .details![detailsIndex]
                                                        .product![productsindex]
                                                        .subUnit!
                                                        .subUnitName!),
                                                  ),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff292929),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 4,
                                                            blurRadius: 4,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Row(
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  if (data
                                                                          .details![
                                                                              detailsIndex]
                                                                          .product![
                                                                              productsindex]
                                                                          .subUnit!
                                                                          .quantity !=
                                                                      0) {
                                                                    data
                                                                        .details![
                                                                            detailsIndex]
                                                                        .product![
                                                                            productsindex]
                                                                        .subUnit!
                                                                        .quantity = data
                                                                            .details![detailsIndex]
                                                                            .product![productsindex]
                                                                            .subUnit!
                                                                            .quantity! -
                                                                        1;
                                                                    setState(
                                                                      () {},
                                                                    );
                                                                    addSubUnitData(
                                                                        data.details![detailsIndex].product![
                                                                            productsindex],
                                                                        setState,
                                                                        data
                                                                            .details![
                                                                                detailsIndex]
                                                                            .product![
                                                                                productsindex]
                                                                            .subUnit!
                                                                            .quantity!,
                                                                        context,
                                                                        data.productname! +
                                                                            " - " +
                                                                            data.details![detailsIndex].unit!.unitName! +
                                                                            " " +
                                                                            "(" +
                                                                            data.details![detailsIndex].product![productsindex].subUnit!.subUnitName! +
                                                                            ")");
                                                                    setState(
                                                                      () {},
                                                                    );
                                                                  }
                                                                },
                                                                child: Icon(Icons
                                                                    .remove)),
                                                            Text(
                                                              data
                                                                  .details![
                                                                      detailsIndex]
                                                                  .product![
                                                                      productsindex]
                                                                  .subUnit!
                                                                  .quantity!
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                            InkWell(
                                                                onTap: () {
                                                                  if (data
                                                                          .details![
                                                                              detailsIndex]
                                                                          .product![
                                                                              productsindex]
                                                                          .availableQuantity! >
                                                                      data.details![detailsIndex].product![productsindex].subUnit!
                                                                              .quantity! +
                                                                          1) {
                                                                    data
                                                                        .details![
                                                                            detailsIndex]
                                                                        .product![
                                                                            productsindex]
                                                                        .subUnit!
                                                                        .quantity = data
                                                                            .details![detailsIndex]
                                                                            .product![productsindex]
                                                                            .subUnit!
                                                                            .quantity! +
                                                                        1;
                                                                    setState(
                                                                      () {},
                                                                    );
                                                                    addSubUnitData(
                                                                        data.details![detailsIndex].product![
                                                                            productsindex],
                                                                        setState,
                                                                        data
                                                                            .details![
                                                                                detailsIndex]
                                                                            .product![
                                                                                productsindex]
                                                                            .subUnit!
                                                                            .quantity!,
                                                                        context,
                                                                        data.productname! +
                                                                            " - " +
                                                                            data.details![detailsIndex].unit!.unitName! +
                                                                            " " +
                                                                            "(" +
                                                                            data.details![detailsIndex].product![productsindex].subUnit!.subUnitName! +
                                                                            ")");
                                                                    setState(
                                                                      () {},
                                                                    );
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                "Stock Limit reached");
                                                                  }
                                                                },
                                                                child: Icon(
                                                                    Icons.add)),
                                                          ],
                                                        ),
                                                      )),
                                                ]),
                                          );
                                  },
                                ),
                              ),
                              Divider(
                                indent: 5,
                                color: Colors.white54,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ])))
        ],
      );
    });
  }

  int getindex(list, id) {
    return list.indexWhere((element) => element.unitId!.id == id);
  }

  addUnitData(
      data, detailsIndex, setState, quantity, BuildContext context, name) {
    var contain = context.read<GetEchoShopCartManagementBloc>().cartData!.where(
        (element) =>
            element['itemId'] ==
            data
                .details![detailsIndex]
                .product![getindex(data.details![detailsIndex].product!,
                    data.details![detailsIndex].unit!.id)]
                .id);

    if (contain.isNotEmpty) {
      for (int i = 0;
          i < context.read<GetEchoShopCartManagementBloc>().cartData!.length;
          i++) {
        if (context.read<GetEchoShopCartManagementBloc>().cartData![i]
                ['itemId'] ==
            data
                .details![detailsIndex]
                .product![getindex(data.details![detailsIndex].product!,
                    data.details![detailsIndex].unit!.id)]
                .id) {
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
              "itemId": data
                  .details![detailsIndex]
                  .product![getindex(data.details![detailsIndex].product!,
                      data.details![detailsIndex].unit!.id)]
                  .id,
              "quantity": quantity,
              "totalamount": quantity *
                  data
                      .details![detailsIndex]
                      .product![getindex(data.details![detailsIndex].product!,
                          data.details![detailsIndex].unit!.id)]
                      .price,
              "productName": name
            })
          : {};
      setState(
        () {},
      );
    }
    BlocProvider.of<GetEchoShopCartManagementBloc>(context).add(ViewCart());
  }

  addSubUnitData(product, setState, quantity, BuildContext context, name) {
    var contain = context
        .read<GetEchoShopCartManagementBloc>()
        .cartData!
        .where((element) => element['itemId'] == product.id);

    if (contain.isNotEmpty) {
      for (int i = 0;
          i < context.read<GetEchoShopCartManagementBloc>().cartData!.length;
          i++) {
        if (context.read<GetEchoShopCartManagementBloc>().cartData![i]
                ['itemId'] ==
            product.id) {
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
              "itemId": product.id,
              "quantity": quantity,
              "totalamount": product.price,
              "productName": name
            })
          : {};
      setState(
        () {},
      );
    }
    BlocProvider.of<GetEchoShopCartManagementBloc>(context).add(ViewCart());
  }
}
