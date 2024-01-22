import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/assetseditbloc/assetseditbloc.dart';
import 'package:parambikulam/bloc/assets/assetseditbloc/assetseditevent.dart';

import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
///////
import 'package:parambikulam/ui/assets/assetshomepage.dart';

class AssetsDetailedView extends StatefulWidget {
  final String assetId;
  final unit;
  final int index;
  final List<ViewAssetsModel> viewassetslist;
  final List<ViewassetsModel> viewassetsModel;
  final List<AssetMasterTable> assetMasterTable;
  AssetsDetailedView(
      {Key? key,
      required this.assetId,
      required this.unit,
      required this.viewassetslist,
      required this.viewassetsModel,
      required this.assetMasterTable,
      required this.index})
      : super(key: key);

  @override
  State<AssetsDetailedView> createState() => _AssetsDetailedViewState();
}

class _AssetsDetailedViewState extends State<AssetsDetailedView> {
  List<ViewAssetsModel> viewassetslist = [];

  final TextEditingController namecontroller = TextEditingController();
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

  ///////
  void fetcher() async {}

  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: new AppBar(
        title: new Text('DETAILS'),
        actions: [
          widget.unit != "ic"
              ? SizedBox()
              : Row(
                  children: [
                    MaterialButton(
                        height: 35,
                        color: Colors.black,
                        child: Row(children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text("Edit")
                        ]),
                        onPressed: () {
                          setState(() {
                            namecontroller.text = widget
                                .viewassetsModel[widget.index].name
                                .toString();
                            descriptioncontroller.text = widget
                                .assetMasterTable[widget.index].description
                                .toString();
                          });

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: SizedBox(
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: const Text('Edit Assets'),
                                    content: Column(
                                      children: [
                                        TextFormField(
                                          textInputAction: TextInputAction.next,
                                          //noted
                                          controller: namecontroller,
                                          autocorrect: true,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            labelText: 'Asset Name',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        TextFormField(
                                          controller: descriptioncontroller,
                                          inputFormatters: const [],
                                          decoration: const InputDecoration(
                                            labelText: "Description",
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      MaterialButton(
                                        textColor: Colors.black,
                                        onPressed: () {
                                          setState(() {
                                            namecontroller.clear();

                                            descriptioncontroller.clear();
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'CANCEL',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      MaterialButton(
                                        child: const Text("SUBMIT",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12)),
                                        onPressed: () async {
                                          if (namecontroller.text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg: "Please Enter Name");
                                          } else {
                                            ///for edit in master table
                                            ///
                                            ///
                                            DatabaseHelper? db =
                                                DatabaseHelper.instance;
                                            List<ViewassetsModel>
                                                viewassetsModel = [];
                                            List<AssetMasterTable>
                                                assetMasterTable = [];

                                            viewassetsModel = await db
                                                .getViewAssetsDownloadData();
                                            print(viewassetsModel);
                                            AddAssetMainModel addAssetMainModel;
                                            assetMasterTable = await db
                                                .getAssetMasterTableDownloadData();
                                            for (int i = 0;
                                                i < assetMasterTable.length;
                                                i++) {
                                              if (assetMasterTable[i].id ==
                                                  widget
                                                      .viewassetsModel[
                                                          widget.index]
                                                      .assetid
                                                      .toString()) {
                                                assetMasterTable[i].name =
                                                    namecontroller.text
                                                        .toString();
                                                assetMasterTable[i]
                                                        .description =
                                                    descriptioncontroller.text;

                                                viewassetsModel[i].name =
                                                    namecontroller.text
                                                        .toString();
                                                viewassetsModel[i].edited =
                                                    "true";
                                              }
                                            }

                                            BlocProvider.of<
                                                        GetAssetsEditDetailedsBloc>(
                                                    context)
                                                .add(AssetsEditDetailedEvent(
                                                    viewassetsModel:
                                                        viewassetsModel,
                                                    assetMasterTable:
                                                        assetMasterTable,
                                                    name: namecontroller.text,
                                                    description:
                                                        descriptioncontroller
                                                            .text,
                                                    assetId: widget
                                                        .viewassetsModel[
                                                            widget.index]
                                                        .assetid
                                                        .toString()));

                                            widget.viewassetsModel[widget.index]
                                                    .name =
                                                namecontroller.text.toString();
                                            widget
                                                    .assetMasterTable[widget.index]
                                                    .name =
                                                namecontroller.text.toString();

                                            widget
                                                    .assetMasterTable[widget.index]
                                                    .description =
                                                descriptioncontroller.text
                                                    .toString();

                                            Fluttertoast.showToast(
                                                backgroundColor: Colors.white,
                                                msg: "Asset Updated",
                                                gravity: ToastGravity.CENTER,
                                                textColor: Colors.black,
                                                fontSize: 16.0);
                                            // fetcher();
                                            Navigator.pop(context);
                                            setState(() {
                                              namecontroller.clear();

                                              descriptioncontroller.clear();
                                            });
                                          }
                                        },
                                        color: const Color(0xff59AF73),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ],
                )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 3.5,
                              width: MediaQuery.of(context).size.width,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage("assets/forest.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Assets Name",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    widget.assetMasterTable[widget.index].name
                                        .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            widget.assetMasterTable[widget.index].description ==
                                    ""
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Description",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          widget.assetMasterTable[widget.index]
                                              .description
                                              .toString(),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Quantity",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    widget
                                        .viewassetsModel[widget.index].quantity
                                        .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Product Type",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    widget.assetMasterTable[widget.index]
                                        .productType
                                        .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Added Date",
                                        style: TextStyle(fontSize: 12)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      d1.format(DateTime.parse(convert(
                                        widget.viewassetsModel[widget.index]
                                            .createDate
                                            .toString(),
                                      ))),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                      ),
                                    )
                                  ]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
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
