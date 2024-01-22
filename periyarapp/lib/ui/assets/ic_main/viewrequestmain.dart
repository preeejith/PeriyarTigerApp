////////Request view to transfer product

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:parambikulam/bloc/assets/new/requestviewmainbloc/requestviewmainbloc.dart';
import 'package:parambikulam/bloc/assets/new/requestviewmainbloc/requestviewmainevent.dart';
import 'package:parambikulam/bloc/assets/new/requestviewmainbloc/requestviewmainstate.dart';
import 'package:parambikulam/ui/assets/ic_main/viewrequestmaindamage.dart';
import 'package:parambikulam/ui/assets/ic_main/viewrequestmaindetailed.dart';
import 'package:parambikulam/ui/assets/ic_main/viewrequestmainstockupdation.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

/////view////////////////main view/////
class ViewRequestMain extends StatefulWidget {
  const ViewRequestMain({Key? key}) : super(key: key);

  @override
  _ViewRequestMain createState() => _ViewRequestMain();
}

class _ViewRequestMain extends State<ViewRequestMain> {
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  String? token;
  bool? mainstatuschange = false;
  bool? buttonall = true;
  String? buttonname;
  bool? all = true;
  bool? stockupdation = false;
  bool? newpurchase = false;
  bool? damage = false;
  bool? repair = false;

  String? unitname;
  @override
  void initState() {
    BlocProvider.of<GetViewRequestMainBloc>(context)
        .add(RefreshViewRequestMainEvent());
    fetcher();

    super.initState();
  }

  final TextEditingController dropdowncontroller = TextEditingController();
  final TextEditingController dropdown2controller = TextEditingController();
  String dropdownvalue = 'All';
  // List of items in our dropdown menu
  var items = [
    'All',
    'Pending',
  ];
//////
  void fetcher() async {
    setState(() {
      dropdowncontroller.text = "all";
    });
    BlocProvider.of<GetViewRequestMainBloc>(context)
        .add(GetofflineRequestMainEvent());
    // BlocProvider.of<GetViewRequestMainBloc>(context)
    //     .add(FetchViewRequestMainEvent(
    //   filters: "",
    // ));
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: AppBar(
        title: const Text("Request View"),
      ),
      body: profileBody(),
    );
  }

