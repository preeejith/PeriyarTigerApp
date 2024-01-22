import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/data/models/entrymodel/guestinfomodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/booking/bookingsummary.dart';
import 'package:parambikulam/ui/app/entrypoint/entranceticketbooking_guest.dart';

class EntranceTicketBooking extends StatefulWidget {
  final String? programId, progName;
  final bool? isCottage, isOffline;
  final List<Map>? vehicleInfo;

  EntranceTicketBooking(
      {this.programId,
      this.progName,
      this.isOffline,
      this.isCottage,
      this.vehicleInfo});
  _EntranceTicketBookingState createState() => _EntranceTicketBookingState();
}

class _EntranceTicketBookingState extends State<EntranceTicketBooking> {
  DatabaseHelper? db = DatabaseHelper.instance;

  List<ListModel> displayList = [];
  List<GuestInfoModel> customersList = [];
  final g = new DateFormat('yyyy-MM-dd');
  bool? isEditing = false, cameraState = false;
  String? path;
  bool? disablePsButton = true;
  @override
  void initState() {
    super.initState();
    addToList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Entry Pass'),
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
      body: _entranceTicketRates(context),
    );
  }

  _entranceTicketRates(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [_guestNumber(context)]),
    );
  }

  void addToList() {
    displayList.clear();
    displayList = [
      ListModel(name: "Indian Adult", value: 0, status: true),
      ListModel(name: "Foreign Adult", value: 0, status: true),
      ListModel(name: "Children", value: 0, status: true)
    ];
  }

  _guestNumber(BuildContext context) {
    return new Column(
      children: [
        new Row(
          children: [
            Expanded(
              child: new Text("Add Guest Number"),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Column(
          children: _guestContainer(context),
        ),
        SizedBox(
          height: 50.0,
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 45,
              width: 290,
              child: new TextButton(
                style: StyleElements.submitButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntranceTicketBookingSecond(
                        displayList: displayList,
                      ),
                    ),
                  );
                },
                child: new Text('SUBMIT',
                    style: StyleElements.buttonTextStyleSemiBold),
              ),
            ),
          ],
        )
      ],
    );
  }

  _guestContainer(BuildContext context) {
    List<Widget> guestWidget = <Widget>[];

    for (int i = 0; i < displayList.length; i++) {
      displayList[i].status != false
          ? guestWidget.add(
              Column(
                children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Text(displayList[i].name.toString()),
                      _slotAddAndRemoverbutton(context, i),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            )
          : Container();
    }
    return guestWidget;
  }

  // void _showToast(BuildContext context, String s, Toast length) {
  //   Fluttertoast.showToast(
  //     toastLength: length,
  //     msg: s,
  //     gravity: ToastGravity.CENTER,
  //     backgroundColor: Colors.black,
  //     textColor: Colors.white,
  //     fontSize: 12.0,
  //   );
  // }

  _slotAddAndRemoverbutton(BuildContext context, int i) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      width: 90.0,
      height: 40.0,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (displayList[i].value != 0)
                      displayList[i].value = displayList[i].value! - 1;
                  });
                },
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              new Text(
                displayList[i].value.toString(),
                style: TextStyle(color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    displayList[i].value = displayList[i].value! + 1;
                  });
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
