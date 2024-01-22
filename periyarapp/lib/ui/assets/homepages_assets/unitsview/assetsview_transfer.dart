////assets Transfer without request

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsbloc.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsevent.dart';

import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsstate.dart';
import 'package:parambikulam/bloc/assetsbloc_withoutrequest/assetsbloc_withoutrequest.dart';
import 'package:parambikulam/bloc/assetsbloc_withoutrequest/assetsevent_withoutrequest.dart';

import 'package:parambikulam/ui/assets/homepages_assets/unitsview/ic_viewunitspage.dart';

//////
class AssetsTransfer extends StatefulWidget {
  final String transferedtoId, untiName;

  const AssetsTransfer(
      {Key? key, required this.transferedtoId, required this.untiName})
      : super(key: key);

  @override
  State<AssetsTransfer> createState() => _AssetsTransferState();
}

/////
class _AssetsTransferState extends State<AssetsTransfer> {
  String? token;
  int? quantitycount;
  var now = DateTime.now().toUtc();
  List<AssetSearchModel> assetSearchlist = [];
  int? k;
  bool? buttonon = false;
  String dropdownvalue = 'Non consumable';
  var items = [
    'Non consumable',
    'Consumable',
  ];
////
  List<TransferAssetsModel> transferassetslislist = [];
  final TextEditingController assetsearchcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController qunatitycontroller = TextEditingController();
  final TextEditingController qunatity2controller = TextEditingController();
  final TextEditingController productidcontroller = TextEditingController();
  final TextEditingController producttypecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();

  final TextEditingController salepricecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController discountcontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();

