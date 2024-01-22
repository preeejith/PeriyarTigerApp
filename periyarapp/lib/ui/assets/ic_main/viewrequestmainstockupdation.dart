////////Request view to view the request and transfer with request/////
///

///All Data Converted to the local the data should have to send to locally
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:parambikulam/bloc/assets/new/transferstockupdationbloc/transferstock_blocupdation.dart';
import 'package:parambikulam/bloc/assets/new/transferstockupdationbloc/transferstock_eventupdation.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/new/requestmaindetailedmodel.dart';
import 'package:parambikulam/ui/assets/bottomnav.dart';

//////////Stock Updation/////
class TransferStockUpdation extends StatefulWidget {
  final String requestId;
  final List<ViewassetsModel> viewassetsModel;
  final List<AssetMasterTable> assetMasterTable;
  final int index;

  final String unitid;
  final List items43;
  final List items42;

  final String typeofrequest;
  final String requestid2;
  final String requesttypeon;

  final String unitname;
  const TransferStockUpdation({
    Key? key,
    required this.requestId,
    required this.index,
    required this.viewassetsModel,
    required this.assetMasterTable,
    required this.items43,
    required this.items42,
    required this.unitid,
    required this.unitname,
    required this.typeofrequest,
    required this.requestid2,
    required this.requesttypeon,
  }) : super(key: key);

  @override
  State<TransferStockUpdation> createState() => _TransferStockUpdationState();
}

class _TransferStockUpdationState extends State<TransferStockUpdation> {
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  List<RequestModel2> requestlist2 = [];
  List<List<DropdownModel>> dropdownlislist = [[]];
  List<AssetDetailsModel> assetdetailslist = [];
  int count = 0;
  String dropdownvalue = 'ENGLISH';
  bool isToggled = true;
  int? quantitycount = 0;
  int? quantitycount2 = 0;
  bool? value;
  bool? buttonok2 = false;
  bool? nobutton = false;
  bool? trasferbuttonon = false;
  bool? buttonok = false;
  ValueChanged<bool>? onChanged;
  String? chosenType;
  RequestMainDetailedModel? requestMainDetailedModel;
  int? k;
  final TextEditingController requestidcontroller = TextEditingController();
  final TextEditingController itemidcontroller = TextEditingController();
  final TextEditingController dropdownidcontroller = TextEditingController();
  @override
  void initState() {
    // fetcher();
    fetcher2();
    super.initState();
  }

//////////
  void fetcher2() async {
    for (int j = 0; j < widget.items43.length; j++) {
      if (widget.items42[widget.index]['requestid'] ==
          widget.items43[j]['requestid']) {
        for (int i = 0; i < widget.viewassetsModel.length; i++) {
          if (widget.items43[j]['assetid'] ==
              widget.viewassetsModel[i].assetid.toString()) {
            if (widget.items43[j]['status'].toString() != "transfered") {
              buttonok2 = true;
            }
            // buttonok2 != true
            //     ? await getupdatemastertabledata(
            //         "transfered", widget.items42[widget.index ]['idno'].toString())
            //     : "";

            assetdetailslist.add(AssetDetailsModel(
                assetId: widget.viewassetsModel[i].assetid.toString(),
                assetName: widget.viewassetsModel[i].name.toString(),
                typeofRequest: widget.items43[j]['typeOfRequest'].toString(),
                quantity: widget.viewassetsModel[i].quantity.toString(),
                quantity2: widget.items43[j]['quantity'].toString(),
                productname: widget.items43[j]['product'].toString(),
                status: widget.items43[j]['status'].toString(),
                other: widget.items43[j]['requestid'].toString(),
                idno: widget.items43[j]['idno'].toString(),
                count: 0,
                change: false));
          }
        }
      }
    }

    ///other to do
    ///

    // print(count);
    print(assetdetailslist);
  }
//   void fetcher() async {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Request Details'),
        actions: <Widget>[],
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: buttonok2 != true
            ? SizedBox()
            : Column(
                children: [
                  MaterialButton(
                    child: Text(
                      "Transfer",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),

                    ///
                    height: 40,
                    minWidth: 300,
                    color: Colors.green,
                    onPressed: () {
                      requestlist2.clear();
                      for (int k = 0; k < assetdetailslist.length; k++) {
                        if (assetdetailslist[k].change == true) {
                          requestlist2.add(
                            RequestModel2(
                                assetId: assetdetailslist[k].assetId,
                                quantity: assetdetailslist[k].count.toString(),
                                totalQuantity: int.parse(
                                  assetdetailslist[k].quantity.toString(),
                                ),
                                idno: assetdetailslist[k].idno.toString(),
                                statusmain: widget.items42[widget.index]['idno']
                                    .toString()),
                          );
                        }
                      }

                      validateData();
                    },
                  ),
                ],
              ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(),
//////new list

          Column(
            children: [
              // Text(state.requestMainDetailedModel.request)
              Text(
                "",
                style: TextStyle(color: Colors.white),
              ),

              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.items42[widget.index]['typeOfRequest'] ==
                          "stock Updation"
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                              height: 25,
                              width: 180,
                              color: Colors.grey.shade700,
                              child: Center(child: Text("Stock Updation  "))),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            height: 25,
                            width: 180,
                            color: Colors.grey.shade700,
                            child: Center(
                              child: Text(widget.items42[widget.index]
                                          ['typeOfRequest'] ==
                                      'repair'
                                  ? "Repair"
                                  : widget.items42[widget.index]
                                              ['typeOfRequest'] ==
                                          'damage'
                                      ? "Damage"
                                      : widget.items42[widget.index]
                                                  ['typeOfRequest'] ==
                                              'replace'
                                          ? 'Replace'
                                          : widget.items42[widget.index]
                                              ['typeOfRequest']),
                            ),
                          ),
                        )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "From",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(widget.unitname)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Time",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      d1.format(DateTime.parse(
                              convert(widget.items42[widget.index]['date']))) +
                          " | " +
                          d2.format(DateTime.parse(
                              convert(widget.items42[widget.index]['date']))),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
