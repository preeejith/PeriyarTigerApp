import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservationfullview.dart';

class Reservation2DetailedList extends StatefulWidget {
  final List<ReservationListModel> reservationlist;
  final index;
  const Reservation2DetailedList(
      {Key? key, required this.reservationlist, this.index})
      : super(key: key);

  @override
  State<Reservation2DetailedList> createState() =>
      _Reservation2DetailedListState();
}

class _Reservation2DetailedListState extends State<Reservation2DetailedList> {
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  List items2 = [];
  String? starttime;
  String? endtime;
  bool? timmer = false;

  @override
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() async {
    List items2 = await getAllIbProgramslotdata();

    for (int i = 0; i < widget.reservationlist.length; i++) {
      for (int k = 0; k < items2.length; k++) {
        if (widget.reservationlist[i].programid == items2[k]['slotprogramme']) {
          setState(() {
            timmer = true;
          });
          print('testok');
          if (timmer == true) {
            starttime = items2[k]['startTime'];
            endtime = items2[k]['endTime'];
          }
        }
      }
    }

    // for (int i = 0; i < widget.state.items2!.length; i++) {
    //   if (widget.state.items2![i]['_id'] ==
    //       widget.state.items7![widget.index]['slotid']) {
    //     print('test2ok');
    //     starttime = widget.state.items2![i]['startTime'];
    //     endtime = widget.state.items2![i]['endTime'];
    //     // ibprogramname = widget.state.items![i]['slotid'];
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SUMMARY'), actions: []),
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
                    SizedBox(height: MediaQuery.of(context).size.height / 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "IB  :  ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          widget.reservationlist[widget.index].programName
                              .toString(),
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
                              .reservationlist[widget.index].bookingdate
                              .toString())),
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
                      ///hello
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reserved for :  ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Flexible(
                          child: Text(
                            widget.reservationlist[widget.index].guestName
                                .toString(),
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
                          widget.reservationlist[widget.index].guestPhone
                              .toString(),
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
                          widget.reservationlist[widget.index].foodprefered
                              .toString(),
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
                          widget.reservationlist[widget.index].reservedcount
                              .toString(),
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
                          widget
                              .reservationlist[widget.index].noofCompaningPerson
                              .toString(),
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
                        ///hello
                        Text(
                          "Reference : ",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Flexible(
                          child: Text(
                            widget.reservationlist[widget.index].refered
                                .toString(),
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
                          widget.reservationlist[widget.index].referedPhone
                              .toString(),
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
                          widget.reservationlist[widget.index].email.toString(),
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
                          widget.reservationlist[widget.index].noofVehicles
                              .toString(),
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
                          widget.reservationlist[widget.index].vehicleno
                              .toString(),
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
                          widget.reservationlist[widget.index].details
                              .toString(),
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
}
