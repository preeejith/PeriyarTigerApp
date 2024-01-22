import 'dart:io';
//////////add product///////main
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/addproductbloc/addproductbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/addproductbloc/addproductevent.dart';

import 'package:parambikulam/bloc/assets/new/addproductbloc/addproductbloc.dart';
import 'package:parambikulam/bloc/assets/new/addproductbloc/addproductstate.dart';

import 'package:parambikulam/ui/assets/bottomnav.dart';

import '../../../bloc/assets/new/addproductbloc/addproductevent.dart';

class AddProductMain extends StatefulWidget {
  const AddProductMain({Key? key}) : super(key: key);

  @override
  State<AddProductMain> createState() => _AddProductMainState();
}

class _AddProductMainState extends State<AddProductMain> {
////////
  String dropdownvalue = 'Grams';

  var items = [
    'Grams',
    'Counts',
  ];
  bool? subunits = true;
  bool? questionoff = false;
  bool? liston = false;
  bool? value = false;
  bool? value2 = false;
  bool? checkon = false;
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
  final TextEditingController specialityController = TextEditingController();

  List<String> images = [];
  String coverImage = "";

  final TextEditingController qunatitycontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();
  final TextEditingController productdidcontroller = TextEditingController();

  bool unitDisplay = false;

  Widget addunit() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
                color: Colors.green,
                child: Row(children: [
                  Text("Add Units"),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  )
                ]),
                onPressed: () {
                  ///important chnages
                  // setState(() {

                  //   unitDisplay = true;
                  // });

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Add '),
                        content:
                            BlocBuilder<GetAddProductBloc, AddProductState>(
                          builder: ((context, state) {
                            if (state is OneAdd) {
                              return SingleChildScrollView(
                                child: Container(
                                  // onPressed: () {
                                  //   BlocProvider.of<GetAddProductBloc>(context)
                                  //       .add(BackEvent());
                                  // },
                                  //  child: Text("click two")

                                  child: Column(children: [
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
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MaterialButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            setState(() {
                                              subunitnamecontroller.clear();
                                              subpricecontroller.clear();
                                              substockController.clear();
                                              subweightController.clear();
                                              value2 = false;
                                            });
                                            BlocProvider.of<GetAddProductBloc>(
                                                    context)
                                                .add(BackEvent());
                                          },
                                        ),
                                        MaterialButton(

                                            ///mainbutton
                                            color: Colors.green,
                                            child: Text("Submit"),
                                            onPressed: () {
                                              if (unitnamecontroller
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please Enter Unit Name");
                                              }

                                              // else if (stockController
                                              //     .text.isEmpty) {
                                              //   Fluttertoast.showToast(
                                              //       msg:
                                              //           "Please Enter Unit Stock");
                                              // } else if (weightController
                                              //     .text.isEmpty) {
                                              //   Fluttertoast.showToast(
                                              //       msg:
                                              //           "Please Enter Unit Weight");
                                              // } else if (pricecontroller
                                              //     .text.isEmpty) {
                                              //   Fluttertoast.showToast(
                                              //       msg:
                                              //           "Please Enter Unit Price");
                                              // }

                                              else if (subunitnamecontroller
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please Enter Unit Name");
                                              } else if (substockController
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please Enter Unit Stock");
                                              } else if (subweightController
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please Enter Unit Weight");
                                              } else if (subpricecontroller
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please Enter Unit Price");
                                              } else {
                                                stockController.text = "";
                                                weightController.text = "";
                                                pricecontroller.text = "";

                                                ProductUnitModel
                                                    productUnitModel =
                                                    ProductUnitModel();
                                                productUnitModel.unitName =
                                                    unitnamecontroller.text;
                                                productUnitModel.price =
                                                    pricecontroller.text;
                                                productUnitModel.weight =
                                                    weightController.text;
                                                productUnitModel.stock =
                                                    stockController.text;
                                                productUnitModel.subUnits = [];

                                                ///ssubUnits

                                                productUnitModellist
                                                    .add(productUnitModel);

                                                setState(() {
                                                  value2 = false;
                                                  // questionoff = true;
                                                  unitDisplay = false;
                                                  unitnamecontroller.clear();
                                                  pricecontroller.clear();
                                                  stockController.clear();
                                                  weightController.clear();
                                                });

                                                //insert2
                                                ProductSubUnitModel
                                                    productSubUnitModel =
                                                    ProductSubUnitModel();

                                                productSubUnitModel
                                                        .subUnitName =
                                                    subunitnamecontroller.text;
                                                productSubUnitModel.price =
                                                    subpricecontroller.text;
                                                productSubUnitModel.weight =
                                                    subweightController.text;
                                                productSubUnitModel.stock =
                                                    substockController.text;

                                                productUnitModellist[
                                                        productUnitModellist
                                                                .length -
                                                            1]
                                                    .subUnits!
                                                    .add(productSubUnitModel);

                                                Navigator.pop(context);

                                                setState(() {
                                                  subunitnamecontroller.clear();
                                                  subpricecontroller.clear();
                                                  substockController.clear();
                                                  subweightController.clear();
                                                });

                                                BlocProvider.of<
                                                            GetAddProductBloc>(
                                                        context)
                                                    .add(BackEvent());
                                              }
                                            }
/////error
                                            // for (int k = 0;
                                            //     k < productUnitModellist.length;
                                            //     k++) {}

                                            ),
                                      ],
                                    )
                                  ]),
                                ),
                              );
                            }
                            return SingleChildScrollView(
                              child: Column(children: [
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
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            activeColor: Colors.green,
                                            value: value2,
                                            onChanged: (bool? val) {
                                              if (unitnamecontroller
                                                  .text.isEmpty) {
                                                Fluttertoast.showToast(
                                                    backgroundColor:
                                                        Colors.white,
                                                    msg:
                                                        "please add the product type name",
                                                    textColor: Colors.black);
                                              } else {
                                                BlocProvider.of<
                                                            GetAddProductBloc>(
                                                        context)
                                                    .add(AddProduct());
                                              }

                                              // setState(() {
                                              //   print(val);
                                              //   this.value2 = val;
                                              // });
                                            },
                                          ),
                                          Text("Add Sub Type ")
                                        ]),
                                    const SizedBox(
                                      height: 5,
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        MaterialButton(
                                          child: Text("SUBMIT"),
                                          onPressed: () {
                                            if (unitnamecontroller
                                                .text.isEmpty) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please Enter Unit Name");
                                            } else if (stockController
                                                .text.isEmpty) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please Enter Unit Stock");
                                            } else if (weightController
                                                .text.isEmpty) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please Enter Unit Weight");
                                            } else if (pricecontroller
                                                .text.isEmpty) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please Enter Unit Price");
                                            } else {
                                              ProductUnitModel
                                                  productUnitModel =
                                                  ProductUnitModel();
                                              productUnitModel.unitName =
                                                  unitnamecontroller.text;
                                              productUnitModel.price =
                                                  pricecontroller.text;
                                              productUnitModel.weight =
                                                  weightController.text;
                                              productUnitModel.stock =
                                                  stockController.text;
                                              productUnitModel.subUnits = [];

                                              ///ssubUnits

                                              productUnitModellist
                                                  .add(productUnitModel);

                                              setState(() {
                                                subunits = false;
                                                // questionoff = true;
                                                unitDisplay = false;
                                                unitnamecontroller.clear();
                                                pricecontroller.clear();
                                                stockController.clear();
                                                weightController.clear();
                                              });
                                            }

                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ]),
                            );
                            // return TextButton(
                            //     onPressed: () {
                            //       BlocProvider.of<GetAddProductBloc>(context).add(AddProduct());
                            //     },
                            //     child: Text("click"));
                          }),
                          // child: SingleChildScrollView(
                          //   child: Column(children: [
                          //     Column(
                          //       children: [
                          //         TextFormField(
                          //             //noted
                          //             controller: unitnamecontroller,
                          //             autocorrect: true,
                          //             keyboardType: TextInputType.text,
                          //             decoration: const InputDecoration(
                          //               labelText: 'Product Type Name',
                          //             ),
                          //             onChanged: (string) {}),
                          //         const SizedBox(
                          //           height: 10,
                          //         ),
                          //         Row(children: [
                          //           Checkbox(
                          //             activeColor: Colors.green,
                          //             value: value2,
                          //             onChanged: (bool? val) {
                          //               setState(() {
                          //                 print(val);
                          //                 this.value2 = val;
                          //               });
                          //             },
                          //           ),
                          //           Text("Add Sub Type ")
                          //         ]),
                          //         const SizedBox(
                          //           height: 5,
                          //         ),
                          //         TextFormField(
                          //           textInputAction: TextInputAction.next,
                          //           keyboardType: TextInputType.number,
                          //           controller: pricecontroller,
                          //           inputFormatters: const [],
                          //           decoration: const InputDecoration(
                          //             labelText: "Price ",
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           height: 10,
                          //         ),
                          //         TextFormField(
                          //           textInputAction: TextInputAction.next,
                          //           keyboardType: TextInputType.number,
                          //           controller: stockController,
                          //           inputFormatters: const [],
                          //           decoration: const InputDecoration(
                          //             labelText: "Stock ",
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           height: 10,
                          //         ),
                          //         TextFormField(
                          //           textInputAction: TextInputAction.next,
                          //           keyboardType: TextInputType.number,
                          //           controller: weightController,
                          //           inputFormatters: const [],
                          //           decoration: const InputDecoration(
                          //             labelText: "Weight",
                          //           ),
                          //         ),
                          //         const SizedBox(
                          //           height: 10,
                          //         ),
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.end,
                          //           children: [
                          //             MaterialButton(
                          //               textColor: Colors.black,
                          //               onPressed: () {
                          //                 Navigator.pop(context);

                          //                 setState(() {
                          //                   unitnamecontroller.clear();
                          //                   pricecontroller.clear();
                          //                   stockController.clear();
                          //                   weightController.clear();
                          //                 });
                          //               },
                          //               child: const Text(
                          //                 'CANCEL',
                          //                 style: TextStyle(color: Colors.white),
                          //               ),
                          //             ),
                          //             MaterialButton(
                          //               child: Text("SUBMIT"),
                          //               onPressed: () {
                          //                 if (unitnamecontroller.text.isEmpty) {
                          //                   Fluttertoast.showToast(
                          //                       msg: "Please Enter Unit Name");
                          //                 } else if (stockController
                          //                     .text.isEmpty) {
                          //                   Fluttertoast.showToast(
                          //                       msg: "Please Enter Unit Stock");
                          //                 } else if (weightController
                          //                     .text.isEmpty) {
                          //                   Fluttertoast.showToast(
                          //                       msg:
                          //                           "Please Enter Unit Weight");
                          //                 } else if (pricecontroller
                          //                     .text.isEmpty) {
                          //                   Fluttertoast.showToast(
                          //                       msg: "Please Enter Unit Price");
                          //                 } else {
                          //                   ProductUnitModel productUnitModel =
                          //                       ProductUnitModel();
                          //                   productUnitModel.unitName =
                          //                       unitnamecontroller.text;
                          //                   productUnitModel.price =
                          //                       pricecontroller.text;
                          //                   productUnitModel.weight =
                          //                       weightController.text;
                          //                   productUnitModel.stock =
                          //                       stockController.text;
                          //                   productUnitModel.subUnits = [];

                          //                   ///ssubUnits

                          //                   productUnitModellist
                          //                       .add(productUnitModel);

                          //                   setState(() {
                          //                     // questionoff = true;
                          //                     unitDisplay = false;
                          //                     unitnamecontroller.clear();
                          //                     pricecontroller.clear();
                          //                     stockController.clear();
                          //                     weightController.clear();
                          //                   });
                          //                 }

                          //                 setState(() {
                          //                   Navigator.pop(context);
                          //                 });
                          //               },
                          //               color: Colors.green,
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     )
                          //   ]),
                          // ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget addSubUnits(i) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
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
              } else {
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
    return liston == false
        ? Container()
        : Padding(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(""),
                                      InkWell(
                                        child: const Icon(Icons.cancel_outlined,
                                            color: Colors.grey),
                                        onTap: () {
                                          setState(() {
                                            productUnitModellist
                                                .removeAt(index);
                                          });
                                          // setState(() {
                                          //   addproductslist.units.removeWhere(
                                          //       (item) =>
                                          //           item.unitName ==
                                          //           addproductslist
                                          //               .units[index].unitName);
                                          // });
                                        },
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                              subunits != false
                                  ? Container()
                                  : productUnitModellist[index]
                                              .stock
                                              .toString() ==
                                          ""
                                      ? Container()
                                      : productUnitModellist[index]
                                                  .subUnits!
                                                  .length !=
                                              0
                                          ? Container()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Quantity  :",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      productUnitModellist[
                                                              index]
                                                          .stock
                                                          .toString(),
                                                      // addproductslist.units![index].stock
                                                      //     .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    )
                                                  ]),
                                            ),
                              subunits != false
                                  ? Container()
                                  : productUnitModellist[index]
                                              .price
                                              .toString() ==
                                          ""
                                      ? Container()
                                      : productUnitModellist[index]
                                                  .subUnits!
                                                  .length !=
                                              0
                                          ? Container()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Price  :",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      productUnitModellist[
                                                              index]
                                                          .price
                                                          .toString(),
                                                      // addproductslist.units![index].price
                                                      //     .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    )
                                                  ]),
                                            ),
                              subunits != false
                                  ? Container()
                                  : productUnitModellist[index]
                                              .weight
                                              .toString() ==
                                          ""
                                      ? Container()
                                      : productUnitModellist[index]
                                                  .subUnits!
                                                  .length !=
                                              0
                                          ? Container()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Weight  :",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      productUnitModellist[
                                                              index]
                                                          .weight
                                                          .toString(),
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

                                      // setState(() {
                                      //   productUnitModellist.removeAt(index);
                                      // });
                                      // addproductslist.units.removeWhere(
                                      //     (item) =>
                                      //         item.unitName ==
                                      //         addproductslist
                                      //             .units[index].unitName);
                                    });
                                  },
                                ),
                              ]),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(4.0),
                        //   child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         const Text(
                        //           "SubType Name  :",
                        //           style: TextStyle(
                        //             fontSize: 12,
                        //           ),
                        //         ),
                        //         Text(
                        //           productUnitModellist[index]
                        //               .unitName
                        //               .toString(),
                        //           // addproductslist.units![index].unitName
                        //           //     .toString(),
                        //           style: TextStyle(
                        //             fontSize: 12,
                        //           ),
                        //         )
                        //       ]),
                        // ),
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
                                    // addproductslist.units![index].stock
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
    return AlertDialog(
      title: Text('Welcome'),
      content: Column(children: [
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
              height: 10,
            ),
            Text("Do you want to "),
            const SizedBox(
              height: 5,
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
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product"), actions: []),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Column(
          children: [
            MaterialButton(
              child: Text(
                "SUBMIT",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
              height: 40,
              minWidth: 300,
              onPressed: () {
                validateData();
              },
              // child: BlocConsumer<GetAddProductMainBloc, AddProductMainState>(
              //     builder: (context, state) {
              //   if (state is AddProductMaining) {
              //     return const SizedBox(
              //       height: 18.0,
              //       width: 18.0,
              //       child: CircularProgressIndicator(
              //         valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              //         strokeWidth: 2,
              //       ),
              //     );
              //   } else {
              //     return const Text(
              //       "SUBMIT",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w600,
              //           fontSize: 12),
              //     );
              //   }
              // }, listener: (context, state) {
              //   if (state is AddProductMainsuccess) {
              //     Fluttertoast.showToast(
              //         backgroundColor: Colors.white,
              //         msg: "Products added ",
              //         textColor: Colors.black);

              //     Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => CustomerBottomNavigation()));
              //   }
              // }),
              color: Colors.green,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: productnamecontroller,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: productdescriptioncontroller,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: specialitycontroller,
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Speciality',
                ),
              ),
              // TextFormField(
              //   maxLength: 8,
              //   textInputAction: TextInputAction.done,
              //   controller: productweightcontroller,
              //   autocorrect: true,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     labelText: 'Weight of Product',
              //   ),
              // ),
              SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Unit Type"),
                  DropdownButtonFormField(
                    focusColor: Colors.black,
                    decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none),
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: TextStyle(color: Colors.grey),
                          //  style: AppStyles.heading,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                        productunittypecontroller.text = newValue;
                      });
                    },
                    dropdownColor: Color(0xfff7f7f7),
                  ),

                  // Text('Unit Type'),
                  // Container(
                  //   width: double.infinity,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text(dropdownvalue),
                  //       Spacer(),
                  //       DropdownButton<String>(
                  //         items:
                  //             <String>['Grams', 'Counts'].map((String value) {
                  //           return DropdownMenuItem<String>(
                  //             value: value,
                  //             child: Text(value),
                  //           );
                  //         }).toList(),
                  //         onChanged: (value) {
                  //           setState(() {
                  //             dropdownvalue = value!;
                  //             productunittypecontroller.text = value;
                  //           });
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(children: [
                Text("Do you want to add product units..?"),
                Checkbox(
                  value: this.value,
                  activeColor: Colors.green,
                  onChanged: (bool? value) {
                    // questionoff != false
                    //     ? Container()
                    //     :

                    checkon == true
                        ? Container()
                        : showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Add Types'),
                                content: BlocBuilder<GetAddProductBloc,
                                    AddProductState>(
                                  builder: ((context, state) {
                                    if (state is OneAdd) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          // onPressed: () {
                                          //   BlocProvider.of<GetAddProductBloc>(context)
                                          //       .add(BackEvent());
                                          // },
                                          //  child: Text("click two")

                                          child: Column(children: [
                                            Column(
                                              children: [
                                                TextFormField(
                                                    //noted
                                                    controller:
                                                        subunitnamecontroller,
                                                    autocorrect: true,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText:
                                                          'Product SubType Name',
                                                    ),
                                                    onChanged: (string) {}),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                TextFormField(
                                                  maxLength: 6,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      subpricecontroller,
                                                  inputFormatters: const [],
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText:
                                                        "Product SubType Price ",
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  maxLength: 6,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      substockController,
                                                  inputFormatters: const [],
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText:
                                                        "Product SubType Stock ",
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  maxLength: 6,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      subweightController,
                                                  inputFormatters: const [],
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText:
                                                        "Product SubType Weight",
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                MaterialButton(
                                                  child: Text("Cancel"),
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                GetAddProductBloc>(
                                                            context)
                                                        .add(BackEvent());
                                                  },
                                                ),
                                                MaterialButton(
                                                  ///mainbutton
                                                  color: Colors.green,

                                                  child: Text("Submit"),
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                GetAddProductBloc>(
                                                            context)
                                                        .add(BackEvent());
                                                    if (unitnamecontroller
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Enter Unit Name");
                                                    }

                                                    // else if (stockController
                                                    //     .text.isEmpty) {
                                                    //   Fluttertoast.showToast(
                                                    //       msg:
                                                    //           "Please Enter Unit Stock");
                                                    // } else if (weightController
                                                    //     .text.isEmpty) {
                                                    //   Fluttertoast.showToast(
                                                    //       msg:
                                                    //           "Please Enter Unit Weight");
                                                    // } else if (pricecontroller
                                                    //     .text.isEmpty) {
                                                    //   Fluttertoast.showToast(
                                                    //       msg:
                                                    //           "Please Enter Unit Price");
                                                    // }

                                                    else {
                                                      stockController.text = "";
                                                      weightController.text =
                                                          "";
                                                      pricecontroller.text = "";

                                                      ProductUnitModel
                                                          productUnitModel =
                                                          ProductUnitModel();
                                                      productUnitModel
                                                              .unitName =
                                                          unitnamecontroller
                                                              .text;
                                                      productUnitModel.price =
                                                          pricecontroller.text;
                                                      productUnitModel.weight =
                                                          weightController.text;
                                                      productUnitModel.stock =
                                                          stockController.text;
                                                      productUnitModel
                                                          .subUnits = [];

                                                      ///ssubUnits

                                                      productUnitModellist.add(
                                                          productUnitModel);

                                                      setState(() {
                                                        // questionoff = true;
                                                        unitDisplay = false;
                                                        unitnamecontroller
                                                            .clear();
                                                        pricecontroller.clear();
                                                        stockController.clear();
                                                        weightController
                                                            .clear();
                                                      });

                                                      if (subunitnamecontroller
                                                          .text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Enter Unit Name");
                                                      } else if (substockController
                                                          .text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Enter Unit Stock");
                                                      } else if (subweightController
                                                          .text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Enter Unit Weight");
                                                      } else if (subpricecontroller
                                                          .text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Please Enter Unit Price");
                                                      } else {
                                                        //insert2
                                                        ProductSubUnitModel
                                                            productSubUnitModel =
                                                            ProductSubUnitModel();

                                                        productSubUnitModel
                                                                .subUnitName =
                                                            subunitnamecontroller
                                                                .text;
                                                        productSubUnitModel
                                                                .price =
                                                            subpricecontroller
                                                                .text;
                                                        productSubUnitModel
                                                                .weight =
                                                            subweightController
                                                                .text;
                                                        productSubUnitModel
                                                                .stock =
                                                            substockController
                                                                .text;

                                                        productUnitModellist[
                                                                productUnitModellist
                                                                        .length -
                                                                    1]
                                                            .subUnits!
                                                            .add(
                                                                productSubUnitModel);

                                                        Navigator.pop(context);

                                                        setState(() {
                                                          subunitnamecontroller
                                                              .clear();
                                                          subpricecontroller
                                                              .clear();
                                                          substockController
                                                              .clear();
                                                          subweightController
                                                              .clear();
                                                        });
                                                      }
                                                    }
/////error
                                                    // for (int k = 0;
                                                    //     k < productUnitModellist.length;
                                                    //     k++) {}
                                                  },
                                                ),
                                              ],
                                            )
                                          ]),
                                        ),
                                      );
                                    }
                                    return SingleChildScrollView(
                                      child: Column(children: [
                                        Column(
                                          children: [
                                            TextFormField(
                                                //noted
                                                controller: unitnamecontroller,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      'Product Type Name',
                                                ),
                                                onChanged: (string) {}),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Checkbox(
                                                    activeColor: Colors.green,
                                                    value: value2,
                                                    onChanged: (bool? val) {
                                                      if (unitnamecontroller
                                                          .text.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            backgroundColor:
                                                                Colors.white,
                                                            msg:
                                                                "please add the product type name",
                                                            textColor:
                                                                Colors.black);
                                                      } else {
                                                        BlocProvider.of<
                                                                    GetAddProductBloc>(
                                                                context)
                                                            .add(AddProduct());
                                                      }
                                                      // setState(() {
                                                      //   print(val);
                                                      //   this.value2 = val;
                                                      // });
                                                    },
                                                  ),
                                                  Text("Add Sub Type ")
                                                ]),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType:
                                                  TextInputType.number,
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
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType:
                                                  TextInputType.number,
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
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType:
                                                  TextInputType.number,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                MaterialButton(
                                                  textColor: Colors.black,
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    setState(() {
                                                      unitnamecontroller
                                                          .clear();
                                                      pricecontroller.clear();
                                                      stockController.clear();
                                                      weightController.clear();
                                                    });
                                                  },
                                                  child: const Text(
                                                    'CANCEL',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                MaterialButton(
                                                  child: Text("SUBMIT"),
                                                  onPressed: () {
                                                    if (unitnamecontroller
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Enter Unit Name");
                                                    } else if (stockController
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Enter Unit Stock");
                                                    } else if (weightController
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Enter Unit Weight");
                                                    } else if (pricecontroller
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Enter Unit Price");
                                                    } else {
                                                      ProductUnitModel
                                                          productUnitModel =
                                                          ProductUnitModel();
                                                      productUnitModel
                                                              .unitName =
                                                          unitnamecontroller
                                                              .text;
                                                      productUnitModel.price =
                                                          pricecontroller.text;
                                                      productUnitModel.weight =
                                                          weightController.text;
                                                      productUnitModel.stock =
                                                          stockController.text;
                                                      productUnitModel
                                                          .subUnits = [];

                                                      ///ssubUnits

                                                      productUnitModellist.add(
                                                          productUnitModel);

                                                      setState(() {
                                                        subunits = false;
                                                        // questionoff = true;
                                                        unitDisplay = false;
                                                        unitnamecontroller
                                                            .clear();
                                                        pricecontroller.clear();
                                                        stockController.clear();
                                                        weightController
                                                            .clear();
                                                      });
                                                    }

                                                    setState(() {
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  color: Colors.green,
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ]),
                                    );
                                    // return TextButton(
                                    //     onPressed: () {
                                    //       BlocProvider.of<GetAddProductBloc>(context).add(AddProduct());
                                    //     },
                                    //     child: Text("click"));
                                  }),
                                  // child: SingleChildScrollView(
                                  //   child: Column(children: [
                                  //     Column(
                                  //       children: [
                                  //         TextFormField(
                                  //             //noted
                                  //             controller: unitnamecontroller,
                                  //             autocorrect: true,
                                  //             keyboardType: TextInputType.text,
                                  //             decoration: const InputDecoration(
                                  //               labelText: 'Product Type Name',
                                  //             ),
                                  //             onChanged: (string) {}),
                                  //         const SizedBox(
                                  //           height: 10,
                                  //         ),
                                  //         Row(children: [
                                  //           Checkbox(
                                  //             activeColor: Colors.green,
                                  //             value: value2,
                                  //             onChanged: (bool? val) {
                                  //               setState(() {
                                  //                 print(val);
                                  //                 this.value2 = val;
                                  //               });
                                  //             },
                                  //           ),
                                  //           Text("Add Sub Type ")
                                  //         ]),
                                  //         const SizedBox(
                                  //           height: 5,
                                  //         ),
                                  //         TextFormField(
                                  //           textInputAction: TextInputAction.next,
                                  //           keyboardType: TextInputType.number,
                                  //           controller: pricecontroller,
                                  //           inputFormatters: const [],
                                  //           decoration: const InputDecoration(
                                  //             labelText: "Price ",
                                  //           ),
                                  //         ),
                                  //         const SizedBox(
                                  //           height: 10,
                                  //         ),
                                  //         TextFormField(
                                  //           textInputAction: TextInputAction.next,
                                  //           keyboardType: TextInputType.number,
                                  //           controller: stockController,
                                  //           inputFormatters: const [],
                                  //           decoration: const InputDecoration(
                                  //             labelText: "Stock ",
                                  //           ),
                                  //         ),
                                  //         const SizedBox(
                                  //           height: 10,
                                  //         ),
                                  //         TextFormField(
                                  //           textInputAction: TextInputAction.next,
                                  //           keyboardType: TextInputType.number,
                                  //           controller: weightController,
                                  //           inputFormatters: const [],
                                  //           decoration: const InputDecoration(
                                  //             labelText: "Weight",
                                  //           ),
                                  //         ),
                                  //         const SizedBox(
                                  //           height: 10,
                                  //         ),
                                  //         Row(
                                  //           mainAxisAlignment: MainAxisAlignment.end,
                                  //           children: [
                                  //             MaterialButton(
                                  //               textColor: Colors.black,
                                  //               onPressed: () {
                                  //                 Navigator.pop(context);

                                  //                 setState(() {
                                  //                   unitnamecontroller.clear();
                                  //                   pricecontroller.clear();
                                  //                   stockController.clear();
                                  //                   weightController.clear();
                                  //                 });
                                  //               },
                                  //               child: const Text(
                                  //                 'CANCEL',
                                  //                 style: TextStyle(color: Colors.white),
                                  //               ),
                                  //             ),
                                  //             MaterialButton(
                                  //               child: Text("SUBMIT"),
                                  //               onPressed: () {
                                  //                 if (unitnamecontroller.text.isEmpty) {
                                  //                   Fluttertoast.showToast(
                                  //                       msg: "Please Enter Unit Name");
                                  //                 } else if (stockController
                                  //                     .text.isEmpty) {
                                  //                   Fluttertoast.showToast(
                                  //                       msg: "Please Enter Unit Stock");
                                  //                 } else if (weightController
                                  //                     .text.isEmpty) {
                                  //                   Fluttertoast.showToast(
                                  //                       msg:
                                  //                           "Please Enter Unit Weight");
                                  //                 } else if (pricecontroller
                                  //                     .text.isEmpty) {
                                  //                   Fluttertoast.showToast(
                                  //                       msg: "Please Enter Unit Price");
                                  //                 } else {
                                  //                   ProductUnitModel productUnitModel =
                                  //                       ProductUnitModel();
                                  //                   productUnitModel.unitName =
                                  //                       unitnamecontroller.text;
                                  //                   productUnitModel.price =
                                  //                       pricecontroller.text;
                                  //                   productUnitModel.weight =
                                  //                       weightController.text;
                                  //                   productUnitModel.stock =
                                  //                       stockController.text;
                                  //                   productUnitModel.subUnits = [];

                                  //                   ///ssubUnits

                                  //                   productUnitModellist
                                  //                       .add(productUnitModel);

                                  //                   setState(() {
                                  //                     // questionoff = true;
                                  //                     unitDisplay = false;
                                  //                     unitnamecontroller.clear();
                                  //                     pricecontroller.clear();
                                  //                     stockController.clear();
                                  //                     weightController.clear();
                                  //                   });
                                  //                 }

                                  //                 setState(() {
                                  //                   Navigator.pop(context);
                                  //                 });
                                  //               },
                                  //               color: Colors.green,
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ],
                                  //     )
                                  //   ]),
                                  // ),
                                ),
                              );
                            },
                          );

                    setState(() {
                      this.value = value;
                      setState(() {
                        checkon = true;
                        liston = true;
                        varientbutton == false
                            ? varientbutton = true
                            : varientbutton = false;
                        unitDisplay = false;
                      });
                    });
                  },
                ),
              ]),
              varientbutton != true
                  ? Container(
                      child: Column(children: [
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: productpricecontroller,
                          autocorrect: true,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Product Price',
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
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: productquantitycontroller,
                          autocorrect: true,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Product Quantity',
                          ),
                        ),
                      ]),
                    )
                  : Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            // Text("Products Units"),
                            SizedBox(
                              height: 2,
                            ),
                            unitDisplay ? _addunitForm() : SizedBox.shrink(),
                            productUnitModellist != []
                                ? addedunitlist()
                                : SizedBox.shrink(),
                            addunit(),
                          ]),
                    ),
              SizedBox(
                height: 20,
              ),
              Text("Add Product Images"),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                          color: Colors.green,
                          onPressed: () {
                            openImages();
                          },
                          child: Row(children: [
                            Text("Upload"),
                            Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                          ])),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              imagefiles != []
                  ? Wrap(
                      children: imagefiles.map((imageone) {
                        return Container(
                            child: Card(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.file(
                              File(imageone.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ));
                      }).toList(),
                    )
                  : Container(),
              SizedBox(
                height: 16,
              ),
              Text("Add Product Cover Image"),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: MaterialButton(
                          color: Colors.green,
                          onPressed: () {
                            openImages2();
                          },
                          child: Row(children: [
                            Text("Upload"),
                            Icon(
                              Icons.upload,
                              color: Colors.white,
                            ),
                          ])),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              imagefiles2 != []
                  ? Wrap(
                      children: imagefiles2.map((imageone) {
                        return Container(
                            child: Card(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Image.file(
                              File(imageone.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ));
                      }).toList(),
                    )
                  : Container(),
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
              //         child: Column(children: [
              //           TextFormField(
              //             textInputAction: TextInputAction.done,
              //             controller: productpricecontroller,
              //             autocorrect: true,
              //             keyboardType: TextInputType.number,
              //             decoration: const InputDecoration(
              //               labelText: 'Product Price',
              //             ),
              //           ),
              //           TextFormField(
              //             textInputAction: TextInputAction.done,
              //             controller: productquantitycontroller,
              //             autocorrect: true,
              //             keyboardType: TextInputType.number,
              //             decoration: const InputDecoration(
              //               labelText: 'Product Quantity',
              //             ),
              //           ),
              //         ]),
              //       )
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
              //                   : SizedBox.shrink(),
              //             ]),
              //       ),
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
          msg: "please enter product name.",
          textColor: Colors.black);
    } else if (productdescriptioncontroller.text.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "please enter product description",
          textColor: Colors.black);
    } else if (specialitycontroller.text.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "please enter product speciality",
          textColor: Colors.black);
    }

    // else if (productweightcontroller.text.isEmpty) {
    //   Fluttertoast.showToast(
    //       backgroundColor: Colors.white,
    //       msg: "Please Enter Product Weigth",
    //       textColor: Colors.black);
    // }

    else if (imagefiles.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "please upload image",
          textColor: Colors.black);
    } else if (productweightcontroller.text.isEmpty &&
        productUnitModellist.length == 0) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "please add product weight",
          textColor: Colors.black);
    } else if (productquantitycontroller.text.isEmpty &&
        productUnitModellist.length == 0) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "please add product quantity",
          textColor: Colors.black);
    } else if (productpricecontroller.text.isEmpty &&
        productUnitModellist.length == 0) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "please add product price",
          textColor: Colors.black);
    }