/////
  Widget profileBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: InkWell(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 32,
                            width: 70,
                            color: all == true ? Colors.green : Colors.grey,
                            child: const Center(
                              child: Text(
                                "All",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              buttonname = "all";
                              buttonall = true;
                              all = true;
                              stockupdation = false;
                              newpurchase = false;
                              damage = false;
                              repair = false;
                            });

                            // BlocProvider.of<GetViewRequestMainBloc>(context)
                            //     .add(FetchViewRequestMainEvent(
                            //   filters: "",
                            // ));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: InkWell(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 32,
                              width: 70,
                              color:
                                  damage == true ? Colors.green : Colors.grey,
                              child: const Center(
                                child: Text(
                                  "Damage",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                buttonname = "damage";
                                all = false;
                                buttonall = false;
                                stockupdation = false;
                                newpurchase = false;
                                damage = true;
                                repair = false;
                              });
                              // BlocProvider.of<GetViewRequestMainBloc>(context)
                              //     .add(GetViewRequestMainEvent(
                              //   filters: "damage",
                              // ));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: InkWell(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 32,
                            width: 87,
                            color: stockupdation == true
                                ? Colors.green
                                : Colors.grey,
                            child: const Center(
                              child: Text(
                                "Stock Request",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              buttonname = "stock Updation";
                              all = false;
                              buttonall = false;
                              stockupdation = true;
                              newpurchase = false;
                              damage = false;
                              repair = false;
                            });
                            // BlocProvider.of<GetViewRequestMainBloc>(context)
                            //     .add(GetViewRequestMainEvent(
                            //   filters: "stock Updation",
                            // ));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: InkWell(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 32,
                              width: 70,
                              color:
                                  repair == true ? Colors.green : Colors.grey,
                              child: const Center(
                                child: Text(
                                  "Repair",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                buttonname = "repair";
                                all = false;
                                buttonall = false;
                                stockupdation = false;
                                newpurchase = false;
                                damage = false;
                                repair = true;
                              });
                              // BlocProvider.of<GetViewRequestMainBloc>(context)
                              //     .add(GetViewRequestMainEvent(
                              //   filters: "repair",
                              // ));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: InkWell(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 32,
                        width: 80,
                        color: newpurchase == true ? Colors.green : Colors.grey,
                        child: const Center(
                          child: Text(
                            "New Purchase",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          buttonname = "New Purchase";
                          all = false;
                          buttonall = false;
                          stockupdation = false;
                          newpurchase = true;
                          damage = false;
                          repair = false;
                        });
                        // BlocProvider.of<GetViewRequestMainBloc>(context)
                        //     .add(GetViewRequestMainEvent(
                        //   filters: "New Purchase",
                        // ));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Container(
                      child: DropdownButtonFormField(
                        focusColor: Colors.white,
                        decoration: InputDecoration(
                            isDense: true,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none),
                        value: dropdownvalue,
                        dropdownColor: Colors.black,
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
                            dropdownvalue = newValue!;

                            dropdowncontroller.text = newValue == "Pending"
                                ? "pending"
                                : newValue == "All"
                                    ? "all"
                                    : "";
                            dropdown2controller.text =
                                newValue == "All" ? "true" : "false";
                          });
                        },
                        // dropdownColor: Color(0xfff7f7f7),
                      ),
                    ),
                  ),
                ),
                BlocConsumer<GetViewRequestMainBloc, ViewRequestMainState>(
                    builder: (context, state) {
                  if (state is GettingdataSuccess) {
                    return state.items42.length == 0
                        ? Text("No Result Found")
                        : dropdowncontroller.text == "all"
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: state.items42.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return state.items42[index]
                                              ['typeOfRequest'] ==
                                          buttonname
                                      ? SizedBox(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 6,
                                              ),
                                              InkWell(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xfff292929),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
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
                                                            8.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "Unit Name : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              ////retrive
                                                              // state
                                                              //             .items42[
                                                              //                 0]
                                                              //             ['typeOfRequest'][
                                                              //                 index]
                                                              //             .unitId !=
                                                              //         null
                                                              //     ?
                                                              state.items42[index]
                                                                          [
                                                                          'unitName'] ==
                                                                      "qwww"
                                                                  ? Text(
                                                                      state.items42[index]['unitName'] ==
                                                                              ""
                                                                          ? "IC "
                                                                          : state.items42[index]
                                                                              [
                                                                              'unitName'],
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    )
                                                                  : Text(state.items42[
                                                                          index]
                                                                      [
                                                                      'unitName']),
                                                            ],
                                                          ),
                                                          ////
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "Request : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              // Text("Boat Number : "),
                                                              Text(
                                                                state.items42[index]
                                                                            [
                                                                            'typeOfRequest'] ==
                                                                        0
                                                                    ? ""
                                                                    : state.items42[index]['typeOfRequest'] ==
                                                                            'stock Updation'
                                                                        ? "Stock Request"
                                                                        : state.items42[index]
                                                                            [
                                                                            'typeOfRequest'],
                                                                // (state
                                                                //             .viewRequestMainModel
                                                                //             .data[
                                                                //                 index]
                                                                //             .productIds
                                                                //             .length ==
                                                                //         0
                                                                //     ? ""
                                                                //     : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest ==
                                                                //             "stock Updation"
                                                                //         ? "Stock Request"
                                                                //         : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest ==
                                                                //                 "transfer"
                                                                //             ? "Transfer"
                                                                //             : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == "damage"
                                                                //                 ? "Damage"
                                                                //                 : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == "replace"
                                                                //                     ? "Replace"
                                                                //                     : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == 'repair'
                                                                //                         ? "Repair"
                                                                //                         : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "Status : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),

                                                              state.items42[index]
                                                                          [
                                                                          'status'] ==
                                                                      "transfered"
                                                                  ? Text(
                                                                      "Transfered",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    )
                                                                  : state.items42[index]
                                                                              [
                                                                              'status'] ==
                                                                          "pending"
                                                                      ? Text(
                                                                          "Pending",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        )
                                                                      : state.items42[index]['status'] ==
                                                                              'accepted'
                                                                          ? Text(
                                                                              "Accepted",
                                                                              style: TextStyle(
                                                                                color: Colors.green,
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              state.items42[index]['status'],
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),

                                                              // Text(
                                                              //   state
                                                              //               .viewRequestMainModel
                                                              //               .data![
                                                              //                   index]
                                                              //               .mainstatus
                                                              //               .toString() ==
                                                              //           "transfered"
                                                              //       ? "Transfered"
                                                              //       : state.viewRequestMainModel.data![index].mainstatus.toString() ==
                                                              //               "pending"
                                                              //           ? "Pending"
                                                              //           : state.viewRequestMainModel.data![index].mainstatus.toString() ==
                                                              //                   'accepted'
                                                              //               ? "Accepted"
                                                              //               : state.viewRequestMainModel.data![index].mainstatus.toString(),
                                                              //   style:
                                                              //       TextStyle(
                                                              //     color: Colors
                                                              //         .white,
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: const Text(
                                                                      "Date:"),
                                                                ),
                                                                Text(
                                                                  d1.format(DateTime.parse(convert(
                                                                          state.items42[index]
                                                                              [
                                                                              'date']))) +
                                                                      " | " +
                                                                      d2.format(
                                                                          DateTime.parse(convert(state.items42[index]
                                                                              [
                                                                              'date']))),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                )
                                                              ]),
                                                        ]),
                                                  ),
                                                ),
                                                onTap: () {
////////
                                                  ///////////to activate
                                                  state.items42[index][
                                                              'typeOfRequest'] ==
                                                          "stock Updation"
                                                      ? Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                TransferStockUpdation(
                                                              viewassetsModel: state
                                                                  .viewassetsModel,
                                                              assetMasterTable:
                                                                  state
                                                                      .assetMasterTable,
                                                              requestId: state
                                                                          .items42[
                                                                      index]
                                                                  ['requestid'],
                                                              unitid:
                                                                  state.items42[
                                                                          index]
                                                                      [
                                                                      'untiId'],
                                                              unitname:
                                                                  state.items42[
                                                                          index]
                                                                      [
                                                                      'unitName'],
                                                              typeofrequest:
                                                                  state.items42[
                                                                          index]
                                                                      [
                                                                      'unitName'],
                                                              requestid2: state
                                                                          .items42[
                                                                      index]
                                                                  ['requestid'],
                                                              requesttypeon:
                                                                  state.items42[
                                                                          index]
                                                                      [
                                                                      'status'],
                                                              items42:
                                                                  state.items42,
                                                              items43:
                                                                  state.items43,
                                                              index: index,
                                                            ),
                                                          ))
                                                      : state.items42[index][
                                                                  'typeOfRequest'] ==
                                                              "New Purchase"
                                                          ? Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ViewRequestDetaied(
                                                                  unitid: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'untiId'],

                                                                  viewassetsModel:
                                                                      state
                                                                          .viewassetsModel,
                                                                  requestId: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'requestid'],
                                                                  unitname: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'unitName'],
                                                                  typeofrequest:
                                                                      state.items42[
                                                                              index]
                                                                          [
                                                                          'typeOfRequest'],

                                                                  requesttypeon:
                                                                      state.items42[
                                                                              index]
                                                                          [
                                                                          'status'],
                                                                  requestid2: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'requestid'],
                                                                  items42: state
                                                                      .items42,
                                                                  items43: state
                                                                      .items43,

                                                                  ///damage
                                                                  items44: state
                                                                      .items44,
                                                                  items45: state
                                                                      .items45,
                                                                  items46: state
                                                                      .items46,
                                                                  // viewRequestMainModel:
                                                                  //     state
                                                                  //         .viewRequestMainModel,
                                                                  index: index,
                                                                ),
                                                              ),
                                                            )
                                                          ////
                                                          : Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ViewRequestDamage(
                                                                  unitid: state.items42[index]
                                                                              [
                                                                              'untiId'] ==
                                                                          null
                                                                      ? ""
                                                                      : state.items42[
                                                                              index]
                                                                          [
                                                                          'untiId'],
                                                                  requestId: state.items42[index]
                                                                              [
                                                                              'requestid'] ==
                                                                          null
                                                                      ? ""
                                                                      : state.items42[
                                                                              index]
                                                                          [
                                                                          'requestid'],
                                                                  unitname: state.items42[index]
                                                                              [
                                                                              'unitName'] ==
                                                                          null
                                                                      ? ""
                                                                      : state.items42[
                                                                              index]
                                                                          [
                                                                          'unitName'],
                                                                  typeofrequest: state.items42[index]
                                                                              [
                                                                              'typeOfRequest'] ==
                                                                          null
                                                                      ? ""
                                                                      : state.items42[
                                                                              index]
                                                                          [
                                                                          'typeOfRequest'],

                                                                  requesttypeon: state.items42[index]
                                                                              [
                                                                              'status'] ==
                                                                          null
                                                                      ? ""
                                                                      : state.items42[
                                                                              index]
                                                                          [
                                                                          'status'],
                                                                  requestid2: state.items42[index]
                                                                              [
                                                                              'requestid'] ==
                                                                          null
                                                                      ? ""
                                                                      : state.items42[
                                                                              index]
                                                                          [
                                                                          'requestid'],
                                                                  items42: state
                                                                      .items42,
                                                                  items43: state
                                                                      .items43,

                                                                  ///damage
                                                                  items44: state
                                                                      .items44,
                                                                  items45: state
                                                                      .items45,
                                                                  items46: state
                                                                      .items46,

                                                                  index: index,
                                                                ),
                                                              ),
                                                            );

                                                  ///////////to activate
                                                  setState(() {});
                                                },
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              // Divider(
                                              //   color: AppStyles.dividerColor,
                                              //   thickness: 1,
                                              //   height: 14,
                                              // )
                                            ],
                                          ),
                                        )
                                      : buttonall == true
                                          ? SizedBox(
                                              //width: MediaQuery.of(context).size.width,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff292929),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
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
                                                                .all(8.0),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      "Unit Name : ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  state.items42[index]
                                                                              [
                                                                              'untiId'] !=
                                                                          null
                                                                      ? Text(
                                                                          state.items42[index]['unitName'] == ""
                                                                              ? "IC "
                                                                              : state.items42[index]['unitName'],
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        )
                                                                      : Text(
                                                                          "Ic"),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      "Request : ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  // Text("Boat Number : "),
                                                                  Text(
                                                                    // state
                                                                    //             .viewRequestMainModel
                                                                    //             .data![
                                                                    //                 index]
                                                                    //             .productIds!
                                                                    //             .length ==
                                                                    //         0
                                                                    //     ? ""
                                                                    //     :
// state.items42[index]
//                                                                             [
//                                                                             'typeOfRequest'] ==
//                                                                         'stock Updation'
//                                                                     ? "Stock Request"
//                                                                     : state.items42[
//                                                                             index]
//                                                                         [
//                                                                         'typeOfRequest']

                                                                    state.items42[index]['typeOfRequest'] ==
                                                                            'stock Updation'
                                                                        ? "Stock Request"
                                                                        : state.items42[index]
                                                                            [
                                                                            'typeOfRequest'],

                                                                    // (state.viewRequestMainModel.data[index].productIds.length ==
                                                                    //         0
                                                                    //     ? ""
                                                                    //     : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest ==
                                                                    //             "stock Updation"
                                                                    //         ? "Stock Request"
                                                                    //         : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == "transfer"
                                                                    //             ? "Transfer"
                                                                    //             : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == "damage"
                                                                    //                 ? "Damage"
                                                                    //                 : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == "replace"
                                                                    //                     ? "Replace"
                                                                    //                     : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == 'repair'
                                                                    //                         ? "Repair"
                                                                    //                         : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      "Status : ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),

                                                                  state.items42[index]
                                                                              [
                                                                              'status'] ==
                                                                          "transfered"
                                                                      ? Text(
                                                                          "Transfered",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.green,
                                                                          ),
                                                                        )
                                                                      : state.items42[index]['status'] ==
                                                                              "pending"
                                                                          ? Text(
                                                                              "Pending",
                                                                              style: TextStyle(
                                                                                color: Colors.red,
                                                                              ),
                                                                            )
                                                                          : state.items42[index]['status'] == 'accepted'
                                                                              ? Text(
                                                                                  "Accepted",
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  state.items42[index]['status'],
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),

                                                                  // Text(
                                                                  //   state.viewRequestMainModel.data![index].mainstatus.toString() ==
                                                                  //           "transfered"
                                                                  //       ? "Transfered"
                                                                  //       : state.viewRequestMainModel.data![index].mainstatus.toString() ==
                                                                  //               "pending"
                                                                  //           ? "Pending"
                                                                  //           : state.viewRequestMainModel.data![index].mainstatus.toString() == 'accepted'
                                                                  //               ? "Accepted"
                                                                  //               : state.viewRequestMainModel.data![index].mainstatus.toString(),
                                                                  //   style:
                                                                  //       TextStyle(
                                                                  //     color: Colors
                                                                  //         .white,
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child: const Text(
                                                                          "Date:"),
                                                                    ),
                                                                    Text(
                                                                      d1.format(DateTime.parse(convert(state.items42[index]
                                                                              [
                                                                              'date']))) +
                                                                          " | " +
                                                                          d2.format(DateTime.parse(convert(state.items42[index]
                                                                              [
                                                                              'date']))),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13,
                                                                      ),
                                                                    )
                                                                  ]),
                                                            ]),
                                                      ),
                                                    ),
                                                    onTap: () {
////////
                                                      ///////////to activate
                                                      state.items42[index][
                                                                  'typeOfRequest'] ==
                                                              "stock Updation"
                                                          ? Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TransferStockUpdation(
                                                                  viewassetsModel:
                                                                      state
                                                                          .viewassetsModel,
                                                                  assetMasterTable:
                                                                      state
                                                                          .assetMasterTable,
                                                                  requestId: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'requestid'],
                                                                  unitid: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'untiId'],
                                                                  unitname: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'unitName'],
                                                                  typeofrequest:
                                                                      state.items42[
                                                                              index]
                                                                          [
                                                                          'unitName'],
                                                                  requestid2: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'requestid'],
                                                                  requesttypeon:
                                                                      state.items42[
                                                                              index]
                                                                          [
                                                                          'status'],
                                                                  items42: state
                                                                      .items42,
                                                                  items43: state
                                                                      .items43,
                                                                  index: index,
                                                                ),
                                                              ))
                                                          : state.items42[index]
                                                                      [
                                                                      'typeOfRequest'] ==
                                                                  "New Purchase"
                                                              ? Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ViewRequestDetaied(
                                                                      unitid: state
                                                                              .items42[index]
                                                                          [
                                                                          'untiId'],

                                                                      viewassetsModel:
                                                                          state
                                                                              .viewassetsModel,
                                                                      requestId:
                                                                          state.items42[index]
                                                                              [
                                                                              'requestid'],
                                                                      unitname:
                                                                          state.items42[index]
                                                                              [
                                                                              'unitName'],
                                                                      typeofrequest:
                                                                          state.items42[index]
                                                                              [
                                                                              'typeOfRequest'],

                                                                      requesttypeon:
                                                                          state.items42[index]
                                                                              [
                                                                              'status'],
                                                                      requestid2:
                                                                          state.items42[index]
                                                                              [
                                                                              'requestid'],
                                                                      items42: state
                                                                          .items42,
                                                                      items43: state
                                                                          .items43,

                                                                      ///damage
                                                                      items44: state
                                                                          .items44,
                                                                      items45: state
                                                                          .items45,
                                                                      items46: state
                                                                          .items46,
                                                                      // viewRequestMainModel:
                                                                      //     state
                                                                      //         .viewRequestMainModel,
                                                                      index:
                                                                          index,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ViewRequestDamage(
                                                                      unitid: state.items42[index]['untiId'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'untiId'],
                                                                      requestId: state.items42[index]['requestid'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'requestid'],
                                                                      unitname: state.items42[index]['unitName'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'unitName'],
                                                                      typeofrequest: state.items42[index]['typeOfRequest'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'typeOfRequest'],

                                                                      requesttypeon: state.items42[index]['status'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'status'],
                                                                      requestid2: state.items42[index]['requestid'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'requestid'],
                                                                      items42: state
                                                                          .items42,
                                                                      items43: state
                                                                          .items43,

                                                                      ///damage
                                                                      items44: state
                                                                          .items44,
                                                                      items45: state
                                                                          .items45,
                                                                      items46: state
                                                                          .items46,

                                                                      index:
                                                                          index,
                                                                    ),
                                                                  ),
                                                                );

                                                      ///////////to activate
                                                      setState(() {});
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  // Divider(
                                                  //   color: AppStyles.dividerColor,
                                                  //   thickness: 1,
                                                  //   height: 14,
                                                  // )
                                                ],
                                              ),
                                            )
                                          : SizedBox();
                                })
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: state.items42.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return state.items42[index]
                                              ['typeOfRequest'] ==
                                          buttonname
                                      ? state.items42[index]['status'] !=
                                              dropdowncontroller.text
                                          ? SizedBox()
                                          : SizedBox(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xfff292929),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
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
                                                                .all(8.0),
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      "Unit Name : ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  ////retrive
                                                                  // state
                                                                  //             .items42[
                                                                  //                 0]
                                                                  //             ['typeOfRequest'][
                                                                  //                 index]
                                                                  //             .unitId !=
                                                                  //         null
                                                                  //     ?
                                                                  state.items42[index]
                                                                              [
                                                                              'unitName'] ==
                                                                          "qwww"
                                                                      ? Text(
                                                                          state.items42[index]['unitName'] == ""
                                                                              ? "IC "
                                                                              : state.items42[index]['unitName'],
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        )
                                                                      : Text(state
                                                                              .items42[index]
                                                                          [
                                                                          'unitName']),
                                                                ],
                                                              ),
                                                              ////
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      "Request : ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  // Text("Boat Number : "),
                                                                  Text(
                                                                    state.items42[index]['typeOfRequest'] ==
                                                                            0
                                                                        ? ""
                                                                        : state.items42[index]['typeOfRequest'] ==
                                                                                'stock Updation'
                                                                            ? "Stock Request"
                                                                            : state.items42[index]['typeOfRequest'],
                                                                    // (state
                                                                    //             .viewRequestMainModel
                                                                    //             .data[
                                                                    //                 index]
                                                                    //             .productIds
                                                                    //             .length ==
                                                                    //         0
                                                                    //     ? ""
                                                                    //     : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest ==
                                                                    //             "stock Updation"
                                                                    //         ? "Stock Request"
                                                                    //         : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest ==
                                                                    //                 "transfer"
                                                                    //             ? "Transfer"
                                                                    //             : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == "damage"
                                                                    //                 ? "Damage"
                                                                    //                 : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == "replace"
                                                                    //                     ? "Replace"
                                                                    //                     : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == 'repair'
                                                                    //                         ? "Repair"
                                                                    //                         : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            4.0),
                                                                    child: Text(
                                                                      "Status : ",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),

                                                                  state.items42[index]
                                                                              [
                                                                              'status'] ==
                                                                          "transfered"
                                                                      ? Text(
                                                                          "Transfered",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.green,
                                                                          ),
                                                                        )
                                                                      : state.items42[index]['status'] ==
                                                                              "pending"
                                                                          ? Text(
                                                                              "Pending",
                                                                              style: TextStyle(
                                                                                color: Colors.red,
                                                                              ),
                                                                            )
                                                                          : state.items42[index]['status'] == 'accepted'
                                                                              ? Text(
                                                                                  "Accepted",
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  state.items42[index]['status'],
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),

                                                                  // Text(
                                                                  //   state
                                                                  //               .viewRequestMainModel
                                                                  //               .data![
                                                                  //                   index]
                                                                  //               .mainstatus
                                                                  //               .toString() ==
                                                                  //           "transfered"
                                                                  //       ? "Transfered"
                                                                  //       : state.viewRequestMainModel.data![index].mainstatus.toString() ==
                                                                  //               "pending"
                                                                  //           ? "Pending"
                                                                  //           : state.viewRequestMainModel.data![index].mainstatus.toString() ==
                                                                  //                   'accepted'
                                                                  //               ? "Accepted"
                                                                  //               : state.viewRequestMainModel.data![index].mainstatus.toString(),
                                                                  //   style:
                                                                  //       TextStyle(
                                                                  //     color: Colors
                                                                  //         .white,
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child: const Text(
                                                                          "Date:"),
                                                                    ),
                                                                    Text(
                                                                      d1.format(DateTime.parse(convert(state.items42[index]
                                                                              [
                                                                              'date']))) +
                                                                          " | " +
                                                                          d2.format(DateTime.parse(convert(state.items42[index]
                                                                              [
                                                                              'date']))),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13,
                                                                      ),
                                                                    )
                                                                  ]),
                                                            ]),
                                                      ),
                                                    ),
                                                    onTap: () {
////////
                                                      ///////////to activate
                                                      state.items42[index][
                                                                  'typeOfRequest'] ==
                                                              "stock Updation"
                                                          ? Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        TransferStockUpdation(
                                                                  viewassetsModel:
                                                                      state
                                                                          .viewassetsModel,
                                                                  assetMasterTable:
                                                                      state
                                                                          .assetMasterTable,
                                                                  requestId: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'requestid'],
                                                                  unitid: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'untiId'],
                                                                  unitname: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'unitName'],
                                                                  typeofrequest:
                                                                      state.items42[
                                                                              index]
                                                                          [
                                                                          'unitName'],
                                                                  requestid2: state
                                                                              .items42[
                                                                          index]
                                                                      [
                                                                      'requestid'],
                                                                  requesttypeon:
                                                                      state.items42[
                                                                              index]
                                                                          [
                                                                          'status'],
                                                                  items42: state
                                                                      .items42,
                                                                  items43: state
                                                                      .items43,
                                                                  index: index,
                                                                ),
                                                              ))
                                                          : state.items42[index]
                                                                      [
                                                                      'typeOfRequest'] ==
                                                                  "New Purchase"
                                                              ? Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ViewRequestDetaied(
                                                                      unitid: state
                                                                              .items42[index]
                                                                          [
                                                                          'untiId'],

                                                                      viewassetsModel:
                                                                          state
                                                                              .viewassetsModel,
                                                                      requestId:
                                                                          state.items42[index]
                                                                              [
                                                                              'requestid'],
                                                                      unitname:
                                                                          state.items42[index]
                                                                              [
                                                                              'unitName'],
                                                                      typeofrequest:
                                                                          state.items42[index]
                                                                              [
                                                                              'typeOfRequest'],

                                                                      requesttypeon:
                                                                          state.items42[index]
                                                                              [
                                                                              'status'],
                                                                      requestid2:
                                                                          state.items42[index]
                                                                              [
                                                                              'requestid'],
                                                                      items42: state
                                                                          .items42,
                                                                      items43: state
                                                                          .items43,

                                                                      ///damage
                                                                      items44: state
                                                                          .items44,
                                                                      items45: state
                                                                          .items45,
                                                                      items46: state
                                                                          .items46,
                                                                      // viewRequestMainModel:
                                                                      //     state
                                                                      //         .viewRequestMainModel,
                                                                      index:
                                                                          index,
                                                                    ),
                                                                  ),
                                                                )
                                                              ////
                                                              : Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ViewRequestDamage(
                                                                      unitid: state.items42[index]['untiId'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'untiId'],
                                                                      requestId: state.items42[index]['requestid'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'requestid'],
                                                                      unitname: state.items42[index]['unitName'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'unitName'],
                                                                      typeofrequest: state.items42[index]['typeOfRequest'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'typeOfRequest'],

                                                                      requesttypeon: state.items42[index]['status'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'status'],
                                                                      requestid2: state.items42[index]['requestid'] ==
                                                                              null
                                                                          ? ""
                                                                          : state.items42[index]
                                                                              [
                                                                              'requestid'],
                                                                      items42: state
                                                                          .items42,
                                                                      items43: state
                                                                          .items43,

                                                                      ///damage
                                                                      items44: state
                                                                          .items44,
                                                                      items45: state
                                                                          .items45,
                                                                      items46: state
                                                                          .items46,

                                                                      index:
                                                                          index,
                                                                    ),
                                                                  ),
                                                                );

                                                      ///////////to activate
                                                      setState(() {});
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  // Divider(
                                                  //   color: AppStyles.dividerColor,
                                                  //   thickness: 1,
                                                  //   height: 14,
                                                  // )
                                                ],
                                              ),
                                            )
                                      : buttonall == true
                                          ? state.items42[index]['status'] !=
                                                  dropdowncontroller.text
                                              ? SizedBox()
                                              : SizedBox(
                                                  //width: MediaQuery.of(context).size.width,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xfff292929),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2),
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
                                                                    .all(8.0),
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Text(
                                                                          "Unit Name : ",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      state.items42[index]['untiId'] !=
                                                                              null
                                                                          ? Text(
                                                                              state.items42[index]['unitName'] == "" ? "IC " : state.items42[index]['unitName'],
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                              ),
                                                                            )
                                                                          : Text(
                                                                              "Ic"),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Text(
                                                                          "Request : ",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                      // Text("Boat Number : "),
                                                                      Text(
                                                                        // state
                                                                        //             .viewRequestMainModel
                                                                        //             .data![
                                                                        //                 index]
                                                                        //             .productIds!
                                                                        //             .length ==
                                                                        //         0
                                                                        //     ? ""
                                                                        //     :
// state.items42[index]
//                                                                             [
//                                                                             'typeOfRequest'] ==
//                                                                         'stock Updation'
//                                                                     ? "Stock Request"
//                                                                     : state.items42[
//                                                                             index]
//                                                                         [
//                                                                         'typeOfRequest']

                                                                        state.items42[index]['typeOfRequest'] ==
                                                                                'stock Updation'
                                                                            ? "Stock Request"
                                                                            : state.items42[index]['typeOfRequest'],

                                                                        // (state.viewRequestMainModel.data[index].productIds.length ==
                                                                        //         0
                                                                        //     ? ""
                                                                        //     : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest ==
                                                                        //             "stock Updation"
                                                                        //         ? "Stock Request"
                                                                        //         : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == "transfer"
                                                                        //             ? "Transfer"
                                                                        //             : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == "damage"
                                                                        //                 ? "Damage"
                                                                        //                 : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == "replace"
                                                                        //                     ? "Replace"
                                                                        //                     : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest == 'repair'
                                                                        //                         ? "Repair"
                                                                        //                         : state.viewRequestMainModel.data[index].productIds[0].typeOfRequest),
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(4.0),
                                                                        child:
                                                                            Text(
                                                                          "Status : ",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),

                                                                      state.items42[index]['status'] ==
                                                                              "transfered"
                                                                          ? Text(
                                                                              "Transfered",
                                                                              style: TextStyle(
                                                                                color: Colors.green,
                                                                              ),
                                                                            )
                                                                          : state.items42[index]['status'] == "pending"
                                                                              ? Text(
                                                                                  "Pending",
                                                                                  style: TextStyle(
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                )
                                                                              : state.items42[index]['status'] == 'accepted'
                                                                                  ? Text(
                                                                                      "Accepted",
                                                                                      style: TextStyle(
                                                                                        color: Colors.green,
                                                                                      ),
                                                                                    )
                                                                                  : Text(
                                                                                      state.items42[index]['status'],
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    ),

                                                                      // Text(
                                                                      //   state.viewRequestMainModel.data![index].mainstatus.toString() ==
                                                                      //           "transfered"
                                                                      //       ? "Transfered"
                                                                      //       : state.viewRequestMainModel.data![index].mainstatus.toString() ==
                                                                      //               "pending"
                                                                      //           ? "Pending"
                                                                      //           : state.viewRequestMainModel.data![index].mainstatus.toString() == 'accepted'
                                                                      //               ? "Accepted"
                                                                      //               : state.viewRequestMainModel.data![index].mainstatus.toString(),
                                                                      //   style:
                                                                      //       TextStyle(
                                                                      //     color: Colors
                                                                      //         .white,
                                                                      //   ),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              const Text("Date:"),
                                                                        ),
                                                                        Text(
                                                                          d1.format(DateTime.parse(convert(state.items42[index]['date']))) +
                                                                              " | " +
                                                                              d2.format(DateTime.parse(convert(state.items42[index]['date']))),
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                13,
                                                                          ),
                                                                        )
                                                                      ]),
                                                                ]),
                                                          ),
                                                        ),
                                                        onTap: () {
////////
                                                          ///////////to activate
                                                          state.items42[index][
                                                                      'typeOfRequest'] ==
                                                                  "stock Updation"
                                                              ? Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            TransferStockUpdation(
                                                                      viewassetsModel:
                                                                          state
                                                                              .viewassetsModel,
                                                                      assetMasterTable:
                                                                          state
                                                                              .assetMasterTable,
                                                                      requestId:
                                                                          state.items42[index]
                                                                              [
                                                                              'requestid'],
                                                                      unitid: state
                                                                              .items42[index]
                                                                          [
                                                                          'untiId'],
                                                                      unitname:
                                                                          state.items42[index]
                                                                              [
                                                                              'unitName'],
                                                                      typeofrequest:
                                                                          state.items42[index]
                                                                              [
                                                                              'unitName'],
                                                                      requestid2:
                                                                          state.items42[index]
                                                                              [
                                                                              'requestid'],
                                                                      requesttypeon:
                                                                          state.items42[index]
                                                                              [
                                                                              'status'],
                                                                      items42: state
                                                                          .items42,
                                                                      items43: state
                                                                          .items43,
                                                                      index:
                                                                          index,
                                                                    ),
                                                                  ))
                                                              : state.items42[index]
                                                                          [
                                                                          'typeOfRequest'] ==
                                                                      "New Purchase"
                                                                  ? Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ViewRequestDetaied(
                                                                          unitid:
                                                                              state.items42[index]['untiId'],

                                                                          viewassetsModel:
                                                                              state.viewassetsModel,
                                                                          requestId:
                                                                              state.items42[index]['requestid'],
                                                                          unitname:
                                                                              state.items42[index]['unitName'],
                                                                          typeofrequest:
                                                                              state.items42[index]['typeOfRequest'],

                                                                          requesttypeon:
                                                                              state.items42[index]['status'],
                                                                          requestid2:
                                                                              state.items42[index]['requestid'],
                                                                          items42:
                                                                              state.items42,
                                                                          items43:
                                                                              state.items43,

                                                                          ///damage
                                                                          items44:
                                                                              state.items44,
                                                                          items45:
                                                                              state.items45,
                                                                          items46:
                                                                              state.items46,
                                                                          // viewRequestMainModel:
                                                                          //     state
                                                                          //         .viewRequestMainModel,
                                                                          index:
                                                                              index,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Navigator
                                                                      .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                ViewRequestDamage(
                                                                          unitid: state.items42[index]['untiId'] == null
                                                                              ? ""
                                                                              : state.items42[index]['untiId'],
                                                                          requestId: state.items42[index]['requestid'] == null
                                                                              ? ""
                                                                              : state.items42[index]['requestid'],
                                                                          unitname: state.items42[index]['unitName'] == null
                                                                              ? ""
                                                                              : state.items42[index]['unitName'],
                                                                          typeofrequest: state.items42[index]['typeOfRequest'] == null
                                                                              ? ""
                                                                              : state.items42[index]['typeOfRequest'],

                                                                          requesttypeon: state.items42[index]['status'] == null
                                                                              ? ""
                                                                              : state.items42[index]['status'],
                                                                          requestid2: state.items42[index]['requestid'] == null
                                                                              ? ""
                                                                              : state.items42[index]['requestid'],
                                                                          items42:
                                                                              state.items42,
                                                                          items43:
                                                                              state.items43,

                                                                          ///damage
                                                                          items44:
                                                                              state.items44,
                                                                          items45:
                                                                              state.items45,
                                                                          items46:
                                                                              state.items46,

                                                                          index:
                                                                              index,
                                                                        ),
                                                                      ),
                                                                    );

                                                          ///////////to activate
                                                          setState(() {});
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      // Divider(
                                                      //   color: AppStyles.dividerColor,
                                                      //   thickness: 1,
                                                      //   height: 14,
                                                      // )
                                                    ],
                                                  ),
                                                )
                                          : SizedBox();
                                });
                  } else {
                    return Center(
                      child: SizedBox(
                        height: 28.0,
                        width: 28.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                }, listener: (context, state) async {
                  if (state is ViewRequestMainSuccess) {
                    //////to get the stock updation main status
                    List items41 = await getAllstockquantitycountdata();

                    if (items41.isNotEmpty) {
                      for (int l = 0;
                          l < state.viewRequestMainModel.data!.length;
                          l++) {
                        for (int n = 0;
                            n <
                                state.viewRequestMainModel.data![l].productIds!
                                    .length;
                            n++) {
                          if (state.viewRequestMainModel.data![l].productIds![n]
                                  .typeOfRequest ==
                              "stock Updation") {
                            for (int m = 0; m < items41.length; m++) {
                              if (items41[m]['assetid'].toString() ==
                                  state.viewRequestMainModel.data![l]
                                      .productIds![n].myStock![0].assetId!.id
                                      .toString()) {
                                setState(() {
                                  state
                                      .viewRequestMainModel
                                      .data![l]
                                      .productIds![n]
                                      .requestStatus = 'transfered';
                                });
                              }
                            }
                          }
                        }
                      }
                    }

                    //////to get the stock updation main status end
                    ///

                    // print(items41);
///////////////////////////////////no for new stockupdation start/////////////
                    if (items41.isNotEmpty) {
                      for (int k = 0;
                          k < state.viewRequestMainModel.data!.length;
                          k++) {
                        for (int g = 0;
                            g <
                                state.viewRequestMainModel.data![k].productIds!
                                    .length;
                            g++) {
                          if (state.viewRequestMainModel.data![k].productIds![g]
                                  .typeOfRequest ==
                              'New Purchase') {
                            for (int m = 0; m < items41.length; m++) {
                              if (items41[m]['requestid'].toString() ==
                                  state.viewRequestMainModel.data![k].id
                                      .toString()) {
                                setState(() {
                                  // quantitycount2 = (int.parse(widget.viewRequestMainModel
                                  //         .data![widget.index].productIds![n].myStock![0].quantity
                                  //         .toString()) -
                                  //     int.parse(items41[m]['quantity'].toString()));

                                  state
                                      .viewRequestMainModel
                                      .data![k]
                                      .productIds![g]
                                      .requestStatus = 'transfered';

                                  // widget.viewRequestMainModel.data![widget.index].productIds![n]
                                  //     .requestStatus = 'transfered';
                                });

                                // print(quantitycount2);
                              }
                            }
                          }
                        }
                      }
                    }

                    ////////////////////////for damage ////////////////////
                    ///mainsttatus
                    ///
                    ///

                    if (items41.isNotEmpty) {
                      for (int t = 0;
                          t < state.viewRequestMainModel.data!.length;
                          t++) {
                        for (int h = 0;
                            h <
                                state.viewRequestMainModel.data![t].productIds!
                                    .length;
                            h++) {
                          if (state.viewRequestMainModel.data![t].productIds![h]
                                  .typeOfRequest ==
                              'damage') {
                            for (int m = 0; m < items41.length; m++) {
                              if (items41[m]['requestid'].toString() ==
                                  state.viewRequestMainModel.data![t].id
                                      .toString()) {
                                setState(() {
                                  state
                                      .viewRequestMainModel
                                      .data![t]
                                      .productIds![h]
                                      .requestStatus = 'accepted';
                                  // damageonaccept = true;
                                });

                                // print(quantitycount2);
                              }
                            }
                          }
                        }
                      }
                    }
                    ////////////////////////for damage end ////////////////////
                    ///mainsttatus end
                    ///
                    ///
                    ///////////////////////////////////no for new stockupdation end/////////////
                    for (int i = 0;
                        i < state.viewRequestMainModel.data!.length;
                        i++) {
                      mainstatuschange = false;

                      for (int j = 0;
                          j <
                              state.viewRequestMainModel.data![i].productIds!
                                  .length;
                          j++) {
                        if (state.viewRequestMainModel.data![i].productIds![j]
                                    .typeOfRequest ==
                                "stock Updation" ||
                            state.viewRequestMainModel.data![i].productIds![j]
                                    .typeOfRequest ==
                                "New Purchase") {
                          if (state.viewRequestMainModel.data![i].productIds![j]
                                  .requestStatus !=
                              'transfered') {
                            setState(() {
                              mainstatuschange = true;
                            });
                          }

                          setState(() {
                            mainstatuschange != true
                                ? state.viewRequestMainModel.data![i]
                                    .mainstatus = "transfered"
                                : SizedBox();
                          });
                        }
                      }
                    }

                    ////////////////for damage
                    for (int i = 0;
                        i < state.viewRequestMainModel.data!.length;
                        i++) {
                      mainstatuschange = false;

                      for (int j = 0;
                          j <
                              state.viewRequestMainModel.data![i].productIds!
                                  .length;
                          j++) {
                        if (state.viewRequestMainModel.data![i].productIds![j]
                                .typeOfRequest ==
                            "damage") {
                          if (state.viewRequestMainModel.data![i].productIds![j]
                                  .requestStatus !=
                              'accepted') {
                            setState(() {
                              mainstatuschange = true;
                            });
                          }

                          setState(() {
                            mainstatuschange != true
                                ? state.viewRequestMainModel.data![i]
                                    .mainstatus = "damaged"
                                : "";
                          });
                        }
                      }
                    }
                  }
                }),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
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
}
