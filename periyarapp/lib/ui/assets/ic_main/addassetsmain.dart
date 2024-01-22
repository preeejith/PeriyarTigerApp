import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:objectid/objectid.dart';
import 'package:parambikulam/bloc/assets/new/addassetsmainbloc/addassetsmainbloc.dart';
import 'package:parambikulam/bloc/assets/new/addassetsmainbloc/addassetsmainevent.dart';
import 'package:parambikulam/bloc/assets/new/searchassetsidbloc/searchassetsidbloc.dart';
import 'package:parambikulam/bloc/assets/new/searchassetsidbloc/searchassetsidevent.dart';
import 'package:parambikulam/bloc/assets/new/searchassetsidbloc/searchassetsidstate.dart';
import 'package:parambikulam/ui/assets/bottomnav.dart';

///////
class AddAssetsMain extends StatefulWidget {
  const AddAssetsMain({Key? key}) : super(key: key);

  @override
  State<AddAssetsMain> createState() => _AddAssetsMainState();
}

class _AddAssetsMainState extends State<AddAssetsMain> {
  String dropdownvalue = 'Non consumable';
  bool? change = false;
  bool? cancellist = false;
  bool? assetidtaken = false;
  int? currentquantity = 0;
  bool? grand = false;
  bool? listview = true;
  bool? newtotal = true;
  int sum = 0;
  var items = [
    'Non consumable',
    'Consumable',
  ];
  List<AddAssetsModel> addassetslist = [];
  final TextEditingController billnumbercontroller = TextEditingController();
  final TextEditingController assetnamecontroller = TextEditingController();
  final TextEditingController totalamountcontroller = TextEditingController();
  final TextEditingController discountcontroller = TextEditingController();
  final TextEditingController grandtotalcontroller = TextEditingController();

  final TextEditingController producttypecontroller = TextEditingController();
  final TextEditingController purchaseamountcontroller =
      TextEditingController();
  final TextEditingController qunatitycontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();
  final TextEditingController assetidcontroller = TextEditingController();

