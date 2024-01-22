import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:intl/intl.dart';

import 'package:parambikulam/bloc/assets/localbloc/ibreservationdetailsbloc.dart';

import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/ibdashboard2.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/ibmaindetailedview.dart';

import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservation2fullview.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservationcompletedata.dart';

import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservationfulldetailed.dart';

class ReservationOnlineDetails extends StatefulWidget {
  const ReservationOnlineDetails({Key? key}) : super(key: key);
/////
  @override
  State<ReservationOnlineDetails> createState() =>
      _ReservationOnlineDetailsState();
}

class _ReservationOnlineDetailsState extends State<ReservationOnlineDetails> {
  final TextEditingController datecontroller = TextEditingController();
  final TextEditingController date2controller = TextEditingController();
  final TextEditingController date2checkcontroler = TextEditingController();
  final TextEditingController date3controller = TextEditingController();
  final TextEditingController date3controller2 = TextEditingController();
  final TextEditingController date3checkcontroler = TextEditingController();
  final TextEditingController datecheckcontroller = TextEditingController();
  final TextEditingController daycontroller = TextEditingController();
  final TextEditingController monthcontroller = TextEditingController();
  final TextEditingController yearcontroller = TextEditingController();
  DateTime now = new DateTime.now();
  String? removed = "true";
  late List newList2;
  int totalRoom = 0;
  int sumTotal = 0;
  String? oldroomid = "";

  List<OldResDataModel> oldresdatalist = [];
  var d1 = new DateFormat('dd-MM-yyyy');
  var d3 = new DateFormat('yyyy');
  var d4 = new DateFormat('MM');
  var d5 = new DateFormat('dd');
  var d2 = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.sss'Z'");
  List items20 = [];

  List<ReservationListModel> reservationlist = [];
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  String? progamName;
  DateTime? selected;
  bool? liston = false;
  String? datecheck1;
  String? datecheck2;
  @override
  void initState() {
    fetcher();

    fetcher2();
    super.initState();
  }

  String? ibprogramname;
  String? starttime;
  String? endtime;
  List<String> ibprogramlist = [];

  List<IbPrgrmNameModel> ibPrgrmNamelist = [];
  void fetcher() {
    BlocProvider.of<Ibreservation2datauploadBloc>(context)
        .add(GetIbreservation2datauploadData());

    setState(() {});
  }

  fetcher2() async {
    BlocProvider.of<Ibreservation2datauploadBloc>(context)
        .add(GetIbreservation2datauploadData());
    // await getAllReservationSortedDate(); //List items = await getAllReservationSortedDate();
    // print(items);
    // items7 = getReservationListOnlinedata();
    datecontroller.text =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    daycontroller.text = "${selectedDate.day}";
    monthcontroller.text = "${selectedDate.month}";
    yearcontroller.text = "${selectedDate.year}";
  }

  // void fetcher2() async {
  //   BlocProvider.of<IBReservationdatauploadBloc>(context)
  //       .add(GetIbreservationdatauploadData());
  // }

  var newdate;
  bool? checkok;

