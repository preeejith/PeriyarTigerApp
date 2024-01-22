//////
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/icbloc/damagerequest_blocaccept/damagerequest_blocaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/damagerequest_blocaccept/damagerequest_eventaccept.dart';

import 'package:parambikulam/bloc/assets/icbloc/repairrequestacceptbloc/repairrequest_blocaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/repairrequestacceptbloc/repairrequest_eventaccept.dart';

import 'package:parambikulam/data/models/assetsmodel/new/requestmaindetailedmodel.dart';
import 'package:parambikulam/ui/assets/bottomnav.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

////Repair ////Damage////
class ViewRequestDamage extends StatefulWidget {
  final String requestId;
  final int index;
  final String unitid;
  final List items44;
  final String typeofrequest;
  final String requestid2;
  final String requesttypeon;
  final List items43;
  final List items42;
  final List items45;
  final List items46;
  // final ViewRequestMainModel viewRequestMainModel;

  final String unitname;
  const ViewRequestDamage({
    Key? key,
    required this.requestId,
    required this.items44,
    required this.items43,
    required this.items42,
    required this.items45,
    required this.items46,
    required this.index,
    required this.unitid,
    required this.unitname,
    required this.typeofrequest,
    required this.requestid2,
    required this.requesttypeon,
    // required this.viewRequestMainModel
  }) : super(key: key);

  @override
  State<ViewRequestDamage> createState() => _ViewRequestDetaiedState();
}

class _ViewRequestDetaiedState extends State<ViewRequestDamage> {
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  List<RequestModel> requestlist = [];
  List<List<DropdownModel>> dropdownlislist = [[]];
  List<AssetNewPurchaeModel> assetnewpurchaselist = [];
  String dropdownvalue = 'ENGLISH';
  bool isToggled = true;
  bool damageonaccept = false;
  int? quantitycount2 = 0;
  bool? value;
  bool? nobutton = false;
  bool? buttonok = false;
  ValueChanged<bool>? onChanged;
  String? chosenType;
  RequestMainDetailedModel? requestMainDetailedModel;
  int? k;
  final TextEditingController requestidcontroller = TextEditingController();
  final TextEditingController itemidcontroller = TextEditingController();
  final TextEditingController dropdownidcontroller = TextEditingController();

  final TextEditingController dropdownquantitycontroller =
      TextEditingController();
  @override
  void initState() {
    fetcher();
    fetcher2();

    super.initState();
  }

  void fetcher2() async {
    assetnewpurchaselist.clear();

    for (int i = 0; i < widget.items46.length; i++) {
      if (widget.requestid2 == widget.items46[i]['requestid']) {
        // if (widget.items43[j]['status'].toString() != "transfered") {
        //   buttonok2 = true;
        // }

        assetnewpurchaselist.add(AssetNewPurchaeModel(
            assetId: widget.items46[i]['assetid'],
            assetName: widget.items46[i]['unitName'],
            typeofRequest: widget.items46[i]['typeOfRequest'],
            quantity: widget.items46[i]['quantity'],
            quantity2: widget.items46[i]['quantity'],
            productname: widget.items46[i]['product'],
            status: widget.items46[i]['status'],
            other: widget.items46[i]['requestid'],
            idno: widget.items46[i]['idno'].toString(),
            count: 0,
            change: false));
      }
    }
    for (int i = 0; i < widget.items45.length; i++) {
      if (widget.requestid2 == widget.items45[i]['requestid']) {
        // if (widget.items43[j]['status'].toString() != "transfered") {
        //   buttonok2 = true;
        // }

        assetnewpurchaselist.add(AssetNewPurchaeModel(
            assetId: widget.items45[i]['assetid'],
            assetName: "abc",
            typeofRequest: widget.items45[i]['typeOfRequest'],
            quantity: widget.items45[i]['quantity'],
            quantity2: widget.items45[i]['quantity'],
            productname: widget.items45[i]['product'],
            status: widget.items45[i]['status'],
            other: widget.items45[i]['requestid'],
            idno: widget.items45[i]['idno'].toString(),
            count: 0,
            change: false));
      }
    }

    print(assetnewpurchaselist);
  }