/////new List

              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: assetdetailslist.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return

                        //  widget.items42[widget.index]['requestid'] !=
                        //         widget.items43[index]['requestid']
                        //     ? SizedBox()
                        //     :

                        SizedBox(
                      //width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(
                                        //   height: 15,
                                        // ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.09,
                                                decoration: BoxDecoration(
                                                  color: Color(0xfff292929),
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 4,
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              Text(" Status"),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),

                                                        //  assetdetailslist.length!=0?

                                                        //
                                                        // :SizedBox(),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: assetdetailslist[
                                                                          index]
                                                                      .status ==
                                                                  null
                                                              ? Text(
                                                                  assetdetailslist[
                                                                          index]
                                                                      .status
                                                                      .toString())
                                                              : Text(assetdetailslist[
                                                                              index]
                                                                          .status
                                                                          .toString() ==
                                                                      'accepted'
                                                                  ? 'Accepted'
                                                                  // : state.requestMainDetailedModel.data![index].requestStatus.toString() ==
                                                                  //         'damaged'
                                                                  //     ? 'Damaged'
                                                                  //     :
                                                                  : assetdetailslist[index]
                                                                              .status
                                                                              .toString() ==
                                                                          'transfered'
                                                                      ? 'Transfered'
                                                                      : assetdetailslist[index].status.toString() ==
                                                                              'pending'
                                                                          ? 'Pending'
                                                                          : assetdetailslist[index]
                                                                              .status
                                                                              .toString()),
                                                        ),
                                                      ]),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              Text(" Product"),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:

                                                              // widget.items43[index]['typeOfRequest'] ==
                                                              //         "stock Updation"
                                                              //     ? Text(widget.items43[index]['unitName'] )
                                                              //     :

                                                              Text(assetdetailslist[
                                                                              index]
                                                                          .assetName ==
                                                                      null
                                                                  ? ""
                                                                  : assetdetailslist[
                                                                          index]
                                                                      .assetName
                                                                      .toString()),
                                                        ),
                                                      ]),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              Text(" Quantity"),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(assetdetailslist[
                                                                        index]
                                                                    .quantity2
                                                                    .toString()),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    //  widget
                                                                    //             .viewRequestMainModel
                                                                    //             .data![widget
                                                                    //                 .index]
                                                                    //             .productIds![
                                                                    //                 index]
                                                                    //             .myStock ==
                                                                    //         null
                                                                    //     ? Text("")
                                                                    //     :

                                                                    Text("(" +
                                                                        assetdetailslist[index]
                                                                            .quantity
                                                                            .toString() +
                                                                        ")"),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ]),
                                                  assetdetailslist[index]
                                                              .typeofRequest
                                                              .toString() ==
                                                          'damage'
                                                      ? Container()
                                                      : assetdetailslist[index]
                                                                  .typeofRequest
                                                                  .toString() ==
                                                              'repair'
                                                          ? Container()

