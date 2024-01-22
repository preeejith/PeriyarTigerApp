//////////add product
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/productdeletebloc/productdeletebloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/productdeletebloc/productdeletestate.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/producteditbloc/producteditbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/producteditbloc/producteditstate.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproductdetailedbloc_main/viewproduct_blocdetailed.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproductdetailedbloc_main/viewproduct_eventdetailed.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproductdetailedbloc_main/viewproduct_statedetailed.dart';
import 'package:parambikulam/ui/assets/bottomnav.dart';

class ProductMainEdit extends StatefulWidget {
  final String productid;
  final String productspeciality;
  final String productname;
  final String productweight;
  final String productdescription;
  final String producttype;
  const ProductMainEdit(
      {Key? key,
      required this.productid,
      required this.productname,
      required this.productweight,
      required this.productspeciality,
      required this.producttype,
      required this.productdescription})
      : super(key: key);

  @override
  State<ProductMainEdit> createState() => _ProductMainEditState();
}

class _ProductMainEditState extends State<ProductMainEdit> {
  void initState() {
    fetcher();

    super.initState();
  }

  final TextEditingController remarkcontroller = TextEditingController();
  void fetcher() async {
    BlocProvider.of<GetViewProductMainDetailedBloc>(context)
        .add(GetViewProductMainDetailed(
      productId: widget.productid,
    ));
  }

  bool? deleteon = false;
  String dropdownvalue = '';
  bool? value = false;
  bool? listview = true;
  bool? varientbutton = false;
  List<String> images3 = [];
  List<String> images4 = [];

  ProductsModel addproductslist = ProductsModel(units: []);
  //hello
  List<ProductUnitModel> productUnitModellist = [];

  final TextEditingController productnamecontroller = TextEditingController();
  final TextEditingController productunittypecontroller =
      TextEditingController();
  final TextEditingController specialitycontroller = TextEditingController();
  final TextEditingController productdescriptioncontroller =
      TextEditingController();
  final TextEditingController productpricecontroller = TextEditingController();
  final TextEditingController productweightcontroller = TextEditingController();
  final TextEditingController productquantitycontroller =
      TextEditingController();

  final TextEditingController unitnamecontroller = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  final TextEditingController subunitnamecontroller = TextEditingController();
  final TextEditingController substockController = TextEditingController();
  final TextEditingController subpricecontroller = TextEditingController();
  final TextEditingController subweightController = TextEditingController();

  final TextEditingController producttypecontroller = TextEditingController();
  // final TextEditingController specialityController = TextEditingController();

  List<String> images = [];
  String coverImage = "";

  final TextEditingController qunatitycontroller = TextEditingController();
  // final TextEditingController remarkcontroller = TextEditingController();
  final TextEditingController productdidcontroller = TextEditingController();

  bool unitDisplay = false;

