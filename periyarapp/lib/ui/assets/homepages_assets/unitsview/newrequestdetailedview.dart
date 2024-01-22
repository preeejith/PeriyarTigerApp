
///no model

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/assets/rejectrequestbloc/rejectrequestbloc.dart';
import 'package:parambikulam/bloc/assets/rejectrequestbloc/rejectrequestevent.dart';
import 'package:parambikulam/bloc/assets/rejectrequestbloc/rejectrequeststate.dart';

import 'package:parambikulam/bloc/assets/viewrequestdetailed_bloc/viewrequestdetailed_bloc.dart';
import 'package:parambikulam/bloc/assets/viewrequestdetailed_bloc/viewrequestdetailed_event.dart';
import 'package:parambikulam/bloc/assets/viewrequestdetailed_bloc/viewrequestdetailed_state.dart';
import 'package:parambikulam/ui/assets/homepages_assets/unitsview/assetsrequested_transfer.dart';

import 'package:parambikulam/ui/assets/homepages_assets/unitsview/newrequestview.dart';

class NewRequestDetailed extends StatefulWidget {
  final String unitId;
  final String requestType;
  const NewRequestDetailed({
    Key? key,
    required this.unitId,
    required this.requestType,
  }) : super(key: key);

  @override
  State<NewRequestDetailed> createState() => _NewRequestDetailedState();
}

class _NewRequestDetailedState extends State<NewRequestDetailed> {
  @override
  void initState() {
    fetcher();

    super.initState();
  }

