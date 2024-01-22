import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';

class NoUploadDetails extends StatefulWidget {
  final String? title;
  final int? id, index;
  final List? finalList;
  NoUploadDetails({this.id, this.title, this.finalList, this.index});
  _NoUploadDetails createState() => _NoUploadDetails();
}

class _NoUploadDetails extends State<NoUploadDetails> {
  DatabaseHelper? db = DatabaseHelper.instance;
  var heavyVehicle = 0,
      heavyVehicleCount = 0,
      lightVehicle = 0,
      lightVehicleCount = 0;
  List newList = [];
  @override
  void initState() {
    newList = jsonDecode(widget.finalList![widget.index!]['newListTwo']);
    generateAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text(widget.title.toString()),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: InkWell(
                  onTap: () async {},
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(
                      "assets/bgptrr.png",
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: listContent(context),
          ),
        ));
  }

  listContent(BuildContext context) {
    return Column(
      children: [
        AppCard(
            outLineColor: HexColor('#292929'),
            color: HexColor('#292929'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Program Name",
                          style: StyleElements.bookingDetailsTitle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(widget.finalList![widget.index!]!['title']),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Booking Date",
                          style: StyleElements.bookingDetailsTitle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(widget.finalList![widget.index!]!['bookingDate']),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Slot",
                          style: StyleElements.bookingDetailsTitle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(widget.finalList![widget.index!]!['startTime']
                                .toString() +
                            " - " +
                            widget.finalList![widget.index!]!['endTime']
                                .toString()),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ticket Number",
                          style: StyleElements.bookingDetailsTitle,
                        ),
                        Text(widget.finalList![widget.index!]!['ticketNumber']
                            .toString()),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Guest",
                          style: StyleElements.bookingDetailsTitle,
                        ),
                        Text((widget.finalList![widget.index!]!['indianCount'] +
                                widget.finalList![widget.index!]![
                                    'foreignerCount'] +
                                widget.finalList![widget.index!]![
                                    'childrenCount'])
                            .toString()),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Guest",
                  style: StyleElements.bookingDetailsTitle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.finalList![widget.index!]!['indianCount'] > 0
                        ? Text(
                            "Indian X " +
                                widget.finalList![widget.index!]!['indianCount']
                                    .toString(),
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      width: 5,
                    ),
                    widget.finalList![widget.index!]!['foreignerCount'] > 0
                        ? Text(
                            "Foreigner X " +
                                widget.finalList![widget.index!]![
                                        'foreignerCount']
                                    .toString(),
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      width: 5,
                    ),
                    widget.finalList![widget.index!]!['childrenCount'] > 0
                        ? Text(
                            "Children X " +
                                widget
                                    .finalList![widget.index!]!['childrenCount']
                                    .toString(),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Amount",
                  style: StyleElements.bookingDetailsTitle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                widget.finalList![widget.index!]!['indianCount'] > 0
                    ? new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Indian X " +
                                widget.finalList![widget.index!]!['indianCount']
                                    .toString(),
                            style: TextStyle(height: 1.5),
                          ),
                          Text(
                            widget.finalList![widget.index!]!['indianTotal']
                                .toString(),
                          )
                        ],
                      )
                    : SizedBox.shrink(),
                widget.finalList![widget.index!]!['foreignerCount'] > 0
                    ? new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Foreigner X " +
                                widget.finalList![widget.index!]![
                                        'foreignerCount']
                                    .toString(),
                            style: TextStyle(height: 1.5),
                          ),
                          Text(widget
                              .finalList![widget.index!]!['foreignerTotal']
                              .toString()),
                        ],
                      )
                    : SizedBox.shrink(),
                widget.finalList![widget.index!]!['childrenCount'] > 0
                    ? new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Children X " +
                                widget
                                    .finalList![widget.index!]!['childrenCount']
                                    .toString(),
                            style: TextStyle(height: 1.5),
                          ),
                          Text(widget
                              .finalList![widget.index!]!['childrenTotal']
                              .toString()),
                        ],
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 5.0,
                ),
                heavyVehicleCount != 0 || lightVehicleCount != 0
                    ? Divider()
                    : SizedBox.shrink(),
                heavyVehicleCount != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Heavy Motor Vehicle X " +
                                heavyVehicleCount.toString(),
                            style: TextStyle(height: 1.5),
                          ),
                          Text(heavyVehicle.toString()),
                        ],
                      )
                    : SizedBox.shrink(),
                lightVehicleCount != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Light Motor Vehicle X " +
                                lightVehicleCount.toString(),
                            style: TextStyle(height: 1.5),
                          ),
                          Text(lightVehicle.toString()),
                        ],
                      )
                    : SizedBox.shrink(),
                Divider(),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total"),
                    Text(
                      "Rs. " +
                          widget.finalList![widget.index!]!['totalAmount']
                              .toString(),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(),
                SizedBox(
                  height: 5.0,
                ),
              ],
            )),
        SizedBox(
          height: 15,
        ),
        AppCard(
          outLineColor: HexColor('#292929'),
          color: HexColor('#292929'),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: newList.length,
              itemBuilder: (context, index) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Name",
                                style: StyleElements.bookingDetailsTitle,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(newList[index]['name']),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "DOB",
                                style: StyleElements.bookingDetailsTitle,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(newList[index]['dob']),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Guest Type",
                                style: StyleElements.bookingDetailsTitle,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(newList[index]['guestType']),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Phone Number",
                        style: StyleElements.bookingDetailsTitle,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(newList[index]['phoneno'].toString()),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Id Proof",
                        style: StyleElements.bookingDetailsTitle,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 240,
                            height: 140,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: newList[index]['image'] != 'Empty'
                                    ? Image.file(
                                        File(
                                            newList[index]['image'].toString()),
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(Icons.error)),
                          ),
                        ],
                      ),
                      Divider(),
                    ]);
              }),
        ),
        SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: () async {
            _showAlert(context, "Delete Booking",
                "Delete this booking from local database ?");
          },
          child: AppCard(
            outLineColor: HexColor('#292929'),
            color: Colors.red,
            child: Text(
              'DELETE',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  _showAlert(BuildContext context, String title, String content) {
    AlertDialog alertDialog = new AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        new Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel", textAlign: TextAlign.center)),
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                        onTap: () async {
                          var deleteResult = await db!.deleteFromBookings(
                              int.parse(widget.id.toString()));
                          print("deleteResult $deleteResult");
                          if (deleteResult == 1) {
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg: "Deleted");
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => home.HomePage(),
                            //   ),
                            // );
                          } else {
                            Fluttertoast.showToast(msg: "Deletion Failed");
                          }
                        },
                        child: Text("Ok", textAlign: TextAlign.center))
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void generateAmount() {
    String theList = jsonEncode(widget.finalList![widget.index!]);
    print(jsonDecode(theList).runtimeType);
    // List vehicleList = widget.finalList![widget.index!];
    // if (vehicleList.contains('vehicle')) {
    //   for (int i = 0; i < vehicleList.length; i++) {
    //     if (vehicleList[i]['vehicleName'] == "Heavy Motor Vehicle") {
    //       heavyVehicle =
    //           heavyVehicle + int.parse(vehicleList[i]['charge'].toString());
    //       heavyVehicleCount = heavyVehicleCount + 1;
    //     } else if (vehicleList[i]['vehicleName'] == "Light Motor Vehicle") {
    //       lightVehicle =
    //           lightVehicle + int.parse(vehicleList[i]['charge'].toString());
    //       lightVehicleCount = lightVehicleCount + 1;
    //     }
    //   }
    // } else {
    //   print('no');
    // }
  }
}
