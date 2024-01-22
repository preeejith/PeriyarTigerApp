import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibreservationdetailsbloc.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservationedit.dart';

class ReservationFullDetailed extends StatefulWidget {
  final int index;
  final ReservationdataRecived state;
  const ReservationFullDetailed(
      {Key? key, required this.state, required this.index})
      : super(key: key);

  @override
  State<ReservationFullDetailed> createState() =>
      _ReservationFullDetailedState();
}

////
///
class _ReservationFullDetailedState extends State<ReservationFullDetailed> {
  String? ibprogramname;
  String? starttime;
  String? endtime;

  @override
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() async {
    for (int i = 0; i < widget.state.items!.length; i++) {
      if (widget.state.items![i]['_id'] ==
          widget.state.items7![widget.index]['programid']) {
        print('testok');
        ibprogramname = widget.state.items![i]['progName'];
      }
    }

    for (int i = 0; i < widget.state.items2!.length; i++) {
      if (widget.state.items2![i]['_id'] ==
          widget.state.items7![widget.index]['slotid']) {
        print('test2ok');
        starttime = widget.state.items2![i]['startTime'];
        endtime = widget.state.items2![i]['endTime'];
        // ibprogramname = widget.state.items![i]['slotid'];
      }
    }
  }

  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  late List newList;
  List<SlotModel> slotlist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SUMMARY'), actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                  color: Colors.black,
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReservationEdit(
                                starttime: starttime.toString(),
                                endtime: endtime.toString(),
                                state: widget.state,
                                index: widget.index,
                                ibprogramname: ibprogramname.toString())));
                  }),
            ],
          ),
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              // height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "IB  :  ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          ibprogramname.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selected Date : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          d1.format(DateTime.parse(widget
                              .state.items7![widget.index]['bookingdate'])),
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selected Slot :  ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          starttime.toString() +
                              'PM' +
                              " - " +
                              endtime.toString() +
                              'AM',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reserved for :  ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Flexible(
                          child: Text(
                            widget.state.items7![widget.index]['guestName'],
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Guest's Phone no. : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          widget.state.items7![widget.index]['guestPhone'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Food Preference : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          widget.state.items7![widget.index]['foodprefered'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rooms Reserved : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          widget.state.items7![widget.index]['reservedcount'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No. of persons accompanying : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          widget.state.items7![widget.index]
                              ['NoofCompaningPerson'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reference : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Flexible(
                          child: Text(
                            widget.state.items7![widget.index]['refered'],
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reference Person's Phone : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          widget.state.items7![widget.index]['referedPhone'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          widget.state.items7![widget.index]['email'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No. of Vehicles : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          widget.state.items7![widget.index]['noofVehicles'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Vehicle Numbers :  ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          widget.state.items7![widget.index]['vehicleno'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Other details provided : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          widget.state.items7![widget.index]['details'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                    ),
                  ],
                ),
              ),
            ),
            Image.asset(
              'assets/elephant2.webp',
              fit: BoxFit.contain,
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
    newList =
        list.where((element) => element['slotprogramme'] == param1).toList();
    print(newList[0][s]);

    // return newList[0]['slotfromDate'];
    return d1.format(DateTime.parse(convert(newList[0][s])));

    // newList[0]['slotfromDate'];
  }

  String getSlotData(
    List list,
    param1,
    String s,
  ) {
    newList =
        list.where((element) => element['slotprogramme'] == param1).toList();
    print(newList[0][s]);
////needed
    for (int j = 0; j < newList.length; j++) {
      slotlist.add(SlotModel(
        status: newList[j]['status'],
        id: newList[j]['_id'],
        starttime: newList[j]['startTime'],
        endtime: newList[j]['endTime'],
        availableNo: newList[j]['availableNo'],
        slotisDaywise: "dsf",
        slotstatus: newList[j]['slotstatus'],
        slotid: newList[j]['slot_id'],
        slotprogramme: newList[j]['slotprogramme'],
        slotfromDate: newList[j]['slotfromDate'],
        slottoDate: newList[j]['slottoDate'],
        slotslotType: newList[j]['slotslotType'],
      ));
    }

    // return newList[0]['slotfromDate'];
    return newList[0]['slotfromDate'];

    // newList[0]['slotfromDate'];
  }

  String getTime(
    List list,
    param1,
    String s,
  ) {
    newList =
        list.where((element) => element['slotprogramme'] == param1).toList();
    print(newList[0][s]);

    return newList[0][s];
    // return d1.format(DateTime.parse(convert(newList[0][s])));
  }

  String getRooms(
    List list,
    param1,
    String s,
  ) {
    newList =
        list.where((element) => element['slotprogramme'] == param1).toList();
    print('roooms');

    for (int j = 0; j < newList.length; j++) {}
    print(newList[0][s]);

    return newList[0][s];
    // return d1.format(DateTime.parse(convert(newList[0][s])));
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