  Widget addunit() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: MaterialButton(
                color: Colors.green,
                child: Row(children: [
                  Text("Add"),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  )
                ]),
                onPressed: () {
                  setState(() {
                    unitDisplay = true;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget addSubUnits(i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: MaterialButton(
            color: Colors.green,
            child: Text("Add SubUnits"),
            onPressed: () {
              if (productnamecontroller.text.isEmpty) {
                Fluttertoast.showToast(
                    backgroundColor: Colors.white,
                    msg: "Please Enter Product Name.",
                    textColor: Colors.black);
              } else if (productdescriptioncontroller.text.isEmpty) {
                Fluttertoast.showToast(
                    backgroundColor: Colors.white,
                    msg: "Please Enter Product Description",
                    textColor: Colors.black);
              }

              // else if (productpricecontroller.text.isEmpty) {
              //   Fluttertoast.showToast(msg: "Please Enter Price");
              // }

              else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: SizedBox(
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: const Text('Add SubTypes'),
                          content: Column(children: [
                            Column(
                              children: [
                                TextFormField(
                                    //noted
                                    controller: subunitnamecontroller,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      labelText: 'Product SubType Name',
                                    ),
                                    onChanged: (string) {}),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  maxLength: 6,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  controller: subpricecontroller,
                                  inputFormatters: const [],
                                  decoration: const InputDecoration(
                                    labelText: "Product SubType Price ",
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  maxLength: 6,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  controller: substockController,
                                  inputFormatters: const [],
                                  decoration: const InputDecoration(
                                    labelText: "Product SubType Stock ",
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  maxLength: 6,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  controller: subweightController,
                                  inputFormatters: const [],
                                  decoration: const InputDecoration(
                                    labelText: "Product SubType Weight",
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          ]),
                          actions: [
                            MaterialButton(
                              textColor: Colors.black,
                              onPressed: () {
                                Navigator.pop(context);

                                setState(() {
                                  subunitnamecontroller.clear();
                                  subpricecontroller.clear();
                                  substockController.clear();
                                  subweightController.clear();
                                });
                              },
                              child: const Text(
                                'CANCEL',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            MaterialButton(
                              child: Text("SUBMIT"),
                              onPressed: () {
                                if (subunitnamecontroller.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Unit Name");
                                } else if (substockController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Unit Stock");
                                } else if (subweightController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Unit Weight");
                                } else if (subpricecontroller.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Unit Price");
                                } else {
                                  //insert2
                                  ProductSubUnitModel productSubUnitModel =
                                      ProductSubUnitModel();

                                  productSubUnitModel.subUnitName =
                                      subunitnamecontroller.text;
                                  productSubUnitModel.price =
                                      subpricecontroller.text;
                                  productSubUnitModel.weight =
                                      subweightController.text;
                                  productSubUnitModel.stock =
                                      substockController.text;

                                  productUnitModellist[i]
                                      .subUnits!
                                      .add(productSubUnitModel);

                                  Navigator.pop(context);

                                  setState(() {
                                    subunitnamecontroller.clear();
                                    subpricecontroller.clear();
                                    substockController.clear();
                                    subweightController.clear();
                                  });
                                }
                              },
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }

  Widget addedunitlist() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: productUnitModellist.length,
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
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(""),
                                InkWell(
                                  child: const Icon(Icons.cancel_outlined,
                                      color: Colors.grey),
                                  onTap: () {
                                    setState(() {
                                      productUnitModellist.removeAt(index);
                                    });
                                  },
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Unit Name  :",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  productUnitModellist[index]
                                      .unitName
                                      .toString(),
                                  // addproductslist.units![index].unitName
                                  //     .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Quantity  :",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  productUnitModellist[index].stock.toString(),
                                  // addproductslist.units![index].stock
                                  //     .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Price  :",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  productUnitModellist[index].price.toString(),
                                  // addproductslist.units![index].price
                                  //     .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Weight  :",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  productUnitModellist[index].weight.toString(),
                                  // addproductslist.units![index].weight
                                  //     .toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                )
                              ]),
                        ),
                        addSubUnits(index),
                        productUnitModellist[index].subUnits != null
                            ? addedSubUnitslist(index)
                            : SizedBox.shrink(),
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

  Widget addedSubUnitslist(i) {
    print(productUnitModellist[i].subUnits!.length);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: productUnitModellist[i].subUnits!.length,
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
                                Text(productUnitModellist[i]
                                    .subUnits![index]
                                    .subUnitName
                                    .toString()),
                                InkWell(
                                  child: const Icon(Icons.close,
                                      color: Colors.white),
                                  onTap: () {
                                    setState(() {
                                      setState(() {
                                        productUnitModellist[i]
                                            .subUnits!
                                            .removeAt(index);
                                      });
                                    });
                                  },
                                ),
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
                                // SizedBox(width:10),
                                Expanded(
                                  child: Text(
                                    productUnitModellist[i]
                                        .subUnits![index]
                                        .stock
                                        .toString(),
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
                                    productUnitModellist[i]
                                        .subUnits![index]
                                        .price
                                        .toString(),
                                    // addproductslist.units![index].price
                                    //     .toString(),
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
                                    productUnitModellist[i]
                                        .subUnits![index]
                                        .weight
                                        .toString(),
                                    // addproductslist.units![index].weight
                                    //     .toString(),
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

  Widget _addunitForm() {
    return Column(children: [
      Column(
        children: [
          TextFormField(
              //noted
              controller: unitnamecontroller,
              autocorrect: true,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Product Type Name',
              ),
              onChanged: (string) {}),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            controller: pricecontroller,
            inputFormatters: const [],
            decoration: const InputDecoration(
              labelText: "Price ",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            controller: stockController,
            inputFormatters: const [],
            decoration: const InputDecoration(
              labelText: "Stock ",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            controller: weightController,
            inputFormatters: const [],
            decoration: const InputDecoration(
              labelText: "Weight",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pop(context);

                  setState(() {
                    unitnamecontroller.clear();
                    pricecontroller.clear();
                    stockController.clear();
                    weightController.clear();
                  });
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                child: Text("SUBMIT"),
                onPressed: () {
                  if (unitnamecontroller.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter Unit Name");
                  } else if (stockController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter Unit Stock");
                  } else if (weightController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter Unit Weight");
                  } else if (pricecontroller.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please Enter Unit Price");
                  } else {
                    ProductUnitModel productUnitModel = ProductUnitModel();
                    productUnitModel.unitName = unitnamecontroller.text;
                    productUnitModel.price = pricecontroller.text;
                    productUnitModel.weight = weightController.text;
                    productUnitModel.stock = stockController.text;
                    productUnitModel.subUnits = [];

                    ///ssubUnits

                    productUnitModellist.add(productUnitModel);

                    setState(() {
                      unitDisplay = false;
                      unitnamecontroller.clear();
                      pricecontroller.clear();
                      stockController.clear();
                      weightController.clear();
                    });
                  }
                },
                color: Colors.green,
              ),
            ],
          ),
        ],
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Product"), actions: [
        Container(
          height: 15,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: deleteon != true
                ? Container()
                : MaterialButton(
                    color: Colors.green,
                    //  child: Text("Delete")
                    onPressed: () {
                      // BlocProvider.of<GetProductDeleteBloc>(context)
                      //     .add(GetProductDelete(
                      //   productId: widget.productid,
                      // ));
                    },

                    child:
                        BlocConsumer<GetProductDeleteBloc, ProductDeleteState>(
                            builder: (context, state) {
                      if (state is ProductDeleteing) {
                        return const SizedBox(
                          height: 18.0,
                          width: 18.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                            strokeWidth: 2,
                          ),
                        );
                      } else {
                        return Text(
                          "Delete",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        );
                      }
                    }, listener: (context, state) {
                      if (state is ProductDeletesuccess) {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.white,
                            msg: "Products deleted ",
                            textColor: Colors.black);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomerBottomNavigation()));
                      }
                    }),
                  ),
          ),
        )
      ]),
      bottomNavigationBar: BlocConsumer<GetViewProductMainDetailedBloc,
          ViewProductMainDetailedState>(
        builder: (context, state) {
          if (state is ViewProductMainDetailedsuccess) {
            return SizedBox(
              height: 60,
              child: Column(
                children: [
                  MaterialButton(
                    height: 40,
                    minWidth: 300,
                    onPressed: () {
                      for (int k = 0;
                          k < state.viewProductMainDetailedModel.data!.length;
                          k++) {
                        if (state.viewProductMainDetailedModel.data![k].unit !=
                            null) {
                          ProductUnitModel productUnitModel =
                              ProductUnitModel();
                          productUnitModel.unitName = state
                              .viewProductMainDetailedModel
                              .data![k]
                              .unit!
                              .unitnamecontroller
                              .text
                              .toString();
                          productUnitModel.price = state
                              .viewProductMainDetailedModel
                              .data![k]
                              .unit!
                              .pricecontroller
                              .text;
                          //ok
                          productUnitModel.weight = state
                              .viewProductMainDetailedModel
                              .data![k]
                              .unit!
                              .weigthcontroller
                              .text
                              .toString();
                          productUnitModel.stock = state
                              .viewProductMainDetailedModel
                              .data![k]
                              .unit!
                              .totalquantitycontroller
                              .text
                              .toString();

                          productUnitModel.unitId = state
                              .viewProductMainDetailedModel.data![k].unit!.id
                              .toString();
                          productUnitModel.subUnits = [];

                          ///ssubUnits

                          productUnitModellist.add(productUnitModel);

                          for (int i = 0;
                              i <
                                  state.viewProductMainDetailedModel.data![k]
                                      .product!.length;
                              i++) {
                            if (state.viewProductMainDetailedModel.data![k]
                                    .product !=
                                null) {
                              if (state.viewProductMainDetailedModel.data![k]
                                      .product![i].subUnit !=
                                  null) {
                                // state
                                //         .viewProductMainDetailedModel
                                //         .data![k]
                                //         .product![i]
                                //         .subUnit!
                                //         .subunitnamecontroller
                                //         .text =
                                //     state.viewProductMainDetailedModel.data![k]
                                //         .product![i].subUnit!.subUnitName
                                //         .toString();

                                // state
                                //         .viewProductMainDetailedModel
                                //         .data![k]
                                //         .product![i]
                                //         .subUnit!
                                //         .subunitweightcontroller
                                //         .text =
                                //     state.viewProductMainDetailedModel.data![k]
                                //         .product![i].totalQuantity
                                //         .toString();
                                // state
                                //         .viewProductMainDetailedModel
                                //         .data![k]
                                //         .product![i]
                                //         .subUnit!
                                //         .subunitpricecontroller
                                //         .text =
                                //     state.viewProductMainDetailedModel.data![k]
                                //         .product![i].price
                                //         .toString();

                                ///to addd to list fot edit purpose
                                ProductSubUnitModel productSubUnitModel =
                                    ProductSubUnitModel();

                                productSubUnitModel.subUnitName = state
                                    .viewProductMainDetailedModel
                                    .data![k]
                                    .product![i]
                                    .subUnit!
                                    .subunitnamecontroller
                                    .text
                                    .toString();
                                productSubUnitModel.price = state
                                    .viewProductMainDetailedModel
                                    .data![k]
                                    .product![i]
                                    .subUnit!
                                    .subunitpricecontroller
                                    .text
                                    .toString();
                                //change
                                productSubUnitModel.weight = state
                                    .viewProductMainDetailedModel
                                    .data![k]
                                    .product![i]
                                    .subUnit!
                                    .subunitweightcontroller
                                    .text
                                    .toString();
                                productSubUnitModel.stock = state
                                    .viewProductMainDetailedModel
                                    .data![k]
                                    .product![i]
                                    .subUnit!
                                    .subunitweightcontroller
                                    .text
                                    .toString();
                                productSubUnitModel.subUnitId = state
                                    .viewProductMainDetailedModel
                                    .data![k]
                                    .product![i]
                                    .subUnit!
                                    .id
                                    .toString();

                                for (int r = 0;
                                    r < productUnitModellist.length;
                                    r++) {
                                  if (r == productUnitModellist.length) {
                                    productUnitModellist[
                                            productUnitModellist.length - 1]
                                        .subUnits!
                                        .add(productSubUnitModel);
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                      validateData();
                    },
                    child: BlocConsumer<GetProductMainEditBloc,
                        ProductMainEditState>(builder: (context, state) {
                      if (state is ProductMainEditing) {
                        return const SizedBox(
                          height: 18.0,
                          width: 18.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                            strokeWidth: 2,
                          ),
                        );
                      } else {
                        return const Text(
                          "SUBMIT",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        );
                      }
                    }, listener: (context, state) {
                      if (state is ProductMainEditsuccess) {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.white,
                            msg: state.productEditModeldart.msg.toString(),
                            textColor: Colors.black);

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomerBottomNavigation()));
                      }
                    }),
                    color: Colors.green,
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
        //////
        listener: (context, state) {
          if (state is ViewProductMainDetailedsuccess) {
            // productnamecontroller.text = widget.productname;
            // productdescriptioncontroller.text = widget.productdescription;
            // specialitycontroller.text = widget.productspeciality;
            // productweightcontroller.text = widget.productweight;

            // productunittypecontroller.text = widget.producttype;
//             for (int k = 0;
//                 k < state.viewProductMainDetailedModel.data!.length;
//                 k++) {
//               if (state.viewProductMainDetailedModel.data![k].unit != null) {
//                 // state.viewProductMainDetailedModel.data![k].unit!
//                 //         .unitnamecontroller.text =
//                 //     state.viewProductMainDetailedModel.data![k].unit!.unitName
//                 //         .toString();

//                 // state.viewProductMainDetailedModel.data![k].unit!
//                 //         .weigthcontroller.text =
//                 //     state.viewProductMainDetailedModel.data![k].unit!.weight
//                 //         .toString();

//                 // state.viewProductMainDetailedModel.data![k].unit!
//                 //         .totalquantitycontroller.text =
//                 //     state.viewProductMainDetailedModel.data![k].product![0]
//                 //         .totalQuantity
//                 //         .toString();

//                 // state.viewProductMainDetailedModel.data![k].unit!
//                 //         .pricecontroller.text =
//                 //     state
//                 //         .viewProductMainDetailedModel.data![k].product![0].price
//                 //         .toString();
// //editadd
//                 ProductUnitModel productUnitModel = ProductUnitModel();
//                 productUnitModel.unitName = state.viewProductMainDetailedModel
//                     .data![k].unit!.unitnamecontroller
//                     .toString();
//                 productUnitModel.price = state
//                     .viewProductMainDetailedModel.data![k].unit!.pricecontroller
//                     .toString();
//                 //ok
//                 productUnitModel.weight = state.viewProductMainDetailedModel
//                     .data![k].unit!.weigthcontroller
//                     .toString();
//                 productUnitModel.stock = state.viewProductMainDetailedModel
//                     .data![k].unit!.totalquantitycontroller.text
//                     .toString();

//                 productUnitModel.unitId = state
//                     .viewProductMainDetailedModel.data![k].unit!.id
//                     .toString();
//                 productUnitModel.subUnits = [];

//                 ///ssubUnits

//                 productUnitModellist.add(productUnitModel);

//                 for (int i = 0;
//                     i <
//                         state.viewProductMainDetailedModel.data![k].product!
//                             .length;
//                     i++) {
//                   if (state.viewProductMainDetailedModel.data![k].product !=
//                       null) {
//                     if (state.viewProductMainDetailedModel.data![k].product![i]
//                             .subUnit !=
//                         null) {
//                       state.viewProductMainDetailedModel.data![k].product![i]
//                               .subUnit!.subunitnamecontroller.text =
//                           state.viewProductMainDetailedModel.data![k]
//                               .product![i].subUnit!.subUnitName
//                               .toString();

//                       state.viewProductMainDetailedModel.data![k].product![i]
//                               .subUnit!.subunitweightcontroller.text =
//                           state.viewProductMainDetailedModel.data![k]
//                               .product![i].totalQuantity
//                               .toString();
//                       state.viewProductMainDetailedModel.data![k].product![i]
//                               .subUnit!.subunitpricecontroller.text =
//                           state.viewProductMainDetailedModel.data![k]
//                               .product![i].price
//                               .toString();

//                       ///to addd to list fot edit purpose
//                       ProductSubUnitModel productSubUnitModel =
//                           ProductSubUnitModel();

//                       productSubUnitModel.subUnitName = state
//                           .viewProductMainDetailedModel
//                           .data![k]
//                           .product![i]
//                           .subUnit!
//                           .subunitnamecontroller
//                           .toString();
//                       productSubUnitModel.price = state
//                           .viewProductMainDetailedModel
//                           .data![k]
//                           .product![i]
//                           .subUnit!
//                           .subunitpricecontroller
//                           .toString();
//                       //change
//                       productSubUnitModel.weight = state
//                           .viewProductMainDetailedModel
//                           .data![k]
//                           .product![i]
//                           .subUnit!
//                           .subunitweightcontroller
//                           .toString();
//                       productSubUnitModel.stock = state
//                           .viewProductMainDetailedModel
//                           .data![k]
//                           .product![i]
//                           .subUnit!
//                           .subunitweightcontroller
//                           .toString();
//                       productSubUnitModel.subUnitId = state
//                           .viewProductMainDetailedModel
//                           .data![k]
//                           .product![i]
//                           .subUnit!
//                           .id
//                           .toString();

//                       for (int r = 0; r < productUnitModellist.length; r++) {
//                         productUnitModellist[productUnitModellist.length - 1]
//                             .subUnits!
//                             .add(productSubUnitModel);
//                       }
//                     }
//                   }
//                 }
//               }
//             }
          }
        },
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: productnamecontroller,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: productdescriptioncontroller,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                controller: specialitycontroller,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Speciality',
                ),
              ),
              TextFormField(
                maxLength: 8,
                textInputAction: TextInputAction.done,
                controller: productweightcontroller,
                autocorrect: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight of Product',
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Unit Type'),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(dropdownvalue == ""
                            ? widget.producttype
                            : dropdownvalue),
                        Spacer(),
                        DropdownButton<String>(
                          items:
                              <String>['Grams', 'Counts'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdownvalue = value!;
                              productunittypecontroller.text = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
              SizedBox(
                height: 15,
              ),

              ///previous place
              // Row(children: [
              //   Text("Do you want to add variants..?"),
              //   Checkbox(
              //     value: this.value,
              //     activeColor: Colors.green,
              //     onChanged: (bool? value) {
              //       setState(() {
              //         this.value = value;
              //         setState(() {
              //           varientbutton == false
              //               ? varientbutton = true
              //               : varientbutton = false;
              //         });
              //       });
              //     },
              //   ),
              // ]),
              // varientbutton != true
              //     ? Container(
              //         // child: Column(children: [
              //         //   TextFormField(
              //         //     textInputAction: TextInputAction.done,
              //         //     controller: productpricecontroller,
              //         //     autocorrect: true,
              //         //     keyboardType: TextInputType.number,
              //         //     decoration: const InputDecoration(
              //         //       labelText: 'Product Price',
              //         //     ),
              //         //   ),
              //         //   TextFormField(
              //         //     textInputAction: TextInputAction.done,
              //         //     controller: productquantitycontroller,
              //         //     autocorrect: true,
              //         //     keyboardType: TextInputType.number,
              //         //     decoration: const InputDecoration(
              //         //       labelText: 'Product Quantity',
              //         //     ),
              //         //   ),
              //         //   SizedBox(
              //         //     height: 10,
              //         //   ),
              //         // ]),
              //         )
              //     : Container(
              //         child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               SizedBox(
              //                 height: 16,
              //               ),
              //               Text("Add Product Variants"),
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               addunit(),
              //               unitDisplay ? _addunitForm() : SizedBox.shrink(),
              //               productUnitModellist != null
              //                   ? addedunitlist()
              //                   //  ? addedunitlist()

              //                   : SizedBox.shrink(),
              //             ]),
              //       ),
              BlocConsumer<GetViewProductMainDetailedBloc,
                  ViewProductMainDetailedState>(
                builder: (context, state) {
                  if (state is ViewProductMainDetailedsuccess) {
                    return Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          state.viewProductMainDetailedModel.data![0].unit ==
                                  null
                              ? Container()
                              : Container(
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: state
                                            .viewProductMainDetailedModel
                                            .data!
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          print(state
                                              .viewProductMainDetailedModel
                                              .data!);
                                          return ListTile(
                                              title: InkWell(
                                            child: Column(children: [
                                              InkWell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            2,
                                                    // height: MediaQuery.of(context).size.height / 3.5,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xfff292929),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
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
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        children: [
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
                                                                state.viewProductMainDetailedModel.data![index]
                                                                            .unit ==
                                                                        null
                                                                    ? Container()
                                                                    : Column(
                                                                        children: [
                                                                          Text(
                                                                            "Variant",
                                                                            style:
                                                                                TextStyle(fontSize: 12),
                                                                          ),
                                                                          TextFormField(
                                                                            textInputAction:
                                                                                TextInputAction.done,
                                                                            controller:
                                                                                state.viewProductMainDetailedModel.data![index].unit!.unitnamecontroller,
                                                                            autocorrect:
                                                                                true,
                                                                            keyboardType:
                                                                                TextInputType.text,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              labelText: 'Name',
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          ////newchnanges
                                                                          state.viewProductMainDetailedModel.data![index].product == null
                                                                              ? Container()
                                                                              : state.viewProductMainDetailedModel.data![index].product![0].subUnit != null
                                                                                  ? Container()
                                                                                  : TextFormField(
                                                                                      textInputAction: TextInputAction.done,
                                                                                      controller: state.viewProductMainDetailedModel.data![index].unit!.weigthcontroller,
                                                                                      autocorrect: true,
                                                                                      keyboardType: TextInputType.number,
                                                                                      decoration: const InputDecoration(
                                                                                        labelText: 'Weight',
                                                                                      ),
                                                                                    ),
                                                                          ////no total quantity
                                                                          // SizedBox(
                                                                          //   height:
                                                                          //       5,
                                                                          // ),

                                                                          // ///new chnages
                                                                          // state.viewProductMainDetailedModel.data![index].product == null
                                                                          //     ? Container()
                                                                          //     : state.viewProductMainDetailedModel.data![index].product![0].subUnit != null
                                                                          //         ? Container()
                                                                          //         : TextFormField(
                                                                          //             textInputAction: TextInputAction.done,
                                                                          //             controller: state.viewProductMainDetailedModel.data![index].unit!.totalquantitycontroller,
                                                                          //             autocorrect: true,
                                                                          //             keyboardType: TextInputType.number,
                                                                          //             decoration: const InputDecoration(
                                                                          //               labelText: 'Total Qunatity ',
                                                                          //             ),
                                                                          //           ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          //new added
                                                                          state.viewProductMainDetailedModel.data![index].product == null
                                                                              ? Container()
                                                                              : state.viewProductMainDetailedModel.data![index].product![0].subUnit != null
                                                                                  ? Container()
                                                                                  : TextFormField(
                                                                                      textInputAction: TextInputAction.done,
                                                                                      controller: state.viewProductMainDetailedModel.data![index].unit!.pricecontroller,
                                                                                      autocorrect: true,
                                                                                      keyboardType: TextInputType.number,
                                                                                      decoration: const InputDecoration(
                                                                                        labelText: 'Price',
                                                                                      ),
                                                                                    ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                        ],
                                                                      ),

                                                                const SizedBox(
                                                                  height: 10,
                                                                ),

                                                                ///next List
                                                                ///
                                                                state
                                                                            .viewProductMainDetailedModel
                                                                            .data![
                                                                                index]
                                                                            .product ==
                                                                        null
                                                                    ? Container()
                                                                    : ListView
                                                                        .builder(
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: state
                                                                            .viewProductMainDetailedModel
                                                                            .data![index]
                                                                            .product!
                                                                            .length,
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index2) {
                                                                          return ListTile(
                                                                              title: InkWell(
                                                                            child: state.viewProductMainDetailedModel.data![index].product![index2].subUnit == null
                                                                                ? Container()
                                                                                : Column(children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(1.0),
                                                                                      child: Container(
                                                                                        width: MediaQuery.of(context).size.width * 2,
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
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.all(8.0),
                                                                                                child: Column(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Container(
                                                                                                      width: 220,
                                                                                                      child: TextFormField(
                                                                                                        textInputAction: TextInputAction.next,
                                                                                                        controller: state.viewProductMainDetailedModel.data![index].product![index2].subUnit!.subunitnamecontroller,
                                                                                                        autocorrect: true,
                                                                                                        keyboardType: TextInputType.text,
                                                                                                        decoration: const InputDecoration(
                                                                                                          labelText: 'Name',
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 5,
                                                                                                    ),

                                                                                                    Container(
                                                                                                      width: 220,
                                                                                                      child: TextFormField(
                                                                                                        textInputAction: TextInputAction.next,
                                                                                                        controller: state.viewProductMainDetailedModel.data![index].product![index2].subUnit!.subunitweightcontroller,
                                                                                                        autocorrect: true,
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        decoration: const InputDecoration(
                                                                                                          labelText: 'weight',
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 5,
                                                                                                    ),
                                                                                                    Container(
                                                                                                      width: 220,
                                                                                                      child: TextFormField(
                                                                                                        textInputAction: TextInputAction.next,
                                                                                                        controller: state.viewProductMainDetailedModel.data![index].product![index2].subUnit!.subunitpricecontroller,
                                                                                                        autocorrect: true,
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        decoration: const InputDecoration(
                                                                                                          labelText: 'price',
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    // SizedBox(
                                                                                                    //   height: 5,
                                                                                                    // ),
                                                                                                    // Row(
                                                                                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    //   children: [
                                                                                                    //     Text(
                                                                                                    //       "Name:  ",
                                                                                                    //       style: TextStyle(fontSize: 12),
                                                                                                    //     ),
                                                                                                    //     Text(
                                                                                                    //       state.viewProductMainDetailedModel.data![index].product![index2].subUnit != null ? state.viewProductMainDetailedModel.data![index].product![index2].subUnit!.subUnitName.toString() : "",
                                                                                                    //       style: TextStyle(fontSize: 12),
                                                                                                    //     ),
                                                                                                    //   ],
                                                                                                    // ),
                                                                                                    // const SizedBox(
                                                                                                    //   height: 10,
                                                                                                    // ),
                                                                                                    // Row(
                                                                                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    //   children: [
                                                                                                    //     Text(
                                                                                                    //       "Total Quantity:  ",
                                                                                                    //       style: TextStyle(fontSize: 12),
                                                                                                    //     ),
                                                                                                    //     Text(
                                                                                                    //       state.viewProductMainDetailedModel.data![index].unit == null ? "" : state.viewProductMainDetailedModel.data![index].product![index2].totalQuantity.toString(),
                                                                                                    //       style: TextStyle(fontSize: 12),
                                                                                                    //     ),
                                                                                                    //   ],
                                                                                                    // ),
                                                                                                    // const SizedBox(
                                                                                                    //   height: 10,
                                                                                                    // ),
                                                                                                    // Row(
                                                                                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    //   children: [
                                                                                                    //     Text(
                                                                                                    //       "Price:  ",
                                                                                                    //       style: TextStyle(fontSize: 12),
                                                                                                    //     ),
                                                                                                    //     Text(
                                                                                                    //       state.viewProductMainDetailedModel.data![index].unit == null ? "" : state.viewProductMainDetailedModel.data![index].product![index2].price.toString(),
                                                                                                    //       style: TextStyle(fontSize: 12),
                                                                                                    //     ),
                                                                                                    //   ],
                                                                                                    // ),
                                                                                                    // const SizedBox(
                                                                                                    //   height: 10,
                                                                                                    // ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
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

                                              ///
                                              SizedBox(
                                                height: 8,
                                              ),
                                            ]),
                                          ));
                                        },
                                      ),
                                      Row(children: [
                                        Text("Do you want to add more..?"),
                                        Checkbox(
                                          value: this.value,
                                          activeColor: Colors.green,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              this.value = value;
                                              setState(() {
                                                varientbutton == false
                                                    ? varientbutton = true
                                                    : varientbutton = false;
                                              });
                                            });
                                          },
                                        ),
                                      ]),
                                      varientbutton != true
                                          ? Container(
                                              // child: Column(children: [
                                              //   TextFormField(
                                              //     textInputAction: TextInputAction.done,
                                              //     controller: productpricecontroller,
                                              //     autocorrect: true,
                                              //     keyboardType: TextInputType.number,
                                              //     decoration: const InputDecoration(
                                              //       labelText: 'Product Price',
                                              //     ),
                                              //   ),
                                              //   TextFormField(
                                              //     textInputAction: TextInputAction.done,
                                              //     controller: productquantitycontroller,
                                              //     autocorrect: true,
                                              //     keyboardType: TextInputType.number,
                                              //     decoration: const InputDecoration(
                                              //       labelText: 'Product Quantity',
                                              //     ),
                                              //   ),
                                              //   SizedBox(
                                              //     height: 10,
                                              //   ),
                                              // ]),
                                              )
                                          : Container(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    Text(
                                                        "Add Product Variants"),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    addunit(),
                                                    unitDisplay
                                                        ? _addunitForm()
                                                        : SizedBox.shrink(),
                                                    productUnitModellist != []
                                                        ? addedunitlist()
                                                        // ? addedunitlist()

                                                        : SizedBox.shrink(),
                                                  ]),
                                            ),
                                    ],
                                  ),
                                ),
                        ]));
                  } else {
                    return Center(
                      child: SizedBox(
                        height: 28.0,
                        width: 28.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                },
                listener: (context, state) {
                  if (state is ViewProductMainDetailedsuccess) {
                    setState(() {
                      deleteon = true;
                    });
                    productnamecontroller.text = widget.productname;
                    productdescriptioncontroller.text =
                        widget.productdescription;
                    specialitycontroller.text = widget.productspeciality;
                    productweightcontroller.text = widget.productweight;

                    productunittypecontroller.text = widget.producttype;
                    for (int k = 0;
                        k < state.viewProductMainDetailedModel.data!.length;
                        k++) {
                      if (state.viewProductMainDetailedModel.data![k].unit !=
                          null) {
                        setState(() {
                          varientbutton = false;
                        });
                        state.viewProductMainDetailedModel.data![k].unit!
                                .unitnamecontroller.text =
                            state.viewProductMainDetailedModel.data![k].unit!
                                .unitName
                                .toString();

                        state.viewProductMainDetailedModel.data![k].unit!
                                .weigthcontroller.text =
                            state.viewProductMainDetailedModel.data![k].unit!
                                .weight
                                .toString();

                        state.viewProductMainDetailedModel.data![k].unit!
                                .totalquantitycontroller.text =
                            state.viewProductMainDetailedModel.data![k]
                                .product![0].totalQuantity
                                .toString();

                        state.viewProductMainDetailedModel.data![k].unit!
                                .pricecontroller.text =
                            state.viewProductMainDetailedModel.data![k]
                                .product![0].price
                                .toString();
//editadd
                        ProductUnitModel productUnitModel = ProductUnitModel();
                        productUnitModel.unitName = state
                            .viewProductMainDetailedModel
                            .data![k]
                            .unit!
                            .unitName
                            .toString();
                        productUnitModel.price = state
                            .viewProductMainDetailedModel
                            .data![k]
                            .product![0]
                            .price
                            .toString();
                        productUnitModel.weight = state
                            .viewProductMainDetailedModel.data![k].unit!.weight
                            .toString();
                        productUnitModel.stock = state
                            .viewProductMainDetailedModel
                            .data![k]
                            .product![0]
                            .totalQuantity
                            .toString();

                        productUnitModel.unitId = state
                            .viewProductMainDetailedModel.data![k].unit!.id
                            .toString();
                        productUnitModel.subUnits = [];

                        ///ssubUnits

                        productUnitModellist.add(productUnitModel);

                        for (int i = 0;
                            i <
                                state.viewProductMainDetailedModel.data![k]
                                    .product!.length;
                            i++) {
                          if (state.viewProductMainDetailedModel.data![k]
                                  .product !=
                              null) {
                            if (state.viewProductMainDetailedModel.data![k]
                                    .product![i].subUnit !=
                                null) {
                              state
                                      .viewProductMainDetailedModel
                                      .data![k]
                                      .product![i]
                                      .subUnit!
                                      .subunitnamecontroller
                                      .text =
                                  state.viewProductMainDetailedModel.data![k]
                                      .product![i].subUnit!.subUnitName
                                      .toString();

                              state
                                      .viewProductMainDetailedModel
                                      .data![k]
                                      .product![i]
                                      .subUnit!
                                      .subunitweightcontroller
                                      .text =
                                  state.viewProductMainDetailedModel.data![k]
                                      .product![i].totalQuantity
                                      .toString();
                              state
                                      .viewProductMainDetailedModel
                                      .data![k]
                                      .product![i]
                                      .subUnit!
                                      .subunitpricecontroller
                                      .text =
                                  state.viewProductMainDetailedModel.data![k]
                                      .product![i].price
                                      .toString();

                              ///to addd to list fot edit purpose
                              ProductSubUnitModel productSubUnitModel =
                                  ProductSubUnitModel();

                              productSubUnitModel.subUnitName = state
                                  .viewProductMainDetailedModel
                                  .data![k]
                                  .product![i]
                                  .subUnit!
                                  .subUnitName
                                  .toString();
                              productSubUnitModel.price = state
                                  .viewProductMainDetailedModel
                                  .data![k]
                                  .product![i]
                                  .price
                                  .toString();
                              //change
                              productSubUnitModel.weight = state
                                  .viewProductMainDetailedModel
                                  .data![k]
                                  .product![i]
                                  .totalQuantity
                                  .toString();
                              productSubUnitModel.stock = state
                                  .viewProductMainDetailedModel
                                  .data![k]
                                  .product![i]
                                  .totalQuantity
                                  .toString();
                              productSubUnitModel.subUnitId = state
                                  .viewProductMainDetailedModel
                                  .data![k]
                                  .product![i]
                                  .subUnit!
                                  .id
                                  .toString();

                              for (int r = 0;
                                  r < productUnitModellist.length;
                                  r++) {
                                productUnitModellist[r]
                                    .subUnits!
                                    .add(productSubUnitModel);
                              }
                            }
                          }
                        }
                      } else {
                        // productpricecontroller.text = state
                        //     .viewProductMainDetailedModel
                        //     .data![0]
                        //     .product![0]
                        //     .price
                        //     .toString();
                        // productquantitycontroller.text = state
                        //     .viewProductMainDetailedModel
                        //     .data![0]
                        //     .product![0]
                        //     .totalQuantity
                        //     .toString();

                        ///varientbutton problem
                        setState(() {
                          varientbutton = false;
                        });
                      }
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

//
  final ImagePicker imgpicker = ImagePicker();
  List<XFile> imagefiles = [];
  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  final ImagePicker imgpicker2 = ImagePicker();
  List<XFile> imagefiles2 = [];
  openImages2() async {
    try {
      var pickedfiles = await imgpicker2.pickMultiImage();
      if (pickedfiles != null) {
        imagefiles2 = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

//sobin Chetten
  // void validateData() {
  //   BlocProvider.of<GetAddProductBloc>(context).add(GetAddProduct(
  //     productsModel: addproductslist,
  //   ));
  // }
  void validateData() {
    if (productnamecontroller.text.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Please Enter Product Name.",
          textColor: Colors.black);
    } else if (productdescriptioncontroller.text.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Please Enter Product Description",
          textColor: Colors.black);
    } else if (specialitycontroller.text.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Please Enter Product Speciality",
          textColor: Colors.black);
    } else if (productweightcontroller.text.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Please Enter Product Weigth",
          textColor: Colors.black);
    } else if (productunittypecontroller.text.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Please Enter Product Unit Type",
          textColor: Colors.black);
    } else if (productUnitModellist.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Some Data are Missing",
          textColor: Colors.black);
    } else {
      ProductUnitModel productUnitModel = ProductUnitModel();

      addproductslist.productname = productnamecontroller.text.toString();
      addproductslist.description =
          productdescriptioncontroller.text.toString();
      addproductslist.totalWeight = productweightcontroller.text.toString();
      //ok
      addproductslist.totalPrice = productpricecontroller.text.toString();
      addproductslist.totalQuatity = productquantitycontroller.text.toString();

      addproductslist.speciality = specialitycontroller.text.toString();
      //ok
      addproductslist.unitType = productunittypecontroller.text.toString();
      //ok

      for (int k = 0; k < productUnitModellist.length; k++) {
        productUnitModel.price = productUnitModellist[k].price;
        productUnitModel.stock = productUnitModellist[k].stock;
        productUnitModel.unitName = productUnitModellist[k].unitName;

        productUnitModel.unitId = productUnitModellist[k].unitId;

        for (int j = 0; j < productUnitModellist[k].subUnits!.length; j++) {
          productUnitModel.subUnits?[j].subUnitName =
              productUnitModellist[k].subUnits![j].subUnitName.toString();
          productUnitModel.subUnits?[j].price =
              productUnitModellist[k].subUnits![j].price.toString();
          productUnitModel.subUnits?[j].weight =
              productUnitModellist[k].subUnits![j].weight.toString();
          productUnitModel.subUnits?[j].stock =
              productUnitModellist[k].subUnits![j].stock.toString();
          productUnitModel.subUnits?[j].subUnitId =
              productUnitModellist[k].subUnits![j].subUnitId.toString();
        }

        // addproductslist.units!
        //     .insert(addproductslist.units!.length, productUnitModellist[k]);
        addproductslist.units
            .insert(addproductslist.units.length, productUnitModellist[k]);
//       addproductslist.units!
//           .insert(addproductslist.units!.length, productUnitModellist[k]);
      }
      if (imagefiles.isNotEmpty) {
        for (int a = 0; a < imagefiles.length; a++) {
          images3.add((imagefiles[a].path));
        }
      }

      if (images3.isNotEmpty) {
        for (int b = 0; b < imagefiles2.length; b++) {
          images4.add((imagefiles2[b].path));
        }
      }

      addproductslist.coverImage = images4 == [] ? [""] : images4;
      addproductslist.photos = images3 == [] ? [""] : images3;

      // BlocProvider.of<GetProductMainEditBloc>(context).add(GetProductMainEdit(
      //     productsModel: addproductslist, productId: widget.productid));
    }
  }
}

class ProductsModel {
  String? productname;
  String? description;
  String? totalQuatity;
  String? totalPrice;
  String? totalWeight;
  String? speciality;
  String? unitType;

  ///add to it
  //hello
  late List<ProductUnitModel> units = [];
  List<String>? photos;
  List<String>? coverImage;
  // String? coverImage;

  ProductsModel(
      {this.productname,
      this.description,
      this.totalPrice,
      this.totalQuatity,
      this.totalWeight,
      this.speciality,
      this.unitType,
      required this.units,
      this.photos,
      this.coverImage});
}

// Map<String, dynamic> toJson() => {
//         'status': status,
//         '_id': id,
//         'uid': uid,
//         'name': name,
//         'email': email,
//         '__v': v,
//       };
///2 times fulll
///subunitis.length multiple
class ProductUnitModel {
  String? unitName;
  String? unitId;
  String? stock;
  String? weight;
  String? price;
  List<ProductSubUnitModel>? subUnits = [];

  ProductUnitModel(
      {this.unitName,
      this.stock,
      this.weight,
      this.price,
      this.unitId,
      this.subUnits});
}

//insert2
class ProductSubUnitModel {
  String? subUnitName;
  String? subUnitId;
  String? stock;
  String? weight;
  String? price;

  ProductSubUnitModel({
    this.subUnitName,
    this.stock,
    this.subUnitId,
    this.weight,
    this.price,
  });
}
