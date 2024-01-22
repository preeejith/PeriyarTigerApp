////populated please chnage while pushing

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:parambikulam/bloc/assets/viewrequestunit_bloc/viewrequest_bloc.dart';
import 'package:parambikulam/bloc/assets/viewrequestunit_bloc/viewrequest_event.dart';
import 'package:parambikulam/bloc/assets/viewrequestunit_bloc/viewrequest_state.dart';
import 'package:parambikulam/bloc/assets/viewrequestunittype_bloc.dart/viewrequestunittype_bloc.dart';
import 'package:parambikulam/bloc/assets/viewrequestunittype_bloc.dart/viewrequestunittype_event.dart';
import 'package:parambikulam/bloc/assets/viewrequestunittype_bloc.dart/viewrequestunittype_state.dart';



import 'package:parambikulam/ui/assets/homepages_assets/unitsview/ic_viewunitspage.dart';
import 'package:parambikulam/ui/assets/homepages_assets/unitsview/newrequestdetailedview.dart';
import 'package:parambikulam/ui/assets/profilepage.dart';

import 'package:parambikulam/utils/pref_manager.dart';

class NewRequestView extends StatefulWidget {
  final String transferedtoId;

  const NewRequestView({Key? key, required this.transferedtoId})
      : super(key: key);

  @override
  State<NewRequestView> createState() => _NewRequestViewState();
}

class _NewRequestViewState extends State<NewRequestView> {
  String? token;
  bool? allon = true;
  String? colormix = "all";
  bool? all = true;
  bool? active = false;
  bool? rejected = false;
  String dropdownvalue = 'All';
  var items = [
    'All',
    'Active',
    'Rejected',
  ];

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController qunatitycontroller = TextEditingController();
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

  String? requesttype;
  void fetcher() async {
    BlocProvider.of<GetViewRequestUnitBloc>(context).add(GetViewRequestUnit(
      unitId: widget.transferedtoId,
    ));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),

