//////
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/icbloc/damagerequest_blocaccept/damagerequest_blocaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/damagerequest_blocaccept/damagerequest_eventaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/damagerequest_blocaccept/damagerequest_stateaccept.dart';

import 'package:parambikulam/bloc/assets/icbloc/newpurchasedropbloc/newpurchasedropbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/newpurchasedropbloc/newpurchasedropevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/newpurchasedropbloc/newpurchasedropstate.dart';
import 'package:parambikulam/bloc/assets/icbloc/repairrequestacceptbloc/repairrequest_blocaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/repairrequestacceptbloc/repairrequest_eventaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/repairrequestacceptbloc/repairrequest_stateaccept.dart';
import 'package:parambikulam/bloc/assets/new/requestmainviewdetailedbloc/requestmainviewdetailedbloc.dart';
import 'package:parambikulam/bloc/assets/new/requestmainviewdetailedbloc/requestmainviewdetailedevent.dart';
import 'package:parambikulam/bloc/assets/new/requestmainviewdetailedbloc/requestmainviewdetailedstate.dart';
import 'package:parambikulam/bloc/assets/new/trasnferwithrequestbloc/transferwithrequest_blocmain.dart';

import 'package:parambikulam/bloc/assets/new/trasnferwithrequestbloc/transferwithrequest_statemain.dart';
import 'package:parambikulam/data/models/assetsmodel/new/requestmaindetailedmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/requestviewmainmodel.dart';

import 'package:parambikulam/ui/assets/bottomnav.dart';

////New purchase ////Repair ////Damage////
class ViewRequestDamage extends StatefulWidget {
  final String requestId;
  final int index;
  final String typeofrequest;
  final String requestid2;
  final String requesttypeon;
  final ViewRequestMainModel viewRequestMainModel;

  final String unitname;
  const ViewRequestDamage(
      {Key? key,
      required this.requestId,
      required this.index,
      required this.unitname,
      required this.typeofrequest,
      required this.requestid2,
      required this.requesttypeon,
      required this.viewRequestMainModel})
      : super(key: key);

  @override
  State<ViewRequestDamage> createState() => _ViewRequestDamageState();
}

class _ViewRequestDamageState extends State<ViewRequestDamage> {
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  List<RequestModel> requestlist = [];
  List<List<DropdownModel>> dropdownlislist = [[]];
  String dropdownvalue = 'ENGLISH';
  bool isToggled = true;
  bool? value;
  bool? nobutton = false;
  ValueChanged<bool>? onChanged;
  String? chosenType;
  RequestMainDetailedModel? requestMainDetailedModel;
  int? k;
  final TextEditingController requestidcontroller = TextEditingController();
  final TextEditingController itemidcontroller = TextEditingController();
  final TextEditingController dropdownidcontroller = TextEditingController();
  @override
  void initState() {
    fetcher();

    super.initState();
  }

  void fetcher() async {
    BlocProvider.of<GetRequestMainDetailedBloc>(context)
        .add(GetRequestMainDetailed(
      requestId: widget.requestId,
    ));
////wants data
    BlocProvider.of<GetNewPurchasedropBloc>(context)
        .add(FetchNewPurchasedropEvent());

    for (int k = 0;
        k < widget.viewRequestMainModel.data![widget.index].productIds!.length;
        k++) {
      if (widget.viewRequestMainModel.data![widget.index].productIds![k]
                  .requestStatus ==
              'transfered' &&
          widget.viewRequestMainModel.data![widget.index].productIds![k]
                  .typeOfRequest ==
              'New Purchase') {
        widget.viewRequestMainModel.data![widget.index].productIds![k]
            .dropdown = true;
      } else {
        widget.viewRequestMainModel.data![widget.index].productIds![k]
            .dropdown = false;
      }
    }
  }

