///My Request Detailes
///
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class DetailedRequestView extends StatefulWidget {
  final List items60;
  final List items61;
  // final List<OfflineRequestModel>? offlineRequestlist;
  final int index;
  // final MyRequestViewModel myRequestViewModel;
  const DetailedRequestView(
      {Key? key,
      required this.items60,
      required this.items61,
      // this.offlineRequestlist,
      // required this.myRequestViewModel,
      required this.index})
      : super(key: key);

  @override
  State<DetailedRequestView> createState() => _DetailedRequestViewState();
}

class _DetailedRequestViewState extends State<DetailedRequestView> {
  @override
  List<AssetMasterTable> assetMasterTable = [];
  String? assetnameid = "Nill";
  List<String> assetnamelist = [];
  // List items60 = [];
  // List items61 = [];
  void initState() {
    fetcher();

    super.initState();
  }

  void fetcher() async {
    DatabaseHelper? db = DatabaseHelper.instance;
    assetMasterTable = await db.getAssetMasterTableDownloadData();
    // items60 = await getproductionunitrequestmaindata();
    // print(items60);
    // items61 = await getproductionunitrequestsubdata();
    // print(items61);

    // for (int h = 0; h < assetMasterTable.length; h++) {
    //   if (assetMasterTable[h].id ==
    //       widget.offlineRequestlist![widget.index].assetid.toString()) {
    //     setState(() {
    //       // assetnamelist.add(assetMasterTable[h].name.toString());
    //       assetnameid = assetMasterTable[h].name;
    //     });
    //   }
    // }
  }

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
                          widget.items60[widget.index]['requesttype']
                                      .toString() ==
                                  'stock Updation'
                              ? Text("Stock Updation")
                              : Text(
                                  (widget.items60[widget.index]['requesttype']
                                              .toString() ==
                                          "replace"
                                      ? "Replace"
                                      : widget.items60[widget.index]
                                                      ['requesttype']
                                                  .toString() ==
                                              'damage'
                                          ? 'Damage'
                                          : widget.items60[widget.index]
                                                          ['requesttype']
                                                      .toString() ==
                                                  'repair'
                                              ? 'Repair'
                                              : widget.items60[widget.index]
                                                      ['requesttype']
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
                              .items60[widget.index]['date']
                              .toString()))),
                          // " | " +
                          // d2.format(DateTime.parse(convert(widget
                          //     .items60[widget.index]['date']
                          //     .toString()))),
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
                    itemCount: widget.items61.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return widget.items60[widget.index]['id'].toString() !=
                              widget.items61[index]['mainid'].toString()
                          ? SizedBox()
                          : ListTile(
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  "Name:",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                widget.items61[index]
                                                            ['assetname'] ==
                                                        null
                                                    // state
                                                    //             .DetailedRequestViewModel
                                                    //             .data![index]
                                                    //             .name ==
                                                    //         null
                                                    ? Text("",

                                                        // state
                                                        //     .DetailedRequestViewModel
                                                        //     .data![index]
                                                        //     .productId!
                                                        //     .name
                                                        //     .toString()
                                                        //     .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12))
                                                    : Text(
                                                        widget.items61[index]
                                                                ['assetname']
                                                            .toString(),

                                                        // widget
                                                        //     .myRequestViewModel
                                                        //     .data![widget.index]
                                                        //     .items![index]
                                                        //     .name
                                                        //     .toString(),
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
                                                const Text("Qunatity:",
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  widget.items61[index]
                                                      ['quantity'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ]),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          widget.items61[index]['remark'] ==
                                                  null
                                              ? SizedBox()
                                              : widget.items61[index]
                                                          ['remark'] ==
                                                      ""
                                                  ? SizedBox()
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                          const Text(
                                                            "Remark:",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            widget.items61[index]
                                                                        [
                                                                        'remark'] ==
                                                                    null
                                                                ? ""
                                                                : widget.items61[
                                                                        index]
                                                                    ['remark'],
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ]),
                                          widget.items61[index]['remark'] ==
                                                  null
                                              ? SizedBox()
                                              : widget.items61[index]
                                                          ['remark'] ==
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
                                                  "Requested Status:",
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  widget.items61[index]
                                                      ['requestatus'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ]),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          widget.items61[index]
                                                      ['transferedQuantity'] ==
                                                  ""
                                              ? SizedBox()
                                              : widget.items61[index][
                                                          'transferedQuantity'] ==
                                                      null
                                                  ? SizedBox()
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                          const Text(
                                                            "Transfer Quantity:",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            widget.items61[
                                                                    index][
                                                                'transferedQuantity'],
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          )
                                                        ]),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          widget.items61[index]
                                                      ['requestatus'] ==
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
                                                    //                   .DetailedRequestViewModel
                                                    //                   .data![
                                                    //                       index]
                                                    //                   .transferedItemId ==
                                                    //               null
                                                    //           ? Text("")
                                                    //           : Text(
                                                    //               state
                                                    //                   .DetailedRequestViewModel
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
                                                    //                 .DetailedRequestViewModel
                                                    //                 .data![
                                                    //                     index]
                                                    //                 .transferedItemId ==
                                                    //             null
                                                    //         ? Text("")
                                                    //         : Text(
                                                    //             d1.format(DateTime.parse(convert(state
                                                    //                     .DetailedRequestViewModel
                                                    //                     .data![
                                                    //                         index]
                                                    //                     .transferedItemId!
                                                    //                     .createDate!))) +
                                                    //                 " | " +
                                                    //                 d2.format(DateTime.parse(convert(state
                                                    //                     .DetailedRequestViewModel
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
          ],
        ),
      ),
    );
  }

  String convert(String uTCTime) {
    var dateFormat = DateFormat("dd-MM-yyyy hh:mm");
    var utcDate =
        dateFormat.format(DateTime.parse(uTCTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    // String createdDate = dateFormat.format(DateTime.parse(localDate));
    return localDate;
  }
}