  int? roomcount;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => IBDashboard2())),
            ),
            title: Text("RESERVATION LIST"),
            actions: []),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.6,
                        child: TextField(
                          readOnly: true,
                          controller: date2controller,
                          inputFormatters: const [],
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: Icon(Icons.calendar_month),
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                            labelText: "From Date",
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.6,
                        child: TextFormField(
                          readOnly: true,
                          controller: date3controller,
                          inputFormatters: const [],
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              child: Icon(Icons.calendar_month),
                              onTap: () {
                                date2controller.text.isEmpty
                                    ? Fluttertoast.showToast(
                                        backgroundColor: Colors.white,
                                        msg: "Please select the from date",
                                        gravity: ToastGravity.CENTER,
                                        textColor: Colors.black,
                                        fontSize: 12.0)
                                    : _selectDate2(context);
                              },
                            ),
                            labelText: "To Date",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),

              BlocConsumer<Ibreservation2datauploadBloc,
                  StateIbreservation2dataupload>(builder: (context, state) {
                if (state is ReservationdataRecived) {
                  return Column(
                    children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: state.items4!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.all(2.0),
                              child: ListTile(
                                  title: InkWell(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 4,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        ibprogramlist.length ==
                                                                0
                                                            ? ""
                                                            : ibprogramlist[
                                                                index],
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      )
                                                    ]),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Reserved for: ',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        state.items4![index]
                                                            ['guestname'],
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      )
                                                    ]),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(children: [
                                                  Text(
                                                    "Selected Date: ",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  Text(
                                                    d1.format(DateTime.parse(
                                                        state.items4![index]
                                                            ['bookingdate'])),
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  )
                                                ]),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(children: [
                                                  Text(
                                                    "Referred Person: ",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  Text(
                                                    state.items4![index]
                                                        ['reference'],
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  )
                                                ]),
                                              ]),
                                        ),
                                        SizedBox(
                                          height: 25,
                                          width: 65,
                                          child: MaterialButton(
                                              color: Colors.green,
                                              child: Text(
                                                "Remove",
                                                style: TextStyle(fontSize: 9),
                                              ),
                                              onPressed: () {
                                                // deletereservationdata(state
                                                //     .items4![index]['id']
                                                //     .toString());

                                                // d2.format(DateTime.parse(state
                                                //     .items4![index]['bookingdate']));

                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      // title: Text('Welcome'),
                                                      content: Text(
                                                          'Do you want to remove this reservation'),
                                                      actions: [
                                                        MaterialButton(
                                                          textColor:
                                                              Colors.black,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'NO',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        MaterialButton(
                                                          textColor:
                                                              Colors.black,
                                                          onPressed: () {
                                                            newdate = state
                                                                        .items4![
                                                                    index]
                                                                ['bookingdate'];
                                                            checkok = true;
                                                            for (int i = 0;
                                                                i <
                                                                    state
                                                                        .items5!
                                                                        .length;
                                                                i++) {
                                                              if (state.items5![
                                                                          i][
                                                                      'slotprogramid'] ==
                                                                  state.items4![
                                                                          index]
                                                                      [
                                                                      'programid']) {
                                                                print(
                                                                    "check ok");
                                                                if ((DateTime.parse(state
                                                                        .items5![
                                                                            i][
                                                                            'bookingDate']
                                                                        .toString())) ==
                                                                    DateTime.parse(
                                                                        newdate)) {
                                                                  print('helo');
                                                                  if (state.items5![
                                                                              i]
                                                                          [
                                                                          'reserveno'] ==
                                                                      state.items4![
                                                                              index]
                                                                          [
                                                                          'numberofRooms']) {
                                                                    if (checkok ==
                                                                        true) {
                                                                      print(
                                                                          'deleted');
                                                                      deletegetreservationdata(int.parse(state
                                                                          .items5![
                                                                              i]
                                                                              [
                                                                              'id']
                                                                          .toString()));
                                                                      checkok =
                                                                          false;

                                                                      deletereservationdata(state
                                                                          .items4![
                                                                              index]
                                                                              [
                                                                              'id']
                                                                          .toString());
                                                                    }

                                                                    print(
                                                                        "object");
                                                                  }
                                                                }
                                                              }
                                                            }
                                                            Navigator.pop(
                                                                context);
                                                            fetcher();
                                                          },
                                                          child: Text(
                                                            'YES',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );

                                                // // deletereservationdata(state
                                                // //     .items4![index]['id']
                                                // //     .toString());
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            IbReservationDetailed(
                                              state: state,
                                              index: index,
                                            )),
                                  );
                                },
                              )),
                            );
                          }),
                    ],
                  );
                } else {
                  return Text("Loading...");
                }
              }, listener: (context, state) {
                if (state is ReservationdataRecived) {
                  // for (int j = 0; j < state.items7!.length; j++) {
                  //   for (int i = 0; i < state.items!.length; i++) {
                  //     if (state.items![i]['_id'] ==
                  //         state.items7![j]['programid']) {
                  //       print('testok');
                  //       ibprogramlist
                  //           .add(state.items![i]['progName'].toString());
                  //     }
                  //   }
                  // }

                  for (int j = 0; j < state.items4!.length; j++) {
                    for (int i = 0; i < state.items!.length; i++) {
                      if (state.items![i]['_id'] ==
                          state.items4![j]['programid']) {
                        print('testok');
                        ibprogramlist
                            .add(state.items![i]['progName'].toString());
                      }
                    }
                  }

                  // state.items4!.length == 0
                  //     ? uploadcount = false
                  //     : uploadcount = true;
                }
              }),
              liston == true
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: reservationlist.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index2) {
                        return Padding(
                          padding: EdgeInsets.all(2.0),
                          child: ListTile(
                              title: InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 4,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Text(
                                                //   "IB  :  ",
                                                //   style: TextStyle(
                                                //       color: Colors
                                                //           .white,
                                                //       fontSize: 14),
                                                // ),
                                                Text(
                                                  reservationlist.length == 0
                                                      ? ""
                                                      : reservationlist[index2]
                                                          .programName
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),

                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .6,
                                                    child: Text(
                                                      'Reserved for: ' +
                                                          reservationlist[
                                                                  index2]
                                                              .guestName
                                                              .toString(),
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ]),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(children: [
                                              Text(
                                                "Selected Date : ",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              Text(
                                                d1.format(DateTime.parse(
                                                    reservationlist[index2]
                                                        .bookingdate
                                                        .toString())),
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ]),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            // Text(
                                            //   reservationlist[index]
                                            //       .bookingdate
                                            //       .toString(),
                                            //   style: TextStyle(fontSize: 14),
                                            // ),
                                            Row(children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .6,
                                                child: Text(
                                                  "Referred Person: " +
                                                      reservationlist[index2]
                                                          .refered
                                                          .toString(),
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              )
                                            ]),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Reservation2DetailedList(
                                            reservationlist: reservationlist,
                                            index: index2)),
                              );
                            },
                          )),
                        );
                      })
                  :

                  //////////////////////old bloc start
                  BlocConsumer<Ibreservation2datauploadBloc,
                      StateIbreservation2dataupload>(builder: (context, state) {
                      if (state is ReservationdataRecived) {
                        return state.items7!.length == 0
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text("No Result Found")),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ////newly added

                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        reverse: true,
                                        itemCount: reservationlist.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return date2controller.text
                                                          .toString() !=
                                                      "" &&
                                                  d1.format(selectedDate) !=
                                                      d1.format(DateTime.parse(
                                                          reservationlist[index]
                                                              .bookingdate
                                                              .toString()))
                                              ? Container()
                                              : Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: ListTile(
                                                      title: InkWell(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white10,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.1),
                                                            spreadRadius: 4,
                                                            blurRadius: 4,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          ibprogramlist.length == 0
                                                                              ? ""
                                                                              : ibprogramlist[index],
                                                                          style: TextStyle(
                                                                              color: Colors.green,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w800),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * .6,
                                                                            child:
                                                                                Text(
                                                                              "Reserved for :" + reservationlist[index].guestName.toString(),
                                                                              style: TextStyle(fontSize: 14),
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                    SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Row(
                                                                        children: [
                                                                          Text(
                                                                            "Selected Date : ",
                                                                            style:
                                                                                TextStyle(fontSize: 14),
                                                                          ),
                                                                          Text(
                                                                            d1.format(DateTime.parse(reservationlist[index].bookingdate.toString())),
                                                                            style:
                                                                                TextStyle(fontSize: 14),
                                                                          ),
                                                                        ]),
                                                                    SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Row(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * .6,
                                                                            child:
                                                                                Text(
                                                                              "Referred Person: " + reservationlist[index].refered.toString(),
                                                                              style: TextStyle(fontSize: 14),
                                                                            ),
                                                                          )
                                                                        ]),
                                                                  ]),
                                                            ),
                                                            SizedBox(
                                                              height: 25,
                                                              width: 65,
                                                              child:
                                                                  MaterialButton(
                                                                      color: Colors
                                                                          .green,
                                                                      child:
                                                                          Text(
                                                                        "Remove",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                9),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        getOldResDataData(
                                                                            state.items5!,
                                                                            reservationlist[index].programid.toString());
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              // title: Text('Welcome'),
                                                                              content: Text('Do you want to remove this reservation'),
                                                                              actions: [
                                                                                MaterialButton(
                                                                                  textColor: Colors.black,
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text(
                                                                                    'NO',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                                MaterialButton(
                                                                                  textColor: Colors.black,
                                                                                  onPressed: () {
                                                                                    updateremovereservationonlinedata(removed, int.parse(reservationlist[index].id.toString()));
                                                                                    if (oldresdatalist.isNotEmpty) {
                                                                                      sumTotal = 0;
                                                                                      totalRoom = 0;
                                                                                      for (int k = 0; k < oldresdatalist.length; k++) {
                                                                                        // totalRoom = 0;
                                                                                        if (oldresdatalist[k].bookingDate.toString() == reservationlist[index].bookingdate.toString()) {
                                                                                          sumTotal = int.parse(oldresdatalist[k].reserveno.toString()) + sumTotal;
                                                                                          print(sumTotal.toString() + "Sum");

                                                                                          if (oldresdatalist[k].reserveno.toString() == reservationlist[index].reservedcount.toString()) {
                                                                                            oldroomid = oldresdatalist[k].id.toString();
                                                                                            // print(oldroomid.toString() + " Old Rooms");
                                                                                          }

                                                                                          // print("total Count" + totalRoom.toString() + reservationlist[index].bookingdate.toString() + "h  " + oldresdatalist[k].bookingDate.toString());
                                                                                        }
                                                                                      }

                                                                                      totalRoom = sumTotal - int.parse(reservationlist[index].reservedcount.toString());
                                                                                      // print(totalRoom.toString() + " Total Rooms");
                                                                                    }
                                                                                    oldroomid != "" ? deleteinsertreservationdata(oldroomid) : SizedBox();
                                                                                    // getupdatereservationdata(totalRoom, reservationlist[index].bookingdate.toString(), reservationlist[index].slotprogramid.toString());

////
                                                                                    Navigator.pop(context);
                                                                                    fetcher();
                                                                                  },
                                                                                  child: Text(
                                                                                    'YES',
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );

                                                                        // // deletereservationdata(state
                                                                        // //     .items4![index]['id']
                                                                        // //     .toString());
                                                                      }),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ReservationFullDetailed(
                                                                  state: state,
                                                                  index: index,
                                                                )),
                                                      );
                                                    },
                                                  )),
                                                );
                                        }),

                                    //////////////////////commmeded online/////end/
                                  ],
                                ),
                              );
                      } else {
                        return Center();
                      }
                    }, listener: (context, state) {
                      /////
                      if (state is ReservationdataRecived) {
                        ibprogramlist.clear();
                        ibprogramlist.clear();
                        for (int j = 0; j < state.items7!.length; j++) {
                          for (int i = 0; i < state.items!.length; i++) {
                            if (state.items![i]['_id'] ==
                                state.items7![j]['programid']) {
                              print('testok');
                              ibprogramlist
                                  .add(state.items![i]['progName'].toString());

                              ibPrgrmNamelist.add(IbPrgrmNameModel(
                                prgName: state.items![i]['progName'].toString(),
                                prgmId: state.items![i]['_id'].toString(),
                              ));
                            }
                          }
                        }
                        reservationlist.clear();
                        // ibprogramlist.clear();
                        for (int i = 0; i < state.items7!.length; i++) {
                          if (state.items7![i]['removed'].toString() !=
                              "true") {
                            reservationlist.add(ReservationListModel(
                                id: state.items7![i]['id'].toString(),
                                reservedcount: state.items7![i]
                                    ['reservedcount'],
                                status: state.items7![i]['status'],
                                foodprefered: state.items7![i]['foodprefered'],
                                vehicleno: state.items7![i]['vehicleno'],
                                bookingid: state.items7![i]['bookingid'],
                                bookingdate: state.items7![i]['bookingdate'],
                                slotid: state.items7![i]['slotid'],
                                slotprogramid: state.items7![i]
                                    ['slotprogramid'],
                                programName: state.items7![i]['programName'],
                                programid: state.items7![i]['programid'],
                                guestName: state.items7![i]['guestName'],
                                noofCompaningPerson: state.items7![i]
                                    ['NoofCompaningPerson'],
                                guestPhone: state.items7![i]['guestPhone'],
                                refered: state.items7![i]['refered'],
                                referedPhone: state.items7![i]['referedPhone'],
                                email: state.items7![i]['email'],
                                noofVehicles: state.items7![i]['noofVehicles'],
                                details: state.items7![i]['details'],
                                programme:
                                    ibprogramlist.length == state.items7!.length
                                        ? ibprogramlist[i]
                                        : ""));
                          }
                        }

                        // for (int i = 0; i < state.items2!.length; i++) {
                        //   if (state.items2![i]['_id'] ==
                        //       state.items7![widget.index]['slotid']) {
                        //     print('test2ok');
                        //     starttime = state.items2![i]['startTime'];
                        //     endtime = state.items2![i]['endTime'];
                        //     // ibprogramname = widget.state.items![i]['slotid'];
                        //   }
                        // }

                      }
                    }),

              /////////////////bloc closed
            ],
          ),
        ),
      ),
    );
  }

