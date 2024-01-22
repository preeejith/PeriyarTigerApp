import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:parambikulam/data/models/assetsmodel/ic_viewunnitsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/homepages_assets/unitsview/assetsview_transfer.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

//////////   want to do the changes///
class IcUnitsassetsview extends StatefulWidget {
  final String unitId;
  final String untiName;
  final int index;
  final IcViewUnitsModel icViewUnitsModel;
  const IcUnitsassetsview(
      {Key? key,
      required this.unitId,
      required this.untiName,
      required this.icViewUnitsModel,
      required this.index})
      : super(key: key);

  @override
  State<IcUnitsassetsview> createState() => _IcUnitsassetsviewState();
}

class _IcUnitsassetsviewState extends State<IcUnitsassetsview> {
  List<AssetsDetailsModel> assetsnamelist = [];
  List<AssetsNewModel> assetsnewlist = [];
  List<TransferAssetsModel> transferassetslislist = [];
  String? unitidname;
  List items62 = [];
  List<ViewassetsModel> viewassetsModel = [];
  List<AssetMasterTable> assetMasterTable = [];
  DatabaseHelper? db = DatabaseHelper.instance;
  @override
  void initState() {
/////
    ///
    print(widget.unitId);
    fetcher();
    super.initState();
  }

  void fetcher() async {
    items62 = await getassetswithoutrequestdata();
    assetsnewlist.clear();
    viewassetsModel = await db!.getViewAssetsDownloadData();
    // print(viewassetsModel);
    assetMasterTable = await db!.getAssetMasterTableDownloadData();
    // print(assetMasterTable);
    //////

    List items35 = await getAlltransferlogdata();
    print(items35);

    // for (int k = 0; k < items35.length; k++) {
    //   for (int r = 0;
    //       r < widget.icViewUnitsModel.user![widget.index].assets!.length;
    //       r++) {
    //     if (items35[k]['unitname'].toString() ==
    //         widget.icViewUnitsModel.user![widget.index].name.toString()) {

    //         }
    //   }
    // }

    for (int k = 0;
        k < widget.icViewUnitsModel.user![widget.index].assets!.length;
        k++) {
      assetsnewlist.add(AssetsNewModel(
          assetname: widget
              .icViewUnitsModel.user![widget.index].assets![k].assetId!.name,
          assetid: widget
              .icViewUnitsModel.user![widget.index].assets![k].assetId!.name,
          quantity: widget
              .icViewUnitsModel.user![widget.index].assets![k].quantity
              .toString(),
          unit: widget.icViewUnitsModel.user![widget.index].unitUnderIc,
          date: widget.icViewUnitsModel.user![widget.index].assets![k].assetId!
              .createDate
              .toString(),
          producttype: widget.icViewUnitsModel.user![widget.index].assets![k]
              .assetId!.productType
              .toString()));

      unitidname = widget.icViewUnitsModel.user![widget.index].unitUnderIc;
    }
    /////
    print(assetsnewlist);
    print('hello');
    print(widget.unitId);
    print(widget.icViewUnitsModel.user![widget.index].unitUnderIc);
    // print(items35);
    if (items35.isNotEmpty) {
      for (int k = 0; k < items35.length; k++) {
        if (unitidname == items35[k]['unitid'].toString())
        // ||
        //     items35[k]['assetname'].toString() == widget.untiName)
        {
          if (items35[k]['change'] == "true") {
            assetsnewlist.add(AssetsNewModel(
                assetid: "121212",
                quantity: items35[k]['quantity'].toString(),
                producttype: "gtv",
                assetname: items35[k]['assetname'].toString(),
                unit: items35[k]['unitname'].toString(),
                date: items35[k]['date'].toString()));
          }
        }
      }

      print(assetsnewlist);
    }
///////
    print(assetsnewlist);
    for (int i = 0; i < assetsnewlist.length; i++) {
      for (int j = 0; j < assetMasterTable.length; j++) {
        if (assetsnewlist[i].assetid.toString() == assetMasterTable[j].id) {
          assetsnamelist.add(AssetsDetailsModel(
              assetname: assetMasterTable[j].name,
              producttype: assetMasterTable[j].productType));
        }
      }
    }

    // BlocProvider.of<GetIcUnitsassetsviewBloc>(context).add(GetIcUnitsassetsview(
    //   /////
    //   unitId: widget.unitId,
    // ));
    setState(() {});
  }

  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Unit Assets'),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                height: 40,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///for new data in
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items62.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return items62[index]['transferedtoId'] !=
                        widget.unitId.toString()
                    ? SizedBox()
                    : ListTile(
                        title: InkWell(
                        child: Column(children: [
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 4,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Asset Name",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            // assetsnewlist[index].assetname.toString(),
                                            items62[index]['assetname'],
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
                                            "Quantity",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            items62[index]['quantity'],
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
                                            "Product Type",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            items62[index]['producttype'] ==
                                                    null
                                                ? "Non consumable"
                                                : items62[index]['producttype'],
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
                                          const Text("Issued Date",
                                              style: TextStyle(fontSize: 12)),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            d1.format(DateTime.parse(convert(
                                                    items62[index]['date']
                                                        .toString()))) +
                                                " | " +
                                                d2.format(DateTime.parse(
                                                    convert(items62[index]
                                                            ['date']
                                                        .toString()))),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                            ),
                                          )
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ]),
                      ));
              },
            ),

            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: assetsnewlist.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: InkWell(
                  child: Column(children: [
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Asset Name",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      // assetsnewlist[index].assetname.toString(),
                                      assetsnamelist.length != 0
                                          ? assetsnamelist[index]
                                              .assetname
                                              .toString()
                                          : assetsnewlist[index]
                                              .assetname
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
                                      "Quantity",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      assetsnewlist[index].quantity.toString(),
                                      // widget
                                      //     .icViewUnitsModel
                                      //     .user![widget.index]
                                      //     .assets![index]
                                      //     .quantity
                                      //     .toString(),
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
                                      "Product Type",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      assetsnewlist[index]
                                          .producttype
                                          .toString(),

                                      // widget
                                      //     .icViewUnitsModel
                                      //     .user![widget.index]
                                      //     .assets![index]
                                      //     .assetId!
                                      //     .productType
                                      //     .toString(),
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
                                    const Text("Issued Date",
                                        style: TextStyle(fontSize: 12)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      d1.format(DateTime.parse(convert(
                                              assetsnewlist[index]
                                                  .date
                                                  .toString()))) +
                                          " | " +
                                          d2.format(DateTime.parse(convert(
                                              assetsnewlist[index]
                                                  .date
                                                  .toString()))),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    )
                                  ]),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ]),
                ));
              },
            ),
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

class AssetsDetailsModel {
  String? assetname;
  String? producttype;

  AssetsDetailsModel({this.assetname, this.producttype});
}

class AssetsNewModel {
  String? assetname;
  String? producttype;
  String? assetid;
  String? quantity;
  String? unit;
  String? date;

  AssetsNewModel(
      {this.assetname,
      this.producttype,
      this.assetid,
      this.unit,
      this.quantity,
      this.date});
}

class ItemtocartModel {
  String? name;
  String? type;
  String? id;
  int? quantity;
  int? salesPrice;
  int? totalamount;
  ItemtocartModel({
    this.name,
    this.type,
    this.id,
    this.quantity,
    this.salesPrice,
    this.totalamount,
  });
}