      // drawer: theDrawer(),
      appBar: new AppBar(
        title: new Text('Request'),
        // leading: InkWell(onTap: () {}, child: Icon(Icons.menu)),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Text("All"),
                      color: colormix == "all"
                          ? Colors.green.shade500
                          : Colors.black,
                      onPressed: () {
                        setState(() {
                          colormix = "all";
                          allon = true;
                        });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Text("New Purchase"),
                      color: colormix == "New Purchase"
                          ? Colors.green.shade500
                          : Colors.black,
                      onPressed: () {
                        BlocProvider.of<GetViewRequestUnittypeBloc>(context)
                            .add(GetViewRequestUnittype(
                          requestType: "New Purchase",
                        ));
                        setState(() {
                          colormix = "New Purchase";
                          allon = false;
                        });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Text("Transfer"),
                      color: colormix == "Transfer"
                          ? Colors.green.shade500
                          : Colors.black,
                      onPressed: () {
                        BlocProvider.of<GetViewRequestUnittypeBloc>(context)
                            .add(GetViewRequestUnittype(
                          requestType: "transfer ",
                        ));
                        setState(() {
                          colormix = "Transfer";
                          allon = false;
                        });
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Text("Damage"),
                      color: colormix == "Damage"
                          ? Colors.green.shade500
                          : Colors.black,
                      onPressed: () {
                        BlocProvider.of<GetViewRequestUnittypeBloc>(context)
                            .add(GetViewRequestUnittype(
                          requestType: "damage ",
                        ));
                        setState(() {
                          colormix = "Damage";
                          allon = false;
                        });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Text("Repair"),
                      color: colormix == "Repair"
                          ? Colors.green.shade500
                          : Colors.black,
                      onPressed: () {
                        BlocProvider.of<GetViewRequestUnittypeBloc>(context)
                            .add(GetViewRequestUnittype(
                          requestType: "repair ",
                        ));
                        setState(() {
                          colormix = "Repair";
                          allon = false;
                        });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Text("Stock Updation"),
                      color: colormix == "Stock Updation"
                          ? Colors.green.shade500
                          : Colors.black,
                      onPressed: () {
                        BlocProvider.of<GetViewRequestUnittypeBloc>(context)
                            .add(GetViewRequestUnittype(
                          requestType: "stock Updation",
                        ));
                        setState(() {
                          colormix = "Stock Updation";
                          allon = false;
                        });
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Text("Replace"),
                      color: colormix == "Replace"
                          ? Colors.green.shade500
                          : Colors.black,
                      onPressed: () {
                        BlocProvider.of<GetViewRequestUnittypeBloc>(context)
                            .add(GetViewRequestUnittype(
                          requestType: "replace",
                        ));
                        setState(() {
                          colormix = "Replace";
                          allon = false;
                        });
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: DropdownButtonFormField(
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
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue == "Active") {
                      active = true;
                      rejected = false;
                      all = false;
                    } else if (newValue == "Rejected") {
                      active = false;
                      rejected = true;
                      all = false;
                    } else if (newValue == "All") {
                      active = false;
                      rejected = false;
                      all = true;
                    }

                    dropdownvalue = newValue!;
                  });
                },
                dropdownColor: Colors.black,
              ),
            ),
            allon != true
                ? BlocConsumer<GetViewRequestUnittypeBloc,
                        ViewRequestUnittypeState>(
                    builder: (context, state) {
                      if (state is ViewRequestUnittypesuccess) {
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
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount:
                                    state.viewUnitsRequestModel.data.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return

                                      //  all != true
                                      //     ? Container()
                                      //     :

                                      //      state.viewUnitsRequestModel.data[index]
                                      //                 .status ==
                                      //             "rejected"
                                      //         ? SizedBox.fromSize()
                                      //         :

                                      all == true
                                          ? ListTile(
                                              title: InkWell(
                                              child: Column(children: [
                                                InkWell(
                                                  child: Container(
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
                                                              16.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Unit Name:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  state
                                                                      .viewUnitsRequestModel
                                                                      .data[
                                                                          index]
                                                                      .unitId
                                                                      .type,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Assets Name:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  state
                                                                      .viewUnitsRequestModel
                                                                      .data[
                                                                          index]
                                                                      .assetName,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Quantity  :",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  state
                                                                      .viewUnitsRequestModel
                                                                      .data[
                                                                          index]
                                                                      .quantity
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    "Type of Request:",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12)),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  state
                                                                      .viewUnitsRequestModel
                                                                      .data[
                                                                          index]
                                                                      .typeOfRequest,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Requested Status:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  state
                                                                      .viewUnitsRequestModel
                                                                      .data[
                                                                          index]
                                                                      .requestStatus,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Action:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  state
                                                                      .viewUnitsRequestModel
                                                                      .data[
                                                                          index]
                                                                      .status,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "Remark :",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  state
                                                                      .viewUnitsRequestModel
                                                                      .data[
                                                                          index]
                                                                      .remark,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewRequestDetailed(
                                                                  unitId: state
                                                                      .viewUnitsRequestModel
                                                                      .data[
                                                                          index]
                                                                      .id,
                                                                  requestType: state
                                                                      .viewUnitsRequestModel
                                                                      .data[
                                                                          index]
                                                                      .typeOfRequest)),
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
                                            ))
                                          : active == true
                                              ? state
                                                          .viewUnitsRequestModel
                                                          .data[index]
                                                          .assetName ==
                                                      "rejected"
                                                  ? SizedBox.fromSize()
                                                  : ListTile(
                                                      title: InkWell(
                                                      child: Column(children: [
                                                        InkWell(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xfff292929),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  spreadRadius:
                                                                      4,
                                                                  blurRadius: 4,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          "Unit Name:",
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          state
                                                                              .viewUnitsRequestModel
                                                                              .data[index]
                                                                              .unitId
                                                                              .type,
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )
                                                                      ]),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          "Assets Name:",
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          state
                                                                              .viewUnitsRequestModel
                                                                              .data[index]
                                                                              .assetName,
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )
                                                                      ]),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          "Quantity  :",
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          state
                                                                              .viewUnitsRequestModel
                                                                              .data[index]
                                                                              .quantity
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )
                                                                      ]),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                            "Type of Request:",
                                                                            style:
                                                                                TextStyle(fontSize: 12)),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          state
                                                                              .viewUnitsRequestModel
                                                                              .data[index]
                                                                              .typeOfRequest,
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )
                                                                      ]),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          "Requested Status:",
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          state
                                                                              .viewUnitsRequestModel
                                                                              .data[index]
                                                                              .requestStatus,
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )
                                                                      ]),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          "Action:",
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          state
                                                                              .viewUnitsRequestModel
                                                                              .data[index]
                                                                              .status,
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        ),
                                                                      ]),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        const Text(
                                                                          "Remark :",
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          state
                                                                              .viewUnitsRequestModel
                                                                              .data[index]
                                                                              .remark,
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )
                                                                      ]),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => NewRequestDetailed(
                                                                      unitId: state
                                                                          .viewUnitsRequestModel
                                                                          .data[
                                                                              index]
                                                                          .id,
                                                                      requestType: state
                                                                          .viewUnitsRequestModel
                                                                          .data[
                                                                              index]
                                                                          .typeOfRequest)),
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
                                                    ))
                                              : rejected == true
                                                  ? state.viewUnitsRequestModel
                                                              .data[index].status ==
                                                          "active"
                                                      ? SizedBox.fromSize()
                                                      : ListTile(
                                                          title: InkWell(
                                                          child: Column(
                                                              children: [
                                                                InkWell(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xfff292929),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.3),
                                                                          spreadRadius:
                                                                              4,
                                                                          blurRadius:
                                                                              4,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          16.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text(
                                                                                  "Unit Name:",
                                                                                  style: TextStyle(fontSize: 12),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  state.viewUnitsRequestModel.data[index].unitId.type,
                                                                                  style: TextStyle(fontSize: 12),
                                                                                )
                                                                              ]),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text(
                                                                                  "Assets Name:",
                                                                                  style: TextStyle(fontSize: 12),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  state.viewUnitsRequestModel.data[index].assetName,
                                                                                  style: TextStyle(fontSize: 12),
                                                                                )
                                                                              ]),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text(
                                                                                  "Quantity  :",
                                                                                  style: TextStyle(fontSize: 12),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  state.viewUnitsRequestModel.data[index].quantity.toString(),
                                                                                  style: TextStyle(fontSize: 12),
                                                                                )
                                                                              ]),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text("Type of Request:", style: TextStyle(fontSize: 12)),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  state.viewUnitsRequestModel.data[index].typeOfRequest,
                                                                                  style: TextStyle(fontSize: 12),
                                                                                )
                                                                              ]),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text(
                                                                                  "Requested Status:",
                                                                                  style: TextStyle(fontSize: 12),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  state.viewUnitsRequestModel.data[index].requestStatus,
                                                                                  style: TextStyle(fontSize: 12),
                                                                                )
                                                                              ]),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text(
                                                                                  "Action:",
                                                                                  style: TextStyle(fontSize: 12),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  state.viewUnitsRequestModel.data[index].status,
                                                                                  style: TextStyle(fontSize: 12),
                                                                                ),
                                                                              ]),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                const Text(
                                                                                  "Remark :",
                                                                                  style: TextStyle(fontSize: 12),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  state.viewUnitsRequestModel.data[index].remark,
                                                                                  style: TextStyle(fontSize: 12),
                                                                                )
                                                                              ]),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => NewRequestDetailed(
                                                                              unitId: state.viewUnitsRequestModel.data[index].id,
                                                                              requestType: state.viewUnitsRequestModel.data[index].typeOfRequest)),
                                                                    );

                                                                    setState(
                                                                        () {});
                                                                  },
                                                                ),
                                                              ]),
                                                        ))
                                                  : Container();
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                    listener: (context, state) {})
                : BlocConsumer<GetViewRequestUnitBloc, ViewRequestUnitState>(
                    builder: (context, state) {
                    if (state is ViewRequestUnitsuccess) {
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
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                                  state.viewUnitsRequestModel.data.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return

                                    //  all != true
                                    //     ? Container()
                                    //     :

                                    //      state.viewUnitsRequestModel.data[index]
                                    //                 .status ==
                                    //             "rejected"
                                    //         ? SizedBox.fromSize()
                                    //         :

                                    all == true
                                        ? ListTile(
                                            title: InkWell(
                                            child: Column(children: [
                                              InkWell(
                                                child: Container(
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
                                                            16.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Unit Name:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                state
                                                                    .viewUnitsRequestModel
                                                                    .data[index]
                                                                    .unitId
                                                                    .type,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Assets Name:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                state
                                                                    .viewUnitsRequestModel
                                                                    .data[index]
                                                                    .assetName,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Quantity  :",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                state
                                                                    .viewUnitsRequestModel
                                                                    .data[index]
                                                                    .quantity
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                  "Type of Request:",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                state
                                                                    .viewUnitsRequestModel
                                                                    .data[index]
                                                                    .typeOfRequest,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Requested Status:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                state
                                                                    .viewUnitsRequestModel
                                                                    .data[index]
                                                                    .requestStatus,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Action:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                state
                                                                    .viewUnitsRequestModel
                                                                    .data[index]
                                                                    .status,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Remark :",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                state
                                                                    .viewUnitsRequestModel
                                                                    .data[index]
                                                                    .remark,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ]),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NewRequestDetailed(
                                                                unitId: state
                                                                    .viewUnitsRequestModel
                                                                    .data[index]
                                                                    .id,
                                                                requestType: state
                                                                    .viewUnitsRequestModel
                                                                    .data[index]
                                                                    .typeOfRequest)),
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
                                          ))
                                        : active == true
                                            ? state.viewUnitsRequestModel
                                                        .data[index].status ==
                                                    "rejected"
                                                ? SizedBox.fromSize()
                                                : ListTile(
                                                    title: InkWell(
                                                    child: Column(children: [
                                                      InkWell(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xfff292929),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3),
                                                                spreadRadius: 4,
                                                                blurRadius: 4,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const Text(
                                                                        "Unit Name:",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .viewUnitsRequestModel
                                                                            .data[index]
                                                                            .unitId
                                                                            .type,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      )
                                                                    ]),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const Text(
                                                                        "Assets Name:",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .viewUnitsRequestModel
                                                                            .data[index]
                                                                            .assetName,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      )
                                                                    ]),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const Text(
                                                                        "Quantity  :",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .viewUnitsRequestModel
                                                                            .data[index]
                                                                            .quantity
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      )
                                                                    ]),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const Text(
                                                                          "Type of Request:",
                                                                          style:
                                                                              TextStyle(fontSize: 12)),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .viewUnitsRequestModel
                                                                            .data[index]
                                                                            .typeOfRequest,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      )
                                                                    ]),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const Text(
                                                                        "Requested Status:",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .viewUnitsRequestModel
                                                                            .data[index]
                                                                            .requestStatus,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      )
                                                                    ]),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const Text(
                                                                        "Action:",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .viewUnitsRequestModel
                                                                            .data[index]
                                                                            .status,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                    ]),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const Text(
                                                                        "Remark :",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        state
                                                                            .viewUnitsRequestModel
                                                                            .data[index]
                                                                            .remark,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      )
                                                                    ]),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => NewRequestDetailed(
                                                                    unitId: state
                                                                        .viewUnitsRequestModel
                                                                        .data[
                                                                            index]
                                                                        .id,
                                                                    requestType: state
                                                                        .viewUnitsRequestModel
                                                                        .data[
                                                                            index]
                                                                        .typeOfRequest)),
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
                                                  ))
                                            : rejected == true
                                                ? state.viewUnitsRequestModel
                                                            .data[index].status ==
                                                        "active"
                                                    ? SizedBox.fromSize()
                                                    : ListTile(
                                                        title: InkWell(
                                                        child: Column(
                                                            children: [
                                                              InkWell(
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xfff292929),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.3),
                                                                        spreadRadius:
                                                                            4,
                                                                        blurRadius:
                                                                            4,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        16.0),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              const Text(
                                                                                "Unit Name:",
                                                                                style: TextStyle(fontSize: 12),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                state.viewUnitsRequestModel.data[index].unitId.type,
                                                                                style: TextStyle(fontSize: 12),
                                                                              )
                                                                            ]),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
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
                                                                                state.viewUnitsRequestModel.data[index].assetName,
                                                                                style: TextStyle(fontSize: 12),
                                                                              )
                                                                            ]),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              const Text(
                                                                                "Quantity  :",
                                                                                style: TextStyle(fontSize: 12),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                state.viewUnitsRequestModel.data[index].quantity.toString(),
                                                                                style: TextStyle(fontSize: 12),
                                                                              )
                                                                            ]),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              const Text("Type of Request:", style: TextStyle(fontSize: 12)),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                state.viewUnitsRequestModel.data[index].typeOfRequest,
                                                                                style: TextStyle(fontSize: 12),
                                                                              )
                                                                            ]),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              const Text(
                                                                                "Requested Status:",
                                                                                style: TextStyle(fontSize: 12),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                state.viewUnitsRequestModel.data[index].requestStatus,
                                                                                style: TextStyle(fontSize: 12),
                                                                              )
                                                                            ]),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              const Text(
                                                                                "Action:",
                                                                                style: TextStyle(fontSize: 12),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                state.viewUnitsRequestModel.data[index].status,
                                                                                style: TextStyle(fontSize: 12),
                                                                              ),
                                                                            ]),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              const Text(
                                                                                "Remark :",
                                                                                style: TextStyle(fontSize: 12),
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                state.viewUnitsRequestModel.data[index].remark,
                                                                                style: TextStyle(fontSize: 12),
                                                                              )
                                                                            ]),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => NewRequestDetailed(
                                                                            unitId:
                                                                                state.viewUnitsRequestModel.data[index].id,
                                                                            requestType: state.viewUnitsRequestModel.data[index].typeOfRequest)),
                                                                  );

                                                                  setState(
                                                                      () {});
                                                                },
                                                              ),
                                                            ]),
                                                      ))
                                                :Center(
        child: SizedBox(
          height: 28.0,
          width: 28.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2,
          ),
        ),
      );
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }, listener: (context, state) {
                    if (state is Units2Error) {
                      Fluttertoast.showToast(
                          backgroundColor: Colors.white,
                          msg: state.error,
                          textColor: Colors.black);
                    }
                  }),
          ],
        ),
      ),
    );
  }

  Widget theDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: const BoxDecoration(
                color: Color(0xfff68D389),
                // image: const DecorationImage(
                //   image: AssetImage("assets/images/wti_logo.png"),
                //   // fit: BoxFit.cover,
                // ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    SizedBox(
                      width: 120,
                      height: 80,
                      // child: CircleAvatar(
                      //   radius: 50.0,
                      //   backgroundImage: AssetImage(
                      //     "assets/images/wti_logo.png",
                      //   ),
                      //   backgroundColor: Colors.transparent,
                      // ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    // Text(
                    //   "Welcome to",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 18.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Text(
                    //   "Anti Snare Walk",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 20.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              )),
          Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  "Home",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text(
                  "Profile",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IcViewUnits()));
                },
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  "View Units",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              ListTile(
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const SignupSuccess()));
                // },
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  "####",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              ListTile(
                  // onTap: () {
                  //   Navigator.pop(context);
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const Completesnarereport()));
                  // },
                  leading: const Icon(Icons.all_inbox, color: Colors.white),
                  title: const Text(
                    "All Reports",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              /////very very important

              //    ListTile(
              // onTap: () {
              //   Navigator.pop(context);
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>  MyPendingdata()));
              // },
              // leading: const Icon(Icons.all_inbox, color: Colors.blueGrey),
              // title: const Text(
              //   "Local Data",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold, color: Colors.blueGrey),
              // )),
              // ListTile(
              // onTap: () {
              //   Navigator.pop(context);
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               const SnareDetailsOffline()));
              // },
              // leading: const Icon(Icons.data_array, color: Colors.blueGrey),
              // title: const Text("Report a Snare")),
              // ListTile(
              //     onTap: () {
              //       Navigator.pop(context);
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) =>
              //                   const ParticipentsOfflinePage()));
              //     },
              //     leading: const Icon(Icons.data_array, color: Colors.blueGrey),
              //     title: const Text("Pending List")),
              ListTile(
                onTap: () {
                  PrefManager.clearToken();
Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                },
                leading: const Icon(Icons.logout_outlined, color: Colors.white),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
