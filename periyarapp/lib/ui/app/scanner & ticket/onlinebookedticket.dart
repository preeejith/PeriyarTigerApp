import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:html/parser.dart' show parse;
// import 'package:html/dom.dart' as dom;
import 'package:open_file_safe/open_file_safe.dart';
import 'package:intl/intl.dart';

import 'package:parambikulam/bloc/busbloc/busbloc.dart';
import 'package:parambikulam/bloc/finalbooking/blocfinalbooking.dart';
import 'package:parambikulam/bloc/finalbooking/eventfinalbooking.dart';
import 'package:parambikulam/bloc/finalbooking/statefinalbooking.dart';
import 'package:parambikulam/bloc/printticket/blocprintticket.dart';
import 'package:parambikulam/bloc/printticket/eventpticket.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/data/models/bookingdetails.dart';
import 'package:parambikulam/data/models/busmodel.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/booking/uploadguestid.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OnlineBookedTicket extends StatefulWidget {
  final List? theResult;
  final String? ticketId;
  final BookingDetails? bookingDetails;
  final List<Map>? programmList;
  final bool? isOffline, isCottage, previousBooked;
  final OfflineBooking? offlineBooking;
  OnlineBookedTicket({
    this.theResult,
    required this.ticketId,
    this.previousBooked,
    this.bookingDetails,
    this.isOffline,
    this.programmList,
    this.isCottage,
    this.offlineBooking,
  });
  _OnlineBookedTicket createState() => _OnlineBookedTicket();
}

