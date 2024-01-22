///no model

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/purchaseorderviewmodel.dart';

import 'package:parambikulam/ui/assets/purchaseorder/viewpurchaseorder.dart';

////
class ViewPurchaseOrderDetailed extends StatefulWidget {
  // final String purchaseId;
  final List<ViewPurchaseModel> viewpurchaselist;
  final List<PurchaseOrder> purchaseOrder;
  final List<PurchaseData> purchaseData;

  final index;
  // final ViewPurchaseListModel viewPurchaseListModel;
  ViewPurchaseOrderDetailed(
      {Key? key,
      // required this.purchaseId,
      required this.viewpurchaselist,
      required this.purchaseOrder,
      required this.purchaseData,
      // required this.viewPurchaseListModel,
      required this.index})
      : super(key: key);

  @override
  State<ViewPurchaseOrderDetailed> createState() =>
      _ViewPurchaseOrderDetailedState();
}

class _ViewPurchaseOrderDetailedState extends State<ViewPurchaseOrderDetailed> {
  @override
  void initState() {
    fetcher();

    super.initState();
  }

  final TextEditingController remarkcontroller = TextEditingController();
  void fetcher() async {
    // BlocProvider.of<GetViewPurchaseOrderDetailedBloc>(context)
    //     .add(GetViewPurchaseOrderDetailed(
    //   purchaseId: widget.purchaseId,
    // ));
  }

  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: new AppBar(
        title: new Text('Details '),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(children: [
                              const Text(
                                "Purchase Id:",
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              widget.purchaseOrder[widget.index].purchaseId
                                          .toString() !=
                                      "null"
                                  ? Text(
                                      widget.purchaseOrder[widget.index]
                                          .purchaseId
                                          .toString(),
                                      style: TextStyle(fontSize: 12),
                                    )
                                  : Text("")
                            ]),
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: widget.purchaseData.length,

                            // state.viewPurchaseDetailedModel
                            //     .data!.purchase!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return widget.purchaseData[index].purchaseid !=
                                      widget.purchaseOrder[widget.index].id
                                  ? SizedBox()
                                  : ListTile(
                                      title: InkWell(
                                      child: Column(children: [
                                        InkWell(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xfff292929),
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          "Name:",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          widget
                                                              .purchaseData[
                                                                  index]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )
                                                      ]),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // Row(
                                                  //     mainAxisAlignment:
                                                  //         MainAxisAlignment
                                                  //             .spaceBetween,
                                                  //     children: [
                                                  //       const Text(
                                                  //         "Type:",
                                                  //         style: TextStyle(
                                                  //             fontSize: 12),
                                                  //       ),
                                                  //       const SizedBox(
                                                  //         width: 10,
                                                  //       ),
                                                  //       Text(
                                                  //         widget
                                                  //                     .viewPurchaseListModel
                                                  //                     .data![widget
                                                  //                         .index]
                                                  //                     .purchase![
                                                  //                         index]
                                                  //                     .assetId!
                                                  //                     .type
                                                  //                     .toString() ==
                                                  //                 ""
                                                  //             ? widget
                                                  //                 .viewPurchaseListModel
                                                  //                 .data![widget
                                                  //                     .index]
                                                  //                 .purchase![
                                                  //                     index]
                                                  //                 .assetId!
                                                  //                 .type
                                                  //                 .toString()
                                                  //             : widget
                                                  //                 .viewPurchaseListModel
                                                  //                 .data![widget
                                                  //                     .index]
                                                  //                 .purchase![
                                                  //                     index]
                                                  //                 .assetId!
                                                  //                 .type
                                                  //                 .toString(),
                                                  //         style: TextStyle(
                                                  //             fontSize: 12),
                                                  //       )
                                                  //     ]),
                                                  // const SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const Text(
                                                          "Qunatity  :",
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          widget
                                                                      .purchaseData[
                                                                          index]
                                                                      .quantity
                                                                      .toString() ==
                                                                  "null"
                                                              ? "-"
                                                              : widget
                                                                  .purchaseData[
                                                                      index]
                                                                  .quantity
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12),
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
                                                            "Purchase Amount:",
                                                            style: TextStyle(
                                                                fontSize: 12)),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          widget
                                                              .purchaseData[
                                                                  index]
                                                              .purchaseAmount
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        )
                                                      ]),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // Row(
                                                  //     mainAxisAlignment:
                                                  //         MainAxisAlignment
                                                  //             .spaceBetween,
                                                  //     children: [
                                                  //       const Text(
                                                  //         "Total Amount:",
                                                  //         style: TextStyle(
                                                  //             fontSize: 12),
                                                  //       ),
                                                  //       const SizedBox(
                                                  //         width: 10,
                                                  //       ),
                                                  //       Text(
                                                  //         state
                                                  //             .viewPurchaseDetailedModel
                                                  //             .data!
                                                  //             .purchase![
                                                  //                 index]
                                                  //             .purchaseAmount
                                                  //             .toString(),
                                                  //         style: TextStyle(
                                                  //             fontSize: 12),
                                                  //       )
                                                  //     ]),
                                                  // const SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total Amount:",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        widget.purchaseOrder[widget.index]
                                            .totalAmount
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
                                        "Discount:",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        widget.purchaseOrder[widget.index]
                                            .discount
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
                                        "Final Amount:",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        widget.purchaseOrder[widget.index]
                                            .billAmount
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
                                        const Text("Date:",
                                            style: TextStyle(fontSize: 12)),
                                        Text(
                                          d1.format(DateTime.parse(convert(
                                              widget.purchaseOrder[widget.index]
                                                  .createDate
                                                  .toString()))),
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ]),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // BlocConsumer<GetViewPurchaseOrderDetailedBloc,
            //         ViewPurchaseOrderDetailedState>(
            //     builder: (context, state) {
            //       if (state is ViewPurchaseOrderDetailedsuccess) {
            //         return Container(
            //           child: Column(
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(2.0),
            //                 child: Container(
            //                   child: Column(
            //                     children: [
            //                       Padding(
            //                         padding: const EdgeInsets.all(12.0),
            //                         child: Row(children: [
            //                           const Text(
            //                             "Purchase Id:",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           const SizedBox(
            //                             width: 10,
            //                           ),
            //                           widget
            //                                       .viewPurchaseListModel
            //                                       .data![widget.index]
            //                                       .purchaseId
            //                                       .toString() !=
            //                                   "null"
            //                               ? Text(
            //                                   widget
            //                                       .viewPurchaseListModel
            //                                       .data![widget.index]
            //                                       .purchaseId
            //                                       .toString(),
            //                                   style: TextStyle(fontSize: 12),
            //                                 )
            //                               : Text("")
            //                         ]),
            //                       ),
            //                       ListView.builder(
            //                         scrollDirection: Axis.vertical,
            //                         shrinkWrap: true,
            //                         itemCount: widget.viewPurchaseListModel
            //                             .data![widget.index].purchase!.length,

            //                         // state.viewPurchaseDetailedModel
            //                         //     .data!.purchase!.length,
            //                         physics:
            //                             const NeverScrollableScrollPhysics(),
            //                         itemBuilder:
            //                             (BuildContext context, int index) {
            //                           return

            //                               // widget.viewPurchaseListModel
            //                               //             .data![0].billAmount
            //                               //             .toString() !=
            //                               //         widget.purchaseId
            //                               //     ? SizedBox()
            //                               //     :

            //                               ListTile(
            //                                   title: InkWell(
            //                             child: Column(children: [
            //                               InkWell(
            //                                 child: Container(
            //                                   decoration: BoxDecoration(
            //                                     color: Color(0xfff292929),
            //                                     borderRadius:
            //                                         BorderRadius.circular(8),
            //                                     boxShadow: [
            //                                       BoxShadow(
            //                                         color: Colors.grey
            //                                             .withOpacity(0.3),
            //                                         spreadRadius: 4,
            //                                         blurRadius: 4,
            //                                       ),
            //                                     ],
            //                                   ),
            //                                   child: Padding(
            //                                     padding:
            //                                         const EdgeInsets.all(16.0),
            //                                     child: Column(
            //                                       children: [
            //                                         const SizedBox(
            //                                           height: 10,
            //                                         ),
            //                                         Row(
            //                                             mainAxisAlignment:
            //                                                 MainAxisAlignment
            //                                                     .spaceBetween,
            //                                             children: [
            //                                               const Text(
            //                                                 "Name:",
            //                                                 style: TextStyle(
            //                                                     fontSize: 12),
            //                                               ),
            //                                               const SizedBox(
            //                                                 width: 10,
            //                                               ),
            //                                               Text(
            //                                                 widget
            //                                                     .viewPurchaseListModel
            //                                                     .data![widget
            //                                                         .index]
            //                                                     .purchase![
            //                                                         index]
            //                                                     .assetId!
            //                                                     .name
            //                                                     .toString(),
            //                                                 style: TextStyle(
            //                                                     fontSize: 12),
            //                                               )
            //                                             ]),
            //                                         const SizedBox(
            //                                           height: 10,
            //                                         ),
            //                                         // Row(
            //                                         //     mainAxisAlignment:
            //                                         //         MainAxisAlignment
            //                                         //             .spaceBetween,
            //                                         //     children: [
            //                                         //       const Text(
            //                                         //         "Type:",
            //                                         //         style: TextStyle(
            //                                         //             fontSize: 12),
            //                                         //       ),
            //                                         //       const SizedBox(
            //                                         //         width: 10,
            //                                         //       ),
            //                                         //       Text(
            //                                         //         widget
            //                                         //                     .viewPurchaseListModel
            //                                         //                     .data![widget
            //                                         //                         .index]
            //                                         //                     .purchase![
            //                                         //                         index]
            //                                         //                     .assetId!
            //                                         //                     .type
            //                                         //                     .toString() ==
            //                                         //                 ""
            //                                         //             ? widget
            //                                         //                 .viewPurchaseListModel
            //                                         //                 .data![widget
            //                                         //                     .index]
            //                                         //                 .purchase![
            //                                         //                     index]
            //                                         //                 .assetId!
            //                                         //                 .type
            //                                         //                 .toString()
            //                                         //             : widget
            //                                         //                 .viewPurchaseListModel
            //                                         //                 .data![widget
            //                                         //                     .index]
            //                                         //                 .purchase![
            //                                         //                     index]
            //                                         //                 .assetId!
            //                                         //                 .type
            //                                         //                 .toString(),
            //                                         //         style: TextStyle(
            //                                         //             fontSize: 12),
            //                                         //       )
            //                                         //     ]),
            //                                         // const SizedBox(
            //                                         //   height: 10,
            //                                         // ),
            //                                         Row(
            //                                             mainAxisAlignment:
            //                                                 MainAxisAlignment
            //                                                     .spaceBetween,
            //                                             children: [
            //                                               const Text(
            //                                                 "Qunatity  :",
            //                                                 style: TextStyle(
            //                                                     fontSize: 12),
            //                                               ),
            //                                               const SizedBox(
            //                                                 width: 10,
            //                                               ),
            //                                               Text(
            //                                                 widget
            //                                                             .viewPurchaseListModel
            //                                                             .data![widget
            //                                                                 .index]
            //                                                             .purchase![
            //                                                                 index]
            //                                                             .quantity
            //                                                             .toString() ==
            //                                                         "null"
            //                                                     ? "-"
            //                                                     : widget
            //                                                         .viewPurchaseListModel
            //                                                         .data![widget
            //                                                             .index]
            //                                                         .purchase![
            //                                                             index]
            //                                                         .quantity
            //                                                         .toString(),
            //                                                 style: TextStyle(
            //                                                     fontSize: 12),
            //                                               )
            //                                             ]),
            //                                         const SizedBox(
            //                                           height: 10,
            //                                         ),
            //                                         Row(
            //                                             mainAxisAlignment:
            //                                                 MainAxisAlignment
            //                                                     .spaceBetween,
            //                                             children: [
            //                                               const Text(
            //                                                   "Purchase Amount:",
            //                                                   style: TextStyle(
            //                                                       fontSize:
            //                                                           12)),
            //                                               const SizedBox(
            //                                                 width: 10,
            //                                               ),
            //                                               Text(
            //                                                 widget
            //                                                     .viewPurchaseListModel
            //                                                     .data![widget
            //                                                         .index]
            //                                                     .purchase![
            //                                                         index]
            //                                                     .purchaseAmount
            //                                                     .toString(),
            //                                                 style: TextStyle(
            //                                                     fontSize: 12),
            //                                               )
            //                                             ]),
            //                                         const SizedBox(
            //                                           height: 10,
            //                                         ),
            //                                         // Row(
            //                                         //     mainAxisAlignment:
            //                                         //         MainAxisAlignment
            //                                         //             .spaceBetween,
            //                                         //     children: [
            //                                         //       const Text(
            //                                         //         "Total Amount:",
            //                                         //         style: TextStyle(
            //                                         //             fontSize: 12),
            //                                         //       ),
            //                                         //       const SizedBox(
            //                                         //         width: 10,
            //                                         //       ),
            //                                         //       Text(
            //                                         //         state
            //                                         //             .viewPurchaseDetailedModel
            //                                         //             .data!
            //                                         //             .purchase![
            //                                         //                 index]
            //                                         //             .purchaseAmount
            //                                         //             .toString(),
            //                                         //         style: TextStyle(
            //                                         //             fontSize: 12),
            //                                         //       )
            //                                         //     ]),
            //                                         // const SizedBox(
            //                                         //   height: 10,
            //                                         // ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ]),
            //                           ));
            //                         },
            //                       ),
            //                       SizedBox(
            //                         height: 10,
            //                       ),
            //                       Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Column(
            //                           children: [
            //                             Padding(
            //                               padding: const EdgeInsets.all(6.0),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text(
            //                                     "Total Amount:",
            //                                     style: TextStyle(fontSize: 12),
            //                                   ),
            //                                   Text(
            //                                     widget
            //                                         .viewPurchaseListModel
            //                                         .data![widget.index]
            //                                         .totalAmount
            //                                         .toString(),
            //                                     style: TextStyle(fontSize: 12),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),

            //                             Padding(
            //                               padding: const EdgeInsets.all(6.0),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text(
            //                                     "Discount:",
            //                                     style: TextStyle(fontSize: 12),
            //                                   ),
            //                                   Text(
            //                                     widget
            //                                         .viewPurchaseListModel
            //                                         .data![widget.index]
            //                                         .discount
            //                                         .toString(),
            //                                     style: TextStyle(fontSize: 12),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),
            //                             Padding(
            //                               padding: const EdgeInsets.all(6.0),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text(
            //                                     "Final Amount:",
            //                                     style: TextStyle(fontSize: 12),
            //                                   ),
            //                                   Text(
            //                                     widget
            //                                         .viewPurchaseListModel
            //                                         .data![widget.index]
            //                                         .billAmount
            //                                         .toString(),
            //                                     style: TextStyle(fontSize: 12),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ),

            //                             Padding(
            //                               padding: const EdgeInsets.all(6.0),
            //                               child: Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment
            //                                           .spaceBetween,
            //                                   children: [
            //                                     const Text("Date:",
            //                                         style: TextStyle(
            //                                             fontSize: 12)),
            //                                     Text(
            //                                       d1.format(DateTime.parse(
            //                                               convert(widget
            //                                                   .viewPurchaseListModel
            //                                                   .data![
            //                                                       widget.index]
            //                                                   .createDate
            //                                                   .toString()))) +
            //                                           " | " +
            //                                           d2.format(DateTime.parse(
            //                                               convert(widget
            //                                                   .viewPurchaseListModel
            //                                                   .data![
            //                                                       widget.index]
            //                                                   .createDate
            //                                                   .toString()))),
            //                                       style: const TextStyle(
            //                                         fontSize: 12,
            //                                       ),
            //                                     )
            //                                   ]),
            //                             ),

            //                             //   Padding(
            //                             //     padding: const EdgeInsets.all(8.0),
            //                             //     child: Row(
            //                             //          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                             //     children: [
            //                             //       Text(
            //                             //         "Created Date",
            //                             //         style: TextStyle(fontSize: 12),
            //                             //       ),
            //                             //       Text(
            //                             //         state.assetsDetailedViewModel.data.assetId
            //                             //             .description,
            //                             //         style: TextStyle(fontSize: 12),
            //                             //       ),
            //                             //     ],
            //                             // ),
            //                             //   )
            //                           ],
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       } else
            //         return Center(
            //           child: SizedBox(
            //             height: 28.0,
            //             width: 28.0,
            //             child: CircularProgressIndicator(
            //               valueColor:
            //                   AlwaysStoppedAnimation<Color>(Colors.white),
            //               strokeWidth: 2,
            //             ),
            //           ),
            //         );
            //     },
            //     listener: (context, state) {})
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
