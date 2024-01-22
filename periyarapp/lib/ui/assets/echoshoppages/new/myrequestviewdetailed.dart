///My Request Detailes

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/myrequestviewmodel.dart';

class MyRequestDetailed extends StatefulWidget {
  final String requestId;
  // final List<OfflineRequestModel>? offlineRequestlist ;
  final int index;
  final MyRequestViewModel myRequestViewModel;
  const MyRequestDetailed(
      {Key? key,
      required this.requestId,
      required this.myRequestViewModel,
      required this.index})
      : super(key: key);

  @override
  State<MyRequestDetailed> createState() => _MyRequestDetailedState();
}

class _MyRequestDetailedState extends State<MyRequestDetailed> {
  @override
  void initState() {
    fetcher();

    super.initState();
  }

  void fetcher() async {}

  var d1 = new DateFormat('dd-MMM-yyyy');
  var d2 = new DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Request Details"), actions: []),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
            ),

            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Type of Request:     ",
                            style: TextStyle(fontSize: 14),
                          ),
                          widget.myRequestViewModel.data![widget.index]
                                      .items![0].typeOfRequest
                                      .toString() ==
                                  'stock Updation'
                              ? Text("Stock Updation")
                              : Text(
                                  (widget.myRequestViewModel.data![widget.index]
                                              .items![0].typeOfRequest
                                              .toString() ==
                                          "replace"
                                      ? "Replace"
                                      : widget
                                                  .myRequestViewModel
                                                  .data![widget.index]
                                                  .items![0]
                                                  .typeOfRequest
                                                  .toString() ==
                                              'damage'
                                          ? 'Damage'
                                          : widget
                                                      .myRequestViewModel
                                                      .data![widget.index]
                                                      .items![0]
                                                      .typeOfRequest
                                                      .toString() ==
                                                  'repair'
                                              ? 'Repair'
                                              : widget
                                                  .myRequestViewModel
                                                  .data![widget.index]
                                                  .items![0]
                                                  .typeOfRequest
                                                  .toString()),
                                  style: TextStyle(fontSize: 14),
                                )
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date:    ",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          d1.format(DateTime.parse(convert(widget
                                  .myRequestViewModel
                                  .data![widget.index]
                                  .items![0]
                                  .createDate!))) +
                              " | " +
                              d2.format(DateTime.parse(convert(widget
                                  .myRequestViewModel
                                  .data![widget.index]
                                  .items![0]
                                  .createDate!))),
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: widget
                        .myRequestViewModel.data![widget.index].items!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: InkWell(
                        child: Column(children: [
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xfff292929),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 4,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Name:",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          widget
                                                      .myRequestViewModel
                                                      .data![widget.index]
                                                      .items![index]
                                                      .name ==
                                                  null
                                              // state
                                              //             .myrequestDetailedModel
                                              //             .data![index]
                                              //             .name ==
                                              //         null
                                              ? Text(
                                                  widget
                                                      .myRequestViewModel
                                                      .data![widget.index]
                                                      .items![index]
                                                      .productId!
                                                      .name
                                                      .toString(),

                                                  // state
                                                  //     .myrequestDetailedModel
                                                  //     .data![index]
                                                  //     .productId!
                                                  //     .name
                                                  //     .toString()
                                                  //     .toString(),
                                                  style:
                                                      TextStyle(fontSize: 12))
                                              : Text(
                                                  widget
                                                      .myRequestViewModel
                                                      .data![widget.index]
                                                      .items![index]
                                                      .name
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Qunatity:",
                                              style: TextStyle(fontSize: 12)),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            widget
                                                .myRequestViewModel
                                                .data![widget.index]
                                                .items![index]
                                                .quantity
                                                .toString(),
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Remark:",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            (widget
                                                        .myRequestViewModel
                                                        .data![widget.index]
                                                        .items !=
                                                    null
                                                ? (widget
                                                            .myRequestViewModel
                                                            .data![widget.index]
                                                            .items![index]
                                                            .remark !=
                                                        null
                                                    ? widget
                                                        .myRequestViewModel
                                                        .data![widget.index]
                                                        .items![index]
                                                        .remark
                                                        .toString()
                                                    : "")
                                                : ""),
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ]),
                                    const SizedBox(
                                      height: 10,
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
                                            widget
                                                .myRequestViewModel
                                                .data![widget.index]
                                                .items![index]
                                                .requestStatus
                                                .toString(),
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    widget
                                                .myRequestViewModel
                                                .data![widget.index]
                                                .items![index]
                                                .requestStatus
                                                .toString() ==
                                            'transfered'
                                        ? Column(
                                            children: [
                                              // Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment
                                              //             .spaceBetween,
                                              //     children: [
                                              //       const Text(
                                              //         "Issued Quntity:",
                                              //         style: TextStyle(
                                              //             fontSize: 12),
                                              //       ),
                                              //       const SizedBox(
                                              //         width: 10,
                                              //       ),
                                              //       state
                                              //                   .myrequestDetailedModel
                                              //                   .data![
                                              //                       index]
                                              //                   .transferedItemId ==
                                              //               null
                                              //           ? Text("")
                                              //           : Text(
                                              //               state
                                              //                   .myrequestDetailedModel
                                              //                   .data![
                                              //                       index]
                                              //                   .transferedItemId!
                                              //                   .quantity
                                              //                   .toString(),
                                              //               style: TextStyle(
                                              //                   fontSize:
                                              //                       12),
                                              //             )
                                              //     ]),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment
                                              //           .spaceBetween,
                                              //   children: [
                                              //     Text(
                                              //       "Issued Date:    ",
                                              //       style: TextStyle(
                                              //           fontSize: 12),
                                              //     ),
                                              //     state
                                              //                 .myrequestDetailedModel
                                              //                 .data![
                                              //                     index]
                                              //                 .transferedItemId ==
                                              //             null
                                              //         ? Text("")
                                              //         : Text(
                                              //             d1.format(DateTime.parse(convert(state
                                              //                     .myrequestDetailedModel
                                              //                     .data![
                                              //                         index]
                                              //                     .transferedItemId!
                                              //                     .createDate!))) +
                                              //                 " | " +
                                              //                 d2.format(DateTime.parse(convert(state
                                              //                     .myrequestDetailedModel
                                              //                     .data![
                                              //                         index]
                                              //                     .transferedItemId!
                                              //                     .createDate!))),
                                              //             style:
                                              //                 TextStyle(
                                              //               fontSize:
                                              //                   12,
                                              //             ),
                                              //           ),
                                              //   ],
                                              // ),
                                            ],
                                          )
                                        : Text(""),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {},
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
                      ));
                    },
                  ),
                ],
              ),
            ),

            // BlocConsumer<GetViewMyRequestDetailedBloc,
            //         ViewMyRequestDetailedState>(
            //     builder: (context, state) {
            //       if (state is ViewMyRequestDetailedSuccess) {
            //         return Padding(
            //           padding: const EdgeInsets.all(6.0),
            //           child: Column(
            //             children: [
            //               const SizedBox(
            //                 height: 15,
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       const Text(
            //                         "Type of Request:     ",
            //                         style: TextStyle(fontSize: 14),
            //                       ),
            //                       widget.myRequestViewModel.data![widget.index]
            //                                   .items![0].typeOfRequest
            //                                   .toString() ==
            //                               'stock Updation'
            //                           ? Text("Stock Updation")
            //                           : Text(
            //                               (widget
            //                                           .myRequestViewModel
            //                                           .data![widget.index]
            //                                           .items![0]
            //                                           .typeOfRequest
            //                                           .toString() ==
            //                                       "replace"
            //                                   ? "Replace"
            //                                   : widget
            //                                               .myRequestViewModel
            //                                               .data![widget.index]
            //                                               .items![0]
            //                                               .typeOfRequest
            //                                               .toString() ==
            //                                           'damage'
            //                                       ? 'Damage'
            //                                       : widget
            //                                                   .myRequestViewModel
            //                                                   .data![
            //                                                       widget.index]
            //                                                   .items![0]
            //                                                   .typeOfRequest
            //                                                   .toString() ==
            //                                               'repair'
            //                                           ? 'Repair'
            //                                           : widget
            //                                               .myRequestViewModel
            //                                               .data![widget.index]
            //                                               .items![0]
            //                                               .typeOfRequest
            //                                               .toString()),
            //                               style: TextStyle(fontSize: 14),
            //                             )
            //                     ]),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text(
            //                       "Date:    ",
            //                       style: TextStyle(fontSize: 14),
            //                     ),
            //                     Text(
            //                       d1.format(DateTime.parse(convert(widget
            //                               .myRequestViewModel
            //                               .data![widget.index]
            //                               .items![0]
            //                               .createDate!))) +
            //                           " | " +
            //                           d2.format(DateTime.parse(convert(widget
            //                               .myRequestViewModel
            //                               .data![widget.index]
            //                               .items![0]
            //                               .createDate!))),
            //                       style: TextStyle(
            //                         fontSize: 14,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               ListView.builder(
            //                 scrollDirection: Axis.vertical,
            //                 shrinkWrap: true,
            //                 itemCount: widget.myRequestViewModel
            //                     .data![widget.index].items!.length,
            //                 physics: const NeverScrollableScrollPhysics(),
            //                 itemBuilder: (BuildContext context, int index) {
            //                   return ListTile(
            //                       title: InkWell(
            //                     child: Column(children: [
            //                       InkWell(
            //                         child: Container(
            //                           decoration: BoxDecoration(
            //                             color: Color(0xfff292929),
            //                             borderRadius: BorderRadius.circular(8),
            //                             boxShadow: [
            //                               BoxShadow(
            //                                 color: Colors.grey.withOpacity(0.3),
            //                                 spreadRadius: 4,
            //                                 blurRadius: 4,
            //                               ),
            //                             ],
            //                           ),
            //                           child: Padding(
            //                             padding: const EdgeInsets.all(12.0),
            //                             child: Column(
            //                               children: [
            //                                 const SizedBox(
            //                                   height: 10,
            //                                 ),
            //                                 Row(
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment
            //                                             .spaceBetween,
            //                                     children: [
            //                                       const Text(
            //                                         "Name:",
            //                                         style:
            //                                             TextStyle(fontSize: 12),
            //                                       ),
            //                                       const SizedBox(
            //                                         width: 10,
            //                                       ),
            //                                       widget
            //                                                   .myRequestViewModel
            //                                                   .data![
            //                                                       widget.index]
            //                                                   .items![index]
            //                                                   .name ==
            //                                               null
            //                                           // state
            //                                           //             .myrequestDetailedModel
            //                                           //             .data![index]
            //                                           //             .name ==
            //                                           //         null
            //                                           ? Text(
            //                                               widget
            //                                                   .myRequestViewModel
            //                                                   .data![
            //                                                       widget.index]
            //                                                   .items![index]
            //                                                   .productId!
            //                                                   .name
            //                                                   .toString(),

            //                                               // state
            //                                               //     .myrequestDetailedModel
            //                                               //     .data![index]
            //                                               //     .productId!
            //                                               //     .name
            //                                               //     .toString()
            //                                               //     .toString(),
            //                                               style: TextStyle(
            //                                                   fontSize: 12))
            //                                           : Text(
            //                                               state
            //                                                   .myrequestDetailedModel
            //                                                   .data![index]
            //                                                   .name
            //                                                   .toString(),
            //                                               style: TextStyle(
            //                                                   fontSize: 12),
            //                                             )
            //                                     ]),
            //                                 const SizedBox(
            //                                   height: 10,
            //                                 ),
            //                                 Row(
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment
            //                                             .spaceBetween,
            //                                     children: [
            //                                       const Text("Qunatity:",
            //                                           style: TextStyle(
            //                                               fontSize: 12)),
            //                                       const SizedBox(
            //                                         width: 10,
            //                                       ),
            //                                       Text(
            //                                         widget
            //                                             .myRequestViewModel
            //                                             .data![widget.index]
            //                                             .items![index]
            //                                             .quantity
            //                                             .toString(),
            //                                         style:
            //                                             TextStyle(fontSize: 12),
            //                                       )
            //                                     ]),
            //                                 const SizedBox(
            //                                   height: 10,
            //                                 ),
            //                                 Row(
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment
            //                                             .spaceBetween,
            //                                     children: [
            //                                       const Text(
            //                                         "Remark:",
            //                                         style:
            //                                             TextStyle(fontSize: 12),
            //                                       ),
            //                                       const SizedBox(
            //                                         width: 10,
            //                                       ),
            //                                       Text(
            //                                         (widget
            //                                                     .myRequestViewModel
            //                                                     .data![widget
            //                                                         .index]
            //                                                     .items !=
            //                                                 null
            //                                             ? (widget
            //                                                         .myRequestViewModel
            //                                                         .data![widget
            //                                                             .index]
            //                                                         .items![
            //                                                             index]
            //                                                         .remark !=
            //                                                     null
            //                                                 ? widget
            //                                                     .myRequestViewModel
            //                                                     .data![widget
            //                                                         .index]
            //                                                     .items![index]
            //                                                     .remark
            //                                                     .toString()
            //                                                 : "")
            //                                             : ""),
            //                                         style:
            //                                             TextStyle(fontSize: 12),
            //                                       )
            //                                     ]),
            //                                 const SizedBox(
            //                                   height: 10,
            //                                 ),
            //                                 Row(
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment
            //                                             .spaceBetween,
            //                                     children: [
            //                                       const Text(
            //                                         "Requested Status:",
            //                                         style:
            //                                             TextStyle(fontSize: 12),
            //                                       ),
            //                                       const SizedBox(
            //                                         width: 10,
            //                                       ),
            //                                       Text(
            //                                         widget
            //                                             .myRequestViewModel
            //                                             .data![widget.index]
            //                                             .items![index]
            //                                             .requestStatus
            //                                             .toString(),
            //                                         style:
            //                                             TextStyle(fontSize: 12),
            //                                       )
            //                                     ]),
            //                                 const SizedBox(
            //                                   height: 10,
            //                                 ),
            //                                widget
            //                                             .myRequestViewModel
            //                                             .data![widget.index]
            //                                             .items![index]
            //                                             .requestStatus
            //                                             .toString() ==
            //                                         'transfered'
            //                                     ? Column(
            //                                         children: [
            //                                           // Row(
            //                                           //     mainAxisAlignment:
            //                                           //         MainAxisAlignment
            //                                           //             .spaceBetween,
            //                                           //     children: [
            //                                           //       const Text(
            //                                           //         "Issued Quntity:",
            //                                           //         style: TextStyle(
            //                                           //             fontSize: 12),
            //                                           //       ),
            //                                           //       const SizedBox(
            //                                           //         width: 10,
            //                                           //       ),
            //                                           //       state
            //                                           //                   .myrequestDetailedModel
            //                                           //                   .data![
            //                                           //                       index]
            //                                           //                   .transferedItemId ==
            //                                           //               null
            //                                           //           ? Text("")
            //                                           //           : Text(
            //                                           //               state
            //                                           //                   .myrequestDetailedModel
            //                                           //                   .data![
            //                                           //                       index]
            //                                           //                   .transferedItemId!
            //                                           //                   .quantity
            //                                           //                   .toString(),
            //                                           //               style: TextStyle(
            //                                           //                   fontSize:
            //                                           //                       12),
            //                                           //             )
            //                                           //     ]),
            //                                           const SizedBox(
            //                                             height: 10,
            //                                           ),
            //                                           // Row(
            //                                           //   mainAxisAlignment:
            //                                           //       MainAxisAlignment
            //                                           //           .spaceBetween,
            //                                           //   children: [
            //                                           //     Text(
            //                                           //       "Issued Date:    ",
            //                                           //       style: TextStyle(
            //                                           //           fontSize: 12),
            //                                           //     ),
            //                                           //     state
            //                                           //                 .myrequestDetailedModel
            //                                           //                 .data![
            //                                           //                     index]
            //                                           //                 .transferedItemId ==
            //                                           //             null
            //                                           //         ? Text("")
            //                                           //         : Text(
            //                                           //             d1.format(DateTime.parse(convert(state
            //                                           //                     .myrequestDetailedModel
            //                                           //                     .data![
            //                                           //                         index]
            //                                           //                     .transferedItemId!
            //                                           //                     .createDate!))) +
            //                                           //                 " | " +
            //                                           //                 d2.format(DateTime.parse(convert(state
            //                                           //                     .myrequestDetailedModel
            //                                           //                     .data![
            //                                           //                         index]
            //                                           //                     .transferedItemId!
            //                                           //                     .createDate!))),
            //                                           //             style:
            //                                           //                 TextStyle(
            //                                           //               fontSize:
            //                                           //                   12,
            //                                           //             ),
            //                                           //           ),
            //                                           //   ],
            //                                           // ),
            //                                         ],
            //                                       )
            //                                     : Text(""),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         onTap: () {},
            //                       ),

            //                       //           Image.network(
            //                       //   WebClient.imageUrl +
            //                       //      state.viewEachReportModel
            //                       //                 .records[index].photo[0]
            //                       //                 ,
            //                       //   width: 110,
            //                       //   height: 180,
            //                       // ),

            //                       //  Image.network(
            //                       //     WebClient.imageUrl +
            //                       //      state.viewEachReportModel.records[index].photo.length.,
            //                       //     width: 110,
            //                       //     height: 180,
            //                       //   ),
            //                     ]),
            //                   ));
            //                 },
            //               ),
            //             ],
            //           ),
            //         );
            //       } else {
            //         return Container();
            //       }
            //     },
            //     listener: (context, state) {}),
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