class _OnlineBookedTicket extends State<OnlineBookedTicket> {
  final f = new DateFormat('MMMM dd, yyyy');
  final tf = new DateFormat('MMMM dd yyyy');
  DatabaseHelper? db = DatabaseHelper.instance;
  List termsAndConditions = [];
  List<Map> listDetails = [];
  List<Map> listVehicles = [];
  bool? isOpened = false;
  // String? ticketName;
  int? ticketNumber;
  @override
  void initState() {
    // print(widget.previousBooked);
    // print('isOffline ${widget.isOffline}');
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.bookingDetails!.data);
    // print(widget.bookingDetails!.data!.details![0].booking![0].bookingDate
    //     .toString());
    return BlocConsumer<BlocFinalBooking, StateFinalBooking>(
      builder: (context, state) {
        if (state is SummaryGenerated) {
          return Scaffold(
            appBar: new AppBar(
              title: new Text('Online Booked Ticket'),
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
              child: new SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      booingDetails(context, state),
                      SizedBox(
                        height: 15.0,
                      ),
                      guestId(context, state),
                      SizedBox(
                        height: 15.0,
                      ),
                      billSummary(context, state),
                      SizedBox(
                        height: 15.0,
                      ),
                      // shareTicket(context, state),
                      // SizedBox(
                      //   height: 15.0,
                      // ),
                      _downloadTicket(context, state),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(
            child: SafeArea(
              child: Scaffold(
                body: new Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
          );
        }
      },
      listener: (context, state) {},
    );
  }

  booingDetails(BuildContext context, SummaryGenerated state) {
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
                            child: widget.isOffline == false
                                ? widget.bookingDetails!.data!.payment!.name !=
                                        null
                                    ? Text(widget
                                        .bookingDetails!.data!.payment!.name
                                        .toString())
                                    : Text("N/A")
                                : Text("N/A"),
                          ),
                          Expanded(
                              flex: 6,
                              child: widget.isOffline == false
                                  ? Text(widget.bookingDetails!.data!
                                      .details![0].guest!.length
                                      .toString())
                                  : widget.previousBooked == false
                                      ? Text((state.bookingSummary![0]
                                                  ['indianCount'] +
                                              state.bookingSummary![0]
                                                  ['childrenCount'] +
                                              state.bookingSummary![0]
                                                  ['foreignerCount'])
                                          .toString())
                                      : Text(
                                          widget.theResult!.length.toString())
                              // Text(''),
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
                            // state.bookingDetails!.data!.details![0]
                            //     .booking![0].bookingDate
                            //     .toString()
                            child: widget.isOffline == false
                                ? Text(
                                    f.format(DateTime.parse(widget
                                            .bookingDetails!
                                            .data!
                                            .details![0]
                                            .booking![0]
                                            .bookingDate
                                            .toString())
                                        .toLocal()),
                                  )
                                : widget.previousBooked == false
                                    ?

                                    // widget.bookingDetails!.data!.details![0]
                                    //     .booking![0].bookingDate
                                    //     .toString())
                                    Text(
                                        f.format(DateTime.parse(state
                                                .bookingSummary![0]
                                                    ['bookingDate']
                                                .toString())
                                            .toLocal()),
                                        // state.bookingSummary![0]['bookingDate']
                                        //     .toString(),
                                      )
                                    : Text('prev'),
                            // child: Text('date'),
                          ),
                          Expanded(
                            flex: 6,
                            child: widget.isOffline == false
                                ? Text(widget.bookingDetails!.data!.details![0]
                                        .slotDetail!.startTime
                                        .toString() +
                                    " - " +
                                    widget.bookingDetails!.data!.details![0]
                                        .slotDetail!.endTime
                                        .toString())
                                : widget.previousBooked == false
                                    ? Text(state.bookingSummary![0]['endTime']
                                            .toString() +
                                        " - " +
                                        state.bookingSummary![0]['endTime']
                                            .toString())
                                    : Text("pre"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: QrImage(
                      version: QrVersions.auto,
                      // size: 200.0,
                      gapless: false,
                      // size: 100.0,
                      // padding: EdgeInsets.all(12),
                      backgroundColor: Colors.white,
                      data: widget.isOffline == false
                          ? 'http://api.parambikulam.org/booking/ticketbyticketpdf?id=' +
                              widget.bookingDetails!.data!.details![0]
                                  .booking![0].ticket
                                  .toString()
                          : widget.previousBooked == false
                              ? 'http://api.parambikulam.org/booking/ticketbyticketpdf?id=' +
                                  state.bookingSummary![0]['ticketId']
                                      .toString()
                              : widget.theResult![0]['paymentTicket']),
                ),
                //
                // Image.network(
                //   'https://www.parambikulam.org/booking/ticketbyticketpdf?id=60e4194848ff4cd8500974fc',
                //   fit: BoxFit.contain,
                //   width: 50.0,
                // )
              ],
            ),
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
                        child: widget.isOffline == false
                            ? Text(
                                widget.bookingDetails!.data!.details![0]
                                    .programme!.progName
                                    .toString(),
                              )
                            : widget.previousBooked == false
                                ? Text(
                                    state.bookingSummary![0]['title']
                                        .toString(),
                                  )
                                : Text(widget.theResult![0]['bookingProgName']
                                    .toString())
                        // : Text(''),
                        ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  guestId(BuildContext context, SummaryGenerated state) {
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
        children: [
          Expanded(
            child: new Column(
              children: [
                new Row(
                  children: [
                    new Text('Upload Guest ID'),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                new Row(
                  children: [
                    widget.isOffline == false
                        ? widget.bookingDetails!.data!.details![0].indian! > 0
                            ? Expanded(
                                flex: 2,
                                child: Text(
                                  'Indian Adult X ' +
                                      widget.bookingDetails!.data!.details![0]
                                          .indian
                                          .toString(),
                                  style: StyleElements.bookingDetailsTitle,
                                ))
                            : SizedBox()
                        : widget.previousBooked == false
                            ? state.bookingSummary![0]['indianCount'] > 0
                                ? Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Indian Adult  X ' +
                                          state.bookingSummary![0]
                                                  ['indianCount']
                                              .toString(),
                                      style: StyleElements.bookingDetailsTitle,
                                    ),
                                  )
                                : SizedBox.shrink()
                            : Text("pre"),
                    widget.isOffline == false
                        ? widget.bookingDetails!.data!.details![0].children! > 0
                            ? Expanded(
                                flex: 1,
                                child: Text(
                                  'Children X ' +
                                      widget.bookingDetails!.data!.details![0]
                                          .children
                                          .toString(),
                                  style: StyleElements.bookingDetailsTitle,
                                ))
                            : SizedBox()
                        : widget.previousBooked == false
                            ? state.bookingSummary![0]['childrenCount'] > 0
                                ? Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Children X ' +
                                          state.bookingSummary![0]
                                                  ['childrenCount']
                                              .toString(),
                                      style: StyleElements.bookingDetailsTitle,
                                    ),
                                  )
                                : SizedBox.shrink()
                            : Text("pre"),
                    widget.isOffline == false
                        ? widget.bookingDetails!.data!.details![0].foreigner! >
                                0
                            ? Expanded(
                                flex: 2,
                                child: Text(
                                  'Foreigner X ' +
                                      widget.bookingDetails!.data!.details![0]
                                          .foreigner
                                          .toString(),
                                  style: StyleElements.bookingDetailsTitle,
                                ),
                              )
                            : SizedBox.shrink()
                        : widget.previousBooked == false
                            ? state.bookingSummary![0]['foreignerCount'] > 0
                                ? Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Foreigner X ' +
                                          state.bookingSummary![0]
                                                  ['foreignerCount']
                                              .toString(),
                                      style: StyleElements.bookingDetailsTitle,
                                    ),
                                  )
                                : SizedBox.shrink()
                            : Text("pre"),
                  ],
                ),
              ],
            ),
          ),
          new Column(
            children: [
              widget.isOffline == false
                  ? widget.bookingDetails!.data!.details![0].guest![0]
                              .idproofs !=
                          null
                      ? new GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadGuestId(
                                  bookingDetails: widget.bookingDetails,
                                  isOffline: widget.isOffline,
                                ),
                              ),
                            );
                          },
                          child: new Container(
                            padding: EdgeInsets.only(
                                left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: HexColor("#59AF74"), width: 1.0),
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
                      : new GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadGuestId(
                                  bookingDetails: widget.bookingDetails,
                                  isOffline: widget.isOffline,
                                ),
                              ),
                            );
                            // Fluttertoast.showToast(msg: 'icon right');
                          },
                          // child: new Icon(Icons.arrow_right_alt, size: 20.0),
                          child: new Container(
                            padding: EdgeInsets.only(
                                left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: HexColor("#59AF74"), width: 1.0),
                            ),
                            child: Row(
                              children: [
                                new Text(
                                  "Verify",
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
                  : new GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //herecheck
                            builder: (context) => UploadGuestId(
                              bookingDetails: widget.bookingDetails,
                              isOffline: widget.isOffline,
                              offlineData: state.bookingSummary,
                            ),
                          ),
                        );
                      },
                      child: new Container(
                        padding: EdgeInsets.only(
                            left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: HexColor("#59AF74"), width: 1.0),
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

  billSummary(BuildContext context, SummaryGenerated state) {
    return Container(
      padding:
          EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0, bottom: 20.0),
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        color: HexColor('#292929'),
        borderRadius: BorderRadius.circular(7),
        boxShadow: [BoxShadow(color: Colors.black)],
      ),
      child: new Container(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  new Row(
                    children: [
                      new Text(
                        'Bill Summary',
                        style: StyleElements.bookingDetailsTitle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  widget.isOffline == false
                      ? widget.bookingDetails!.data!.details![0].indian! > 0
                          ? new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Indian Adult X ' +
                                        widget.bookingDetails!.data!.details![0]
                                            .indian
                                            .toString(),
                                  ),
                                ),
                                new Text(widget.bookingDetails!.data!
                                    .details![0].indianTotal
                                    .toString()),
                              ],
                            )
                          : SizedBox.shrink()
                      : state.bookingSummary![0]['indianCount'] > 0
                          ? new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Indian Adult X ' +
                                        state.bookingSummary![0]['indianCount']
                                            .toString(),
                                  ),
                                ),
                                new Text(state.bookingSummary![0]['indianTotal']
                                    .toString()),
                              ],
                            )
                          : SizedBox.shrink(),
                  SizedBox(
                    height: 10.0,
                  ),
                  widget.isOffline == false
                      ? widget.bookingDetails!.data!.details![0].children! > 0
                          ? new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Children X ' +
                                        widget.bookingDetails!.data!.details![0]
                                            .children
                                            .toString(),
                                  ),
                                ),
                                new Text(widget.bookingDetails!.data!
                                    .details![0].childrenTotal
                                    .toString()),
                              ],
                            )
                          : SizedBox()
                      : state.bookingSummary![0]['childrenCount'] > 0
                          ? new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Children X ' +
                                      state.bookingSummary![0]['childrenCount']
                                          .toString(),
                                ),
                                new Text(state.bookingSummary![0]
                                        ['childrenTotal']
                                    .toString()),
                              ],
                            )
                          : SizedBox(),
                  SizedBox(
                    height: 10.0,
                  ),
                  widget.isOffline == false
                      ? widget.bookingDetails!.data!.details![0].foreigner! > 0
                          ? new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Foreigner X ' +
                                      widget.bookingDetails!.data!.details![0]
                                          .foreigner
                                          .toString(),
                                ),
                                new Text(widget.bookingDetails!.data!
                                    .details![0].foreignerTotal
                                    .toString()),
                              ],
                            )
                          : SizedBox()
                      : state.bookingSummary![0]['foreignerCount'] > 0
                          ? new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Foreigner X ' +
                                      state.bookingSummary![0]['foreignerCount']
                                          .toString(),
                                ),
                                new Text(state.bookingSummary![0]
                                        ['foreignerTotal']
                                    .toString()),
                              ],
                            )
                          : SizedBox(),
                  Divider(
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  new Row(
                    children: [
                      new Text("Total"),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.isOffline == false
                          ? widget.bookingDetails!.data!.details![0].guest!
                                      .length >
                                  1
                              ? new Text(
                                  (widget.bookingDetails!.data!.details![0]
                                          .guest!.length
                                          .toString() +
                                      ' Persons'),
                                )
                              : new Text(
                                  (widget.bookingDetails!.data!.details![0]
                                          .guest!.length
                                          .toString() +
                                      ' Person'),
                                )
                          : state.bookingSummary![0]['indianCount'] +
                                      state.bookingSummary![0]
                                          ['childrenCount'] +
                                      state.bookingSummary![0]
                                          ['foreignerCount'] >
                                  1
                              ? new Text(
                                  ((state.bookingSummary![0]['indianCount'] +
                                              state.bookingSummary![0]
                                                  ['childrenCount'] +
                                              state.bookingSummary![0]
                                                  ['foreignerCount'])
                                          .toString() +
                                      ' Persons'),
                                )
                              : new Text(
                                  ((state.bookingSummary![0]['indianCount'] +
                                              state.bookingSummary![0]
                                                  ['childrenCount'] +
                                              state.bookingSummary![0]
                                                  ['foreignerCount'])
                                          .toString() +
                                      ' Person'),
                                ),
                      widget.isOffline == false
                          ? new Text(
                              widget.bookingDetails!.data!.payment!.total
                                      .toString() +
                                  " INR",
                            )
                          : new Text(state.bookingSummary![0]['totalAmount']
                                  .toString() +
                              " INR"),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Icon(
                        Icons.check_circle_outline,
                        size: 20.0,
                        color: HexColor('#069B56'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      widget.isOffline == false
                          ? widget.bookingDetails!.data!.payment!.type ==
                                  "Counter"
                              ? new Text(
                                  'Amount paid offline',
                                  style: TextStyle(
                                    color: HexColor('#069B56'),
                                  ),
                                )
                              : new Text(
                                  'Amount paid online',
                                  style: TextStyle(
                                    color: HexColor('#069B56'),
                                  ),
                                )
                          : new Text(
                              'Amount paid offline',
                              style: TextStyle(
                                color: HexColor('#069B56'),
                              ),
                            ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _downloadTicket(BuildContext context, SummaryGenerated state) {
    return AppCard(
      outLineColor: HexColor('#292929'),
      color: HexColor('#292929'),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              // for (int index = 0;
              //     index < context.read<BusBloc>().busAllocated.length;
              //     index++) {
              //   print(index);
              //   context
              //       .read<BusBloc>()
              //       .busAllocated[index]
              //       .busDetails!
              //       .tickets!
              //       .add(
              //         Tickets(
              //           ticketId: widget.ticketId,
              //           numberOfMembers: context
              //               .read<BlocFinalBooking>()
              //               .membersInTicket
              //               .toString(),
              //         ),
              //       );
              // }
              // print();
              //thepdf
              // generatePdf(state, ticketName);
              // print("offline ${widget.isOffline}");
              // print("isOpened $isOpened");
              //---------------------------------------------------------------------
              if (widget.isOffline == true) {
                print(state.bookingSummary![0]['ticketId'].toString());
                print("offline");
                // if (isOpened == false) {
                var status = await Permission.storage.status;
                print(status);
                if (status == PermissionStatus.denied) {
                  await Permission.storage.request();
                  status = await Permission.storage.status;
                  print("now the status is + " + status.toString());
                }
                _showToast(
                    context, "File opening, please wait", Toast.LENGTH_SHORT);
                generatePdf(state, '${widget.ticketId!}.pdf');
                // } else {
                //   var status = await Permission.storage.status;
                //   print(status);
                //   if (status == PermissionStatus.denied) {
                //     await Permission.storage.request();
                //     status = await Permission.storage.status;
                //     print("now the status is + " + status.toString());
                //   }
                //   _showToast(
                //       context, "File opening, please wait", Toast.LENGTH_SHORT);
                //   print(status);
                //   Directory appDocumentsDirectory =
                //       await getApplicationDocumentsDirectory();
                //   String appDocumentsPath = appDocumentsDirectory.path;
                //   File file =
                //       File(appDocumentsPath + "/" + ticketName.toString());
                //   _showToast(
                //       context, "File opening, please wait", Toast.LENGTH_SHORT);
                //   await OpenFile.open(file.path);
                // }
              } else {
                print("online");
                BlocProvider.of<BlocPrintTicket>(context).add(PrintTicket(
                    ticketId:
                        widget.bookingDetails!.data!.payment!.id.toString()));
              }
              //---------------------------------------------------------------------

              // getTicketNumber();
              // generatePdfList(state);
              // BlocProvider.of<BlocFinalBooking>(context)
              //     .add(GenerateSummary(db, widget.offlineBooking));

              //---------------------------------------------------------------------

              // getTicketNumber();
              // generatePdfList(state);
              // BlocProvider.of<BlocFinalBooking>(context)
              //     .add(GenerateSummary(db, widget.offlineBooking));
            },
          )
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String s, Toast length) {
    Fluttertoast.showToast(
      toastLength: length,
      msg: s,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }

  Future<void> checkStatus() async {
    //
    // if (widget.isOffline == true) {
    // if (widget.previousBooked == false) {
    print("ticket offline view");
    termsAndConditions = await db!.getTermsAndConditionsOffline();
    await getTicketNumber();
    print("below can value");
    print(termsAndConditions[0]['canValue']);

    BlocProvider.of<BlocFinalBooking>(context).add(GenerateSummary(
        db: db,
        offlineBooking: widget.offlineBooking,
        isOffline: widget.isOffline,
        previousBooked: widget.previousBooked));
    // } else {
    //   print("here else");
    //   BlocProvider.of<BlocFinalBooking>(context).add(GenerateSummary(
    //     isOffline: widget.isOffline,
    //     previousBooked: widget.previousBooked,
    //   ));
    // }
    // } else {
    //   print("here else else");
    //   print(widget.bookingDetails!.data);
    //   print(widget.bookingDetails!.data!.details![0].booking![0].bookingDate
    //       .toString());
    //   print("ticket online view");
    //   print(widget.bookingDetails!.data!.details![0].booking![0].bookingDate
    //       .toString());
    //   BlocProvider.of<BlocFinalBooking>(context).add(GenerateSummary(
    //     isOffline: widget.isOffline,
    //   ));
    //   print("------------------");
    // }
  }

  Future<void> generatePdf(SummaryGenerated state, String? ticketName) async {
    print(state.bookingSummary![0]['ticketId'].toString());
    print("started");
    List<Map> listVehicles = [];
    List<Map> listEntranceTickets = await generatePdfList(state);
    if (widget.offlineBooking!.vehicleList != null) {
      listVehicles = await getVehicleData();
    }

    print("the length is $listEntranceTickets");
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
    // final kfd = pw.MemoryImage(
    //   (await rootBundle.load('assets/kfd.png')).buffer.asUint8List(),
    // );
    // final kfdc = pw.MemoryImage(
    //   (await rootBundle.load('assets/kfdc.jpg')).buffer.asUint8List(),
    // );
    final logoTr2 = pw.MemoryImage(
      (await rootBundle.load('assets/logo_tr_2.jpg')).buffer.asUint8List(),
    );
    // final logoTr = pw.MemoryImage(
    //   (await rootBundle.load('assets/logo_tr.jpg')).buffer.asUint8List(),
    // );
    // final qrImage = pw.MemoryImage(
    //   (await rootBundle.load('assets/qr_image.png')).buffer.asUint8List(),
    // );
    print(termsAndConditions[0]['tcValue']);

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
    var terms = pw.TextStyle(font: ttf, fontSize: 6);

    var message = pw.TextStyle(font: ttf, fontSize: 6, height: 0.5);
    final pdf = pw.Document();
    // Test? test;
    // print(test!.tc.toString());
    // dom.Document tcValue = parse(termsAndCondtions[0]['tcValue']);
    // final String parsedtcValue =
    //     parse(tcValue.body!.text).documentElement!.text;
    // final canValue = parse(termsAndCondtions[0]['canValue']);
    // final String parsedcanValue =
    //     parse(canValue.body!.text).documentElement!.text;
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
                          data:
                              'http://api.parambikulam.org/booking/ticketbyticketpdf?id=' +
                                  state.bookingSummary![0]['ticketId']
                                      .toString(),
                          barcode: pw.Barcode.qrCode(),
                        ),
                      ),
                    ]),
                new pw.SizedBox(height: 40.0),
                new pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      new pw.Text(
                        "Ticket Number: #${ticketNumber.toString()}",
                        style: ticketAndAmount,
                      ),
                      new pw.Text(
                        "Amount: Rs.${state.bookingSummary![0]['totalAmount'].toString()}",
                        style: ticketAndAmount,
                      ),
                    ]),
                new pw.SizedBox(height: 30.0),
                widget.isCottage!
                    ? new pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: <pw.Widget>[
                            new pw.Text(
                                'Room data: ${widget.offlineBooking!.roomCount} room(s)',
                                style: titleAndEntrance),
                          ])
                    : pw.SizedBox.shrink(),
                new pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      new pw.Text(state.bookingSummary![0]['title'].toString(),
                          style: titleAndEntrance),
                    ]),
                new pw.SizedBox(height: 10.0),

                //-----------------------------------------------------------------------
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
                    data: listEntranceTickets.map((e) {
                      return [
                        e['name'],
                        tf.format(
                            DateTime.parse(e['dob'].toString()).toLocal()),
                        // e['dob'].toString(),
                        e['gender'],
                        e['nationality'],
                        tf.format(DateTime.parse(e['booking_date'].toString())
                            .toLocal()),
                        // e['booking_date'].toString(),
                        e['slot'],
                      ];
                    }).toList()),
                //-----------------------------------------------------------------------

                new pw.SizedBox(height: 10.0),
                new pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      new pw.Text(
                          "Notice (${f.format(DateTime.parse(state.bookingSummary![0]['bookingDate'].toString()).toLocal())})",
                          // '',
                          style: header),
                    ]),
                new pw.SizedBox(height: 5.0),
                new pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      new pw.Flexible(
                        child: new pw.Text(
                            "Minimum Participants required for conducting this program is 5 , for an amount of INR 6100. If the minimum slots are not filled up by the program date,"
                            "you should pay an additional amount on arrival at the Reserve which shall extend up to a maximum of INR 3660. if you fail to pay the amount, you will not"
                            "be able to avail the program and amount paid online shall be non refundable.",
                            style: message),
                      ),
                    ]),
                new pw.SizedBox(height: 10.0),

                widget.offlineBooking!.vehicleList == null
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

                widget.offlineBooking!.vehicleList == null
                    ? pw.SizedBox.shrink()
                    : new pw.SizedBox(height: 5.0),

                widget.offlineBooking!.vehicleList == null
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
                            data: listVehicles.map((e) {
                              return [
                                e['vName'],
                                tf.format(DateTime.parse(e['vDate'].toString())
                                    .toLocal()),
                                // e['vDate'].toString(),
                                e['vCharge'].toString(),
                              ];
                            }).toList()),
                      ),

                widget.offlineBooking!.vehicleList == null
                    ? pw.SizedBox.shrink()
                    : new pw.SizedBox(height: 10.0),

                // new pw.Row(
                //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                //     children: <pw.Widget>[
                //       new pw.Text(
                //         "Entrance tickets",
                //         //nowhere
                //         style: titleAndEntrance,
                //       ),
                //     ]),
                // new pw.SizedBox(height: 5.0),

                //-----------------------------------------------------------------------
                // pw.Align(
                //   alignment: pw.Alignment.centerLeft,
                //   child: new pw.Table.fromTextArray(
                //       tableWidth: pw.TableWidth.min,
                //       headerAlignment: pw.Alignment.center,
                //       cellAlignment: pw.Alignment.center,
                //       headerStyle: header,
                //       cellStyle: cell,
                //       context: context,
                //       headers: [
                //         'Guest',
                //         'Date',
                //         'Charge',
                //       ],
                //       data: listEntranceTickets.map((e) {
                //         return [
                //           e['name'],

                //           f.format(DateTime.parse(e['booking_date'].toString())
                //               .toLocal()),
                //           // state.bookingSummary![0]['bookingDate'].toString(),
                //           e['eTicket'],
                //         ];
                //       }).toList()),
                // ),
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

    // pdf.addPage(
    //   pw.MultiPage(
    //       crossAxisAlignment: pw.CrossAxisAlignment.start,
    //       pageFormat: PdfPageFormat.a5,
    //       margin: pw.EdgeInsets.all(20),
    //       build: (context) {
    //         return <pw.Widget>[
    //           pw.Column(
    //               mainAxisSize: pw.MainAxisSize.max,
    //               children: <pw.Widget>[
    //                 new pw.Row(children: [
    //                   new pw.Text(
    //                     'Terms & Conditions',
    //                     style: terms,
    //                   )
    //                 ]),
    //                 pw.SizedBox(height: 20.0),
    //                 // new pw.Row(children: [

    //                 // ])
    //                 // new pw.Flexible(
    //                 //   child:
    //                 // ),
    //                 pw.Container(
    //                   child: new pw.Text(
    //                     termsAndConditions[0]['tcValue'],
    //                     style: terms,
    //                   ),
    //                 ),
    //               ])
    //         ];
    //       }),
    // );
    // pdf.addPage(
    //   pw.MultiPage(
    //       crossAxisAlignment: pw.CrossAxisAlignment.start,
    //       pageFormat: PdfPageFormat.a5,
    //       margin: pw.EdgeInsets.all(20),
    //       build: (pw.Context context) {
    //         return <pw.Widget>[
    //           pw.Column(
    //               mainAxisSize: pw.MainAxisSize.max,
    //               children: <pw.Widget>[
    //                 new pw.Row(children: [
    //                   new pw.Text(
    //                     'Booking & Cancellation Policy',
    //                     style: terms,
    //                   )
    //                 ]),
    //                 pw.SizedBox(height: 20.0),
    //                 // new pw.Row(children: [

    //                 // ])
    //                 // new pw.Flexible(
    //                 //   child:
    //                 // ),
    //                 pw.Container(
    //                   child: new pw.Text(
    //                     termsAndConditions[0]['canValue'],
    //                     style: terms,
    //                   ),
    //                 ),
    //                 // new pw.Text(
    //                 //   termsAndConditions[0]['canValue'],
    //                 //   style: terms,
    //                 // ),
    //               ])
    //         ];
    //       }),
    // );

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
    setState(() {
      isOpened = true;
    });
    // print(file.path);
    // print(appDocumentsPath);
  }

  generatePdfList(SummaryGenerated state) {
    listDetails.clear();
    for (int i = 0; i < widget.offlineBooking!.newListTwo.length; i++) {
      listDetails.add({
        "name": widget.offlineBooking!.newListTwo[i]['name'].toString(),
        "dob": widget.offlineBooking!.newListTwo[i]['dob'].toString(),
        "gender": 'N/A',
        "eTicket": widget.offlineBooking!.newListTwo[i]['eTicket'].toString(),
        "nationality": 'N/A',
        'booking_date': state.bookingSummary![0]['bookingDate'].toString(),
        // DateTime.parse(state.bookingSummary![0]['bookingDate'].toString())
        //     .toLocal(),
        'slot': state.bookingSummary![0]['startTime'].toString() +
            " - " +
            state.bookingSummary![0]['endTime'].toString(),
      });
      print(
          "${widget.offlineBooking!.newListTwo[i]['name'].toString()}+${widget.offlineBooking!.newListTwo[i]['dob'].toString()}+${state.bookingSummary![0]['startTime'].toString()}");
    }
    return listDetails;
  }

  getTicketNumber() async {
    List<BusData> busAllocated = context.read<BusBloc>().busAllocated;
    for (int index = 0; index < busAllocated.length; index++) {
      await db!.saveToBusAllocationTable(busAllocated[index], widget.ticketId!);
    }
    List allocationData = await db!.getAllocationData();
    print(allocationData);

    // for (int index = 0;
    //     index < context.read<BusBloc>().busAllocated.length;
    //     index++) {
    //   print(
    //       'Bus id - ${context.read<BusBloc>().busAllocated[index].busDetails!.busId}');
    //   // var data = await db!.getBusId(
    //   //     context.read<BusBloc>().busAllocated[index].busDetails!.busId);

    //   // await db!.updateBusAllocationOne(
    //   //     context.read<BusBloc>().busAllocated[index], data[0]['id'], ticketId);
    //   var finalData = await db!.getData();
    //   print(finalData);
    // }
    // ticketName = ticketId.toString() + ".pdf";
    // ------------------------BUS------------------------

    // try {
    // if (termsAndConditions[0]['ticketNumber'] == 0 ||
    //     termsAndConditions[0]['ticketNumber'] == null) {
    //   ticketNumber = termsAndConditions[0]['ticketNumber'];
    //   // print(
    //   //     "the ticket number if ${context.read<ProgramsBloc>().ticketNumber.toString()}");
    //   // await db!.updateTicket(
    //   //     int.parse(context.read<ProgramsBloc>().ticketNumber.toString()));
    // } else {
    print(termsAndConditions);
    ticketNumber = termsAndConditions[0]['ticketNumber'] + 1;

    print("the ticket number else $ticketNumber");
    await db!.updateTicket(ticketNumber!);
    // }
    widget.offlineBooking!.ticketNumber = ticketNumber;
    //  termsAndConditions = await db!.getTermsAndConditionsOffline();
    await db!.addTicketNumber(widget.offlineBooking, ticketNumber);
    // } catch (e) {
    //   print(e);
    // }
  }

  getVehicleData() {
    listVehicles.clear();
    for (int i = 0; i < widget.offlineBooking!.vehicleList!.length; i++) {
      listVehicles.add({
        'vName':
            widget.offlineBooking!.vehicleList![i]['vehicleName'].toString(),
        'vDate':
            widget.offlineBooking!.vehicleList![i]['bookingDate'].toString(),
        'vCharge': widget.offlineBooking!.vehicleList![i]['charge'].toString(),
      });
    }
    return listVehicles;
  }

  // shareTicket(BuildContext context, SummaryGenerated state) {
  //   return AppCard(
  //     outLineColor: HexColor('#292929'),
  //     color: HexColor('#292929'),
  //     child: new Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text("Share Ticket"),
  //         IconButton(
  //           padding: EdgeInsets.zero,
  //           constraints: BoxConstraints(),
  //           icon: Icon(
  //             Icons.share,
  //             size: 20,
  //           ),
  //           onPressed: () async {
  //             Share.share(WebClient.ip +
  //                 "/" +
  //                 widget.bookingDetails!.data!.payment!.id.toString());
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
}
