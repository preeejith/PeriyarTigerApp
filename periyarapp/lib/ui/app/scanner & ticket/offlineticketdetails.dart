import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:objectid/objectid.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/data/models/bookingdetails.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/datasync/offlineviewuploadid.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/widgets.dart' as pw;

class OfflineTicketDetails extends StatefulWidget {
  final List? ticketDetails,
      mainProgrammList,
      onlineTicketDetails,
      entanceList,
      vehiclesList;
  final bool? isOffline;
  final BookingDetails? onineMainProgrammList;
  final int? bookingLength;
  OfflineTicketDetails({
    this.isOffline,
    this.bookingLength,
    this.entanceList,
    this.vehiclesList,
    this.ticketDetails,
    this.onlineTicketDetails,
    this.onineMainProgrammList,
    this.mainProgrammList,
  });
  _OfflineTicketDetails createState() => _OfflineTicketDetails();
}

class _OfflineTicketDetails extends State<OfflineTicketDetails> {
  final tf = new DateFormat('MMMM dd yyyy');
  final f = new DateFormat('MMMM dd, yyyy');
  DatabaseHelper? db = DatabaseHelper.instance;
  String? ticketName;
  List<Map> listDetails = [];
  List termsAndConditions = [];
  List<Map> listVehicles = [];
  List<Widget> widgetS = [];
  List decodeProgramme = [], decodeDetails = [];
  @override
  void initState() {
    super.initState();
    loadBasicData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Previously Booked Ticket'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(
                  "assets/bgptrr.png",
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: new Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                booingDetails(context),
                SizedBox(
                  height: 15.0,
                ),
                _downloadTicket(context),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: Colors.white,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Column(
                  children: generateWidgets(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  booingDetails(BuildContext context) {
    return AppCard(
      outLineColor: HexColor('#292929'),
      color: HexColor('#292929'),
      child: new Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: new Row(
              children: [
                Expanded(
                  flex: 3,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text(
                              'Ticket Booked B',
                              style: StyleElements.bookingDetailsTitle,
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text('Ticket Number',
                                style: StyleElements.bookingDetailsTitle),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text(
                              // widget.ticketDetails![0]['name'].toString(),
                              "N/A",
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: widget.isOffline == true
                                ? Text(
                                    widget.ticketDetails![0]['ticketNo']
                                        .toString(),
                                  )
                                : Text(
                                    // widget.onineMainProgrammList![0].data!
                                    //     .payment!.ticket
                                    //     .toString(),
                                    'N/A'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text('Total Amount',
                                style: StyleElements.bookingDetailsTitle),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text('Payment Status',
                                style: StyleElements.bookingDetailsTitle),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: widget.isOffline == true
                                ? Text(
                                    "Rs. ${widget.ticketDetails![0]['total'].toString()}",
                                  )
                                : Text(
                                    "Rs. ${widget.onineMainProgrammList!.data!.payment!.total.toString()}",
                                    // ''
                                  ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text("Success"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: QrImage(
                    version: QrVersions.auto,
                    gapless: false,
                    backgroundColor: Colors.white,
                    data: widget.isOffline == true
                        ? widget.ticketDetails![0]['ticket']
                        : widget.onineMainProgrammList!.data!.payment!.ticket,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _downloadTicket(BuildContext context) {
    return AppCard(
      outLineColor: HexColor('#292929'),
      color: HexColor('#292929'),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Print Ticket"),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: Icon(
              Icons.print,
              size: 20,
            ),
            onPressed: () async {
              print("widget.isOffline " + widget.isOffline.toString());
              print(widget.ticketDetails.toString());
              print(widget.ticketDetails![0]['ticketPdf']);
              if (widget.ticketDetails![0]['ticketPdf'] != null ||
                  widget.ticketDetails![0]['ticketPdf'] != "null") {
                OpenFile.open(widget.ticketDetails![0]['ticketPdf']);
              }

              // widget.isOffline != false
              //     ? BlocProvider.of<BlocPrintTicket>(context).add(PrintTicket(
              //         ticketId: widget.onineMainProgrammList!.data!.payment!.id,
              //       ))
              //     // : generatePdf(context);
              //     : OpenFile.open(widget.ticketDetails![0]['ticketPdf']);
            },
          )
        ],
      ),
    );
  }

  generateWidgets(BuildContext context) {
    List<Widget> next = [];
    // print("the length ${widget.programme!.length.toString()}");
    if (widget.isOffline == true) {
      print("mainprogramm length ${widget.mainProgrammList!.length}");
      for (int i = 0; i < widget.mainProgrammList!.length; i++) {
        // print(widget.mainProgrammList![i]['programme']['progName']);
        decodeProgramme = jsonDecode(widget.mainProgrammList![i]['programme']);
        decodeDetails = jsonDecode(widget.mainProgrammList![i]['details']);
        print(decodeProgramme[0]['progName']);
        print("hello");
        // print(decodeDetails[i]['name']);
        next.add(Column(children: <Widget>[
          packageDetails(context, i),
          SizedBox(
            height: 10,
          ),
          guestId(context, i),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            color: Colors.white,
            thickness: 0.5,
          ),
          SizedBox(
            height: 5.0,
          ),
        ]));
      }
    } else {
      for (int i = 0;
          i < widget.onineMainProgrammList!.data!.details!.length;
          i++) {
        // print(widget.onineMainProgrammList!.data!.details![i].booking!.length
        //     .toString());

        next.add(Column(children: <Widget>[
          packageDetails(context, i),
          SizedBox(
            height: 10,
          ),
          guestId(context, i),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            color: Colors.white,
            thickness: 0.5,
          ),
          SizedBox(
            height: 5.0,
          ),
        ]));
      }
    }
    return next;
  }

  packageDetails(BuildContext context, int i) {
    return AppCard(
      outLineColor: HexColor('#292929'),
      color: HexColor('#292929'),
      child: new Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: new Row(
              children: [
                Expanded(
                  flex: 3,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text(
                              'Ticket Booked By',
                              style: StyleElements.bookingDetailsTitle,
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text('Total Persons',
                                style: StyleElements.bookingDetailsTitle),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text("N/A"),
                          ),
                          Expanded(
                            flex: 6,
                            child: widget.isOffline == true
                                ? Text(
                                    decodeDetails.length.toString(),
                                  )
                                : Text(
                                    widget.onineMainProgrammList!.data!
                                        .details![i].booking!.length
                                        .toString(),
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Text('Selected Date',
                                style: StyleElements.bookingDetailsTitle),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text('Selected Slot',
                                style: StyleElements.bookingDetailsTitle),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: widget.isOffline == true
                                ? Text(
                                    f.format(DateTime.parse(
                                      decodeDetails[i]['bookingDate']
                                          .toString(),
                                    ).toLocal()),
                                  )
                                : Text(
                                    f.format(DateTime.parse(
                                      widget.onineMainProgrammList!.data!
                                          .details![i].booking![0].bookingDate
                                          .toString(),
                                    ).toLocal()),
                                  ),
                          ),
                          Expanded(
                            flex: 6,
                            child: widget.isOffline == true
                                ? Text(
                                    decodeDetails[i]['startTime'].toString() +
                                        " - " +
                                        decodeDetails[i]['endTime'].toString())
                                : Text(widget.onineMainProgrammList!.data!
                                        .details![i].slotDetail!.startTime
                                        .toString() +
                                    " - " +
                                    widget.onineMainProgrammList!.data!
                                        .details![i].slotDetail!.endTime
                                        .toString()
                                        .toString()),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: new Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text('Package',
                                      style: StyleElements.bookingDetailsTitle),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: widget.isOffline == true
                                      ? Text(
                                          decodeProgramme[0]['progName']
                                              .toString(),
                                        )
                                      : Text(
                                          widget.onineMainProgrammList!.data!
                                              .details![i].programme!.progName
                                              .toString(),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  guestId(BuildContext context, int i) {
    var indianCount = 0, foreignerCount = 0, childrenCount = 0, idProofs = 0;
    if (widget.isOffline == true) {
      // for (int a = 0; a < widget.mainProgrammList![i]['details'].length; a++) {
      //   widget.mainProgrammList![i]['details'][a]['idProof'] != null
      //       ? idProofs = idProofs + 1
      //       : idProofs = idProofs;
      //   if (widget.mainProgrammList![i]['details'][a]['guestType'] ==
      //       "children") {
      //     childrenCount = childrenCount + 1;
      //   }
      //   if (widget.mainProgrammList![i]['details'][a]['guestType'] ==
      //       "indian") {
      //     indianCount = indianCount + 1;
      //   }
      //   if (widget.mainProgrammList![i]['details'][a]['guestType'] ==
      //       "foreigner") {
      //     foreignerCount = foreignerCount + 1;
      //   }
      // }
      for (int a = 0; a < decodeDetails.length; a++) {
        decodeDetails[a]['idProof'] != null
            ? idProofs = idProofs + 1
            : idProofs = idProofs;
        if (decodeDetails[a]['guestType'] == "children") {
          childrenCount = childrenCount + 1;
        }
        if (decodeDetails[a]['guestType'] == "indian") {
          indianCount = indianCount + 1;
        }
        if (decodeDetails[a]['guestType'] == "foreigner") {
          foreignerCount = foreignerCount + 1;
        }
      }
    } else {
      print(
          "the details length two ${widget.onineMainProgrammList!.data!.details!.length}");
      for (int a = 0;
          a < widget.onineMainProgrammList!.data!.details![i].guest!.length;
          a++) {
        widget.onineMainProgrammList!.data!.details![i].guest![a].idproofs !=
                null
            ? idProofs = idProofs + 1
            : idProofs = idProofs;
        if (widget
                .onineMainProgrammList!.data!.details![i].guest![a].guestType ==
            "children") {
          childrenCount = childrenCount + 1;
        }
        if (widget
                .onineMainProgrammList!.data!.details![i].guest![a].guestType ==
            "indian") {
          indianCount = indianCount + 1;
        }
        if (widget
                .onineMainProgrammList!.data!.details![i].guest![a].guestType ==
            "foreigner") {
          foreignerCount = foreignerCount + 1;
        }
      }
    }

    // }
    return new Container(
      padding:
          EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0, bottom: 20.0),
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        color: HexColor('#292929'),
        borderRadius: BorderRadius.circular(7),
        boxShadow: [BoxShadow(color: Colors.black)],
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: new Column(
              children: [
                new Row(
                  children: [
                    new Text('View All Guests'),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    indianCount > 0
                        ? Flexible(
                            child: Text(
                              'Indian X ' + indianCount.toString(),
                              style: StyleElements.bookingDetailsTitle,
                            ),
                          )
                        : SizedBox(),
                    foreignerCount > 0
                        ? Flexible(
                            child: Text(
                              'Foreigner X ' + foreignerCount.toString(),
                              style: StyleElements.bookingDetailsTitle,
                            ),
                          )
                        : SizedBox(),
                    childrenCount > 0
                        ? Flexible(
                            child: Text(
                              'Children X ' + childrenCount.toString(),
                              style: StyleElements.bookingDetailsTitle,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 30,
          ),
          new Column(
            children: [
              // widget.isOffline == true
              //     ? widget.bookingDetails!.data!.details![0].guest![0]
              //                 .idproofs !=
              //             null
              //         ?
              new GestureDetector(
                onTap: () async {
                  // idProofs > 0
                  //     ?
                  // Fluttertoast.showToast(msg: "Yes idproofs found")
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadGuestIdOffline(
                        isOffline: true,
                        mainProgrammList: widget.mainProgrammList,
                        decodeDetails: decodeDetails,
                        decodeProgramme: decodeProgramme,
                        indianCount: indianCount,
                        childrenCount: childrenCount,
                        foreignerCount: foreignerCount,
                        ticket: widget.ticketDetails![0]['ticket'],
                      ),
                    ),
                  );

                  // widget.isOffline == false
                  //     ? Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => UploadGuestIdOffline(
                  //             isOffline: widget.isOffline,
                  //             bookingDetails: widget.onineMainProgrammList,
                  //             indianCount: indianCount,
                  //             childrenCount: childrenCount,
                  //             foreignerCount: foreignerCount,
                  //           ),
                  //         ),
                  //       )
                  //     : Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => UploadGuestIdOffline(
                  //             isOffline: widget.isOffline,
                  //             mainProgrammList: widget.mainProgrammList,
                  //             decodeDetails: decodeDetails,
                  //             decodeProgramme: decodeProgramme,
                  //             indianCount: indianCount,
                  //             childrenCount: childrenCount,
                  //             foreignerCount: foreignerCount,
                  //             ticket: widget.ticketDetails![0]['ticket'],
                  //           ),
                  //         ),
                  //       );

                  // : Fluttertoast.showToast(msg: "No idproofs found");
                },
                child: new Container(
                  padding: EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: HexColor("#59AF74"), width: 1.0),
                  ),
                  child: Row(
                    children: [
                      new Text(
                        "View ID",
                        style: new TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      new Icon(
                        Icons.check_circle_outline,
                        size: 15.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  //thepdf
  generatePdf(BuildContext context) async {
    // List<Map> listVehicles = await getVehicleDetails();
    List<Map> listDetails = await generatePdfList();
    final font = await rootBundle.load("assets/times-new-roman.ttf");
    final ttf = pw.Font.ttf(font);
    final fontOne =
        await rootBundle.load("assets/times-new-roman-grassetto.ttf");
    final ttfBold = pw.Font.ttf(fontOne);
    final forestLogoBlack = pw.MemoryImage(
      (await rootBundle.load('assets/forest_logo_black.jpg'))
          .buffer
          .asUint8List(),
    );
    final foundationLogo2 = pw.MemoryImage(
      (await rootBundle.load('assets/foundation_logo_2.jpg'))
          .buffer
          .asUint8List(),
    );
    final logoTr2 = pw.MemoryImage(
      (await rootBundle.load('assets/logo_tr_2.jpg')).buffer.asUint8List(),
    );
    var ticketAndAmount = pw.TextStyle(
      font: ttfBold,
      fontSize: 12,
    );
    var titleAndEntrance = pw.TextStyle(
      font: ttfBold,
      fontSize: 10,
    );
    var header = pw.TextStyle(
      font: ttfBold,
      fontSize: 8,
    );
    var cell = pw.TextStyle(
      font: ttf,
      fontSize: 8,
    );
    var terms = pw.TextStyle(
      font: ttf,
      fontSize: 6,
    );

    var message = pw.TextStyle(
      font: ttf,
      fontSize: 6,
    );
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a5,
          margin: pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return <pw.Widget>[
              new pw.Column(children: <pw.Widget>[
                new pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.SizedBox(
                        height: 70.0,
                        width: 70.0,
                        child:
                            pw.Image(forestLogoBlack, fit: pw.BoxFit.contain),
                      ),
                      pw.SizedBox(
                        height: 70.0,
                        width: 70.0,
                        child:
                            pw.Image(foundationLogo2, fit: pw.BoxFit.contain),
                      ),
                      pw.SizedBox(
                        height: 90.0,
                        width: 150.0,
                        child: pw.Image(logoTr2, fit: pw.BoxFit.contain),
                      ),
                      pw.SizedBox(
                        height: 60.0,
                        width: 60.0,
                        child: pw.BarcodeWidget(
                          data: ticketName!,
                          barcode: pw.Barcode.qrCode(),
                        ),
                      ),
                    ]),
                new pw.SizedBox(height: 40.0),
                new pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      new pw.Text(
                        // "Ticket Number: 5000510",
                        "Ticket Number: #${widget.ticketDetails![0]['ticketNo'].toString()}",
                        // '',
                        style: ticketAndAmount,
                      ),
                      new pw.Text(
                        "Amount: Rs.${widget.ticketDetails![0]['total'].toString()}",
                        style: ticketAndAmount,
                      ),
                    ]),
                new pw.SizedBox(height: 20.0),

                new pw.ListView.builder(
                  itemBuilder: (context, index) {
                    return pw.Column(children: [
                      new pw.SizedBox(height: 20.0),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: <pw.Widget>[
                            new pw.Text(
                                jsonDecode(widget.mainProgrammList![index]
                                        ['programme'])![0]['progName']
                                    .toString(),
                                // '',
                                style: titleAndEntrance),
                          ]),
                      new pw.SizedBox(height: 10.0),
                      new pw.Table.fromTextArray(
                          headerAlignment: pw.Alignment.center,
                          cellAlignment: pw.Alignment.center,
                          headerStyle: header,
                          cellStyle: cell,
                          headers: [
                            'Name',
                            'Date of birth',
                            'Gender',
                            'Nationality',
                            'Booking Date',
                            'Slot'
                          ],
                          data: listDetails.map((e) {
                            return [
                              e['name'],
                              tf.format(DateTime.parse(e['dob'].toString())
                                  .toLocal()),
                              // e['dob'].toString(),
                              e['gender'],
                              e['nationality'],
                              tf.format(
                                  DateTime.parse(e['booking_date'].toString())
                                      .toLocal()),
                              // e['booking_date'].toString(),
                              e['slot'],
                            ];
                          }).toList()),
                    ]);
                  },
                  itemCount: widget.mainProgrammList!.length,
                ),

                //-----------------------------------------------------------------------

                // //-----------------------------------------------------------------------

                // new pw.SizedBox(height: 10.0),
                // new pw.Row(
                //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                //     children: <pw.Widget>[
                //       new pw.Text(
                //           "Notice (${f.format(DateTime.parse(jsonDecode(widget.mainProgrammList![0]['details'])![0]['bookingDate']).toLocal())})",
                //           // '',
                //           style: header),
                //     ]),
                // new pw.SizedBox(height: 5.0),
                // new pw.Row(
                //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                //     children: <pw.Widget>[
                //       new pw.Flexible(
                //         child: new pw.Text(
                //             "Minimum Participants required for conducting this program is 5 , for an amount of INR 6100. If the minimum slots are not filled up by the program date,"
                //             "you should pay an additional amount on arrival at the Reserve which shall extend up to a maximum of INR 3660. if you fail to pay the amount, you will not"
                //             "be able to avail the program and amount paid online shall be non refundable.",
                //             style: message),
                //       ),
                //     ]),
                // new pw.SizedBox(height: 10.0),
                widget.vehiclesList!.length == 0
                    ? pw.SizedBox.shrink()
                    : new pw.SizedBox(height: 10.0),

                widget.vehiclesList!.length == 0
                    ? pw.SizedBox.shrink()
                    : new pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: <pw.Widget>[
                            new pw.Text(
                              "Vehicle Information",
                              //nowhere
                              style: titleAndEntrance,
                            ),
                          ]),

                widget.vehiclesList!.length == 0
                    ? pw.SizedBox.shrink()
                    : new pw.SizedBox(height: 5.0),

                widget.vehiclesList!.length == 0
                    ? pw.SizedBox.shrink()
                    : pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: new pw.Table.fromTextArray(
                            tableWidth: pw.TableWidth.min,
                            headerAlignment: pw.Alignment.center,
                            cellAlignment: pw.Alignment.center,
                            headerStyle: header,
                            cellStyle: cell,
                            context: context,
                            headers: [
                              'Vehicle',
                              'Date',
                              'Charge',
                            ],
                            data: widget.vehiclesList!.map((e) {
                              return [
                                e['vehicle'],
                                tf.format(
                                    DateTime.parse(e['bookingDate'].toString())
                                        .toLocal()),
                                e['charge'].toString(),
                              ];
                            }).toList()),
                      ),

                widget.vehiclesList!.length == 0
                    ? pw.SizedBox.shrink()
                    : new pw.SizedBox(height: 10.0),

                new pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      new pw.Text(
                        "Entrance tickets",
                        //nowhere
                        style: titleAndEntrance,
                      ),
                    ]),
                new pw.SizedBox(height: 5.0),

                //-----------------------------------------------------------------------
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: new pw.Table.fromTextArray(
                      tableWidth: pw.TableWidth.min,
                      headerAlignment: pw.Alignment.center,
                      cellAlignment: pw.Alignment.center,
                      headerStyle: header,
                      cellStyle: cell,
                      context: context,
                      headers: [
                        'Guest',
                        'Date',
                        'Charge',
                      ],
                      data: widget.entanceList!.map((e) {
                        return [
                          e['guest'],
                          f.format(DateTime.parse(e['bookingDate'].toString())
                              .toLocal()),
                          // '',
                          e['charge'],
                        ];
                      }).toList()),
                ),
                //-----------------------------------------------------------------------

                new pw.SizedBox(height: 5.0),
                new pw.Column(
                  children: <pw.Widget>[
                    new pw.Row(
                      children: [
                        new pw.Text(
                            "*This is not a valid ticket. This ticket is generated under test environment. Money is not deducted from your account. Booking will be enabled soon",
                            style: message),
                      ],
                    ),
                    new pw.Row(
                      children: [
                        new pw.Text(
                          "*This is an auto generated ticket",
                          style: message,
                        ),
                      ],
                    ),
                    new pw.Row(
                      children: [
                        new pw.Text(
                          "*Helpline number: +91 94963 33873",
                          style: message,
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            ];
            // return pw.Center(
            //   child: pw.Image(forestLogoBlack),
            // );
          }),
    );
    pdf.addPage(
      pw.MultiPage(
          // maxPages: 10000,
          pageFormat: PdfPageFormat.a5,
          margin: pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Column(children: <pw.Widget>[
                new pw.Row(children: [
                  new pw.Text(
                    'Terms & Conditions',
                    style: terms,
                  )
                ]),
                pw.SizedBox(height: 20.0),
                new pw.Text(
                  termsAndConditions[0]['tcValue'],
                  // '',
                  // termsAndCondtions[0]['tcValue'],
                  style: terms,
                ),
                // pw.Html(
                //   data: tcValue,
                // )
              ])
            ];
          }),
    );
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a5,
          margin: pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Column(children: <pw.Widget>[
                new pw.Row(children: [
                  new pw.Text(
                    'Booking & Cancellation Policy',
                    style: terms,
                  )
                ]),
                pw.SizedBox(height: 20.0),
                new pw.Row(children: [
                  new pw.Flexible(
                    child: new pw.Text(
                      termsAndConditions[0]['canValue'],
                      // '',
                      style: terms,
                    ),
                  ),
                ])
              ])
            ];
          }),
    );

    ticketName = "ticket_" + ObjectId().toString() + ".pdf";
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    File file = File(appDocumentsPath + "/" + ticketName.toString());
    await file.writeAsBytes(await pdf.save());

    try {
      await OpenFile.open(file.path);
      print("opening file ${file.path}");
    } catch (e) {
      print(e.toString());
    }
  }

  void loadBasicData(BuildContext context) async {
    termsAndConditions = await db!.getTermsAndConditionsOffline();
  }

  generatePdfList() {
    listDetails.clear();
    print("the length ${widget.mainProgrammList!.length}");
    print("the list ${widget.mainProgrammList![0]['details'].runtimeType}");
    for (int i = 0; i < widget.mainProgrammList!.length; i++) {
      List theMainList = jsonDecode(widget.mainProgrammList![i]['details']);
      for (int d = 0; d < theMainList.length; d++) {
        print(theMainList[d]['name'].toString());
        listDetails.add({
          "name": theMainList[d]['name'].toString(),
          "dob": theMainList[d]['dob'].toString(),
          "gender": 'N/A',
          "eTicket": 'N/A',
          "nationality": 'N/A',
          'booking_date': theMainList[d]['bookingDate'].toString(),
          // DateTime.parse(state.bookingSummary![0]['bookingDate'].toString())
          //     .toLocal(),
          'slot': theMainList[d]['startTime'].toString() +
              " - " +
              theMainList[d]['endTime'].toString(),
        });
      }
    }
    print(listDetails);
    return listDetails;
  }

  // getVehicleDetails() {
  //   widget.vehiclesList!.clear();
  //   for (int i = 0; i < widget.mainProgrammList!.length; i++) {
  //     print(widget.mainProgrammList![i]['vehicles'].length);
  //     // List widget.vehiclesList! = widget.mainProgrammList![i]['vehicles'];
  //     // widget.vehiclesList!.forEach((element) {
  //     //   print(element);
  //     // });
  //     for (int v = 0; v < widget.mainProgrammList![i]['vehicles'].length; v++) {
  //       widget.vehiclesList!.add({
  //         "vehicle": widget.mainProgrammList![i]['vehicles'][v]['vehicle'],
  //         "charge": widget.mainProgrammList![i]['vehicles'][v]['charge'],
  //         "date": widget.mainProgrammList![i]['vehicles'][v]['bookingDate'],
  //       });
  //     }
  //   }
  //   return widget.vehiclesList!;
  // }
}