//  widget.viewRequestMainModel.data![widget.index].productIds![index].requestStatus ==
//                                                                                 'transfered'

                                                          : assetdetailslist[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  'transfered'
                                                              ? Container()
                                                              : Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                      InkWell(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            assetdetailslist[index].count == 0
                                                                                ? SizedBox()
                                                                                : assetdetailslist[index].count = assetdetailslist[index].count! - 1;

                                                                            assetdetailslist[index].count! < 1
                                                                                ? assetdetailslist[index].change = false
                                                                                : assetdetailslist[index].change = true;
                                                                          });
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      assetdetailslist[index].count! <
                                                                              0
                                                                          ? SizedBox()
                                                                          : Container(
                                                                              child: Text(
                                                                                assetdetailslist[index].count.toString(),
                                                                                style: TextStyle(fontSize: 16, color: Colors.white),
                                                                              ),
                                                                            ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      InkWell(
                                                                        child: Icon(
                                                                            Icons.add),
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            trasferbuttonon =
                                                                                true;
                                                                            // widget.viewRequestMainModel.data![widget.index].productIds![index].start = true;

                                                                            (int.parse(assetdetailslist[index].count.toString()) >= int.parse(assetdetailslist[index].quantity.toString()))
                                                                                ? Fluttertoast.showToast(backgroundColor: Colors.white, msg: "Low Stock Available", textColor: Colors.black)
                                                                                : assetdetailslist[index].count = assetdetailslist[index].count! + 1;
                                                                            requestidcontroller.text =
                                                                                assetdetailslist[index].assetId.toString();
                                                                            // assetdetailslist[index].change =
                                                                            //     true;

                                                                            assetdetailslist[index].count! < 1
                                                                                ? assetdetailslist[index].change = false
                                                                                : assetdetailslist[index].change = true;
                                                                          });
                                                                        },
                                                                      )
                                                                    ]),
                                                  // : SizedBox(
                                                  //     height: 5,
                                                  //   )
                                                ]),
                                              ),

                                              // ),
                                            ]),
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),

/////newlist end
        ]),
      ),
    );
  }

///////
  void validateData() {
    if (requestlist2.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Please add Items ",
          textColor: Colors.black);
    } else {
      /////
      BlocProvider.of<GetTransferStockUpdationBloc>(context)
          .add(GetTransferStockUpdation(
        requestId: widget.requestId,
        transferedtoId: widget.unitid,
        requestlist2: requestlist2,
      ));

      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Asset Transfered ",
          textColor: Colors.black);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomerBottomNavigation()));
    }

    /////
  }
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

class DropdownModel {
  String? name;
  String? id;
  String? quantity;
  DropdownModel({
    this.name,
    this.id,
    this.quantity,
  });
}

class RequestModel2 {
  String? assetId;
  String? quantity;
  int? totalQuantity;
  String? idno;
  String? statusmain;

  RequestModel2(
      {this.idno,
      this.assetId,
      this.quantity,
      this.totalQuantity,
      this.statusmain});
}

class AssetDetailsModel {
  String? assetId;
  String? typeofRequest;
  String? assetName;
  String? quantity;
  String? quantity2;
  String? productname;
  String? status;
  String? other;
  String? idno;
  bool? change = false;
  int? count = 0;

  AssetDetailsModel(
      {this.assetId,
      this.typeofRequest,
      this.assetName,
      this.quantity,
      this.quantity2,
      this.productname,
      this.status,
      this.other,
      this.count,
      this.idno,
      this.change});
}