/////for geting the previous room count
  String getOldResDataData(
    List list,
    param1,
  ) {
    newList2 =
        list.where((element) => element['slotprogramid'] == param1).toList();
    oldresdatalist.clear();
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
    // print(oldresdatalist);

    // return newList2[0]['slotfromDate'];
    return '';

    // newList2[0]['slotfromDate'];
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2028),
    );
    if (selected != null && selected != selectedDate)
      context.read<Ibreservation2datauploadBloc>().dateOne = selected;
    setState(() {
      selectedDate = selected!;
      datecheckcontroller.text =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}/${selectedDate.hour}/${selectedDate.minute}/${selectedDate.second}";

      date2controller.text =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

      date2checkcontroler.text = selected.toString();

      // print(date2checkcontroler.text);
      if (date3controller.text.isNotEmpty) {
        setState(() {
          datecheck1 = date2checkcontroler.text.toString();

          datecheck2 = date3checkcontroler.text.toString();
        });
      }

      //  DateTime dt1 =  DateTime.parse(datecheckyearcontroller.text.toString());

      setState(() {});
    });

    if (date3controller.text.isNotEmpty) {
      List items20 = [];
      items20 = await getAllReservationSortedDate(datecheck1, datecheck2);
      // print(items20);

      if (items20.isNotEmpty) {
        // if (items20 == []) {
        //   setState(() {
        //     reservationlist.clear();
        //   });
        // }

        {
          reservationlist.clear();
          for (int t = 0; t < items20.length; t++) {
            for (int k = 0; k < ibPrgrmNamelist.length; k++) {
              if (ibPrgrmNamelist[k].prgmId == items20[t]['programid']) {
                progamName = ibPrgrmNamelist[k].prgName.toString();
              } else {
                progamName = "nill".toString();
              }
            }
            reservationlist.add(ReservationListModel(
                reservedcount: items20[t]['reservedcount'],
                status: items20[t]['status'],
                foodprefered: items20[t]['foodprefered'],
                vehicleno: items20[t]['vehicleno'],
                bookingid: items20[t]['bookingid'],
                bookingdate: items20[t]['bookingdate'],
                slotid: items20[t]['slotid'],
                slotprogramid: items20[t]['slotprogramid'],
                programName: items20[t]['programName'],
                programid: items20[t]['programid'],
                guestName: items20[t]['guestName'],
                noofCompaningPerson: items20[t]['NoofCompaningPerson'],
                guestPhone: items20[t]['guestPhone'],
                refered: items20[t]['refered'],
                referedPhone: items20[t]['referedPhone'],
                email: items20[t]['email'],
                noofVehicles: items20[t]['noofVehicles'],
                details: items20[t]['details'],
                programme: progamName));
            // print("listtesting");
            print(reservationlist[0].foodprefered);
          }
        }

        setState(() {
          liston = true;
        });
      } else if (items20.isEmpty) {
        setState(() {
          reservationlist.clear();
        });
      }
    }
  }

  _selectDate2(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2028),
    );
    if (selected != null && selected != selectedDate)
      // context.read<Ibreservation2datauploadBloc>().dateTwo = selected2;

      // context.read<Ibreservation2datauploadBloc>().add(SortList());

      setState(() {
        selectedDate = selected;
        selectedDate2 = selected.add(Duration(days: 1));

        datecheckcontroller.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}/${selectedDate.hour}/${selectedDate.minute}/${selectedDate.second}";

        date3controller.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

        date3controller2.text =
            "${selectedDate2.day}/${selectedDate2.month}/${selectedDate2.year}";

        date3checkcontroler.text = selectedDate2.toString();
        print(date3checkcontroler.text);

        datecheck1 = date2checkcontroler.text.toString();

        datecheck2 = date3checkcontroler.text.toString();
      });

    // await getAllReservationSortedDate(); //List items = await getAllReservationSortedDate();
    List items20 = [];
    items20 = await getAllReservationSortedDate(datecheck1, datecheck2);
    // print(items20);

    if (items20.isNotEmpty) {
      // if (items20 == []) {
      //   setState(() {
      //     reservationlist.clear();
      //   });
      // }

      {
        reservationlist.clear();
        for (int t = 0; t < items20.length; t++) {
          for (int k = 0; k < ibPrgrmNamelist.length; k++) {
            if (ibPrgrmNamelist[k].prgmId == items20[t]['programid']) {
              progamName = ibPrgrmNamelist[k].prgName.toString();
            } else {
              progamName = "nill".toString();
            }
          }
          reservationlist.add(ReservationListModel(
              reservedcount: items20[t]['reservedcount'],
              status: items20[t]['status'],
              foodprefered: items20[t]['foodprefered'],
              vehicleno: items20[t]['vehicleno'],
              bookingid: items20[t]['bookingid'],
              bookingdate: items20[t]['bookingdate'],
              slotid: items20[t]['slotid'],
              slotprogramid: items20[t]['slotprogramid'],
              programName: items20[t]['programName'],
              programid: items20[t]['programid'],
              guestName: items20[t]['guestName'],
              noofCompaningPerson: items20[t]['NoofCompaningPerson'],
              guestPhone: items20[t]['guestPhone'],
              refered: items20[t]['refered'],
              referedPhone: items20[t]['referedPhone'],
              email: items20[t]['email'],
              noofVehicles: items20[t]['noofVehicles'],
              details: items20[t]['details'],
              programme: progamName));
          print("listtesting");
          // print(reservationlist[0].foodprefered);
        }
      }

      setState(() {
        liston = true;
      });
    } else if (items20.isEmpty) {
      setState(() {
        reservationlist.clear();
      });
    }

    //  DateTime dt1 =  DateTime.parse(datecheckyearcontroller.text.toString());

    setState(() {});
  }
}

class IbPrgrmNameModel {
  String? prgName, prgmId;

  IbPrgrmNameModel({this.prgName, this.prgmId});
}

//////////
class ReservationListModel {
  String? reservedcount,
      status,
      foodprefered,
      vehicleno,
      bookingid,
      bookingdate,
      slotid,
      slotprogramid,
      programName,
      programid,
      guestName,
      noofCompaningPerson,
      guestPhone,
      refered,
      referedPhone,
      email,
      noofVehicles,
      details,
      programme,
      id;
  ReservationListModel(
      {this.reservedcount,
      this.status,
      this.foodprefered,
      this.vehicleno,
      this.bookingid,
      this.bookingdate,
      this.slotid,
      this.slotprogramid,
      this.programName,
      this.programid,
      this.guestName,
      this.noofCompaningPerson,
      this.guestPhone,
      this.refered,
      this.referedPhone,
      this.email,
      this.noofVehicles,
      this.details,
      this.programme,
      this.id});
}
