import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/addroom/blocaddroom.dart';
import 'package:parambikulam/bloc/addroom/eventaddroom.dart';
import 'package:parambikulam/bloc/addroom/stateaddroom.dart';
import 'package:parambikulam/bloc/booking/bookingbloc.dart';
import 'package:parambikulam/bloc/booking/bookingevent.dart';
import 'package:parambikulam/bloc/booking/bookingstate.dart';
import 'package:parambikulam/data/models/bookingsummary.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/booking/bookingsummarysecond.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';
import 'package:parambikulam/ui/app/widgets/appcardwhite.dart';
import '../../../config.dart';

class BookingSummary extends StatefulWidget {
  final String? programId;
  final String? title;
  final bool? isCottage, isOffline;
  final List<Map>? offlineData;
  // final List<Map>? vehicleInfo;
  //  final List<BusData>? busData;

  BookingSummary({
    this.programId,
    // this.busData,
    this.title,
    this.isCottage,
    // this.vehicleInfo,
    this.isOffline,
    this.offlineData,
  });

  _BookingSummary createState() => _BookingSummary();
}

class _BookingSummary extends State<BookingSummary> {
  Widget? child;
  bool colorState = false, oneRoomDataAdded = false;
  OfflineRoomModel offlineRoomModel = OfflineRoomModel();
  List<OfflineRoomModel> offlineRoomDataList = [];
  bool? isOpened = true;
  String? selectId = "";
  int? seatCount = 0,
      totalRoom = 0,
      newSeatCount = 0,
      nextRoom = 0,
      freeCount = 0,
      maxTotalGuests,
      guestPerRoom,
      maxTotalIndians,
      maxTotalChildren,
      maxTotalForeigners,
      maxExtraGuestCount,
      maxExtraIndianCount,
      maxExtraForeignerCount,
      maxExtraChildrenCount;
  final String currentDate =
      new DateFormat('yyyy-MM-dd').format(DateTime.now());
  // new DateFormat('yyyy-MM-dd').format(DateTime(2021, 10, 28));

  final f = new DateFormat('MMMM dd, yyyy');

  List<ListModel> displayList = [];
  List<RoomModel> roomData = [];
  List<Widget> nextRoomList = [];
  List<Map> slotList = [];
  List<Map> programList = [];
  List<Map> slotDetails = [];

