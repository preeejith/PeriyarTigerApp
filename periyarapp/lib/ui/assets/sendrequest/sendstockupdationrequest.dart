//////add to list example
// new changes/////
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/requestupdationbloc/requestupdationbloc.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/requestupdationbloc/requestupdationevent.dart';

import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsbloc.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsstate.dart';
import 'package:parambikulam/ui/assets/bottombarunits.dart';
import 'package:parambikulam/ui/assets/bottomnavechoshop.dart';

import '../../../bloc/assets/viewallassets/viewallassetsevent.dart';

//////////important////////////////
class StockUpdationRequest extends StatefulWidget {
  final String requesttype;
  final String title;
  final String homenav;
  const StockUpdationRequest(
      {Key? key,
      required this.requesttype,
      required this.title,
      required this.homenav})
      : super(key: key);

  @override
  State<StockUpdationRequest> createState() => _StockUpdationRequestState();
}

class _StockUpdationRequestState extends State<StockUpdationRequest> {
  String? count = "no";

  int counter = 0;
  bool? addon = false;
  final TextEditingController assetnamecontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();
  final TextEditingController remarkfinalcontroller = TextEditingController();
  final TextEditingController typecontroller = TextEditingController();
  final TextEditingController assetsidcontroller = TextEditingController();
  final TextEditingController typeofrequestcontroller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetViewallAssetsBloc>(context)
        .add(RefreshViewallAssetsEvent());
    fetcher();
    super.initState();
  }

  void fetcher() async {
    // token = await PrefManager.getToken();
    BlocProvider.of<GetViewallAssetsBloc>(context).add(FetchAssetsdataEvent());
    setState(() {
      typecontroller.text = 'asset';
      typeofrequestcontroller.text = widget.requesttype.toString();
    });
  }

  List<Assetrequest2Model> assetrequestcartlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: []),
      bottomNavigationBar:
          BlocConsumer<GetViewallAssetsBloc, ViewallAssetsState>(
              listener: ((context, state) {}),
              builder: (context, state) {
                if (state is FetchAssetsSuccess) {
                  return state.viewassetsModel.length == 0
                      ? SizedBox()
                      : addon != true
                          ? SizedBox()
                          : SizedBox(
                              height: 80,
                              child: Column(
                                children: [
                                  MaterialButton(
                                    child: Text(
                                      "SUBMIT",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                    height: 40,
                                    minWidth: 300,
                                    color: Colors.green,
                                    onPressed: () {
                                      for (int k = 0;
                                          k < state.viewassetsModel.length;
                                          k++) {
                                        if (state.viewassetsModel[k].change ==
                                            true) {
                                          assetrequestcartlist
                                              .add(Assetrequest2Model(
                                            productid: state
                                                .viewassetsModel[k].assetid,
                                            assetname:
                                                state.viewassetsModel[k].name,
                                            productquantity: state
                                                .viewassetsModel[k].quantity
                                                .toString(),
                                            type: typecontroller.text,
                                            quantity: state
                                                .viewassetsModel[k].count
                                                .toString(),
                                            typeofrequest:
                                                typeofrequestcontroller.text,
                                            remark: remarkfinalcontroller.text
                                                .toString(),
                                          ));
                                        }
                                      }
                                      validateData();
                                    },

                                    // child: BlocConsumer<GetRequestUpdationBloc,
                                    //     RequestUpdationState>(builder: (context, state) {
                                    //   if (state is RequestUpdationing) {
                                    //     return const SizedBox(
                                    //       height: 18.0,
                                    //       width: 18.0,
                                    //       child: CircularProgressIndicator(
                                    //         valueColor:
                                    //             AlwaysStoppedAnimation<Color>(Colors.black),
                                    //         strokeWidth: 2,
                                    //       ),
                                    //     );
                                    //   } else {
                                    //     return const Text(
                                    //       "SUBMIT",
                                    //       style: TextStyle(
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.w600,
                                    //           fontSize: 12),
                                    //     );
                                    //   }
                                    // }, listener: (context, state) {
                                    //   if (state is RequestUpdationsuccess) {
                                    //     // groupid = state.snareWalkStartModel.data!.id;

                                    //     Fluttertoast.showToast(
                                    //         backgroundColor: Colors.white,
                                    //         msg: "Request  Sent",
                                    //         textColor: Colors.black);
                                    //     if (widget.homenav == 'echoshop') {
                                    //       Navigator.pushReplacement(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) =>
                                    //                   EchoShopBottomNavigation()));
                                    //     } else if (widget.homenav == 'productionunit') {
                                    //       Navigator.pushReplacement(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) =>
                                    //                   UnitsAssetsBottomNavigation()));
                                    //     } else {
                                    //       Navigator.pushReplacement(
                                    //           context,
                                    //           MaterialPageRoute(
                                    //               builder: (context) =>
                                    //                   EchoShopBottomNavigation()));
                                    //     }
                                    //   }
                                    // }),
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
          Container(
            color: Colors.green,
          ),
          BlocConsumer<GetViewallAssetsBloc, ViewallAssetsState>(
              builder: (context, state) {
                if (state is FetchAssetsSuccess) {
                  return state.viewassetsModel.length == 0
                      ? Center(child: Text("No Stock Available"))
                      : Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),

                              SizedBox(
                                height: 15,
                              ),

                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: state.viewassetsModel.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                          title: InkWell(
                                        child: Column(children: [
                                          InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 4,
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
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
                                                                        .assetMasterTable[
                                                                            index]
                                                                        .name
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  )
                                                                ]),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            state
                                                                        .assetMasterTable[
                                                                            index]
                                                                        .description
                                                                        .toString() ==
                                                                    ""
                                                                ? SizedBox()
                                                                : Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                        const Text(
                                                                            "Description:",
                                                                            style:
                                                                                TextStyle(fontSize: 12)),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          state
                                                                              .assetMasterTable[index]
                                                                              .description
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )
                                                                      ]),
                                                            state.assetMasterTable[index]
                                                                        .description
                                                                        .toString() ==
                                                                    ""
                                                                ? SizedBox()
                                                                : const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                            Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  const Text(
                                                                    "Quantity:",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    state
                                                                        .viewassetsModel[
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
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(30.0),
                                                        child: SizedBox(
                                                          height: 30,
                                                          width: 70,
                                                          child: state
                                                                      .viewassetsModel[
                                                                          index]
                                                                      .change ==
                                                                  false
                                                              ? MaterialButton(
                                                                  child: Text(
                                                                      "Add"),
                                                                  color: Colors
                                                                      .grey,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      addon =
                                                                          true;
                                                                      state
                                                                          .viewassetsModel[
                                                                              index]
                                                                          .change = true;
                                                                      state
                                                                          .viewassetsModel[
                                                                              index]
                                                                          .count = (state
                                                                              .viewassetsModel[index]
                                                                              .count! +
                                                                          1);
                                                                    });
                                                                  })
                                                              : Row(children: [
                                                                  InkWell(
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                    ),
                                                                    onTap: () {
                                                                      // _decrementCount;
                                                                      quantitycontroller.text = state
                                                                          .viewassetsModel[
                                                                              index]
                                                                          .count
                                                                          .toString();
                                                                      setState(
                                                                          () {
                                                                        state
                                                                            .viewassetsModel[
                                                                                index]
                                                                            .count = state
                                                                                .viewassetsModel[index].count! -
                                                                            1;

                                                                        state.viewassetsModel[index].count! <
                                                                                1
                                                                            ? state.viewassetsModel[index].change =
                                                                                false
                                                                            : state.viewassetsModel[index].change =
                                                                                true;
                                                                      });
                                                                    },
                                                                  ),

                                                                  state.viewassetsModel[index].count! <
                                                                          0
                                                                      ? Container()
                                                                      : Text(state
                                                                          .viewassetsModel[
                                                                              index]
                                                                          .count
                                                                          .toString()),
                                                                  // Text(state),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  InkWell(
                                                                    child: Icon(
                                                                        Icons
                                                                            .add),
                                                                    onTap: () {
                                                                      if (widget
                                                                              .requesttype ==
                                                                          'damage') {
                                                                        (int.parse(state.viewassetsModel[index].count.toString())) >=
                                                                                (int.parse(state.viewassetsModel[index].quantity.toString()))
                                                                            ? Fluttertoast.showToast(backgroundColor: Colors.white, msg: "Enter quantity as in your stock", textColor: Colors.black)
                                                                            : setState(() {
                                                                                state.viewassetsModel[index].count = state.viewassetsModel[index].count! + 1;

                                                                                quantitycontroller.text = state.viewassetsModel[index].count.toString();

                                                                                assetsidcontroller.text = state.viewassetsModel[index].assetid.toString();
                                                                              });
                                                                      } else if (widget
                                                                              .requesttype ==
                                                                          'repair') {
                                                                        (int.parse(state.viewassetsModel[index].count.toString())) >=
                                                                                (int.parse(state.viewassetsModel[index].quantity.toString()))
                                                                            ? Fluttertoast.showToast(backgroundColor: Colors.white, msg: "Enter quantity as in your stock", textColor: Colors.black)
                                                                            : setState(() {
                                                                                state.viewassetsModel[index].count = state.viewassetsModel[index].count! + 1;

                                                                                quantitycontroller.text = state.viewassetsModel[index].count.toString();

                                                                                assetsidcontroller.text = state.viewassetsModel[index].assetid.toString();
                                                                              });
                                                                      } else {
                                                                        setState(
                                                                            () {
                                                                          state.viewassetsModel[index].count =
                                                                              state.viewassetsModel[index].count! + 1;

                                                                          quantitycontroller.text = state
                                                                              .viewassetsModel[index]
                                                                              .count
                                                                              .toString();

                                                                          assetsidcontroller.text = state
                                                                              .viewassetsModel[index]
                                                                              .assetid
                                                                              .toString();
                                                                        });
                                                                      }

//
                                                                    },
                                                                  ),
                                                                ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              // setState(() {});
                                            },
                                          ),
                                        ]),
                                      )),
                                    ],
                                  );
                                },
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  //noted
                                  controller: remarkfinalcontroller,
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Remark',
                                  ),
                                ),
                              ),

                              ////ppng
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
              },
              listener: (context, state) {}),
        ]),
      ),
    );
  }

////
  void validateData() {
    if (assetrequestcartlist.isEmpty) {
      Fluttertoast.showToast(msg: "Please add Items ");
    } else {
      BlocProvider.of<GetRequestUpdationBloc>(context).add(GetRequestUpdation(
          assetrequestcartlist: assetrequestcartlist,
          description: remarkfinalcontroller.text == ""
              ? ""
              : remarkfinalcontroller.text));

      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Request  Sent",
          textColor: Colors.black);
      if (widget.homenav == 'echoshop') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EchoShopBottomNavigation()));
      } else if (widget.homenav == 'productionunit') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UnitsAssetsBottomNavigation()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EchoShopBottomNavigation()));
      }
    }
  }
}

class Assetrequest2Model {
  String? typeofrequest;
  String? assetname;
  String? type;
  String? productquantity;
  String? quantity;
  String? productid;
  String? remark;
  Assetrequest2Model({
    this.typeofrequest,
    this.type,
    this.productquantity,
    this.assetname,
    this.quantity,
    this.productid,
    this.remark,
  });
}