  final TextEditingController remarkcontroller = TextEditingController();
  void fetcher() async {
    // token = await PrefManager.getToken();

    BlocProvider.of<GetViewRequestDetailedBloc>(context)
        .add(GetViewRequestDetailed(
      requestId: widget.unitId,
      requestType: widget.requestType,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: new AppBar(
        title: new Text('Details '),
        // leading: InkWell(onTap: () {}, child: Icon(Icons.menu)),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<GetViewRequestDetailedBloc, ViewRequestDetailedState>(
                builder: (context, state) {
                  if (state is ViewRequestDetailedsuccess) {
                    return Container(
                      child: Column(
                        children: [
                          const Text(
                            "",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          state.unitRequestDetailedModel.data.status != "active"
                              ? Container()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MaterialButton(
                                          color: Color(0xfff68D389),
                                          height: 30,
                                          minWidth: 10,
                                          child: const Text(
                                            'Transfer Assets',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AssetsTransferRequested(
                                                            assetId: state
                                                                .unitRequestDetailedModel
                                                                .data
                                                                .productId,
                                                            requestId: state
                                                                .unitRequestDetailedModel
                                                                .data
                                                                .id)));
                                          }),
                                    ),
                                  ],
                                ),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        state.unitRequestDetailedModel.data
                                                    .status ==
                                                "active"
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: MaterialButton(
                                                    color: Color(0xfff68D389),
                                                    height: 30,
                                                    minWidth: 10,
                                                    child: const Text(
                                                      'Cancel ',
                                                      style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      state.unitRequestDetailedModel
                                                                  .data.status ==
                                                              "active"
                                                          ? showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return SingleChildScrollView(
                                                                  child:
                                                                      SizedBox(
                                                                    child:
                                                                        AlertDialog(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      title: const Text(
                                                                          'Cancel Order'),
                                                                      content:
                                                                          Column(
                                                                              children: [
                                                                            Column(
                                                                              children: [
                                                                                TextFormField(
                                                                                  //noted
                                                                                  textInputAction: TextInputAction.next,
                                                                                  controller: remarkcontroller,
                                                                                  autocorrect: true,
                                                                                  keyboardType: TextInputType.text,
                                                                                  decoration: const InputDecoration(
                                                                                    labelText: 'Reason ',
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ]),
                                                                      actions: [
                                                                        MaterialButton(
                                                                          textColor:
                                                                              Colors.black,
                                                                          onPressed:
                                                                              () {
                                                                            setState(() {
                                                                              remarkcontroller.clear();
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'CANCEL',
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                        ),
                                                                        MaterialButton(
                                                                          // child: const Text("SUBMIT",
                                                                          //     style: TextStyle(
                                                                          //         color: Colors.white,
                                                                          //         fontSize: 12)),
                                                                          onPressed:
                                                                              () {
                                                                            if (remarkcontroller.text.isEmpty) {
                                                                              Fluttertoast.showToast(msg: "Please Enter the Reason");
                                                                            } else {
                                                                              // Navigator.pop(context);

                                                                              BlocProvider.of<GetRequestRejectBloc>(context).add(GetRequestReject(
                                                                                requestId: state.unitRequestDetailedModel.data.id,
                                                                                remark: remarkcontroller.text,
                                                                              ));
                                                                            }
                                                                          },

                                                                          child: BlocConsumer<
                                                                              GetRequestRejectBloc,
                                                                              RequestRejectState>(builder: (context, state) {
                                                                            // if (state is Checking) {
                                                                            //   return CircularProgressIndicator(
                                                                            //     valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                                                            //     strokeWidth: 2,
                                                                            //   );
                                                                            // }

                                                                            if (state
                                                                                is Requestrejecting) {
                                                                              return const SizedBox(
                                                                                height: 18.0,
                                                                                width: 18.0,
                                                                                child: CircularProgressIndicator(
                                                                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                                                                  strokeWidth: 2,
                                                                                ),
                                                                              );
                                                                            } else {
                                                                              return const Text("SUBMIT", style: TextStyle(color: Colors.white, fontSize: 12));
                                                                            }
                                                                          }, listener:
                                                                              (context, state) {
                                                                            if (state
                                                                                is RequestRejectsuccess) {
                                                                              Fluttertoast.showToast(msg: "Oreder Rejected", gravity: ToastGravity.CENTER, textColor: Colors.white, fontSize: 16.0);
                                                                              Navigator.pop(context);
                                                                              //  fetcher();
                                                                              Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(builder: (context) => NewRequestView(transferedtoId: '111')),
                                                                              );

                                                                              setState(() {
                                                                                remarkcontroller.clear();
                                                                              });
                                                                              //  this.setState(() {
                                                                              //                          firstName.clear();
                                                                              //                           lastName.clear();
                                                                              //                           gender.clear();
                                                                              //                           modeOfDelivary.clear();
                                                                              //                           address.clear();
                                                                              //                           pincode.clear();
                                                                              //                       }

                                                                              // Navigator.push(
                                                                              //   context,
                                                                              //   MaterialPageRoute(builder: (context) => const StaysHomePage()),
                                                                              // );
                                                                              // BlocProvider.of<
                                                                              //             GetPendingOrderBloc>(
                                                                              //         context)
                                                                              // .add(
                                                                              //     GetPendingOrderEvent());
                                                                            }

                                                                            //
                                                                            //else if (state is ProfileViewError) {
                                                                            //   Fluttertoast.showToast(
                                                                            //       msg: "Rejection failed",
                                                                            //       gravity: ToastGravity.CENTER,
                                                                            //       textColor: Colors.white,
                                                                            //       fontSize: 16.0);
                                                                            // }
                                                                          }),

                                                                          color:
                                                                              const Color(0xff59AF73),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            )
                                                          : Fluttertoast.showToast(
                                                              msg:
                                                                  "Already Reject");

                                                      // Navigator.pushReplacement(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             AssetsTransfer( transferedtoId: state.unitsDetailedViewModel.user.id   )));
                                                    }),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Unit Name",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            state.unitRequestDetailedModel.data
                                                .unitId.name,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Asset Name",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            state.unitRequestDetailedModel.data
                                                .assetName,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(6.0),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Text(
                                    //         "Product Id Name",
                                    //         style: TextStyle(fontSize: 12),
                                    //       ),
                                    //       Text(
                                    //         state.unitRequestDetailedModel.data
                                    //             .productId,
                                    //         style: TextStyle(fontSize: 12),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Qunatity",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            state.unitRequestDetailedModel.data
                                                .quantity
                                                .toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Type of Request",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            state.unitRequestDetailedModel.data
                                                .typeOfRequest,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Requested Status",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            state.unitRequestDetailedModel.data
                                                .requestStatus,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Remark",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            state.unitRequestDetailedModel.data
                                                .remark,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //   Padding(
                                    //     padding: const EdgeInsets.all(8.0),
                                    //     child: Row(
                                    //          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Text(
                                    //         "Created Date",
                                    //         style: TextStyle(fontSize: 12),
                                    //       ),
                                    //       Text(
                                    //         state.assetsDetailedViewModel.data.assetId
                                    //             .description,
                                    //         style: TextStyle(fontSize: 12),
                                    //       ),
                                    //     ],
                                    // ),
                                    //   )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else
                    return Container();
                },
                listener: (context, state) {})
          ],
        ),
      ),
    );
  }
}