  ///
  void fetcher() async {}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Request Details'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                      height: 25,
                      width: 180,
                      color: Colors.grey.shade700,
                      child: Center(child: Text(widget.typeofrequest))),
                ),
              ),
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
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: assetnewpurchaselist.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    TextEditingController remarkcontroller =
                        TextEditingController();
                    return SizedBox(
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
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: assetnewpurchaselist[
                                                                          index]
                                                                      .productname ==
                                                                  null
                                                              ? Text(
                                                                  assetnewpurchaselist[
                                                                          index]
                                                                      .status
                                                                      .toString())
                                                              : Text(assetnewpurchaselist[
                                                                              index]
                                                                          .status
                                                                          .toString() ==
                                                                      'accepted'
                                                                  ? 'Accepted'
                                                                  // : state.requestMainDetailedModel.data![index].requestStatus.toString() ==
                                                                  //         'damaged'
                                                                  //     ? 'Damaged'
                                                                  //     :
                                                                  : assetnewpurchaselist[index]
                                                                              .status
                                                                              .toString() ==
                                                                          'transfered'
                                                                      ? 'Transfered'
                                                                      : assetnewpurchaselist[index].status.toString() ==
                                                                              'pending'
                                                                          ? 'Pending'
                                                                          : assetnewpurchaselist[index]
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
                                                          child: assetnewpurchaselist[
                                                                          index]
                                                                      .typeofRequest
                                                                      .toString() !=
                                                                  "stock Updation"
                                                              ? Text(assetnewpurchaselist[
                                                                      index]
                                                                  .productname
                                                                  .toString())
                                                              : Text(assetnewpurchaselist[
                                                                      index]
                                                                  .productname
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
                                                                child: Text(
                                                                    assetnewpurchaselist[
                                                                            index]
                                                                        .quantity
                                                                        .toString()),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: dropdownquantitycontroller
                                                                            .text
                                                                            .toString() ==
                                                                        ""
                                                                    ? Text("")
                                                                    : Text("(" +
                                                                        dropdownquantitycontroller
                                                                            .text
                                                                            .toString() +
                                                                        ")"),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ]),

                                                  ///damegemain
                                                  ///
                                                  ///
                                                  ///repair
                                                  assetnewpurchaselist[index]
                                                              .status
                                                              .toString() ==
                                                          'accepted'
                                                      ? Container()
                                                      : assetnewpurchaselist[
                                                                      index]
                                                                  .typeofRequest
                                                                  .toString() ==
                                                              'repair'
                                                          ? MaterialButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6.0))),
                                                              color:
                                                                  Colors.green,
                                                              child: Text(
                                                                  "Accept"),
                                                              onPressed: () {
                                                                ////changed to
                                                                BlocProvider.of<GetRepairRequestAcceptBloc>(context).add(GetRepairRequestAccept(
                                                                    requestId:
                                                                        widget
                                                                            .requestId,
                                                                    assetId: assetnewpurchaselist[
                                                                            index]
                                                                        .assetId
                                                                        .toString(),
                                                                    idno: assetnewpurchaselist[
                                                                            index]
                                                                        .idno
                                                                        .toString()));

                                                                Fluttertoast.showToast(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    msg:
                                                                        "Request Accepted",
                                                                    textColor:
                                                                        Colors
                                                                            .black);

                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                CustomerBottomNavigation()));

                                                                // acceptrepairedData();
                                                              },

                                                              // child: BlocConsumer<
                                                              //         GetRepairRequestAcceptBloc,
                                                              //         RepairRequestAcceptState>(
                                                              //     builder:
                                                              //         (context,
                                                              //             state) {
                                                              //   if (state
                                                              //       is RepairRequestAccepting) {
                                                              //     return const SizedBox(
                                                              //       height:
                                                              //           18.0,
                                                              //       width: 18.0,
                                                              //     );
                                                              //   } else {
                                                              //     return const Text(
                                                              //       "Accept",
                                                              //       style: TextStyle(
                                                              //           color: Colors
                                                              //               .white,
                                                              //           fontWeight:
                                                              //               FontWeight
                                                              //                   .w600,
                                                              //           fontSize:
                                                              //               12),
                                                              //     );
                                                              //   }
                                                              // }, listener:
                                                              //         (context,
                                                              //             state) {
                                                              //   if (state
                                                              //       is RepairRequestAcceptsuccess) {
                                                              //     // groupid = state.snareWalkStartModel.data!.id;

                                                              //     Fluttertoast.showToast(
                                                              //         backgroundColor:
                                                              //             Colors
                                                              //                 .white,
                                                              //         msg:
                                                              //             "Request Accepted",
                                                              //         textColor:
                                                              //             Colors
                                                              //                 .black);

                                                              //     BlocProvider.of<
                                                              //                 GetRequestMainDetailedBloc>(
                                                              //             context)
                                                              //         .add(
                                                              //             GetRequestMainDetailed(
                                                              //       requestId:
                                                              //           widget
                                                              //               .requestId,
                                                              //     ));
                                                              //   }
                                                              // }),
                                                            )
                                                          : Container(),

                                                  ////for damaged
                                                  // damageonaccept == true
                                                  //     ? SizedBox()
                                                  //     :