//     else if (productunittypecontroller.text.isEmpty) {

// productunittypecontroller.text=""

//       Fluttertoast.showToast(
//           backgroundColor: Colors.white,
//           msg: "Please Enter Product Unit Type",
//           textColor: Colors.black);
//     }
    ///////
    else {
      varientbutton == false ? productUnitModellist.clear() : Container();
      productunittypecontroller.text == ""
          ? productunittypecontroller.text = "Grams"
          : productunittypecontroller.text;
      /////////////////////////////////////
      productweightcontroller.text = "10";
      ProductUnitModel productUnitModel = ProductUnitModel();

      addproductslist.productname = productnamecontroller.text.toString();
      addproductslist.description =
          productdescriptioncontroller.text.toString();
      addproductslist.totalWeight =
          productweightcontroller.text.toString() == ""
              ? ""
              : productweightcontroller.text.toString();
      addproductslist.totalPrice = productpricecontroller.text.toString();
      addproductslist.totalQuatity = productquantitycontroller.text.toString();

      addproductslist.speciality = specialitycontroller.text.toString();
      addproductslist.unitType = productunittypecontroller.text.toString();

      for (int k = 0; k < productUnitModellist.length; k++) {
        productUnitModel.price = productUnitModellist[k].price;
        productUnitModel.stock = productUnitModellist[k].stock;
        productUnitModel.unitName = productUnitModellist[k].unitName;

        for (int j = 0; j < productUnitModellist[k].subUnits!.length; j++) {
          productUnitModel.subUnits?[j].subUnitName =
              productUnitModellist[k].subUnits![j].subUnitName.toString();
          productUnitModel.subUnits?[j].price =
              productUnitModellist[k].subUnits![j].price.toString();
          productUnitModel.subUnits?[j].weight =
              productUnitModellist[k].subUnits![j].weight.toString();
          productUnitModel.subUnits?[j].stock =
              productUnitModellist[k].subUnits![j].stock.toString();
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

      BlocProvider.of<GetAddProductMainBloc>(context).add(GetAddProductMain(
        productsModel: addproductslist,
      ));

      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Product added ",
          textColor: Colors.black);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CustomerBottomNavigation()),
      );
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

class ProductUnitModel {
  String? unitName;
  String? stock;
  String? weight;
  String? price;
  List<ProductSubUnitModel>? subUnits = [];

  ProductUnitModel(
      {this.unitName, this.stock, this.weight, this.price, this.subUnits});
}

//insert2
class ProductSubUnitModel {
  String? subUnitName;
  String? stock;
  String? weight;
  String? price;

  ProductSubUnitModel({
    this.subUnitName,
    this.stock,
    this.weight,
    this.price,
  });
}