  //  state.requestMainDetailedModel.data![k].typeOfRequest
  //                               .toString() ==
  //                           "New Purchase" &&
  //                       widget.requesttypeon != 'transfered'
  //                   ? state.requestMainDetailedModel.data![k].dropdown = true
  //                   : state.requestMainDetailedModel.data![k].dropdown = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Request Details'),
        actions: <Widget>[],
      ),
      bottomNavigationBar: BlocConsumer<GetRequestMainDetailedBloc,
              RequestMainDetailedState>(
          listener: ((context, state) {}),
          builder: (context, state) {
            if (state is RequestMainDetailedsuccess) {
              return SizedBox(
                height: 80,
                child: widget.requesttypeon == 'Transfered'
                    ? Container()
                    : nobutton == true
                        ? Container()
                        : state.requestMainDetailedModel.data![0].typeOfRequest
                                    .toString() ==
                                'damage'
                            ? Container()
                            : state.requestMainDetailedModel.data![0]
                                        .typeOfRequest
                                        .toString() ==
                                    'repair'
                                ? Container()
                                : Column(
                                    children: [
                                      MaterialButton(
                                        // child: Text("Transfer"),
                                        height: 40,
                                        minWidth: 300,
                                        color: Colors.green,
                                        onPressed: () {
                                          for (int k = 0;
                                              k <
                                                  widget
                                                      .viewRequestMainModel
                                                      .data![widget.index]
                                                      .productIds!
                                                      .length;
                                              k++) {
                                            if (widget
                                                    .viewRequestMainModel
                                                    .data![widget.index]
                                                    .productIds![k]
                                                    .change ==
                                                true) {
                                              requestlist.add(RequestModel(
                                                  assetId: widget
                                                              .viewRequestMainModel
                                                              .data![
                                                                  widget.index]
                                                              .productIds![k]
                                                              .typeOfRequest
                                                              .toString() ==
                                                          'New Purchase'
                                                      ? dropdownidcontroller
                                                          .text
                                                      : widget
                                                          .viewRequestMainModel
                                                          .data![widget.index]
                                                          .productIds![k]
                                                          .productId,
                                                  quantity: widget
                                                      .viewRequestMainModel
                                                      .data![widget.index]
                                                      .productIds![k]
                                                      .quantity
                                                      .toString(),
                                                  itemid:
                                                      itemidcontroller.text));
                                            }
                                          }

                                          validateData();
                                        },

                                        child: BlocConsumer<
                                                GetTransferwithRequestBloc,
                                                TransferwithRequestState>(
                                            builder: (context, state) {
                                          if (state is TransferwithRequesting) {
                                            return const SizedBox(
                                              height: 18.0,
                                              width: 18.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.black),
                                                strokeWidth: 2,
                                              ),
                                            );
                                          } else {
                                            return const Text(
                                              "Transfer",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                            );
                                          }
                                        }, listener: (context, state) {
                                          if (state
                                              is TransferwithRequestsuccess) {
                                            // groupid = state.snareWalkStartModel.data!.id;

                                            Fluttertoast.showToast(
                                                backgroundColor: Colors.white,
                                                msg: "Transfered sucessfully",
                                                textColor: Colors.black);

                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CustomerBottomNavigation()));
                                          }

                                          if (state
                                              is TransferwithRequestError) {
                                            // groupid = state.snareWalkStartModel.data!.id;

                                            Fluttertoast.showToast(
                                                msg: state.error);

                                            // Navigator.pushReplacement(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) => AssestsHomePage()));
                                          }
                                        }),
                                      ),
                                    ],
                                  ),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(),
          BlocConsumer<GetRequestMainDetailedBloc, RequestMainDetailedState>(
              builder: (context, state) {
            if (state is RequestMainDetailedsuccess) {
              return Column(
                children: [
                  // Text(state.requestMainDetailedModel.request)
                  Text(
                    "",
                    style: TextStyle(color: Colors.white),
                  ),

                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: state.requestMainDetailedModel.data![0]
                                  .typeOfRequest
                                  .toString() ==
                              "stock Updation"
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                  height: 25,
                                  width: 180,
                                  color: Colors.grey.shade700,
                                  child:
                                      Center(child: Text("Stock Updation  "))),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                height: 25,
                                width: 180,
                                color: Colors.grey.shade700,
                                child: Center(
                                  child: Text(widget
                                              .viewRequestMainModel
                                              .data![widget.index]
                                              .productIds![0]
                                              .typeOfRequest
                                              .toString() ==
                                          'repair'
                                      ? "Repair"
                                      : widget
                                                  .viewRequestMainModel
                                                  .data![widget.index]
                                                  .productIds![0]
                                                  .typeOfRequest
                                                  .toString() ==
                                              'damage'
                                          ? "Damage"
                                          : widget
                                                      .viewRequestMainModel
                                                      .data![widget.index]
                                                      .productIds![0]
                                                      .typeOfRequest
                                                      .toString() ==
                                                  'replace'
                                              ? 'Replace'
                                              : widget
                                                  .viewRequestMainModel
                                                  .data![widget.index]
                                                  .productIds![0]
                                                  .typeOfRequest
                                                  .toString()),
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
                          d1.format(DateTime.parse(convert(widget
                                  .viewRequestMainModel.data![0].createDate
                                  .toString()))) +
                              " | " +
                              d2.format(DateTime.parse(convert(widget
                                  .viewRequestMainModel.data![0].createDate
                                  .toString()))),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                  BlocListener<GetNewPurchasedropBloc, NewPurchasedropState>(
                    listener: (context, newState) {
                      if (newState is NewPurchasedropSuccess) {
                        for (var j = 0;
                            j <
                                widget.viewRequestMainModel.data![widget.index]
                                    .productIds!.length;
                            j++) {
                          for (var i = 0;
                              i < newState.newPurchaseDropModel.data!.length;
                              i++) {
                            dropdownlislist[j].add(DropdownModel(
                              name: newState
                                  .newPurchaseDropModel.data![i].assetId!.name
                                  .toString(),
                              id: newState
                                  .newPurchaseDropModel.data![i].assetId!.id,
                              quantity: newState
                                  .newPurchaseDropModel.data![i].quantity
                                  .toString(),
                            ));
                            dropdownlislist.add(dropdownlislist[j]);
                          }
                        }

                        setState(() {});
                      }
                    },
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.viewRequestMainModel
                            .data![widget.index].productIds!.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.09,
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
                                                      child: Column(children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                    " Status"),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: widget
                                                                            .viewRequestMainModel
                                                                            .data![widget
                                                                                .index]
                                                                            .productIds ==
                                                                        null
                                                                    ? Text(widget
                                                                        .viewRequestMainModel
                                                                        .data![widget
                                                                            .index]
                                                                        .productIds![
                                                                            index]
                                                                        .requestStatus
                                                                        .toString())
                                                                    : Text(widget.viewRequestMainModel.data![widget.index].productIds![index].requestStatus ==
                                                                            'accepted'
                                                                        ? 'Accepted'
                                                                        // : state.requestMainDetailedModel.data![index].requestStatus.toString() ==
                                                                        //         'damaged'
                                                                        //     ? 'Damaged'
                                                                        //     :
                                                                        : widget.viewRequestMainModel.data![widget.index].productIds![index].requestStatus ==
                                                                                'transfered'
                                                                            ? 'Transfered'
                                                                            : widget.viewRequestMainModel.data![widget.index].productIds![index].requestStatus == 'pending'
                                                                                ? 'Pending'
                                                                                : widget.viewRequestMainModel.data![widget.index].productIds![index].requestStatus.toString()),
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
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                    " Product"),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: widget
                                                                            .viewRequestMainModel
                                                                            .data![widget
                                                                                .index]
                                                                            .productIds![
                                                                                index]
                                                                            .typeOfRequest !=
                                                                        "stock Updation"
                                                                    ? Text(widget
                                                                        .viewRequestMainModel
                                                                        .data![widget
                                                                            .index]
                                                                        .productIds![
                                                                            index]
                                                                        .name
                                                                        .toString())
                                                                    : Text(widget
                                                                        .viewRequestMainModel
                                                                        .data![widget
                                                                            .index]
                                                                        .productIds![
                                                                            index]
                                                                        .name
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
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                    " Qunatity"),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: Text(widget
                                                                          .viewRequestMainModel
                                                                          .data![widget
                                                                              .index]
                                                                          .productIds![
                                                                              index]
                                                                          .quantity
                                                                          .toString()),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: widget.viewRequestMainModel.data![widget.index].productIds![index].myStock ==
                                                                              null
                                                                          ? Text(
                                                                              "")
                                                                          : Text("(" +
                                                                              widget.viewRequestMainModel.data![widget.index].productIds![index].myStock![0].quantity.toString() +
                                                                              ")"),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ]),

                                                        ///damegemain
                                                        ///
                                                        ///
                                                        state
                                                                    .requestMainDetailedModel
                                                                    .data![
                                                                        index]
                                                                    .requestStatus
                                                                    .toString() ==
                                                                'accepted'
                                                            ? Container()
                                                            : state
                                                                        .requestMainDetailedModel
                                                                        .data![
                                                                            0]
                                                                        .typeOfRequest
                                                                        .toString() ==
                                                                    'repair'
                                                                ? MaterialButton(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(6.0))),
                                                                    color: Colors
                                                                        .green,
                                                                    // child: Text(
                                                                    //     "Accept"),
                                                                    onPressed:
                                                                        () {
                                                                      ////changed to
                                                                      BlocProvider.of<GetRepairRequestAcceptBloc>(context).add(GetRepairRequestAccept(
                                                                          requestId: widget
                                                                              .requestId,
                                                                          assetId: widget
                                                                              .viewRequestMainModel
                                                                              .data![widget.index]
                                                                              .productIds![index]
                                                                              .productId));

                                                                      // acceptrepairedData();
                                                                    },

                                                                    child: BlocConsumer<
                                                                        GetRepairRequestAcceptBloc,
                                                                        RepairRequestAcceptState>(builder: (context, state) {
                                                                      if (state
                                                                          is RepairRequestAccepting) {
                                                                        return const SizedBox(
                                                                          height:
                                                                              18.0,
                                                                          width:
                                                                              18.0,
                                                                          // child:
                                                                          //     CircularProgressIndicator(
                                                                          //   valueColor:
                                                                          //       AlwaysStoppedAnimation<Color>(Colors.black),
                                                                          //   strokeWidth:
                                                                          //       2,
                                                                          // ),
                                                                        );
                                                                      } else {
                                                                        return const Text(
                                                                          "Accept",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12),
                                                                        );
                                                                      }
                                                                    }, listener:
                                                                        (context,
                                                                            state) {
                                                                      if (state
                                                                          is RepairRequestAcceptsuccess) {
                                                                        // groupid = state.snareWalkStartModel.data!.id;

                                                                        Fluttertoast.showToast(
                                                                            backgroundColor: Colors
                                                                                .white,
                                                                            msg:
                                                                                "Request Accepted",
                                                                            textColor:
                                                                                Colors.black);

                                                                        BlocProvider.of<GetRequestMainDetailedBloc>(context)
                                                                            .add(GetRequestMainDetailed(
                                                                          requestId:
                                                                              widget.requestId,
                                                                        ));

                                                                        // Navigator.pushReplacement(
                                                                        //     context,
                                                                        //     MaterialPageRoute(
                                                                        //         builder: (context) => AssestsHomePage()));
                                                                      }
                                                                    }),
                                                                  )
                                                                : Container(),

                                                        ////for damaged
                                                        ///
                                                        ///
                                                        ///
                                                        ///
                                                        ///
                                                        ////
                                                        ///
                                                        ///
                                                        state
                                                                    .requestMainDetailedModel
                                                                    .data![
                                                                        index]
                                                                    .requestStatus
                                                                    .toString() ==
                                                                'damaged'
                                                            ? Container()
                                                            : state
                                                                        .requestMainDetailedModel
                                                                        .data![
                                                                            0]
                                                                        .typeOfRequest
                                                                        .toString() ==
                                                                    'damage'
                                                                ? Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            TextFormField(
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          //noted
                                                                          // controller: billnumbercontroller,
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
                                                                        // child: Text(
                                                                        //     "Accept"),
                                                                        onPressed:
                                                                            () {
                                                                          BlocProvider.of<GetDamageRequestAcceptBloc>(context)
                                                                              .add(GetDamageRequestAccept(
                                                                            requestId:
                                                                                widget.requestId,
                                                                            assetId:
                                                                                state.requestMainDetailedModel.data![index].productId!.id.toString(),
                                                                            remark:
                                                                                "accepting damaged items",
                                                                          ));

                                                                          // acceptrepairedData();
                                                                        },

                                                                        child: BlocConsumer<
                                                                            GetDamageRequestAcceptBloc,
                                                                            DamageRequestAcceptState>(builder: (context, state) {
                                                                          if (state
                                                                              is DamageRequestAccepting) {
                                                                            return const SizedBox(
                                                                              height: 18.0,
                                                                              width: 18.0,
                                                                              // child:
                                                                              //     Text(
                                                                              //   "Accept",
                                                                              //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                                                                              // )
                                                                              child: CircularProgressIndicator(
                                                                                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                                                                strokeWidth: 2,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            return const Text(
                                                                              "Accept",
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                                                                            );
                                                                          }
                                                                        }, listener:
                                                                            (context,
                                                                                state) {
                                                                          if (state
                                                                              is DamageRequestAcceptsuccess) {
                                                                            // groupid = state.snareWalkStartModel.data!.id;

                                                                            Fluttertoast.showToast(
                                                                                backgroundColor: Colors.white,
                                                                                msg: "Request Accepted",
                                                                                textColor: Colors.black);

                                                                            BlocProvider.of<GetRequestMainDetailedBloc>(context).add(GetRequestMainDetailed(
                                                                              requestId: widget.requestId,
                                                                            ));

                                                                            // Navigator.pushReplacement(
                                                                            //     context,
                                                                            //     MaterialPageRoute(
                                                                            //         builder: (context) => AssestsHomePage()));
                                                                          }
                                                                        }),
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
                                                            : state
                                                                        .requestMainDetailedModel
                                                                        .data![
                                                                            index]
                                                                        .dropdown !=
                                                                    true
                                                                ? Container()
                                                                : Container(
                                                                    child: Column(
                                                                        children: [
                                                                          BlocConsumer<
                                                                              GetNewPurchasedropBloc,
                                                                              NewPurchasedropState>(builder: (context, newState) {
                                                                            if (newState
                                                                                is NewPurchasedropSuccess) {
                                                                              return Column(children: [
                                                                                Text("Select Asset"),
                                                                                ButtonTheme(
                                                                                  alignedDropdown: true,
                                                                                  child: DropdownButtonFormField(
                                                                                    icon: Visibility(visible: true, child: Icon(Icons.keyboard_arrow_down)),
                                                                                    value: state.requestMainDetailedModel.data![index].chooseType,
                                                                                    isExpanded: true,
                                                                                    ////important
                                                                                    items: index != 0
                                                                                        ? dropdownlislist[0].map((DropdownModel drop) {
                                                                                            return new DropdownMenuItem<String>(
                                                                                              value: drop.id,
                                                                                              child: new Text(
                                                                                                drop.name.toString(),
                                                                                                style: const TextStyle(color: Colors.white),
                                                                                              ),
                                                                                            );
                                                                                          }).toList()
                                                                                        : dropdownlislist[index].map((DropdownModel drop) {
                                                                                            return new DropdownMenuItem<String>(
                                                                                              value: drop.id,
                                                                                              child: new Text(
                                                                                                drop.name.toString(),
                                                                                                style: const TextStyle(color: Colors.white),
                                                                                              ),
                                                                                            );
                                                                                          }).toList(),
                                                                                    onChanged: (String? value) {
                                                                                      print(value);
                                                                                      setState(() {
                                                                                        dropdownidcontroller.text = value.toString();
                                                                                        requestidcontroller.text = state.requestMainDetailedModel.data![index].requestId.toString();
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Container()
                                                                              ]);
                                                                            }
                                                                            return Center(
                                                                              child: SizedBox(
                                                                                height: 18.0,
                                                                                width: 18.0,
                                                                                child: CircularProgressIndicator(
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                                                  strokeWidth: 2,
                                                                                ),
                                                                              ),
                                                                            );

                                                                            // ////
                                                                          }, listener:
                                                                              (context, newState) {
                                                                            if (newState
                                                                                is NewPurchasedropSuccess) {
                                                                              setState(() {
                                                                                setState(() {
                                                                                  widget.viewRequestMainModel.data![widget.index].productIds![index].dropdown = true;
                                                                                });
                                                                              });
                                                                            }
                                                                          }),
                                                                          SizedBox(
                                                                            height:
                                                                                6,
                                                                          ),
                                                                          widget.viewRequestMainModel.data![widget.index].productIds![index].dropdown2 != true
                                                                              ? Container()
                                                                              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                  InkWell(
                                                                                    child: Icon(Icons.remove),
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        widget.viewRequestMainModel.data![widget.index].productIds![index].count == 0 ? SizedBox() : widget.viewRequestMainModel.data![widget.index].productIds![index].count = widget.viewRequestMainModel.data![widget.index].productIds![index].count! - 1;

                                                                                        widget.viewRequestMainModel.data![widget.index].productIds![index].count! < 1 ? widget.viewRequestMainModel.data![widget.index].productIds![index].change = false : widget.viewRequestMainModel.data![widget.index].productIds![index].change = true;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  widget.viewRequestMainModel.data![widget.index].productIds![index].count! < 0
                                                                                      ? SizedBox()
                                                                                      : Container(
                                                                                          child: Text(
                                                                                            widget.viewRequestMainModel.data![widget.index].productIds![index].count.toString(),
                                                                                            style: TextStyle(fontSize: 16, color: Colors.white),
                                                                                          ),
                                                                                        ),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  InkWell(
                                                                                    child: Icon(Icons.add),
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        widget.viewRequestMainModel.data![widget.index].productIds![index].start = true;

                                                                                        widget.viewRequestMainModel.data![widget.index].productIds![index].count = widget.viewRequestMainModel.data![widget.index].productIds![index].count! + 1;
                                                                                        requestidcontroller.text = widget.viewRequestMainModel.data![widget.index].productIds![index].requestId.toString();
                                                                                        widget.viewRequestMainModel.data![widget.index].productIds![index].change = true;
                                                                                        // requestidcontroller.text = state.requestMainDetailedModel.data![index].requestId.toString();
                                                                                      });
                                                                                    },
                                                                                  )
                                                                                ]),

                                                                          ///imporatant to transfer with check box
                                                                        ]),
                                                                  ),

                                                        widget
                                                                    .viewRequestMainModel
                                                                    .data![widget
                                                                        .index]
                                                                    .productIds![
                                                                        index]
                                                                    .typeOfRequest
                                                                    .toString() ==
                                                                'damage'
                                                            ? Container()
                                                            : widget
                                                                        .viewRequestMainModel
                                                                        .data![widget
                                                                            .index]
                                                                        .productIds![
                                                                            index]
                                                                        .typeOfRequest
                                                                        .toString() ==
                                                                    'repair'
                                                                ? Container()
                                                                : widget
                                                                            .viewRequestMainModel
                                                                            .data![widget
                                                                                .index]
                                                                            .productIds![
                                                                                index]
                                                                            .typeOfRequest
                                                                            .toString() ==
                                                                        'transfered'
                                                                    ? Container()
                                                                    : widget.viewRequestMainModel.data![widget.index].productIds![index].dropdown !=
                                                                            false
                                                                        ? Container()
                                                                        : Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                                InkWell(
                                                                                  child: Icon(
                                                                                    Icons.remove,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      widget.viewRequestMainModel.data![widget.index].productIds![index].count = widget.viewRequestMainModel.data![widget.index].productIds![index].count! - 1;

                                                                                      widget.viewRequestMainModel.data![widget.index].productIds![index].count! < 1 ? widget.viewRequestMainModel.data![widget.index].productIds![index].change = false : widget.viewRequestMainModel.data![widget.index].productIds![index].change = true;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                //////tochange
                                                                                ///
                                                                                ///
                                                                                widget.viewRequestMainModel.data![widget.index].productIds![index].count! < 0
                                                                                    ? Container()
                                                                                    : Container(
                                                                                        child: Text(
                                                                                          widget.viewRequestMainModel.data![widget.index].productIds![index].count.toString(),
                                                                                          style: TextStyle(fontSize: 16, color: Colors.white),
                                                                                        ),
                                                                                      ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                InkWell(
                                                                                  child: Icon(Icons.add),
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      widget.viewRequestMainModel.data![widget.index].productIds![index].start = true;
                                                                                      widget.viewRequestMainModel.data![widget.index].productIds![index].count = widget.viewRequestMainModel.data![widget.index].productIds![index].count! + 1;
                                                                                      requestidcontroller.text = widget.viewRequestMainModel.data![widget.index].productIds![index].requestId.toString();
                                                                                      widget.viewRequestMainModel.data![widget.index].productIds![index].change = true;

                                                                                      ///added additionally
                                                                                      // if (int.parse(state.requestMainDetailedModel.data![index].count.toString()) >
                                                                                      //     int.parse(state.requestMainDetailedModel.data![index].quantity.toString())) {
                                                                                      //   Fluttertoast.showToast(backgroundColor: Colors.white, msg: "Stock quantity is lesser", textColor: Colors.black);
                                                                                      // } else if (state.requestMainDetailedModel.data![index].count! <
                                                                                      //     1) {
                                                                                      //   Fluttertoast.showToast(backgroundColor: Colors.white, msg: "Select Quantity", textColor: Colors.black);
                                                                                      // } else {
                                                                                      //   setState(() {
                                                                                      //     state.requestMainDetailedModel.data![index].color == true ? state.requestMainDetailedModel.data![index].color = false : state.requestMainDetailedModel.data![index].color = true;
                                                                                      //   });
                                                                                      //   setState(() {
                                                                                      //     state.requestMainDetailedModel.data![index].color == false ? requestlist.removeWhere((item) => item.assetId == requestlist[index].assetId) : Container();
                                                                                      //   });

                                                                                      //   requestlist.add(RequestModel(
                                                                                      //     assetId: state.requestMainDetailedModel.data![index].productId!.id.toString(),
                                                                                      //     quantity: state.requestMainDetailedModel.data![index].count.toString(),
                                                                                      //   ));
                                                                                      // }
                                                                                    });
                                                                                  },
                                                                                )
                                                                              ]),
                                                        // state
                                                        //             .requestMainDetailedModel
                                                        //             .data![index]
                                                        //             .dropdown !=
                                                        //         false
                                                        //     ? Container()
                                                        //     : state
                                                        //                 .requestMainDetailedModel
                                                        //                 .data![
                                                        //                     index]
                                                        //                 .start ==
                                                        //             true
                                                        //         ? Row(
                                                        //             mainAxisAlignment:
                                                        //                 MainAxisAlignment
                                                        //                     .end,
                                                        //             children: [
                                                        //               Padding(
                                                        //                 padding:
                                                        //                     const EdgeInsets.all(
                                                        //                         8.0),
                                                        //                 child:
                                                        //                     InkWell(
                                                        //                   child: state.requestMainDetailedModel.data![index].color !=
                                                        //                           true
                                                        //                       ? Icon(
                                                        //                           Icons.check,
                                                        //                           color: Colors.white,
                                                        //                         )
                                                        //                       : CircleAvatar(
                                                        //                           radius: 12,
                                                        //                           backgroundColor: Colors.green,
                                                        //                           child: Icon(
                                                        //                             Icons.check,
                                                        //                             color: Colors.white,
                                                        //                           ),
                                                        //                         ),
                                                        //                   onTap:
                                                        //                       () {
                                                        //                     if (int.parse(state.requestMainDetailedModel.data![index].count.toString()) >
                                                        //                         int.parse(state.requestMainDetailedModel.data![index].quantity.toString())) {
                                                        //                       Fluttertoast.showToast(
                                                        //                           backgroundColor: Colors.white,
                                                        //                           msg: "Stock quantity is lesser",
                                                        //                           textColor: Colors.black);
                                                        //                     } else if (state.requestMainDetailedModel.data![index].count! <
                                                        //                         1) {
                                                        //                       Fluttertoast.showToast(
                                                        //                           backgroundColor: Colors.white,
                                                        //                           msg: "Select Quantity",
                                                        //                           textColor: Colors.black);
                                                        //                     } else {
                                                        //                       setState(() {
                                                        //                         state.requestMainDetailedModel.data![index].color == true ? state.requestMainDetailedModel.data![index].color = false : state.requestMainDetailedModel.data![index].color = true;
                                                        //                       });
                                                        //                       setState(() {
                                                        //                         state.requestMainDetailedModel.data![index].color == false ? requestlist.removeWhere((item) => item.assetId == requestlist[index].assetId) : Container();
                                                        //                       });

                                                        //                       requestlist.add(RequestModel(
                                                        //                         assetId: state.requestMainDetailedModel.data![index].productId!.id.toString(),
                                                        //                         quantity: state.requestMainDetailedModel.data![index].count.toString(),
                                                        //                       ));
                                                        //                     }
                                                        //                   },
                                                        //                 ),
                                                        //               ),
                                                        //             ],
                                                        //           )
                                                        //         : Container(),
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
                  ),
                ],
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
          }, listener: (context, state) {
            if (state is RequestMainDetailedsuccess) {
              for (int k = 0;
                  k < state.requestMainDetailedModel.data!.length;
                  k++) {
                state.requestMainDetailedModel.data![k].typeOfRequest
                                .toString() ==
                            "New Purchase" &&
                        widget.requesttypeon != 'transfered'
                    ? state.requestMainDetailedModel.data![k].dropdown = true
                    : state.requestMainDetailedModel.data![k].dropdown = false;

                state.requestMainDetailedModel.data![k].typeOfRequest
                            .toString() ==
                        "New Purchase"
                    ? itemidcontroller.text =
                        state.requestMainDetailedModel.data![0].id.toString()
                    : itemidcontroller.text = "";

                if (state.requestMainDetailedModel.data![k].requestStatus
                        .toString() ==
                    'transfered') {
                  // state.requestMainDetailedModel.data![k].dropdown = true;

                  nobutton = true;
                } else {
                  nobutton = false;
                }
              }
            }
          }),
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