  bool? onceUpdated = true;
  DatabaseHelper? db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  @override
  void dispose() {
    super.dispose();
    BookingBloc().close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state is GettingBookingSummaryRecieved) {
          return Scaffold(
            appBar: new AppBar(
              title: Text(
                widget.title.toString(),
              ),
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
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: new Column(
                    children: <Widget>[
                      _bookingSummary(context, state),
                      SizedBox(
                        height: 15.0,
                      ),
                      widget.isCottage == false
                          ? _selectTimeSlot(context, state)
                          : _allocateRooms(context, state),
                      // : widget.isOffline == true
                      //     ? Fluttertoast.showToast(msg: 'working on it')
                      //     : _allocateRooms(context, state),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        thickness: 1.0,
                        color: HexColor("#3E3E3E"),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      widget.isCottage == false
                          ? _guestNumber(context, state)
                          : guestRoomNumber(context, state),
                      // : SizedBox.shrink(),
                      BlocConsumer<BlocAddRoom, StateAddRoom>(
                        builder: (context, state) {
                          return Container();
                        },
                        listener: (context, state) {
                          if (state is RoomAdded) {
                            print("Room Added");
                            BlocProvider.of<BlocAddRoom>(context).add(
                              AddRoomRefresh(),
                            );
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingSummarySecond(
                                  date: currentDate,
                                  // busData: widget.busData,
                                  title: widget.title,
                                  isCottage: widget.isCottage,
                                  isOffline: widget.isOffline,
                                  offlineBooking: state.offlineBooking,
                                  programList: programList,
                                  slotDetails: slotDetails,
                                  offlineRoomModel: state.offlineRoomModel,
                                  // vehicleInfo: widget.vehicleInfo,
                                ),
                              ),
                            );
                            // _showToast(
                            //     context,
                            //     state.offlineBooking!.entranceCharge.toString(),
                            //     Toast.LENGTH_LONG);
                          } else if (state is RoomNotAdded) {
                            Navigator.pop(context);
                            _showToast(context, state.msg.toString(),
                                Toast.LENGTH_LONG);
                          }
                        },
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
      listener: (context, state) {
        if (state is GettingBookingSummaryFailed) {
          _showToast(
              context, state.summaryData!.msg.toString(), Toast.LENGTH_LONG);
        }
        if (state is GettingBookingSummaryRecieved) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     backgroundColor: Colors.red[300],
          //     content: Text(
          //         "Going to book online. Stable internet connection required.",
          //         style: TextStyle(color: Colors.white)),
          //   ),
          // );
          //heree
          print('after bloc');
          if (state.offline == false) {
            print('after bloc - isoffline false');
            if (widget.isCottage == true) {
              print(state
                  .summaryData!.programData!.cottage!.maxExtraForeignerCount
                  .toString());
              print(state
                  .summaryData!.programData!.cottage!.maxExtraChildrenCount
                  .toString());
              state.summaryData!.data![0].freeCount != 0
                  ? totalRoom = 1
                  : totalRoom = 0;
              guestPerRoom =
                  state.summaryData!.programData!.cottage!.guestPerRoom;

              maxExtraGuestCount =
                  state.summaryData!.programData!.cottage!.maxExtraGuestCount;
              maxExtraIndianCount =
                  state.summaryData!.programData!.cottage!.maxExtraIndianCount;
              maxExtraForeignerCount = state
                  .summaryData!.programData!.cottage!.maxExtraForeignerCount;
              maxExtraChildrenCount = state
                  .summaryData!.programData!.cottage!.maxExtraChildrenCount;

              maxTotalGuests =
                  state.summaryData!.programData!.cottage!.maxTotalGuests;
              maxTotalIndians =
                  state.summaryData!.programData!.cottage!.maxTotalIndians;
              maxTotalForeigners =
                  state.summaryData!.programData!.cottage!.maxTotalForeigners;
              maxTotalChildren =
                  state.summaryData!.programData!.cottage!.maxTotalChildren;
            }
            addToList(context, state);
          } else {
            print('after bloc - isoffline true');
            if (widget.isCottage == true) {
              state.localSlotData![0].freeCount != 0
                  ? totalRoom = 1
                  : totalRoom = 0;

              guestPerRoom = state.programList![0]['cottageGuestPerRoom'];
              maxExtraGuestCount =
                  state.programList![0]['cottagemaxExtraGuestCount'];
              maxExtraIndianCount =
                  state.programList![0]['cottagemaxExtraIndianCount'];
              maxExtraForeignerCount =
                  state.programList![0]['cottagemaxExtraForeignerCount'];
              maxExtraChildrenCount =
                  state.programList![0]['cottagemaxExtraChildrenCount'];
              maxExtraChildrenCount =
                  state.programList![0]['cottagemaxExtraChildrenCount'];
              print(
                  "guest per room + ${state.programList![0]['cottageGuestPerRoom']}");
              maxTotalGuests =
                  (guestPerRoom! + int.parse(maxExtraGuestCount.toString()));
              maxTotalIndians =
                  (guestPerRoom! + int.parse(maxExtraIndianCount.toString()));
              maxTotalForeigners = (guestPerRoom! +
                  int.parse(maxExtraForeignerCount.toString()));
              maxTotalChildren =
                  (guestPerRoom! + int.parse(maxExtraChildrenCount.toString()));
              // maxTotalChildren =
            }
            addToList(context, state);
          }
          // // if (state.offline == true) {
          //   addToList(context, state);
          // // }
        }
        if (state is PartialDataReceived) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BookingSummarySecond(
                date: currentDate,
                // busData: widget.busData,
                title: widget.title,
                isCottage: widget.isCottage,
                isOffline: widget.isOffline,
                offlineBooking: state.offlineBooking,
                programList: programList,
                slotDetails: slotDetails,
                // vehicleInfo: widget.vehicleInfo,
              ),
            ),
          );
        }
      },
    );
  }

  _bookingSummary(BuildContext context, GettingBookingSummaryRecieved state) {
    return new Container(
      child: new Column(
        children: [
          new Row(
            children: [
              new Text(
                'Booking Summary',
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          new AppCard(
            outLineColor: HexColor('#292929'),
            color: HexColor('#292929'),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Row(
                  children: [
                    new Text(
                      'Selected Date',
                      style: StyleElements.bookingDetailsTitle,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                new Row(
                  children: [
                    new Text(
                      f.format(
                        DateTime.parse(
                          DateTime.now().toString(),
                          // DateTime(2021, 11, 15).toString()
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                new Row(
                  children: [
                    new Text(
                      'Package',
                      style: StyleElements.bookingDetailsTitle,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                new Row(
                  children: [
                    Expanded(
                        child: widget.isOffline == true
                            ? new Text(
                                widget.title.toString(),
                              )
                            : new Text(
                                state.summaryData!.programData!.progName
                                    .toString(),
                              ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _selectTimeSlot(BuildContext context, GettingBookingSummaryRecieved state) {
    return Column(
      children: [
        new Row(
          children: [
            new Text('Select Time Slot'),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        widget.isOffline == true
            ? new ListView.separated(
                shrinkWrap: true,
                itemCount: state.localSlotData!.length,
                itemBuilder: (context, index) {
                  return state.localSlotData![index].freeCount! > 0
                      ? InkWell(
                          child: new AppCardWhite(
                            color: state.localSlotData![index].selected == true
                                ? HexColor("#68D389")
                                : Colors.white,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Text(
                                  state.localSlotData![index].startTime
                                          .toString() +
                                      " - " +
                                      state.localSlotData![index].endTime
                                          .toString(),
                                  style: TextStyle(
                                      color:
                                          // Colors.black,
                                          state.localSlotData![index]
                                                      .selected ==
                                                  true
                                              ? Colors.white
                                              : Colors.black),
                                ),
                                new Text(
                                  state.localSlotData![index].freeCount
                                          .toString() +
                                      " Seats Available",
                                  style: TextStyle(
                                    color:
                                        // Colors.black,
                                        state.localSlotData![index].selected ==
                                                true
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              freeCount = state.localSlotData![index].freeCount;
                              seatCount = 0;
                              state.localSlotData!.forEach((element) {
                                element.selected = false;
                              });
                              state.localSlotData![index].selected = true;
                              if (state.localSlotData![index].selected ==
                                  true) {
                                selectId =
                                    state.localSlotData![index].id.toString();
                                seatCount =
                                    state.localSlotData![index].freeCount;
                                print(state.localSlotData![index].endTime);
                                print(selectId.toString() +
                                    " - " +
                                    seatCount.toString());
                              } else {
                                print("no");
                              }
                            });
                          },
                        )
                      : InkWell(
                          child: new AppCardWhite(
                            color: HexColor("#720000"),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Text(
                                  state.localSlotData![index].startTime
                                          .toString() +
                                      " - " +
                                      state.localSlotData![index].endTime
                                          .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                new Text(
                                  // state.localSlotData![index].freeCount
                                  //         .toString() +
                                  "0 Seats Available",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            _showToast(context, "No seats available",
                                Toast.LENGTH_SHORT);
                          },
                        );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10.0);
                },
              )
            : new ListView.separated(
                shrinkWrap: true,
                itemCount: state.summaryData!.data!.length,
                itemBuilder: (context, index) {
                  return state.summaryData!.data![index].freeCount != 0
                      ? InkWell(
                          child: new AppCardWhite(
                            color:
                                state.summaryData!.data![index].selected == true
                                    ? HexColor("#68D389")
                                    : Colors.white,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Text(
                                  state.summaryData!.data![index].startTime
                                          .toString() +
                                      " - " +
                                      state.summaryData!.data![index].endTime
                                          .toString(),
                                  style: TextStyle(
                                      color: state.summaryData!.data![index]
                                              .selected!
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                new Text(
                                  state.summaryData!.data![index].freeCount
                                          .toString() +
                                      " Seats Available",
                                  style: TextStyle(
                                      color: state.summaryData!.data![index]
                                              .selected!
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              seatCount = 0;
                              state.summaryData!.data!.forEach((element) {
                                element.selected = false;
                              });
                              print(state.summaryData!.data![index].id);
                              state.summaryData!.data![index].selected =
                                  !state.summaryData!.data![index].selected!;
                              if (state.summaryData!.data![index].selected ==
                                  true) {
                                selectId = state.summaryData!.data![index].id
                                    .toString();
                                seatCount =
                                    state.summaryData!.data![index].freeCount;
                                print(state.summaryData!.data![index].endTime);
                                print(selectId.toString() +
                                    " - " +
                                    seatCount.toString());
                              }
                            });
                          },
                        )
                      : InkWell(
                          child: new AppCardWhite(
                            color: HexColor("#720000"),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Text(
                                  state.summaryData!.data![index].startTime
                                          .toString() +
                                      " - " +
                                      state.summaryData!.data![index].endTime
                                          .toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                new Text(
                                  state.summaryData!.data![index].freeCount
                                          .toString() +
                                      " Seats Available",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            _showToast(context, "No seats available",
                                Toast.LENGTH_SHORT);
                          },
                        );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10.0);
                },
              ),
      ],
    );
  }

  _guestNumber(BuildContext context, GettingBookingSummaryRecieved state) {
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
          children: _slotContainer(context, state),
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
                  selectId == ""
                      ? _showToast(
                          context, "Please select a slot", Toast.LENGTH_SHORT)
                      : newSeatCount == 0
                          ? _showToast(
                              context, "Please add members", Toast.LENGTH_SHORT)
                          : getAllData(state);
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

  _slotContainer(BuildContext context, GettingBookingSummaryRecieved state) {
    List<Widget> slotWidget = <Widget>[];
    print(displayList.length);
    for (int i = 0; i < displayList.length; i++) {
      print(displayList[i].status);
      displayList[i].status != false
          ? slotWidget.add(
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
    return slotWidget;
  }

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
                    if (selectId != "") {
                      if (displayList[i].value != 0) {
                        displayList[i].value = displayList[i].value! - 1;
                        newSeatCount = newSeatCount! - 1;
                      } else {
                        _showToast(
                            context, "Limit reached", Toast.LENGTH_SHORT);
                      }
                    } else {
                      displayList[i].value = 0;
                      _showToast(
                          context, "Please select slot", Toast.LENGTH_SHORT);
                    }
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
                    if (selectId != "") {
                      if (seatCount! > newSeatCount!) {
                        displayList[i].value = displayList[i].value! + 1;
                        newSeatCount = newSeatCount! + 1;
                      } else {
                        _showToast(
                            context, "Limit reached", Toast.LENGTH_SHORT);
                      }
                    } else {
                      _showToast(
                          context, "Please select slot", Toast.LENGTH_SHORT);
                    }
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

  void returnZero(BuildContext context) {
    for (int i = 0; i < displayList.length; i++) {
      setState(() {
        newSeatCount = 0;
        seatCount = 0;
        displayList[i].value = 0;
      });
    }
  }

  getAllData(GettingBookingSummaryRecieved state) async {
    List<Map> newList = [];
    print("Program ID - " + widget.programId.toString());
    // print("Slot ID - " + state.summaryData!.data![0].id.toString());
    print("Booking Date - " + currentDate.toString());
    for (int i = 0; i < displayList.length; i++) {
      if (displayList[i].name == "Indian Adult") {
        newList.add({"name": "Indian", "value": displayList[i].value});
      }
      if (displayList[i].name == "Foreign Adult") {
        newList.add({"name": "Foreigner", "value": displayList[i].value});
      }
      if (displayList[i].name == "Children") {
        newList.add({"name": "Children", "value": displayList[i].value});
      }
    }

    print("the results");
    print('Total - ' + newSeatCount.toString());
    print(newList);
    print("the slot id $selectId");
    print('the date $currentDate');
    print("freecount is $freeCount");
    print("new seat count $newSeatCount and free count $freeCount");

    if (state.offline == false) {
      BlocProvider.of<BookingBloc>(context).add(
        //slotbloc
        DoPartialBookingOne(
          programId: widget.programId,
          slotId: selectId,
          bookingDate: currentDate,
          newList: newList,
          isOffline: state.offline,
        ),
      );
    } else {
      slotDetails = await db!.getSlotDetails(selectId);
      BlocProvider.of<BookingBloc>(context).add(
        //slotbloc
        DoPartialBookingOne(
          programId: widget.programId,
          slotId: selectId,
          bookingDate: currentDate,
          newList: newList,
          // vehicleInfo: widget.vehicleInfo,
          isOffline: state.offline,
          totalMembers: state.localSlotData![0].freeCount! -
              int.parse(newSeatCount.toString()),
          title: widget.title,
          freeCount: freeCount,
          slotDetails: slotDetails,
        ),
      );
    }

    newSeatCount = 0;
  }

  void addToList(BuildContext context, GettingBookingSummaryRecieved state) {
    displayList.clear();
    if (state.offline == false) {
      displayList = [
        ListModel(
          name: "Indian Adult",
          value: 0,
          status: state.summaryData!.programData!.bookingAvailability!.indian,
        ),
        ListModel(
            name: "Foreign Adult",
            value: 0,
            status:
                state.summaryData!.programData!.bookingAvailability!.foreigner),
        ListModel(
            name: "Children",
            value: 0,
            status:
                state.summaryData!.programData!.bookingAvailability!.children)
      ];
      widget.isCottage == true
          ? addRoomsToList(context, state)
          : SizedBox.shrink();
    } else {
      displayList = [
        ListModel(
          name: "Indian Adult",
          value: 0,
          status: state.programList![0]['bookingAvailabilityindian'] == '1'
              ? true
              : false,
        ),
        ListModel(
          name: "Foreign Adult",
          value: 0,
          status: state.programList![0]['bookingAvailabilityforeigner'] == '1'
              ? true
              : false,
        ),
        ListModel(
          name: "Children",
          value: 0,
          status: state.programList![0]['bookingAvailabilitychildren'] == '1'
              ? true
              : false,
        )
      ];
      widget.isCottage == true
          ? addRoomsToList(context, state)
          : SizedBox.shrink();
    }
  }

  _allocateRooms(BuildContext context, GettingBookingSummaryRecieved state) {
    return Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Text('Availability'),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        widget.isOffline == false
            ? new AppCardWhite(
                color: state.summaryData!.data![0].freeCount != 0
                    ? HexColor("#68D389")
                    : HexColor("#720000"),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    state.summaryData!.data![0].freeCount != 0
                        ? state.summaryData!.data![0].freeCount! > 1
                            ? new Text(
                                state.summaryData!.data![0].freeCount
                                        .toString() +
                                    " Rooms Available",
                                style: TextStyle(color: Colors.white),
                              )
                            : new Text(
                                state.summaryData!.data![0].freeCount
                                        .toString() +
                                    " Room Available",
                                style: TextStyle(color: Colors.white),
                              )
                        : new Text(
                            "No Rooms Available",
                            style: TextStyle(color: Colors.white),
                          ),
                  ],
                ),
              )
            : new AppCardWhite(
                color: state.localSlotData![0].freeCount != 0
                    ? HexColor("#68D389")
                    : HexColor("#720000"),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    state.localSlotData![0].freeCount != 0
                        ? state.localSlotData![0].freeCount! > 1
                            ? new Text(
                                state.localSlotData![0].freeCount.toString() +
                                    " Rooms Available",
                                style: TextStyle(color: Colors.white),
                              )
                            : new Text(
                                state.localSlotData![0].freeCount.toString() +
                                    " Room Available",
                                style: TextStyle(color: Colors.white),
                              )
                        : new Text(
                            "No Rooms Available",
                            style: TextStyle(color: Colors.white),
                          ),
                  ],
                ),
              ),
        new SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  guestRoomNumber(BuildContext context, GettingBookingSummaryRecieved state) {
    return new Column(
      children: [
        widget.isOffline == false
            ? new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: new Text("Add Room"),
                  ),
                  new IconButton(
                    onPressed: () {
                      print("adding room");
                      isOpened == false
                          ? totalRoom! < state.summaryData!.data![0].freeCount!
                              ? setState(() {
                                  totalRoom = totalRoom! + 1;
                                  isOpened = true;
                                  _showToast(context, "New room added",
                                      Toast.LENGTH_SHORT);
                                })
                              : _showToast(
                                  context, "Limit Reached", Toast.LENGTH_SHORT)
                          : _showToast(context, "Please save the opened room",
                              Toast.LENGTH_SHORT);
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              )
            : new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: new Text("Add Room"),
                  ),
                  new IconButton(
                    onPressed: () {
                      isOpened == false
                          ? totalRoom! < state.localSlotData![0].freeCount!
                              ? setState(() {
                                  totalRoom = totalRoom! + 1;
                                  isOpened = true;
                                })
                              : _showToast(
                                  context, "Limit Reached", Toast.LENGTH_SHORT)
                          : _showToast(context, "Please save the opened room",
                              Toast.LENGTH_SHORT);
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
        new Column(
          children: _nextRoom(context, state),
        ),
        SizedBox(
          height: 20.0,
        ),
        _submitButton(context, state),
      ],
    );
  }

  _nextRoom(BuildContext context, GettingBookingSummaryRecieved state) {
    nextRoomList.clear();
    for (int i = 0; i < totalRoom!; i++) {
      nextRoomList.add(
        roomData[i].isDetailsAdded == false
            ? Column(
                children: [
                  Column(
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Room " + (i + 1).toString(),
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          _roomAddAndRemoverbutton(context, i),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      // roomData[i].maxTotalIndians != 0
                      //     ?
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Indian"),
                          Container(
                            width: 150,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("X  " +
                                    roomData[i].maxTotalIndians.toString()),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    roomData[i].maxTotalIndians! > 0
                                        ? setState(() {
                                            roomData[i].maxTotalIndians =
                                                roomData[i].maxTotalIndians! -
                                                    1;
                                            roomData[i].maxGuestCount =
                                                roomData[i].maxGuestCount! - 1;
                                            offlineRoomModel.indianCount =
                                                roomData[i].maxTotalIndians;
                                            newSeatCount = newSeatCount! - 1;
                                          })
                                        : _showToast(context, "Limit Reached",
                                            Toast.LENGTH_SHORT);
                                  },
                                  child: Icon(Icons.remove),
                                ),
                                SizedBox(width: 20.0),
                                InkWell(
                                    onTap: () {
                                      roomData[i].roomCount != 0
                                          ? roomData[i].maxGuestCount! <
                                                  roomData[i].roomCount!
                                              ? (guestPerRoom! + 1) !=
                                                      (roomData[i]
                                                              .maxTotalIndians! +
                                                          roomData[i]
                                                              .maxTotalForeigners!)
                                                  ? roomData[i]
                                                              .maxTotalIndians! <
                                                          maxTotalIndians!
                                                      ? setState(() {
                                                          roomData[i]
                                                                  .maxTotalIndians =
                                                              roomData[i]
                                                                      .maxTotalIndians! +
                                                                  1;
                                                          roomData[i]
                                                                  .maxGuestCount =
                                                              roomData[i]
                                                                      .maxGuestCount! +
                                                                  1;

                                                          offlineRoomModel
                                                                  .indianCount =
                                                              roomData[i]
                                                                  .maxTotalIndians;
                                                          newSeatCount =
                                                              newSeatCount! + 1;
                                                        })
                                                      : setState(() {
                                                          roomData[i]
                                                                  .extraAdded =
                                                              true;
                                                          _showToast(
                                                            context,
                                                            "Reached maximum",
                                                            Toast.LENGTH_SHORT,
                                                          );
                                                        })
                                                  : _showToast(
                                                      context,
                                                      "You can only add one extra member in a single room",
                                                      Toast.LENGTH_LONG,
                                                    )
                                              : _showToast(
                                                  context,
                                                  "Limit Reached",
                                                  Toast.LENGTH_SHORT)
                                          : _showToast(
                                              context,
                                              "Please select number of guest in a single room",
                                              Toast.LENGTH_SHORT);
                                    },
                                    child: Icon(Icons.add)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // : SizedBox.shrink(),
                      // roomData[i].maxTotalIndians != 0
                      //     ?
                      SizedBox(
                        height: 20.0,
                      ),
                      //     : SizedBox.shrink(),
                      // roomData[i].maxTotalForeigners != 0
                      //     ?
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Foreigner"),
                          Container(
                            width: 150,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("X  " +
                                    roomData[i].maxTotalForeigners.toString()),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    roomData[i].maxTotalForeigners! > 0
                                        ? setState(() {
                                            roomData[i].maxTotalForeigners =
                                                roomData[i]
                                                        .maxTotalForeigners! -
                                                    1;
                                            roomData[i].maxGuestCount =
                                                roomData[i].maxGuestCount! - 1;

                                            offlineRoomModel.foreignerCount =
                                                roomData[i].maxTotalForeigners;
                                            newSeatCount = newSeatCount! - 1;
                                          })
                                        : _showToast(context, "Limit Reached",
                                            Toast.LENGTH_SHORT);
                                  },
                                  child: Icon(Icons.remove),
                                ),
                                SizedBox(width: 20.0),
                                InkWell(
                                    onTap: () {
                                      roomData[i].roomCount != 0
                                          ? roomData[i].maxGuestCount! <
                                                  roomData[i].roomCount!
                                              ? (guestPerRoom! + 1) !=
                                                      (roomData[i]
                                                              .maxTotalIndians! +
                                                          roomData[i]
                                                              .maxTotalForeigners!)
                                                  ? roomData[i]
                                                              .maxTotalForeigners! <
                                                          maxTotalForeigners!
                                                      ? setState(
                                                          () {
                                                            roomData[i]
                                                                    .maxTotalForeigners =
                                                                roomData[i]
                                                                        .maxTotalForeigners! +
                                                                    1;
                                                            roomData[i]
                                                                    .maxGuestCount =
                                                                roomData[i]
                                                                        .maxGuestCount! +
                                                                    1;
                                                            offlineRoomModel
                                                                    .foreignerCount =
                                                                roomData[i]
                                                                    .maxTotalForeigners;
                                                            newSeatCount =
                                                                newSeatCount! +
                                                                    1;
                                                          },
                                                        )
                                                      : setState(() {
                                                          roomData[i]
                                                                  .extraAdded =
                                                              true;
                                                          _showToast(
                                                            context,
                                                            "Reached maximum",
                                                            Toast.LENGTH_SHORT,
                                                          );
                                                        })
                                                  : _showToast(
                                                      context,
                                                      "You can only add one extra member in a single room",
                                                      Toast.LENGTH_LONG,
                                                    )
                                              : _showToast(
                                                  context,
                                                  "Limit Reached",
                                                  Toast.LENGTH_SHORT)
                                          : _showToast(
                                              context,
                                              "Please select number of guest in a single room",
                                              Toast.LENGTH_SHORT);
                                    },
                                    child: Icon(Icons.add)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // : SizedBox.shrink(),
                      // roomData[i].maxTotalForeigners != 0
                      SizedBox(
                        height: 20.0,
                      ),
                      //     : SizedBox.shrink(),
                      // roomData[i].maxTotalChildren != 0
                      //     ?
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Children"),
                          Container(
                            width: 150,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("X  " +
                                    roomData[i].maxTotalChildren.toString()),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    roomData[i].maxTotalChildren! > 0
                                        ? setState(() {
                                            roomData[i].maxTotalChildren =
                                                roomData[i].maxTotalChildren! -
                                                    1;
                                            roomData[i].maxGuestCount =
                                                roomData[i].maxGuestCount! - 1;

                                            offlineRoomModel.childrenCount =
                                                roomData[i].maxTotalChildren;
                                            newSeatCount = newSeatCount! - 1;
                                          })
                                        : _showToast(context, "Limit Reached",
                                            Toast.LENGTH_SHORT);
                                  },
                                  child: Icon(Icons.remove),
                                ),
                                SizedBox(width: 20.0),
                                InkWell(
                                    onTap: () {
                                      roomData[i].roomCount != 0
                                          ? roomData[i].maxGuestCount! <
                                                  roomData[i].roomCount!
                                              ? roomData[i].maxTotalChildren! <
                                                      maxTotalChildren!
                                                  ? setState(() {
                                                      roomData[i]
                                                              .maxTotalChildren =
                                                          roomData[i]
                                                                  .maxTotalChildren! +
                                                              1;
                                                      roomData[i]
                                                              .maxGuestCount =
                                                          roomData[i]
                                                                  .maxGuestCount! +
                                                              1;
                                                      offlineRoomModel
                                                              .childrenCount =
                                                          roomData[i]
                                                              .maxTotalChildren;
                                                      newSeatCount =
                                                          newSeatCount! + 1;
                                                    })
                                                  : _showToast(
                                                      context,
                                                      "Reached maximum",
                                                      Toast.LENGTH_SHORT)
                                              : _showToast(
                                                  context,
                                                  "Limit Reached",
                                                  Toast.LENGTH_SHORT)
                                          : _showToast(
                                              context,
                                              "Please select number of guest in a single room",
                                              Toast.LENGTH_SHORT);
                                    },
                                    child: Icon(Icons.add)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // : SizedBox.shrink(),
                      // roomData[i].maxTotalChildren != 0
                      SizedBox(
                        height: 20.0,
                      ),
                      //     : SizedBox.shrink(),
                      new Container(
                        height: 45,
                        width: 270,
                        //savebutton
                        child: new TextButton(
                          style: StyleElements.submitAddPersonButtonStyle,
                          onPressed: () {
                            roomData[i].roomCount != 0 &&
                                        roomData[i].maxTotalIndians != 0 ||
                                    roomData[i].maxTotalForeigners != 0 ||
                                    roomData[i].maxTotalChildren != 0
                                ? roomData[i].roomCount ==
                                        (roomData[i].maxTotalIndians! +
                                            roomData[i].maxTotalForeigners! +
                                            roomData[i].maxTotalChildren!)
                                    ? setState(() {
                                        roomData[i].isDetailsAdded = true;
                                        oneRoomDataAdded = true;
                                        isOpened = false;

                                        offlineRoomDataList
                                            .add(OfflineRoomModel(
                                          roomCount: offlineRoomModel.roomCount,
                                          roomNumber:
                                              offlineRoomModel.roomNumber,
                                          indianCount:
                                              offlineRoomModel.indianCount,
                                          foreignerCount:
                                              offlineRoomModel.foreignerCount,
                                          childrenCount:
                                              offlineRoomModel.childrenCount,
                                          // totalCount: totalCount,
                                        ));
                                        print(offlineRoomDataList.length);
                                        offlineRoomModel =
                                            new OfflineRoomModel();
                                        // totalCount = 0;
                                      })
                                    : _showToast(
                                        context,
                                        "You can add " +
                                            roomData[i].roomCount.toString() +
                                            " member (s) in this room. But added only " +
                                            (roomData[i].maxTotalIndians! +
                                                    roomData[i]
                                                        .maxTotalForeigners! +
                                                    roomData[i]
                                                        .maxTotalChildren!)
                                                .toString() +
                                            " member (s).",
                                        Toast.LENGTH_LONG)
                                : _showToast(
                                    context,
                                    "Please add room members.",
                                    Toast.LENGTH_SHORT);
                          },
                          child: Text(
                            "SAVE",
                            style: StyleElements.buttonTextStyleSemiBoldBlack,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                children: [
                  AppCard(
                    outLineColor: HexColor('#292929'),
                    color: HexColor('#292929'),
                    child: Column(
                      children: [
                        new Row(
                          children: [
                            Text("Room " + (i + 1).toString() + " created"),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        new Row(
                          children: [
                            roomData[i].maxTotalIndians != 0
                                ? Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Indian X " +
                                          roomData[i]
                                              .maxTotalIndians
                                              .toString(),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            roomData[i].maxTotalForeigners != 0
                                ? Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Foreigner X " +
                                          roomData[i]
                                              .maxTotalForeigners
                                              .toString(),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            roomData[i].maxTotalChildren != 0
                                ? Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Children X " +
                                          roomData[i]
                                              .maxTotalChildren
                                              .toString(),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                        // SizedBox(
                        //   height: 15.0,
                        // ),
                        // new Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {
                        //         setState(() {
                        //           roomData.removeAt(i);
                        //           oneRoomDataAdded = false;
                        //           _showToast(
                        //               context,
                        //               "Room " + (i + 1).toString() + " Removed",
                        //               Toast.LENGTH_SHORT);
                        //         });
                        //       },
                        //       child: new Container(
                        //         height: 20.0,
                        //         width: 50.0,
                        //         padding: EdgeInsets.all(2.0),
                        //         decoration: new BoxDecoration(
                        //           color: Colors.red,
                        //           borderRadius: BorderRadius.circular(6.0),
                        //         ),
                        //         child: Center(
                        //           child: new Text(
                        //             "Remove",
                        //             style: new TextStyle(fontSize: 10.0),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
      );
    }

    return nextRoomList;
  }

  _roomAddAndRemoverbutton(BuildContext context, int i) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      width: 90.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  roomData[i].roomCount! > 0
                      ? setState(() {
                          roomData[i].roomCount = roomData[i].roomCount! - 1;
                          // roomData[i].maxTotalIndians = 0;
                          // roomData[i].maxTotalForeigners = 0;
                          // roomData[i].maxTotalChildren = 0;
                          // roomData[i].roomCount = 0;
                        })
                      : _showToast(
                          context, "Limit Reached", Toast.LENGTH_SHORT);
                  offlineRoomModel.roomCount = (roomData[i].roomCount);
                  print(
                      "offlineRoomModel ${offlineRoomModel.roomCount = (roomData[i].roomCount)}");
                  offlineRoomModel.roomNumber = (i + 1);
                  print("the room is ${i + 1}");
                  print("the room count is ${roomData[i].roomCount}");
                },
                child: Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              new Text(
                roomData[i].roomCount.toString(),
                style: TextStyle(color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  roomData[i].roomCount! < maxTotalGuests!
                      ? setState(() {
                          roomData[i].roomCount = roomData[i].roomCount! + 1;
                          // roomData[i].maxTotalIndians = 0;
                          // roomData[i].maxTotalForeigners = 0;
                          // roomData[i].maxTotalChildren = 0;

                          offlineRoomModel.roomCount = (roomData[i].roomCount);
                          print(
                              "offlineRoomModel ${offlineRoomModel.roomCount = (roomData[i].roomCount)}");
                          offlineRoomModel.roomNumber = (i + 1);
                        })
                      : _showToast(
                          context,
                          "You can add only " +
                              maxTotalGuests.toString() +
                              " persons in a single room",
                          Toast.LENGTH_LONG);

                  print("the room is ${i + 1}");
                  print("the room count is ${roomData[i].roomCount}");
                },
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showAlert(BuildContext context, int i) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Remove Room " + (i + 1).toString()),
      content: Text("Are you sure you wnat to Remove this Room ?"),
      actions: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Text(
              "Remove",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                nextRoomList.removeAt(i);
              });
              Navigator.pop(context);

              print("Guest Deletion - Initalized");
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

//roomdatalist
  addRoomsToList(BuildContext context, GettingBookingSummaryRecieved state) {
    if (state.offline == false) {
      for (int i = 0;
          i < int.parse(state.summaryData!.data![0].freeCount.toString());
          i++) {
        roomData.add(
          RoomModel(
            roomCount: 0,
            maxTotalIndians: 0,
            maxTotalForeigners: 0,
            maxTotalChildren: 0,
            maxExtraForeignerCount: maxExtraForeignerCount,
            maxExtraIndianCount: maxExtraIndianCount,
            maxExtraChildrenCount: maxExtraChildrenCount,
            maxGuestCount: 0,
            isDetailsAdded: false,
            extraAdded: false,
          ),
        );
      }
    } else {
      for (int i = 0; i < state.localSlotData![0].freeCount!; i++) {
        print("the free count ${state.localSlotData![0].freeCount}");
        roomData.add(
          RoomModel(
            roomCount: 0,
            maxTotalIndians: 0,
            maxTotalForeigners: 0,
            maxTotalChildren: 0,
            maxExtraForeignerCount: maxExtraForeignerCount,
            maxExtraIndianCount: maxExtraIndianCount,
            maxExtraChildrenCount: maxExtraChildrenCount,
            maxGuestCount: 0,
            isDetailsAdded: false,
            extraAdded: false,
          ),
        );
      }
    }
  }

  //roomsubmitbutton
  _submitButton(BuildContext context, GettingBookingSummaryRecieved state) {
    return new Container(
      height: 45,
      width: 270,
      child: new TextButton(
        style: StyleElements.submitButtonStyle,
        onPressed: () {
          if (oneRoomDataAdded == true) {
            _openLoadingDialog(context, "Adding room, Please wait.");
            getAllRoomData(context, state);
          } else {
            _showToast(context, "Please select and save room(s) and members.",
                Toast.LENGTH_LONG);
          }
        },
        child: Text(
          "SUBMIT",
          style: StyleElements.submitButtonText,
        ),
      ),
    );
  }

  void getAllRoomData(
      BuildContext context, GettingBookingSummaryRecieved state) {
    List<Map> finalRoomData = [];
    if (widget.isOffline == false) {
      for (int i = 0; i < roomData.length; i++) {
        if (roomData[i].isDetailsAdded == true) {
          finalRoomData.add({
            "total": roomData[i].maxGuestCount,
            "type": [
              {
                "name": "Indian",
                "value": roomData[i].maxTotalIndians,
              },
              {
                "name": "Foreigner",
                "value": roomData[i].maxTotalForeigners,
              },
              {
                "name": "Children",
                "value": roomData[i].maxTotalChildren,
              },
            ]
          });
        }
      }

      BlocProvider.of<BlocAddRoom>(context).add(
        SaveRoomData(
          newList: finalRoomData,
          numberOfRooms: totalRoom,
          programId: widget.programId,
          slotId: state.summaryData!.data![0].id,
          bookingDate: currentDate,
          isOffline: widget.isOffline,
        ),
      );
    } else {
      //finalroomsubmit
      for (int i = 0; i < roomData.length; i++) {
        if (roomData[i].isDetailsAdded == true) {
          finalRoomData.add({
            "total": roomData[i].maxGuestCount,
            "type": [
              {
                "name": "Indian",
                "value": roomData[i].maxTotalIndians,
              },
              {
                "name": "Foreigner",
                "value": roomData[i].maxTotalForeigners,
              },
              {
                "name": "Children",
                "value": roomData[i].maxTotalChildren,
              },
            ]
          });
        }
      }
      print("new seat count $newSeatCount and free count $freeCount");
      print(finalRoomData);

      BlocProvider.of<BlocAddRoom>(context).add(
        //roombloc
        SaveRoomData(
          maxTotalGuests: maxTotalGuests,
          newList: finalRoomData,
          numberOfRooms: state.localSlotData![0].freeCount! -
              int.parse(totalRoom.toString()),
          programId: widget.programId,
          slotId: state.localSlotData![0].id,
          title: widget.title,
          bookingDate: currentDate,
          isOffline: widget.isOffline,
          offlineRoomDataList: offlineRoomDataList,
          slotDetails: slotList,
          guestPerRoom: guestPerRoom,
          // vehicleInfo: widget.vehicleInfo,
          // freeCount: freeCount,
          totalMembers: state.localSlotData![0].freeCount! -
              int.parse(newSeatCount.toString()),
        ),
      );
    }

    print(totalRoom);
    print(finalRoomData);
  }

  checkInternet() async {
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (widget.isOffline == true) {
    List<BookingSummaryData> localSlotData = [];
    // Fluttertoast.showToast(msg: 'showing offline data');
    // print(connectivityResult);
    try {
      slotList =
          await db!.getSlotData('slotdetails_table_two', widget.programId);
      print("slotList ${slotList.length}");
      // slotList.forEach((element) {
      //   print(element);
      // });
      // print(slotList[0]['startTime']);
      programList =
          await db!.getProgramData('allprogramms_seven', widget.title);
      // print(programList[0]['cottageGuestPerRoom']);
      // print("program list");
      // print("------------------------------");
      // print(programList);
      // localSlotData.clear();
      for (int i = 0; i < slotList.length; i++) {
        print("slotList.length ${slotList.length}");
        localSlotData.add(
          BookingSummaryData(
            id: slotList[i]['idStringOne'],
            selected: false,
            startTime: slotList[i]['startTime'],
            endTime: slotList[i]['endTime'],
            status: slotList[i]['statusTwo'],
            freeCount: slotList[i]['freeCount'],
            availableNo: slotList[i]['availableNo'],
            bookedCount: slotList[i]['bookedCount'],
            slot: Slot(
              idOne: slotList[i]['idStringTwo'],
              programme: slotList[i]['programme'],
              fromDate: slotList[i]['fromDate'],
              toDate: slotList[i]['toDate'],
              slotType: slotList[i]['slotType'],
            ),
          ),
        );
        print(
          slotList[i]['freeCount'].toString(),
        );
      }
      print("localSlotData.length ${localSlotData.length}");

      BlocProvider.of<BookingBloc>(context).add(GetBookingSummary(
        id: widget.programId,
        date: currentDate,
        offlineData: slotList,
        programList: programList,
        isOffline: true,
        localSlotData: localSlotData,
      ));

      // slotList.forEach((element) {
      //   print(element);
      // });
    } catch (e) {
      print(e);
    }

    // } else {
    //   // Fluttertoast.showToast(msg: 'showing online data');
    //   BlocProvider.of<BookingBloc>(context).add(
    //     GetBookingSummary(
    //       id: widget.programId,
    //       date: currentDate,
    //       isOffline: widget.isOffline,
    //     ),
    //   );
    // }
  }
}

void _openLoadingDialog(BuildContext context, String s) {
  showDialog(
    barrierDismissible: false,
    context: context,
    barrierColor: Colors.black38,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ),
        ],
      );
    },
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

class ListModel {
  bool? status;
  String? name;
  int? value, extraCount;
  ListModel({this.status, this.name, this.extraCount, this.value});
}

class RoomModel {
  int? roomCount,
      maxGuestCount,
      maxTotalGuests,
      maxTotalIndians,
      maxTotalForeigners,
      maxTotalChildren,
      maxExtraGuestCount,
      maxExtraIndianCount,
      maxExtraForeignerCount,
      maxExtraChildrenCount;
  String? type;
  bool? isDetailsAdded, extraAdded;
  RoomModel({
    this.roomCount,
    this.isDetailsAdded,
    this.type,
    this.extraAdded,
    this.maxGuestCount,
    this.maxExtraChildrenCount,
    this.maxExtraForeignerCount,
    this.maxExtraGuestCount,
    this.maxExtraIndianCount,
    this.maxTotalChildren,
    this.maxTotalForeigners,
    this.maxTotalGuests,
    this.maxTotalIndians,
  });
}

class OfflineRoomModel {
  int? roomNumber,
      roomCount,
      indianCount,
      foreignerCount,
      childrenCount,
      totalCount;
  OfflineRoomModel({
    this.roomCount,
    this.roomNumber,
    this.childrenCount,
    this.foreignerCount,
    this.indianCount,
    this.totalCount,
  });
}
//1449