  List<File> files3 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Assets"), actions: []),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Column(
          children: [
            addassetslist.isEmpty
                ? SizedBox()
                : MaterialButton(
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
                      if (addassetslist.isEmpty) {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.white,
                            msg: "Please add the details",
                            textColor: Colors.black);
                      } else if (totalamountcontroller.text.isEmpty) {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.white,
                            msg: "Please Enter Total Amount",
                            textColor: Colors.black);
                      } else if (discountcontroller.text.isEmpty) {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.white,
                            msg: "Please Enter Discount",
                            textColor: Colors.black);
                      } else if (int.parse(
                              discountcontroller.text.toString()) >=
                          int.parse(totalamountcontroller.text.toString())) {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.white,
                            msg: "Discount Amount is greater than the cost",
                            textColor: Colors.black);
                      } else {
                        validateData();
                      }
                    },
                    color: Color(0xfff68D389),
                  ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  maxLength: 20,
                  textInputAction: TextInputAction.next,
                  //noted
                  controller: billnumbercontroller,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Bill No.',
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: Color(0xfff68D389),
                      child: Text("Add Items"),
                      onPressed: () {
                        if (billnumbercontroller.text.isEmpty) {
                          Fluttertoast.showToast(
                              backgroundColor: Colors.white,
                              msg: "Please Enter Bill no.",
                              textColor: Colors.black);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: SizedBox(
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: const Text('Add Assets'),
                                    content: Column(children: [
                                      Column(
                                        children: [
                                          TextFormField(
                                              //noted
                                              controller: assetnamecontroller,
                                              autocorrect: true,
                                              keyboardType: TextInputType.text,
                                              decoration: const InputDecoration(
                                                labelText: 'Asset Name',
                                              ),
                                              onChanged: (string) {
                                                print("hello");
                                                if (assetnamecontroller
                                                    .text.isNotEmpty) {
                                                  BlocProvider.of<
                                                              GetSearchAssetsBloc>(
                                                          context)
                                                      .add(GetSearchAssets(
                                                    keyword: assetnamecontroller
                                                        .text,
                                                  ));

                                                  setState(() {
                                                    listview = true;
                                                  });
                                                }
                                              }),
                                          listview != true
                                              ? Container()
                                              : BlocConsumer<
                                                  GetSearchAssetsBloc,
                                                  SearchAssetsState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is SearchAssetssuccess) {
                                                      return ListView.builder(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              shrinkWrap: true,
                                                              itemCount: state
                                                                  .assetMasterSuggestion
                                                                  .length,
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return state
                                                                            .assetMasterSuggestion[
                                                                                index]
                                                                            .status ==
                                                                        "active11"
                                                                    ? SizedBox()
                                                                    : Column(
                                                                        children: [
                                                                            // Text("Hello"),
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(4.0),
                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                InkWell(
                                                                                  child: Text(
                                                                                    state.assetMasterSuggestion[index].name.toString(),
                                                                                    style: TextStyle(
                                                                                      fontSize: 12,
                                                                                    ),
                                                                                  ),
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      assetidcontroller.text = state.assetMasterSuggestion[index].id.toString();
                                                                                      assetnamecontroller.text = state.assetMasterSuggestion[index].name.toString();
                                                                                      listview = false;
                                                                                      assetidtaken = true;
                                                                                      // currentquantity=state.assetMasterSuggestion[index]..toString()
                                                                                    });

                                                                                    BlocProvider.of<GetSearchAssetsBloc>(context).add(GetSearchAssets(
                                                                                      keyword: "xzfcdfdfagfadgadhbaf",
                                                                                    ));

                                                                                    // setState(() {
                                                                                    //   cancellist = true;
                                                                                    // });
                                                                                  },
                                                                                )
                                                                              ]),
                                                                            ),
                                                                          ]);
                                                              })
                                                          // : Text("")
                                                          ;
                                                    }

                                                    return Container();
                                                  },
                                                  listener: (context, state) {},
                                                ),
                                          const SizedBox(
                                            height: 17,
                                          ),
                                          Text("Product Type"),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          DropdownButtonFormField(
                                            focusColor: Colors.black,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                border: InputBorder.none),
                                            value: dropdownvalue,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: items.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue = newValue!;
                                                producttypecontroller.text =
                                                    newValue;
                                              });
                                            },
                                            dropdownColor: Colors.black,
                                            // dropdownColor: Color(0xfff7f7f7),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            maxLength: 8,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            controller:
                                                purchaseamountcontroller,
                                            inputFormatters: const [],
                                            decoration: const InputDecoration(
                                              labelText: "Purchase Amount",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            maxLength: 5,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: qunatitycontroller,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: const [],
                                            decoration: const InputDecoration(
                                              labelText: "Quantity",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: remarkcontroller,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              labelText: 'Remark',
                                            ),
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
                                            assetnamecontroller.clear();
                                            producttypecontroller.clear();
                                            purchaseamountcontroller.clear();
                                            qunatitycontroller.clear();
                                            remarkcontroller.clear();
                                            assetidcontroller.clear();
                                            assetidtaken = false;
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
                                          if (assetnamecontroller
                                              .text.isEmpty) {
                                            Fluttertoast.showToast(
                                                backgroundColor: Colors.white,
                                                msg: "Please Enter AssetsName",
                                                textColor: Colors.black);
                                          } else if (producttypecontroller
                                              .text.isEmpty) {
                                            producttypecontroller.text =
                                                "Non consumable";
                                          } else if (purchaseamountcontroller
                                              .text.isEmpty) {
                                            Fluttertoast.showToast(
                                                backgroundColor: Colors.white,
                                                msg:
                                                    "Please Enter Purchase Amount",
                                                textColor: Colors.black);
                                          } else if (qunatitycontroller
                                              .text.isEmpty) {
                                            Fluttertoast.showToast(
                                                backgroundColor: Colors.white,
                                                msg: "Please Enter Quantity",
                                                textColor: Colors.black);
                                          } else {
                                            String? localassetid =
                                                ObjectId().toString();
                                            addassetslist.add(AddAssetsModel(
                                                assetsname:
                                                    assetnamecontroller.text,
                                                localid: localassetid,
                                                producttype:
                                                    producttypecontroller.text,
                                                purchaseamount:
                                                    purchaseamountcontroller
                                                        .text,
                                                quantity:
                                                    qunatitycontroller.text,
                                                assetidtaken:
                                                    assetidtaken.toString(),
                                                remark: remarkcontroller.text == ""
                                                    ? ""
                                                    : remarkcontroller.text,
                                                assetsid: assetidcontroller.text.isEmpty
                                                    ? ""
                                                    : assetidcontroller.text,
                                                totalamount2: (int.parse(
                                                        qunatitycontroller.text
                                                            .toString()) *
                                                    int.parse(
                                                        purchaseamountcontroller.text
                                                            .toString()))));
                                            Navigator.pop(context);

                                            initFunc();

                                            setState(() {
                                              // cancellist = false;
                                              change = true;
                                              assetnamecontroller.clear();
                                              assetidtaken = false;
                                              producttypecontroller.clear();
                                              purchaseamountcontroller.clear();
                                              qunatitycontroller.clear();
                                              remarkcontroller.clear();
                                              assetidcontroller.clear();
                                            });
                                          }
                                        },
                                        color: Color(0xfff68D389),
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
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: addassetslist.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Container(
                              width: MediaQuery.of(context).size.width + 8,
                              decoration: BoxDecoration(
                                color: Color(0xfff292929),
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
                                padding: const EdgeInsets.all(6.0),
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Name  :",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            addassetslist[index]
                                                .assetsname
                                                .toString(),
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
                                            "Quantity  :",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            addassetslist[index]
                                                .quantity
                                                .toString(),
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
                                            "Product Type  :",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            addassetslist[index]
                                                .producttype
                                                .toString(),
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
                                            "Purchase Amount  :",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            addassetslist[index]
                                                .purchaseamount
                                                .toString(),
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
                                            "Amount total  :",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            addassetslist[index]
                                                .totalamount2
                                                .toString(),
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
                                            "Remark  :",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            addassetslist[index]
                                                        .remark
                                                        .toString() ==
                                                    ""
                                                ? "-"
                                                : addassetslist[index]
                                                    .remark
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 12,
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
              ),
              Container(),
              change == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Total Amount :  "),
                                Text(totalamountcontroller.text)
                              ]),
                        ),
                      ],
                    )
                  : Text(""),
              change == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              // border: Border.all(
                              //   color: Colors.grey,
                              // ),
                              ),
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                maxLength: 6,
                                textInputAction: TextInputAction.done,
                                //noted
                                controller: discountcontroller,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Discount',
                                ),
                                onChanged: (string) {
                                  print("hello");
                                  if (discountcontroller.text.isNotEmpty) {
                                    setState(() {
                                      sum = ((int.parse(totalamountcontroller
                                              .text
                                              .toString()) -
                                          int.parse(discountcontroller.text
                                              .toString())));

                                      grandtotalcontroller.text =
                                          sum.toString();

                                      grand = true;
                                    });
                                    newtotal = false;
                                  }
                                }),
                          ),
                        ),
                      ],
                    )
                  : Text(""),
              grand == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Grand total :  "),
                                Text(grandtotalcontroller.text)
                              ]),
                        ),
                      ],
                    )
                  : Text("")
            ],
          ),
        ),
      ),
    );
  }

  /////////
  void validateData() {
    /////////
    BlocProvider.of<GetAddAssetsmainBloc>(context).add(GetAddAssetsmain(
      purchaseId: billnumbercontroller.text,
      totalAmount: totalamountcontroller.text,
      discount: discountcontroller.text,
      addassetslist: addassetslist,
    ));

    Fluttertoast.showToast(
        msg: "Asset Added",
        textColor: Colors.black,
        backgroundColor: Colors.white,
        gravity: ToastGravity.BOTTOM);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => CustomerBottomNavigation()));
  }

  initFunc() {
    totalamountcontroller.text = "";
    sum = 0;

    for (int i = 0; i < addassetslist.length; i++) {
      sum = sum + int.parse(addassetslist[i].totalamount2.toString());
    }
    print(sum);

    totalamountcontroller.text = sum.toString();
    sum = 0;
  }
}

class AddAssetsModel {
  String? assetsname;
  String? producttype;
  String? localid;

  String? assetidtaken;
  String? purchaseamount;
  int? totalamount2;

  String? assetsid;

  String? quantity;

  String? remark;
  AddAssetsModel({
    this.assetsname,
    this.localid,
    this.assetidtaken,
    this.producttype,
    this.purchaseamount,
    this.quantity,
    this.totalamount2,
    this.assetsid,
    this.remark,
  });
}