  @override
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() async {
    BlocProvider.of<GetViewallAssetsBloc>(context).add(FetchAssetsdataEvent());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: new AppBar(
        title: new Text('Transfer Asset'),
      ),
      bottomNavigationBar: BlocConsumer<GetViewallAssetsBloc,
              ViewallAssetsState>(
          listener: ((context, state) {}),
          builder: (context, state) {
            if (state is FetchAssetsSuccess) {
              return (buttonon != true
                  ? SizedBox()
                  : SizedBox(
                      height: 80,
                      child: Column(
                        children: [
                          // const SizedBox(
                          //   height: 40,
                          // ),
                          MaterialButton(
                            child: const Text(
                              "Transfer",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                            height: 40,
                            minWidth: 300,
/////state

                            onPressed: () async {
                              for (int k = 0;
                                  k < state.viewassetsModel.length;
                                  k++) {
                                if (state.viewassetsModel[k].change == true) {
                                  transferassetslislist.add(TransferAssetsModel(
                                      assetId: state.assetMasterTable[k].id,
                                      producttype:
                                          state.assetMasterTable[k].productType,
                                      quantity: state.viewassetsModel[k].count
                                          .toString(),
                                      remark: "gtv",
                                      added: state.viewassetsModel[k].added
                                          .toString(),
                                      assetName: state.assetMasterTable[k].name,
                                      unitName: widget.untiName,
                                      orgquantity: state
                                          .viewassetsModel[k].quantity
                                          .toString(),
                                      unitid: state.viewassetsModel[k].unitId
                                          .toString(),
                                      date: now.toString()));
                                }
                              }
////validate start
                              if (transferassetslislist.isEmpty) {
                                Fluttertoast.showToast(
                                    backgroundColor: Colors.white,
                                    msg: "Please add Items ",
                                    textColor: Colors.black);
                              } else {
                                BlocProvider.of<GetAssetsWithoutRequestBloc>(
                                        context)
                                    .add(GetAssetsWithoutRequest(
                                  transferedtoId: widget.transferedtoId,
                                  transferassetslislist: transferassetslislist,
                                ));

                                ////////
/////to check the count
                                ///

/////////////
                                Fluttertoast.showToast(
                                    backgroundColor: Colors.white,
                                    msg: "Assets trasnfered ",
                                    textColor: Colors.black);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => IcViewUnits()));
                              }
////validate end
                              // validateData();
                            },

                            color: Color(0xfff68D389),
                          ),
                        ],
                      ),
                    ));
            } else if (state is SearchAssetssuccess) {
              return (buttonon != true
                  ? SizedBox()
                  : SizedBox(
                      height: 120,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          MaterialButton(
                            child: const Text(
                              "Transfer",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                            height: 40,
                            minWidth: 300,
//////////
                            onPressed: () async {
                              for (int k = 0;
                                  k < state.viewassetssearchModel.length;
                                  k++) {
                                if (state.viewassetssearchModel[k].change ==
                                    true) {
                                  transferassetslislist.add(TransferAssetsModel(
                                      assetId: state
                                          .viewassetssearchModel[k].assetid,
                                      quantity: state
                                          .viewassetssearchModel[k].count
                                          .toString(),
                                      remark: "gtv",
                                      assetName:
                                          state.viewassetssearchModel[k].name,
                                      unitid:
                                          state.viewassetssearchModel[k].unitId,
                                      unitName: widget.untiName,
                                      orgquantity: state
                                          .viewassetssearchModel[k].quantity
                                          .toString(),
                                      date: now.toString()));
                                }
                              }
////validate start
                              if (transferassetslislist.isEmpty) {
                                Fluttertoast.showToast(
                                    backgroundColor: Colors.white,
                                    msg: "Please add Items ",
                                    textColor: Colors.black);
                              } else {
                                BlocProvider.of<GetAssetsWithoutRequestBloc>(
                                        context)
                                    .add(GetAssetsWithoutRequest(
                                  transferedtoId: widget.transferedtoId,
                                  transferassetslislist: transferassetslislist,
                                ));

                                ////////
/////to check the count
                                ///

/////////////
                                Fluttertoast.showToast(
                                    backgroundColor: Colors.white,
                                    msg: "Assets trasnfered ",
                                    textColor: Colors.black);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => IcViewUnits()));
                              }
////validate end
                              // validateData();
                            },

                            color: Color(0xfff68D389),
                          ),
                        ],
                      ),
                    ));
            } else {
              return SizedBox.shrink();
            }
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                  //noted
                  controller: assetsearchcontroller,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Search Assets',
                  ),
                  onChanged: (string) {
                    print("hello");
                    if (assetsearchcontroller.text.isNotEmpty) {
                      BlocProvider.of<GetViewallAssetsBloc>(context)
                          .add(GetUnitSearchAssets(
                        keyword: assetsearchcontroller.text,
                      ));

                      setState(() {
                        // listview = true;
                      });
                    }
                  }),
            ),
            BlocConsumer<GetViewallAssetsBloc, ViewallAssetsState>(
                builder: (context, state) {
              if (state is FetchAssetsSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.viewassetsModel.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              title: InkWell(
                            child: Column(children: [
                              InkWell(
                                child: Container(
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
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Assets Name:",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state
                                                    .viewassetsModel[index].name
                                                    .toString(),
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Product Type :",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.assetMasterTable[index]
                                                    .productType
                                                    .toString(),
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("Description:",
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.assetMasterTable[index]
                                                            .description
                                                            .toString() ==
                                                        ""
                                                    ? "-"
                                                    : state
                                                        .assetMasterTable[index]
                                                        .description
                                                        .toString(),
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Quantity:",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.viewassetsModel[index]
                                                    .quantity
                                                    .toString(),
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              child: Icon(Icons.remove),
                                              onTap: () {
                                                //
                                                setState(() {
                                                  state.viewassetsModel[index]
                                                              .count! <
                                                          1
                                                      ? SizedBox()
                                                      : state
                                                          .viewassetsModel[
                                                              index]
                                                          .count = state
                                                              .viewassetsModel[
                                                                  index]
                                                              .count! -
                                                          1;
                                                  state.viewassetsModel[index]
                                                              .count! <
                                                          1
                                                      ? state
                                                          .viewassetsModel[
                                                              index]
                                                          .change = false
                                                      : state
                                                          .viewassetsModel[
                                                              index]
                                                          .change = true;
                                                });
                                              },
                                            ),
                                            state.viewassetsModel[index]
                                                        .count! <
                                                    0
                                                ? Text("")
                                                : Text(state
                                                    .viewassetsModel[index]
                                                    .count!
                                                    .toString()),
                                            InkWell(
                                              child: Icon(Icons.add),
                                              onTap: () {
                                                setState(() {
                                                  buttonon = true;
                                                  (int.parse(state
                                                              .viewassetsModel[
                                                                  index]
                                                              .count!
                                                              .toString()) >=
                                                          int.parse(state
                                                              .viewassetsModel[
                                                                  index]
                                                              .quantity
                                                              .toString()))
                                                      ? Fluttertoast.showToast(
                                                          backgroundColor:
                                                              Colors.white,
                                                          msg:
                                                              "Quantity is lesser",
                                                          textColor:
                                                              Colors.black)
                                                      : state.viewassetsModel[index].count =
                                                          state.viewassetsModel[index]
                                                                  .count! +
                                                              1;

                                                  state.viewassetsModel[index]
                                                      .change = true;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ));
                        },
                      ),
                    ],
                  ),
                );
              } else if (state is SearchAssetssuccess) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.viewassetssearchModel.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              title: InkWell(
                            child: Column(children: [
                              InkWell(
                                child: Container(
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
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Assets Name:",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.assetMasterSuggestion
                                                            .length >
                                                        index
                                                    ? state
                                                        .assetMasterSuggestion[
                                                            index]
                                                        .name
                                                        .toString()
                                                    : state
                                                        .viewassetssearchModel[
                                                            index]
                                                        .name
                                                        .toString(),
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Product Type :",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.assetMasterSuggestion
                                                            .length >
                                                        index
                                                    ? state
                                                        .assetMasterSuggestion[
                                                            index]
                                                        .productType
                                                        .toString()
                                                    : "-",
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("Description:",
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.assetMasterSuggestion
                                                            .length >
                                                        index
                                                    ? state
                                                        .assetMasterSuggestion[
                                                            index]
                                                        .description
                                                        .toString()
                                                    : "-",
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Quantity:",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state
                                                    .viewassetssearchModel[
                                                        index]
                                                    .quantity
                                                    .toString(),
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              child: Icon(Icons.remove),
                                              onTap: () {
                                                //
                                                setState(() {
                                                  state
                                                              .viewassetssearchModel[
                                                                  index]
                                                              .count! <
                                                          1
                                                      ? SizedBox()
                                                      : state
                                                          .viewassetssearchModel[
                                                              index]
                                                          .count = state
                                                              .viewassetssearchModel[
                                                                  index]
                                                              .count! -
                                                          1;
                                                  state
                                                              .viewassetssearchModel[
                                                                  index]
                                                              .count! <
                                                          1
                                                      ? state
                                                          .viewassetssearchModel[
                                                              index]
                                                          .change = false
                                                      : state
                                                          .viewassetssearchModel[
                                                              index]
                                                          .change = true;
                                                });
                                              },
                                            ),
                                            state.viewassetssearchModel[index]
                                                        .count! <
                                                    0
                                                ? Text("")
                                                // : state
                                                //             .viewassetssearchModel[
                                                //                 index]
                                                //             .count!
                                                //             .toString() ==
                                                //         "0"
                                                //     ? Text("ADD")
                                                : Text(state
                                                    .viewassetssearchModel[
                                                        index]
                                                    .count!
                                                    .toString()),
                                            InkWell(
                                              child: Icon(Icons.add),
                                              onTap: () {
                                                setState(() {
                                                  buttonon = true;
                                                  (int.parse(state.viewassetssearchModel[index].count!
                                                              .toString()) >=
                                                          int.parse(state
                                                              .viewassetssearchModel[
                                                                  index]
                                                              .quantity
                                                              .toString()))
                                                      ? Fluttertoast.showToast(
                                                          backgroundColor:
                                                              Colors.white,
                                                          msg:
                                                              "Quantity is lesser",
                                                          textColor:
                                                              Colors.black)
                                                      : state
                                                          .viewassetssearchModel[
                                                              index]
                                                          .count = state
                                                              .viewassetssearchModel[index]
                                                              .count! +
                                                          1;

                                                  state
                                                      .viewassetssearchModel[
                                                          index]
                                                      .change = true;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ));
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Text("Loading...");
              }
            }, listener: (context, state) async {
              if (state is SearchAssetssuccess) {
                //////
                ///
                ///
                // assetMasterTable = await db.getAssetMasterTableDownloadData();

                // for (int i = 0; i < state.viewassetssearchModel.length; i++) {
                //   for (int j = 0; j < assetMasterTable.length; j++) {
                //     if (state.viewassetssearchModel[i].assetid.toString() ==
                //         assetMasterTable[j].id)
                //       assetSearchlist.add(AssetSearchModel(
                //           producttype: assetMasterTable[j].productType,
                //           assetName: assetMasterTable[j].name,
                //           remark: assetMasterTable[j].description));
                //   }
                // }
                // print(widget.untiName);

              }
            }),
          ],
        ),
      ),
    );
  }

/////////
  void validateData() {
    if (transferassetslislist.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Please add Items ",
          textColor: Colors.black);
    } else {
      BlocProvider.of<GetAssetsWithoutRequestBloc>(context)
          .add(GetAssetsWithoutRequest(
        transferedtoId: widget.transferedtoId,
        transferassetslislist: transferassetslislist,
      ));
    }
  }
}

class TransferAssetsModel {
  String? assetId;
  String? added;
  String? producttype;
  String? unitid;
  String? assetName, unitName, date, employeename;

  String? quantity, orgquantity;
  String? remark;

  TransferAssetsModel({
    this.assetId,
    this.producttype,
    this.added,
    this.employeename,
    this.unitid,
    this.orgquantity,
    this.assetName,
    this.date,
    this.unitName,
    this.quantity,
    this.remark,
  });
}

class AssetSearchModel {
  String? assetId;
  String? assetName, unitName, date;
  String? producttype;
  String? quantity, orgquantity;
  String? remark;

  AssetSearchModel({
    this.assetId,
    this.producttype,
    this.orgquantity,
    this.assetName,
    this.date,
    this.unitName,
    this.quantity,
    this.remark,
  });
}
