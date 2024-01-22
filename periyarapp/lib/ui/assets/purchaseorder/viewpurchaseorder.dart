////populated please chnage while pushing

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewbloc/purchaseviewbloc.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewbloc/purchaseviewevent.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewbloc/purchaseviewstate.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/assetmastertablemodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

import 'package:parambikulam/ui/assets/purchaseorder/viewpurchasedetailedview.dart';

/////////
class ViewPurchaseOrder extends StatefulWidget {
  const ViewPurchaseOrder({
    Key? key,
  }) : super(key: key);
//////
  @override
  State<ViewPurchaseOrder> createState() => _ViewPurchaseOrderState();
}

class _ViewPurchaseOrderState extends State<ViewPurchaseOrder> {
  String? token;

  List<AssetMasterTable> assetMasterTable = [];
  bool? starton = true;
  bool? starton2 = false;
  String? assetname = "nill";
  late List newList;
  List<ViewPurchaseModel> viewpurchaselist = [];
  List<PurchaseListModel>? listpurchase = [];
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  @override
  void initState() {
    BlocProvider.of<GetViewPurchaseOrderBloc>(context)
        .add(RefreshOfflinePurchaseOrder2Event());
    fetcher();
    super.initState();
  }

  String? requesttype;
  void fetcher() async {
    BlocProvider.of<GetViewPurchaseOrderBloc>(context)
        .add(RefreshOfflinePurchaseOrderEvent());
    // BlocProvider.of<GetViewPurchaseOrderBloc>(context)
    //     .add(FetchOfflinePurchaseOrderEvent());
/////
    // setState(() {});
  }

////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: new AppBar(
        title: new Text('Purchase List'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<GetViewPurchaseOrderBloc, ViewPurchaseOrderState>(
                builder: (context, state) {
              if (state is RefreshStateSucces) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ////
                      ListView.builder(
                        reverse: true,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.purchaseOrder.length,
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
                                                "Purchase Id:",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              state.purchaseOrder[index]
                                                          .purchaseId
                                                          .toString() !=
                                                      "null"
                                                  ? Text(
                                                      state.purchaseOrder[index]
                                                          .purchaseId
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  : Text("")
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ////
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Total Amount:",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.purchaseOrder[index]
                                                    .billAmount
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
                                              const Text("Date:",
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                              Text(
                                                d1.format(
                                                    DateTime.parse(convert(
                                                  state.purchaseOrder[index]
                                                      .createDate
                                                      .toString(),
                                                ))),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewPurchaseOrderDetailed(
                                                purchaseOrder:
                                                    state.purchaseOrder,
                                                purchaseData:
                                                    state.purchaseData,
                                                viewpurchaselist:
                                                    viewpurchaselist,
                                                // purchaseId: state
                                                //     .viewPurchaseListModel
                                                //     .data![index]
                                                //     .id
                                                //     .toString(),
                                                // viewPurchaseListModel:
                                                //     state.viewPurchaseListModel,
                                                index: index)),
                                  );

                                  setState(() {});
                                },
                              ),

                              //           Image.network(
                              //   WebClient.imageUrl +
                              //      state.viewEachReportModel
                              //                 .records[index].photo[0]
                              //                 ,
                              //   width: 110,
                              //   height: 180,
                              // ),

                              //  Image.network(
                              //     WebClient.imageUrl +
                              //      state.viewEachReportModel.records[index].photo.length.,
                              //     width: 110,
                              //     height: 180,
                              //   ),
                            ]),
                          ));
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: SizedBox(
                    height: 28.0,
                    width: 28.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  ),
                );
              }
            }, listener: (context, state) async {
              if (state is RefreshStateSucces) {
                /////to do the chnages
                for (int k = 0; k < state.purchaseData.length; k++) {
                  for (int i = 0; i < state.assetMasterTable.length; i++) {
                    if (state.assetMasterTable[i].id ==
                        state.purchaseData[k].assetId) {
                      setState(() {
                        state.purchaseData[k].name =
                            state.assetMasterTable[i].name.toString();
                        assetname = state.assetMasterTable[i].name.toString();
                        print(assetname.toString() + "hello assets");
                      });
                    }
                  }
                }

                for (int k = 0; k < state.purchaseOrder.length; k++) {
                  viewpurchaselist.add(ViewPurchaseModel(
                    purchaseId: state.purchaseOrder[k].purchaseId,
                    totalAmount: state.purchaseOrder[k].totalAmount,
                    date: state.purchaseOrder[k].createDate,
                    discount: state.purchaseOrder[k].discount,
                    finalamount: state.purchaseOrder[k].billAmount,
                    name: "assets",
                    quantity: "111",
                    purchaseamount: "123",
                    purchaselist: [
                      if (state.purchaseOrder[k].id ==
                          state.purchaseData[0].purchaseid)
                        for (int k = 0; k < state.purchaseData.length; k++)
                          PurchaseListModel(
                            name: state.purchaseData[0].name.toString(),
                            quantity: state.purchaseData[0].quantity,
                            purchaseamount:
                                state.purchaseData[0].purchaseAmount.toString(),
                          )
                    ],
                  ));
                }
              }
              if (state is ViewPurchaseOrderSuccess) {
                viewpurchaselist.clear();
                DatabaseHelper? db = DatabaseHelper.instance;

                List items21 = [];
                items21 = await db.getICAddAssetsListDownloadData();
/////
                // var data = jsonDecode(items21[0]['data']);
                // print(data);
                // print(data['purchaseId']);
                // print(data['assets'][0]['name']);
                // print(data['assets'].length);

///////////////////to insert new values
                ///
                if (items21.isNotEmpty) {
                  /////
                  for (int j = items21.length - 1;
                      j != items21.length - items21.length - 1;
                      j--) {
                    var data = jsonDecode(items21[j]['data']);
////
                    int c = 0;
                    c = int.parse(data['totalAmount']) -
                        int.parse(data['discount']);
                    print(c.toString() + "Final Amout");

                    viewpurchaselist.add(ViewPurchaseModel(
                      purchaseId: data['purchaseId'],
                      totalAmount: data['totalAmount'],
                      date: state.viewPurchaseListModel.data![0].createDate
                          .toString(),
                      discount: data['discount'],
                      finalamount: c.toString(),
                      name: data['assets'][0]['name'],
                      quantity: data['assets'][0]['quantity'],
                      purchaseamount: data['assets'][0]['purchaseAmount'],
                      purchaselist: [
                        for (int r = 0; r < data['assets'].length; r++)
                          PurchaseListModel(
                            name: data['assets'][r]['name'],
                            quantity: data['assets'][r]['quantity'],
                            purchaseamount: data['assets'][r]['purchaseAmount'],
                          )
                      ],
                    ));
                  }
                }

///////old list
                setState(() {});
////////
                for (int i = 0;
                    i < state.viewPurchaseListModel.data!.length;
                    i++) {
                  viewpurchaselist.add(ViewPurchaseModel(
                    purchaseId: state.viewPurchaseListModel.data![i].purchaseId
                        .toString(),
                    totalAmount: state
                        .viewPurchaseListModel.data![i].totalAmount
                        .toString(),
                    date: state.viewPurchaseListModel.data![i].createDate
                        .toString(),
                    discount: state.viewPurchaseListModel.data![i].discount
                        .toString(),
                    finalamount: state.viewPurchaseListModel.data![i].billAmount
                        .toString(),
                    name: state.viewPurchaseListModel.data![i].purchase != null
                        ? state.viewPurchaseListModel.data![i].purchase!
                                    .length !=
                                0
                            ? state.viewPurchaseListModel.data![i].purchase![0]
                                .assetId!.name
                                .toString()
                            : "nill"
                        : "nill",
                    quantity: "111",

                    //  state
                    //     .viewPurchaseListModel.data![i].purchase![0].quantity
                    //     .toString(),
                    purchaseamount: "123",

                    // state.viewPurchaseListModel.data![i]
                    //     .purchase![0].purchaseAmount
                    //     .toString(),
                    purchaselist: [
                      for (int k = 0;
                          k <
                              state.viewPurchaseListModel.data![i].purchase!
                                  .length;
                          k++)
                        PurchaseListModel(
                          name: state.viewPurchaseListModel.data![i]
                              .purchase![k].assetId!.name
                              .toString(),
                          quantity: state.viewPurchaseListModel.data![i]
                              .purchase![k].quantity
                              .toString(),
                          purchaseamount: state.viewPurchaseListModel.data![i]
                              .purchase![k].purchaseAmount
                              .toString(),
                        )
                    ],
                  ));
                }
                setState(() {});
                print("hello");
                // print(viewpurchaselist);
              }
            })
          ],
        ),
      ),
    );
  }

  String convert(String uTCTime) {
    var dateFormat = DateFormat("dd-MM-yyyy hh:mm");
    var utcDate = dateFormat.format(DateTime.parse(uTCTime));
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();

    return localDate;
  }
}

class ViewPurchaseModel {
  String? purchaseId;
  String? totalAmount, date, discount, finalamount;
  List<PurchaseListModel>? purchaselist = [];
  String? name;
  String? quantity;
  String? purchaseamount;

  ViewPurchaseModel({
    this.purchaseId,
    this.purchaselist,
    this.totalAmount,
    this.date,
    this.discount,
    this.finalamount,
    this.name,
    this.quantity,
    this.purchaseamount,
  });
}

class PurchaseListModel {
  String? name;
  String? quantity;
  String? purchaseamount;

  PurchaseListModel({
    this.name,
    this.quantity,
    this.purchaseamount,
  });
}
