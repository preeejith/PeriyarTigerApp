import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:parambikulam/bloc/assets/localbloc/ibprogramsofflinebloc.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/ibmainreservation.dart';

class IbMainDetailed extends StatefulWidget {
  final String index;

  ///
  final OfflineDataReceived2 state;
  const IbMainDetailed({Key? key, required this.state, required this.index})
      : super(key: key);

  @override
  State<IbMainDetailed> createState() => _IbMainDetailedState();
}

/////
class _IbMainDetailedState extends State<IbMainDetailed> {
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  late List newList2;
  late List newList22;
  List<SlotModel> slotlist = [];

  List<OldResDataModel> oldresdatalist = [];

  void initState() {
    // fetcher();
    slotlist.clear();
    getSlotData(widget.state.items2!,
        widget.state.items![int.parse(widget.index)]['_id'], 'slotfromDate');

    getOldResDataData(widget.state.items5!,
        widget.state.items![int.parse(widget.index)]['_id']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: FileImage(
                        File(
                          widget.state.items![int.parse(widget.index)]
                              ['coverImage'],
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 55,
                  left: 0,
                  // height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(100.0),
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.state.items![
                                                  int.parse(widget.index)]
                                              ['progName'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 182,
                  left: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      color: Colors.green.shade400,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          widget.state.items![int.parse(widget.index)]
                                      ['started'] ==
                                  "1"
                              ? "STARTED"
                              : "ad",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Start Point",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.state.items![int.parse(widget.index)]
                            ['startPoint'],
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "End Point",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.state.items![int.parse(widget.index)]
                            ['endPoint'],
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Min Guest",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.state.items![int.parse(widget.index)]
                            ['minGuest'],
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Max Guest",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.state.items![int.parse(widget.index)]
                            ['maxGuest'],
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Duration",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.state.items![int.parse(widget.index)]
                            ['duration'],
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Min Age",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.state.items![int.parse(widget.index)]['minAge'],
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Max Age",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.state.items![int.parse(widget.index)]['maxAge'],
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Reporting Time",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.state.items![int.parse(widget.index)]
                            ['reportingTime'],
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: slotlist.length == 0
                            ? SizedBox()
                            : MaterialButton(
                                color: Colors.green,
                                child: Container(
                                    width: 150,
                                    child: Row(children: [
                                      Text("ADD RESERVATION"),
                                      Icon(Icons.forward_outlined)
                                    ])),
                                onPressed: () {
                                  /////
                                  ///

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => IbReservation(
                                              slotlist: slotlist,
                                              oldresdatalist: oldresdatalist,
                                              index: widget.index,
                                              state: widget.state)));
                                }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Notes",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "basic notes",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rules",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "normal rules",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recent Package Rates",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "No Package",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text(
                  //         "Slot Availablity",
                  //         style: TextStyle(color: Colors.black),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: slotlist.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Container(
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Column(children: [
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(3),
                  //               child: Container(
                  //                 height: 18,
                  //                 color: Colors.green,
                  //                 child: Row(children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(2.0),
                  //                     child: Text(
                  //                       d1.format(DateTime.parse(convert(
                  //                               slotlist[index]
                  //                                   .slotfromDate
                  //                                   .toString()
                  //                                   .toString()))) +
                  //                           " " +
                  //                           "to" +
                  //                           "  ",
                  //                       // slotlist[index].slotfromDate.toString(),
                  //                       style: TextStyle(
                  //                           color: Colors.white,
                  //                           letterSpacing: 1.0),
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     d1.format(DateTime.parse(convert(
                  //                         slotlist[index]
                  //                             .slottoDate
                  //                             .toString()
                  //                             .toString()))),
                  //                     style: TextStyle(
                  //                         color: Colors.white,
                  //                         letterSpacing: 1.0),
                  //                   )
                  //                 ]),
                  //               ),
                  //             ),
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(2),
                  //               child: Container(
                  //                 height: 18,
                  //                 color: Colors.grey.shade400,
                  //                 child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Container(
                  //                         child: Row(children: [
                  //                           Padding(
                  //                             padding:
                  //                                 const EdgeInsets.all(3.0),
                  //                             child: Text(
                  //                               slotlist[index]
                  //                                       .starttime
                  //                                       .toString() +
                  //                                   "PM  " +
                  //                                   "-",
                  //                               style: TextStyle(
                  //                                   color: Colors.black,
                  //                                   letterSpacing: 1.0),
                  //                             ),
                  //                           ),
                  //                           Text(
                  //                             slotlist[index]
                  //                                     .endtime
                  //                                     .toString() +
                  //                                 "AM",
                  //                             style: TextStyle(
                  //                                 color: Colors.black),
                  //                           ),
                  //                         ]),
                  //                       ),
                  //                       Text(
                  //                         slotlist[index]
                  //                                 .availableNo
                  //                                 .toString() +
                  //                             " " +
                  //                             "Rooms Available",
                  //                         style: TextStyle(
                  //                             color: Colors.black,
                  //                             letterSpacing: 1.0),
                  //                       )
                  //                     ]),
                  //               ),
                  //             ),
                  //           ]),
                  //         ),
                  //       );
                  //     }),
                ],
              ),
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

//////
  String getDate(
    List list,
    param1,
    String s,
  ) {
    newList2 =
        list.where((element) => element['slotprogramme'] == param1).toList();
    print(newList2[0][s]);

    // return newList2[0]['slotfromDate'];
    return d1.format(DateTime.parse(convert(newList2[0][s])));

    // newList2[0]['slotfromDate'];
  }

  String getSlotData(
    List list,
    param1,
    String s,
  ) {
    newList2 =
        list.where((element) => element['slotprogramme'] == param1).toList();
    // print(newList2[0][s]);

    for (int j = 0; j < newList2.length; j++) {
      slotlist.add(SlotModel(
        status: newList2[j]['status'],
        id: newList2[j]['_id'],
        starttime: newList2[j]['startTime'],
        endtime: newList2[j]['endTime'],
        availableNo: newList2[j]['availableNo'],
        slotisDaywise: "dsf",
        slotstatus: newList2[j]['slotstatus'],
        slotid: newList2[j]['slot_id'],
        slotprogramme: newList2[j]['slotprogramme'],
        slotfromDate: newList2[j]['slotfromDate'],
        slottoDate: newList2[j]['slottoDate'],
        slotslotType: newList2[j]['slotslotType'],
      ));
    }

    // return newList2[0]['slotfromDate'];
    return newList2[0]['slotfromDate'];

    // newList2[0]['slotfromDate'];
  }

  String getOldResDataData(
    List list,
    param1,
  ) {
    newList2 =
        list.where((element) => element['slotprogramid'] == param1).toList();

    for (int m = 0; m < newList2.length; m++) {
      oldresdatalist.add(OldResDataModel(
        id: newList2[m]['id'].toString(),
        reserveno: newList2[m]['reserveno'],
        bookingDate: newList2[m]['bookingDate'],
        slotid: newList2[m]['slotid'],
        slotprogramid: newList2[m]['slotprogramid'],
        programName: newList2[m]['programName'],
      ));
    }

    // return newList2[0]['slotfromDate'];
    return '';

    // newList2[0]['slotfromDate'];
  }

  String getTime(
    List list,
    param1,
    String s,
  ) {
    newList2 =
        list.where((element) => element['slotprogramme'] == param1).toList();
    print(newList2[0][s]);

    return newList2[0][s];
    // return d1.format(DateTime.parse(convert(newList2[0][s])));
  }

  String getRooms(
    List list,
    param1,
    String s,
  ) {
    newList2 =
        list.where((element) => element['slotprogramme'] == param1).toList();
    print('roooms');

    for (int j = 0; j < newList2.length; j++) {}
    print(newList2[0][s]);

    return newList2[0][s];
    // return d1.format(DateTime.parse(convert(newList2[0][s])));
  }
}

class SlotModel {
  String? status;
  String? id;
  String? starttime;
  String? endtime;
  String? availableNo;
  String? slotisDaywise;
  String? slotstatus;
  String? slotid;
  String? slotprogramme;
  String? slotfromDate;
  String? slottoDate;
  String? slotslotType;

  SlotModel(
      {this.status,
      this.id,
      this.starttime,
      this.endtime,
      this.availableNo,
      this.slotisDaywise,
      this.slotstatus,
      this.slotid,
      this.slotprogramme,
      this.slotfromDate,
      this.slottoDate,
      this.slotslotType});
}

class OldResDataModel {
  String? id;
  String? reserveno;
  String? bookingDate;
  String? slotid;
  String? slotprogramid;
  String? programName;

  OldResDataModel({
    this.id,
    this.reserveno,
    this.bookingDate,
    this.slotid,
    this.slotprogramid,
    this.programName,
  });
}


 ///for furture reference please 
 ///
 /////important to reuse
                  // Padding(
                  //   padding: const EdgeInsets.all(6.0),
                  //   child: Row(
                  //     children: [
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "Recent Slots",
                  //             style:
                  //                 TextStyle(color: Colors.black, fontSize: 14),
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Container(
                  //               child: Column(children: [
                  //                 ClipRRect(
                  //                   borderRadius: BorderRadius.circular(4),
                  //                   child: Container(
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.end,
                  //                         children: [
                  //                           Text(
                  //                             getDate(
                  //                                     widget.state.items2!,
                  //                                     widget.state.items![
                  //                                             int.parse(
                  //                                                 widget.index)]
                  //                                         ['_id'],
                  //                                     'slotfromDate') +
                  //                                 " " +
                  //                                 "to",
                  //                             style: const TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 12,
                  //                             ),
                  //                           ),
                  //                           SizedBox(
                  //                             width: 2,
                  //                           ),
                  //                           Text(
                  //                             getDate(
                  //                                 widget.state.items2!,
                  //                                 widget.state.items![int.parse(
                  //                                     widget.index)]['_id'],
                  //                                 'slottoDate'),
                  //                             style: const TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 12,
                  //                             ),

                  //                             // d1.format(DateTime.parse(convert(
                  //                             //     widget.state.items2!
                  //                             //         .map((e) =>
                  //                             //             e['programme'] ==
                  //                             //             widget.state.items![int
                  //                             //                     .parse(widget
                  //                             //                         .index)]
                  //                             //                 ['_id'])
                  //                             //         .toString()
                  //                             //     // [0]
                  //                             //     //     ['slottoDate']

                  //                             //     ))),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     height:
                  //                         MediaQuery.of(context).size.height /
                  //                             26,
                  //                     width: MediaQuery.of(context).size.width /
                  //                         1.2,
                  //                     color: Colors.green,
                  //                   ),
                  //                 ),
                  //                 ClipRRect(
                  //                   borderRadius: BorderRadius.circular(4),
                  //                   child: Container(
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Row(
                  //                         children: [
                  //                           Text(
                  //                             getTime(
                  //                                     widget.state.items2!,
                  //                                     widget.state.items![
                  //                                             int.parse(
                  //                                                 widget.index)]
                  //                                         ['_id'],
                  //                                     'startTime') +
                  //                                 " " +
                  //                                 "PM" +
                  //                                 "-",
                  //                             style: TextStyle(
                  //                                 color: Colors.black,
                  //                                 fontSize: 12),
                  //                           ),
                  //                           Text(
                  //                             getTime(
                  //                                     widget.state.items2!,
                  //                                     widget.state.items![
                  //                                             int.parse(
                  //                                                 widget.index)]
                  //                                         ['_id'],
                  //                                     'endTime') +
                  //                                 " " +
                  //                                 "AM",
                  //                             style: TextStyle(
                  //                                 color: Colors.black,
                  //                                 fontSize: 12),
                  //                           ),
                  //                           Spacer(),
                  //                           Text(
                  //                             getTime(
                  //                                     widget.state.items2!,
                  //                                     widget.state.items![
                  //                                             int.parse(
                  //                                                 widget.index)]
                  //                                         ['_id'],
                  //                                     'availableNo') +
                  //                                 " " +
                  //                                 "Rooms Available",
                  //                             style: TextStyle(
                  //                                 color: Colors.black,
                  //                                 fontSize: 12),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     height:
                  //                         MediaQuery.of(context).size.height /
                  //                             29,
                  //                     width: MediaQuery.of(context).size.width /
                  //                         1.2,
                  //                     color: Colors.grey.shade300,
                  //                   ),
                  //                 ),
                  //               ]),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),