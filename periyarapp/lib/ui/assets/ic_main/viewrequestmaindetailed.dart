import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:parambikulam/bloc/assets/new/trasnferwithrequestbloc/transferwithrequest_blocmain.dart';
import 'package:parambikulam/bloc/assets/new/trasnferwithrequestbloc/transferwithrequest_eventmain.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/requestmaindetailedmodel.dart';
import 'package:parambikulam/ui/assets/bottomnav.dart';

////New purchase
class ViewRequestDetaied extends StatefulWidget {
  final String requestId;
  final List<ViewassetsModel> viewassetsModel;
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
  const ViewRequestDetaied({
    Key? key,
    required this.viewassetsModel,
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
  State<ViewRequestDetaied> createState() => _ViewRequestDetaiedState();
}

class _ViewRequestDetaiedState extends State<ViewRequestDetaied> {
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  List<RequestModel> requestlist = [];

  List<List<DropdownModel>> dropdownlislist = [[]];
  List<DropdownModel> dropdownlist2 = [];
  List<AssetNewPurchaeModel> assetnewpurchaselist = [];
  String dropdownvalue = 'ENGLISH';
  bool isToggled = true;
  bool damageonaccept = false;
  int? quantitycount2 = 0;
  bool? value;
  bool? nobutton = false;
  bool? buttonok2 = false;
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
  final TextEditingController dropdownaddedcontroller = TextEditingController();

  @override
  void initState() {
    fetcher();
    fetcher2();

    super.initState();
  }

  ///
  void fetcher2() async {
    assetnewpurchaselist.clear();

    for (int i = 0; i < widget.items44.length; i++) {
      if (widget.items42[widget.index]['requestid'] ==
          widget.items44[i]['requestid']) {
        if (widget.items44[0]['status'].toString() != "transfered") {
          buttonok2 = true;
        }
        setState(() {
          assetnewpurchaselist.add(AssetNewPurchaeModel(
              assetId: "123",
              itemid: widget.items44[i]['idid'].toString(),
              assetName: widget.items44[i]['product'],
              typeofRequest: widget.items44[i]['typeOfRequest'],
              remark: widget.items44[i]['remark'],
              quantity: widget.items44[i]['quantity'],
              quantity2: widget.items44[i]['quantity'],
              productname: widget.items44[i]['product'],
              status: widget.items44[i]['status'],
              other: widget.items44[i]['requestid'],
              idno: widget.items44[i]['idno'].toString(),
              count: 0,
              change: false));
        });
      }
    }
    print(assetnewpurchaselist);

    for (int k = 0; k < widget.viewassetsModel.length; k++) {
      dropdownlist2.add(DropdownModel(
        added: widget.viewassetsModel[k].added,
        id: widget.viewassetsModel[k].assetid.toString(),
        name: widget.viewassetsModel[k].name.toString(),
        quantity: widget.viewassetsModel[k].quantity.toString(),
      ));
    }
    // if (dropdownlist2.isNotEmpty) {
    //   for (int q = 0; q < widget.items44.length; q++) {
    //     dropdownlist2.addAll(dropdownlist2);
    //   }
    // }

    setState(() {});
    print("aaaaaaaaaaa");
    print(dropdownlist2);
  }

  void fetcher() async {}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Request Details'),
        actions: <Widget>[],
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: assetnewpurchaselist[0].status.toString() != 'pending'
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
                    // child: Text("Transfer"),
                    height: 40,
                    minWidth: 300,
                    color: Colors.green,
                    onPressed: () {
                      requestlist.clear();
                      for (int k = 0; k < assetnewpurchaselist.length; k++) {
                        if (assetnewpurchaselist[k].change == true) {
                          requestlist.add(RequestModel(
                              assetId: assetnewpurchaselist[k].typeofRequest ==
                                      'New Purchase'
                                  ? dropdownidcontroller.text
                                  : assetnewpurchaselist[k].assetId,
                              added: dropdownaddedcontroller.text.toString(),
                              quantity:
                                  assetnewpurchaselist[k].count.toString(),
                              itemid: assetnewpurchaselist[k].itemid.toString(),
                              idno: assetnewpurchaselist[k].idno,
                              requestid: assetnewpurchaselist[k].other,
                              quantity2:
                                  dropdownquantitycontroller.text.toString(),
                              mainstatus: widget.items42[widget.index]['idno']
                                  .toString()));
                        }
                      }
                      print(requestlist);
                      validateData();
                    },
                  ),
                ],
              ),
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
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  // itemCount: widget.items44.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return
                        // widget.items44[index]['requestid'] !=
                        //         widget.items42[widget.index]['requestid']
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
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(assetnewpurchaselist[
                                                                          index]
                                                                      .status ==
                                                                  'accepted'
                                                              ? 'Accepted'
                                                              : assetnewpurchaselist[
                                                                              index]
                                                                          .status ==
                                                                      'transfered'
                                                                  ? 'Transfered'
                                                                  : assetnewpurchaselist[index]
                                                                              .status ==
                                                                          'pending'
                                                                      ? 'Pending'
                                                                      : assetnewpurchaselist[
                                                                              index]
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
                                                                      .typeofRequest !=
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
                                                              Text(" Remark"),
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
                                                                      .remark
                                                                      .toString() ==
                                                                  ""
                                                              ? Text(
                                                                  assetnewpurchaselist[
                                                                          index]
                                                                      .remark
                                                                      .toString())
                                                              : Text(assetnewpurchaselist[
                                                                      index]
                                                                  .remark
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
                                                                child: Text(widget
                                                                            .items44[
                                                                        index][
                                                                    'quantity']),
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
                                                  ///

                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  assetnewpurchaselist[index]
                                                              .status
                                                              .toString() !=
                                                          'pending'
                                                      ? SizedBox()
                                                      : Container(
                                                          child: Column(
                                                              children: [
                                                                ButtonTheme(
                                                                  alignedDropdown:
                                                                      true,
                                                                  child:
                                                                      DropdownButtonFormField(
                                                                    icon: Visibility(
                                                                        visible:
                                                                            true,
                                                                        child: Icon(
                                                                            Icons.keyboard_arrow_down)),

                                                                    value:
                                                                        chosenType,

                                                                    isExpanded:
                                                                        true,

                                                                    ////importantdrr

                                                                    items: index ==
                                                                            10000
                                                                        ? dropdownlist2.map((DropdownModel
                                                                            drop) {
                                                                            return new DropdownMenuItem<String>(
                                                                              value: drop.id,
                                                                              child: new Text(
                                                                                drop.name.toString(),
                                                                                style: const TextStyle(color: Colors.white),
                                                                              ),
                                                                            );
                                                                          }).toList()
                                                                        : dropdownlist2.map((DropdownModel
                                                                            drop) {
                                                                            return new DropdownMenuItem<String>(
                                                                              value: drop.id.toString() + "split1" + drop.quantity.toString() + "split2" + drop.added.toString(),
                                                                              child: new Text(
                                                                                drop.name.toString(),
                                                                                style: const TextStyle(color: Colors.white),
                                                                              ),
                                                                            );
                                                                          }).toList(),

                                                                    onChanged:
                                                                        (String?
                                                                            value) {
                                                                      print(
                                                                          value);

                                                                      setState(
                                                                          () {
                                                                        chosenType =
                                                                            value;
                                                                        dropdownidcontroller.text = value!
                                                                            .split('split1')
                                                                            .first
                                                                            .toString();

                                                                        dropdownquantitycontroller.text = value
                                                                            .split('split1')
                                                                            .last
                                                                            .split('split2')
                                                                            .first
                                                                            .toString();

                                                                        dropdownaddedcontroller.text = value
                                                                            .split('split2')
                                                                            .last
                                                                            .toString();

                                                                        print(dropdownidcontroller
                                                                            .text
                                                                            .toString());

                                                                        print(dropdownquantitycontroller
                                                                            .text
                                                                            .toString());

                                                                        requestidcontroller.text =
                                                                            value.toString();
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),

                                                  assetnewpurchaselist[index]
                                                              .status
                                                              .toString() !=
                                                          'pending'
                                                      ? SizedBox()
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                              InkWell(
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    assetnewpurchaselist[index].count ==
                                                                            0
                                                                        ? SizedBox()
                                                                        : assetnewpurchaselist[index]
                                                                            .count = assetnewpurchaselist[index]
                                                                                .count! -
                                                                            1;

                                                                    assetnewpurchaselist[index].count! <
                                                                            1
                                                                        ? assetnewpurchaselist[index].change =
                                                                            false
                                                                        : assetnewpurchaselist[index].change =
                                                                            true;
                                                                  });
                                                                },
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              // assetnewpurchaselist.length ==
                                                              //         0
                                                              //     ? SizedBox()
                                                              //     : assetnewpurchaselist[index].count! <
                                                              //             0
                                                              //         ?

                                                              Container(
                                                                child: Text(
                                                                  assetnewpurchaselist[
                                                                          index]
                                                                      .count
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              // : SizedBox(),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              InkWell(
                                                                child: Icon(
                                                                    Icons.add),
                                                                onTap: () {
                                                                  setState(() {
                                                                    // widget.viewRequestMainModel.data![widget.index].productIds![index].start = true;

                                                                    dropdownidcontroller
                                                                            .text
                                                                            .isEmpty
                                                                        ? Fluttertoast.showToast(
                                                                            backgroundColor: Colors
                                                                                .white,
                                                                            msg:
                                                                                "Please select the asset",
                                                                            textColor:
                                                                                Colors.black)
                                                                        : (int.parse(dropdownquantitycontroller.text.toString()) <= int.parse(assetnewpurchaselist[index].count.toString()))
                                                                            ? Fluttertoast.showToast(backgroundColor: Colors.white, msg: "Quantity is lesser", textColor: Colors.black)
                                                                            : assetnewpurchaselist[index].count = assetnewpurchaselist[index].count! + 1;
                                                                    requestidcontroller
                                                                        .text = assetnewpurchaselist[
                                                                            index]
                                                                        .quantity
                                                                        .toString();
                                                                    assetnewpurchaselist[
                                                                            index]
                                                                        .change = true;
                                                                  });
                                                                },
                                                              )
                                                            ]),

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

/////
  void validateData() {
    if (requestlist.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Please add Items ",
          textColor: Colors.black);
    } else {
      BlocProvider.of<GetTransferwithRequestBloc>(context)
          .add(GetTransferwithRequest(
        requestId: widget.requestid2,
        requestlist: requestlist,
      ));
/////
//       for (int k = 0; k < requestlist.length; k++) {
//         final assetid = requestlist[k].assetId;
//         final unitid = widget.unitid;
//         final requestid = widget.requestid2;
//         final requesttype = "New Purchase";
//         final quantity = requestlist[k].quantity.toString();

//         if (assetid!.isEmpty) {
//           return;
//         } else {
//           Map data = {
//             "assetid": assetid,
//             "quantity": quantity,
//             "unitid": unitid,
//             "requestid": requestid,
//             "requesttype": requesttype,
//           };
//           print(data);
//           // stockupdationquantitycount(data);
// ////////main
//           setState(() {});
//         }
//       }

      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Asset Transfered ",
          textColor: Colors.black);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomerBottomNavigation()));
    }
  }

  ///
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
  String? added;
  String? choosenType;
  String? id;
  String? quantity;
  DropdownModel({
    this.name,
    this.added,
    this.choosenType,
    this.id,
    this.quantity,
  });
}

//AssetNewPurchaeModel
class AssetNewPurchaeModel {
  String? assetId;
  String? typeofRequest;
  String? assetName;
  String? itemid;
  String? remark;
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
      this.itemid,
      this.remark,
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
  String? added;
  String? quantity;
  String? quantity2;
  String? itemid;
  String? idno;
  String? requestid;
  String? mainstatus;

  RequestModel(
      {this.assetId,
      this.added,
      this.quantity2,
      this.requestid,
      this.idno,
      this.quantity,
      this.itemid,
      this.mainstatus});
}