/////////////damage
                                                  assetnewpurchaselist[index]
                                                              .typeofRequest
                                                              .toString() ==
                                                          'repair'
                                                      ? SizedBox()
                                                      : assetnewpurchaselist[
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              'damaged'
                                                          ? Container()
                                                          : assetnewpurchaselist[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  'pending'
                                                              ? Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          TextFormField(
                                                                        textInputAction:
                                                                            TextInputAction.next,
                                                                        //noted
                                                                        controller:
                                                                            remarkcontroller,
                                                                        autocorrect:
                                                                            true,
                                                                        keyboardType:
                                                                            TextInputType.text,
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          labelText:
                                                                              'Remark',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    MaterialButton(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(6.0))),
                                                                      color: Colors
                                                                          .green,

                                                                      child:
                                                                          Text(
                                                                        "Accept",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),
                                                                      ),
                                                                      // child: Text(
                                                                      //     "Accept"),
                                                                      onPressed:
                                                                          () {
                                                                        BlocProvider.of<GetDamageRequestAcceptBloc>(context)
                                                                            .add(GetDamageRequestAccept(
                                                                          requestId:
                                                                              widget.requestId,
                                                                          assetId: assetnewpurchaselist[index]
                                                                              .assetId
                                                                              .toString(),
                                                                          remark: remarkcontroller.text.isEmpty
                                                                              ? ""
                                                                              : remarkcontroller.text,
                                                                          idno: assetnewpurchaselist[index]
                                                                              .idno
                                                                              .toString(),
                                                                          statusmain: widget
                                                                              .items42[widget.index]['idno']
                                                                              .toString(),
                                                                        ));
///////////////////local data for damage/////start
                                                                        final assetid = assetnewpurchaselist[index]
                                                                            .typeofRequest
                                                                            .toString();
                                                                        final unitid =
                                                                            widget.unitid;
                                                                        final requestid =
                                                                            widget.requestId;
                                                                        final requesttype =
                                                                            "damage";
                                                                        final quantity =
                                                                            "0";

                                                                        if (assetid
                                                                            .isEmpty) {
                                                                          return;
                                                                        } else {
                                                                          Map data =
                                                                              {
                                                                            "assetid":
                                                                                assetid,
                                                                            "quantity":
                                                                                quantity,
                                                                            "unitid":
                                                                                unitid,
                                                                            "requestid":
                                                                                requestid,
                                                                            "requesttype":
                                                                                requesttype,
                                                                          };
                                                                          print(
                                                                              data);
                                                                          // stockupdationquantitycount(
                                                                          //     data);
////////main
                                                                          setState(
                                                                              () {});
                                                                          ///////////////////local data for damage/////end
                                                                        }

                                                                        Fluttertoast.showToast(
                                                                            backgroundColor: Colors
                                                                                .white,
                                                                            msg:
                                                                                "Request Accepted",
                                                                            textColor:
                                                                                Colors.black);

                                                                        Navigator.pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => CustomerBottomNavigation()));

                                                                        // acceptrepairedData();
                                                                      },
                                                                    ),
                                                                  ],
                                                                )
                                                              : Container(),

                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  widget.requesttypeon ==
                                                          'Transfered'
                                                      ? Container()
                                                      : SizedBox(),

                                                  SizedBox(
                                                    height: 8,
                                                  ),

                                                  ///to activate////start
                                                  //  assetnewpurchaselist[index].typeofRequest.toString()  ==
                                                  //           'damage'
                                                  //       ? Container()
                                                  //       :assetnewpurchaselist[index].typeofRequest.toString()  ==
                                                  //               'repair'
                                                  //           ? Container()
                                                  //           : assetnewpurchaselist[index].typeofRequest.toString()  ==
                                                  //                   'transfered'
                                                  //               ? Container()
                                                  //               : widget
                                                  //                           .viewRequestMainModel
                                                  //                           .data![widget
                                                  //                               .index]
                                                  //                           .productIds![
                                                  //                               index]
                                                  //                           .dropdown !=
                                                  //                       true
                                                  //                   ? Container()
                                                  //                   : widget.requesttypeon ==
                                                  //                           'Transfered'
                                                  //                       ? Container()
                                                  //                       : Row(
                                                  //                           mainAxisAlignment:
                                                  //                               MainAxisAlignment.center,
                                                  //                           children: [
                                                  //                               InkWell(
                                                  //                                 child: Icon(
                                                  //                                   Icons.remove,
                                                  //                                   color: Colors.white,
                                                  //                                 ),
                                                  //                                 onTap: () {
                                                  //                                   setState(() {
                                                  //                                     widget.viewRequestMainModel.data![widget.index].productIds![index].count == 0 ? SizedBox() : widget.viewRequestMainModel.data![widget.index].productIds![index].count = widget.viewRequestMainModel.data![widget.index].productIds![index].count! - 1;

                                                  //                                     widget.viewRequestMainModel.data![widget.index].productIds![index].count! < 1 ? widget.viewRequestMainModel.data![widget.index].productIds![index].change = false : widget.viewRequestMainModel.data![widget.index].productIds![index].change = true;
                                                  //                                   });
                                                  //                                 },
                                                  //                               ),
                                                  //                               SizedBox(
                                                  //                                 width: 5,
                                                  //                               ),
                                                  //                               //////tochange
                                                  //                               ///
                                                  //                               ///

                                                  //                               widget.viewRequestMainModel.data![widget.index].productIds![index].count! < 0
                                                  //                                   ? Container()
                                                  //                                   : Container(
                                                  //                                       child: Text(
                                                  //                                         widget.viewRequestMainModel.data![widget.index].productIds![index].count.toString(),
                                                  //                                         style: TextStyle(fontSize: 16, color: Colors.white),
                                                  //                                       ),
                                                  //                                     ),
                                                  //                               SizedBox(
                                                  //                                 width: 5,
                                                  //                               ),
                                                  //                               InkWell(
                                                  //                                 child: Icon(Icons.add),
                                                  //                                 onTap: () {
                                                  //                                   setState(() {
                                                  //                                     widget.viewRequestMainModel.data![widget.index].productIds![index].start = true;

                                                  //                                     dropdownidcontroller.text.isEmpty
                                                  //                                         ? Fluttertoast.showToast(backgroundColor: Colors.white, msg: "Please select the asset", textColor: Colors.black)
                                                  //                                         : (int.parse(dropdownquantitycontroller.text.toString()) <= int.parse(widget.viewRequestMainModel.data![widget.index].productIds![index].count.toString()))
                                                  //                                             ? Fluttertoast.showToast(backgroundColor: Colors.white, msg: "Quantity is lesser", textColor: Colors.black)
                                                  //                                             : widget.viewRequestMainModel.data![widget.index].productIds![index].count = widget.viewRequestMainModel.data![widget.index].productIds![index].count! + 1;
                                                  //                                     requestidcontroller.text = widget.viewRequestMainModel.data![widget.index].productIds![index].requestId.toString();
                                                  //                                     widget.viewRequestMainModel.data![widget.index].productIds![index].change = true;
                                                  //                                   });
                                                  //                                 },
                                                  //                               )
                                                  //                             ]),
                                                  ///to activate////start
                                                  SizedBox(
                                                    height: 5,
                                                  )
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
        ]),
      ),
    );
  }

  void validateData() {
    if (requestlist.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Please add Items ",
          textColor: Colors.black);
    } else {
      // BlocProvider.of<GetTransferwithRequestBloc>(context)
      //     .add(GetTransferwithRequest(
      //   requestId: widget.requestid2,
      //   requestlist: requestlist,
      // ));

      for (int k = 0; k < requestlist.length; k++) {
        final assetid = requestlist[k].assetId;
        final unitid = widget.unitid;
        final requestid = widget.requestid2;
        final requesttype = "New Purchase";
        final quantity = requestlist[k].quantity.toString();

        if (assetid!.isEmpty) {
          return;
        } else {
          Map data = {
            "assetid": assetid,
            "quantity": quantity,
            "unitid": unitid,
            "requestid": requestid,
            "requesttype": requesttype,
          };
          print(data);
          stockupdationquantitycount(data);
////////main
          setState(() {});
        }
      }

      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Asset Transfered ",
          textColor: Colors.black);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomerBottomNavigation()));
    }
  }

  String convert(String uTCTime) {
    var dateFormat =
        DateFormat("dd-MM-yyyy hh:mm"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(uTCTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();

    return localDate;
  }
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

//AssetNewPurchaeModel
class AssetNewPurchaeModel {
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

  AssetNewPurchaeModel(
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

class RequestModel {
  String? assetId;
  String? quantity;
  String? itemid;

  RequestModel({
    this.assetId,
    this.quantity,
    this.itemid,
  });
}
