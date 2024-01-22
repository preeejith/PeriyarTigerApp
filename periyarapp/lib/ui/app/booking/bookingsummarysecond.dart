import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:objectid/objectid.dart';
import 'package:parambikulam/bloc/addperson/blocaddperson.dart';
import 'package:parambikulam/bloc/addperson/eventaddperson.dart';
import 'package:parambikulam/bloc/addperson/stateaddperson.dart';
import 'package:parambikulam/bloc/addroomperson/blocaddroomperson.dart';
import 'package:parambikulam/bloc/addroomperson/eventaddroomperson.dart';
import 'package:parambikulam/bloc/addroomperson/stateaddroomperson.dart';
import 'package:parambikulam/bloc/booking/bookingbloc.dart';
import 'package:parambikulam/bloc/booking/bookingevent.dart';
import 'package:parambikulam/bloc/booking/bookingstate.dart';
import 'package:parambikulam/bloc/busbloc/busbloc.dart';
import 'package:parambikulam/bloc/entrancecharge/blocentrancecharge.dart';
import 'package:parambikulam/bloc/entrancecharge/evententrancecharge.dart';
import 'package:parambikulam/bloc/finalbooking/blocfinalbooking.dart';
import 'package:parambikulam/bloc/finalbooking/eventfinalbooking.dart';
import 'package:parambikulam/bloc/finalbooking/statefinalbooking.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/bloc/programs/programsevent.dart';
import 'package:parambikulam/bloc/programs/programsstate.dart';
import 'package:parambikulam/bloc/updateguest/blocroomupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/blocupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/eventroomupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/eventupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/stateroomupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/stateupdateguest.dart';
import 'package:parambikulam/bloc/vehicle/blocvehicle.dart';
import 'package:parambikulam/bloc/vehicle/eventvehicle.dart';
import 'package:parambikulam/bloc/vehicle/statevehicle.dart';
import 'package:parambikulam/data/models/busmodel.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/booking/bookingsummary.dart';
import 'package:parambikulam/ui/app/scanner%20&%20ticket/onlinebookedticket.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';
import 'package:parambikulam/ui/app/widgets/textinputfield.dart';
import 'package:parambikulam/utils/helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../config.dart';

class BookingSummarySecond extends StatefulWidget {
  final OfflineBooking? offlineBooking;
  final String? title, date;
  final bool? isCottage, isOffline;
  final List<Map>? offlineData, programList, slotDetails, vehicleInfo;
  final List<OfflineRoomModel>? offlineRoomModel;
  // final List<BusData>? busData;
  BookingSummarySecond({
    this.title,
    this.date,
    // this.busData,
    this.vehicleInfo,
    this.isCottage,
    this.isOffline,
    this.offlineRoomModel,
    this.offlineBooking,
    this.programList,
    this.slotDetails,
    this.offlineData,
  });
  _BookingSummarySecond createState() => _BookingSummarySecond();
}

class _BookingSummarySecond extends State<BookingSummarySecond> {
  final f = new DateFormat('MMMM dd, yyyy');
  final g = new DateFormat('yyyy-MM-dd');
  final time = new DateFormat('hh:mm a');
  String pguestId = "", pticketId = '';
  String? totalAmount;
  List<Customers> customersList = [];
  List<RoomCount> roomList = [];
  List<InnerListIndividual> innerListIndividual = [];
  List<AddedPerson> totalPerson = [];
  String? currentCutomer;
  List<VeicleInformation> vehicleDetails = [];
  List<VeicleInformation> vehicleDetailsSelected = [];
  List<Customers> newList = [];
  List<Customers> indianList = [];
  List<Customers> indianListAll = [];
  List<Customers> foreignerList = [];
  List<Customers> childrenList = [];
  List<Map> vehicleDetailsList = [];
  List<Map> vehicleInfo = [];
  List? newListTwo = [];
  int? vehicleAddCount = 0, personCount = 0;
  int? editingIndex, indianI = 0;
  int? allCount = 0, size, activeKey = 0;
  String? cartId, name, theName;
  String path = "Empty";
  bool? isEnabled, isActivated;
  int? currentIndex, currentIndexTwo, selected = 0, selectedTwo = 0;
  bool? isExpanded = false, deleted = false;
  bool? disablePsButton = true;
  bool? isEditing = false, cameraState = false;
  File? imageFile;
  int? count = 0, totalGuests = 0;
  DatabaseHelper? db = DatabaseHelper.instance;
  final ticketId = ObjectId();
  bool isRemoved = false, isAdded = true;
  bool timer = false;
  Color? borderColor = Colors.green;
  BookingBloc? bookingBloc;
  QRViewController? controller;
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  BuildContext? dialogContext;
  List<Widget>? widgetList;
  List<BusAllocationModel>? busAllocation;
  DateTime? currentBackPressedTime;
  @override
  void initState() {
    context.read<BusBloc>().busAllocated.clear();
    context.read<BusBloc>().totalMembers = widget.offlineBooking!.indianCount! +
        widget.offlineBooking!.foreignerCount! +
        widget.offlineBooking!.childrenCount!;
    context.read<BusBloc>().remaining = widget.offlineBooking!.indianCount! +
        widget.offlineBooking!.foreignerCount! +
        widget.offlineBooking!.childrenCount!;
    print(widget.isCottage);
    isActivated = false;
    isEnabled = true;
    context.read<BusBloc>().add(GetBusData(isFilter: true));
    BlocProvider.of<BlocVehicle>(context).add(
      RefreshEvent(),
    );
    BlocProvider.of<BlocEntranceCharge>(context).add(
      RefreshBloc(),
    );
    checkStatus();
    getPermission();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    BookingBloc().close();
    AddPersonBloc().close();
    BlocEntranceCharge().close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressedTime == null ||
            now.difference(currentBackPressedTime!) > Duration(seconds: 2)) {
          currentBackPressedTime = now;
          Helper.centerToast("Press again to go to home page");
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: BlocConsumer<BookingBloc, BookingState>(
        //mainbloc
        builder: (context, state) {
          if (state is PartialBookingDataTwoReceived) {
            return new Scaffold(
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
              body: new SafeArea(
                child: new SingleChildScrollView(
                  child: new Container(
                    padding: EdgeInsets.all(12.0),
                    child: new Column(
                      children: <Widget>[
                        BlocConsumer<ProgramsBloc, ProgramsState>(
                          listener: (context, state) {
                            if (state is LoadedBookingDataToBooking) {
                              Navigator.of(context).pop();
                              if (widget.isOffline == false) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OnlineBookedTicket(
                                      ticketId: ticketId.toString(),
                                      bookingDetails: state.bookingDetails,
                                      programmList: widget.programList,
                                      isCottage: widget.isCottage,
                                      isOffline: widget.isOffline,
                                      previousBooked: false,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OnlineBookedTicket(
                                      ticketId: ticketId.toString(),
                                      isOffline: widget.isOffline,
                                      programmList: widget.programList,
                                      offlineBooking: widget.offlineBooking,
                                      isCottage: widget.isCottage,
                                      previousBooked: false,
                                    ),
                                  ),
                                );
                              }
                            } else if (state is BookingsDataNotReceived) {
                              _showToast(
                                  context, state.error, Toast.LENGTH_LONG);
                            }
                          },
                          builder: (context, state) {
                            // if (state is LoadedBookingDataToBooking) {
                            //   return new TextButton(
                            //     style: StyleElements.submitButtonStyle,
                            //     onPressed: () {},
                            //     child: SizedBox(
                            //       height: 28.0,
                            //       width: 28.0,
                            //       child: CircularProgressIndicator(
                            //         valueColor: AlwaysStoppedAnimation<Color>(
                            //             Colors.white),
                            //         strokeWidth: 2,
                            //       ),
                            //     ),
                            //   );
                            // }
                            return Container();
                          },
                        ),
                        BlocConsumer<BlocVehicle, StateVehicle>(
                            builder: (context, state) {
                          // if (state is VehicleAddedSuccess) {
                          //   _openLoadingDialog(context);
                          // }
                          return SizedBox.shrink();
                          // else {
                          // return SizedBox.shrink();
                          // }
                        }, listener: (context, state) {
                          if (state is VehicleAddedSuccess) {
                            Navigator.of(context).pop();
                            if (widget.isOffline == false) {
                              print("Vehicle Added At Index - " +
                                  state.index.toString());
                              print("Vehicle Added Id - " +
                                  state.vehicleAdded!.data![0].id.toString());
                              setState(() {
                                vehicleDetailsSelected[state.index!].id =
                                    state.vehicleAdded!.data![0].id.toString();
                                // print(state.vehicleAdded!.data![state.index!].id
                                //     .toString());

                                // entranceTicket = state
                                //     .bookingSummaryAll!.data!.entranceTickettotal
                                //     .toString();
                                //COMMENTED FINAL AMOUNT
                                // totalAmount = state
                                //     .bookingSummaryAll!.data!.finalAmount
                                //     .toString();
                                print("Final Amount After Vehicle Added - " +
                                    state.bookingSummaryAll!.data!.finalAmount
                                        .toString());
                              });
                              BlocProvider.of<BlocVehicle>(context).add(
                                RefreshEvent(),
                              );
                            } else {
                              setState(() {
                                vehicleDetailsSelected[state.index!].id =
                                    state.index.toString();
                              });
                              BlocProvider.of<BlocVehicle>(context).add(
                                RefreshEvent(),
                              );
                            }
                          }
                          if (state is VehicleUpdatedSuccess) {
                            Navigator.of(context).pop();
                            if (state.isOffline == false) {
                              print("Vehicle Updated At Index - " +
                                  state.index.toString());
                              // print("Vehicle Updated Id - " +
                              //     state.vehicleModified!.data!.id.toString());
                              setState(() {
                                // vehicleDetailsSelected[state.index!].id = state
                                //       .vehicleModified!.data!.id
                                //       .toString();
                                // print(state.vehicleAdded!.data![state.index!].id
                                //     .toString());

                                // entranceTicket = state
                                //     .bookingSummaryAll!.data!.entranceTickettotal
                                //     .toString();
                                //COMMENTED - FINAL AMOUNT
                                // totalAmount = state
                                //     .bookingSummaryAll!.data!.finalAmount
                                //     .toString();
                                print("Final Amount After Vehicle Added - " +
                                    state.bookingSummaryAll!.data!.finalAmount
                                        .toString());
                                BlocProvider.of<BlocVehicle>(context).add(
                                  RefreshEvent(),
                                );
                              });
                            } else {
                              BlocProvider.of<BlocVehicle>(context).add(
                                RefreshEvent(),
                              );
                            }
                          }
                          if (state is VehicleRemovededSuccess) {
                            Navigator.of(context).pop();
                            if (state.isOffline == false) {
                              print("Vehicle Removed At Index - " +
                                  state.index.toString());
                              print("Vehicle Removed Id - " +
                                  state.vehicleModified!.data!.id.toString());
                              setState(() {
                                // vehicleDetailsSelected[state.index!].id =
                                //     state.vehicleModified!.data!.id.toString();
                                // print(state.vehicleAdded!.data![state.index!].id
                                //     .toString());

                                // entranceTicket = state
                                //     .bookingSummaryAll!.data!.entranceTickettotal
                                //     .toString();
                                //COMMENTED - FINAL AMOUNT
                                // totalAmount = state
                                //     .bookingSummaryAll!.data!.finalAmount
                                //     .toString();
                                // print("Final Amount After Vehicle Removed - " +
                                //     state.bookingSummaryAll!.data!.finalAmount
                                //         .toString());
                                vehicleAddCount = vehicleAddCount! - 1;
                                // vehicleDetailsSelected.removeAt(vehicleAddCount!);
                                vehicleDetailsSelected.removeAt(state.index!);
                              });
                              BlocProvider.of<BlocVehicle>(context).add(
                                RefreshEvent(),
                              );
                            } else {
                              setState(() {
                                vehicleAddCount = vehicleAddCount! - 1;
                                vehicleDetailsSelected.removeAt(state.index!);
                              });
                              BlocProvider.of<BlocVehicle>(context).add(
                                RefreshEvent(),
                              );
                            }
                          }
                        }),
                        _bookingSummarySecond(context, state),
                        SizedBox(
                          height: 20.0,
                        ),
                        _guestNumber(context, state),
                        assignBus(context, state),

                        // Divider(),
                        // _addVehicles(context),
                        // Divider(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _finalSubmitButton(context),
                        SizedBox(
                          height: 10.0,
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
        listener: (context, state) async {
          if (state is PartialBookingDataTwoReceived) {
            if (state.isOffline == false) {
              //-----------------------------------------------------------
              // bookingDate = state.bookingSummaryAll!.data!.bookingDate.toString();
              setState(() {
                // entranceTicket =
                //     state.bookingSummaryAll!.data!.entranceTickettotal.toString();
                totalAmount =
                    state.bookingSummaryAll!.data!.finalAmount.toString();
              });
              state.bookingSummaryAll!.data!.isCottage == true
                  //alllist
                  ? buildRoomList(context, state)
                  : buildSeatList(context, state);
              //   addToVehicleList(context, state);
              //-----------------------------------------------------------
              // addIndividualCustomer();
            } else {
              if (widget.isCottage == false) {
                await buildSeatList(context, state);
                //  addToVehicleList(context, state);
              } else {
                await buildRoomList(context, state);
                // addToVehicleList(context, state);
              }
            }
          }
          // if (state is VehicleAddedSuccess) {
          //   setState(() {
          //     // vehicleDetailsSelected[state.index!].id =
          //     //     state.vehicleAdded!.data![state.index!].id.toString();
          //   });
          // }
        },
      ),
    );
  }

  _bookingSummarySecond(
      BuildContext context, PartialBookingDataTwoReceived state) {
    return Container(
      child: Column(
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
          AppCard(
            outLineColor: HexColor('#292929'),
            color: HexColor('#292929'),
            child: new Column(
              children: [
                new Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: new Text(
                        'Selected Date',
                        style: StyleElements.bookingDetailsTitle,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: new Text(
                        'Selected Slot',
                        style: StyleElements.bookingDetailsTitle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                new Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: state.isOffline == false
                          ? new Text(
                              f.format(
                                DateTime.parse(
                                  state.bookingSummaryAll!.data!.bookingDate
                                      .toString(),
                                ),
                              ),
                            )
                          : new Text(
                              f.format(
                                DateTime.parse(
                                  widget.date.toString(),
                                ),
                              ),
                            ),
                    ),
                    // -----------------------------------------------------------
                    Expanded(
                      flex: 1,
                      child: state.isOffline == false
                          ? new Text(
                              state.bookingSummaryAll!.data!.slotDetail!
                                      .startTime
                                      .toString() +
                                  " - " +
                                  state.bookingSummaryAll!.data!.slotDetail!
                                      .endTime
                                      .toString(),
                            )
                          : widget.isCottage == false
                              ? state.slotDetails != null
                                  ? new Text(
                                      // '',
                                      state.slotDetails![0]['startTime']
                                              .toString() +
                                          " - " +
                                          state.slotDetails![0]['endTime']
                                              .toString(),
                                    )
                                  : Text("N/A")
                              : new Text(
                                  widget.offlineBooking!.startTime.toString() +
                                      " - " +
                                      widget.offlineBooking!.endTime.toString(),
                                ),
                    )
                    // -----------------------------------------------------------
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                new Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: new Text(
                        'Package',
                        style: StyleElements.bookingDetailsTitle,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: new Text(
                        'Entrance Ticket',
                        style: StyleElements.bookingDetailsTitle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),

                //-----------------------------------------------------------

                new Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: state.isOffline == false
                            ? new Text(
                                state.bookingSummaryAll!.data!.programme!
                                    .progName
                                    .toString(),
                              )
                            : new Text(
                                widget.programList![0]['progName'].toString(),
                              )),
                    Expanded(
                        flex: 1,
                        child:
                            // new Text(
                            //   "0 INR",
                            // ),
                            // state.isOffline == false
                            //     ? entranceTicket != null || entranceTicket != ""
                            //         ? new Text(
                            //             entranceTicket.toString() + " INR",
                            //           )
                            //         : new Text(
                            //             "0 INR",
                            //           )
                            //     : entranceTicket != null || entranceTicket != ""
                            //         ? new Text(
                            //             widget.offlineBooking!.entranceCharge
                            //                     .toString() +
                            //                 " INR",
                            //           )
                            //         : new Text(
                            //             "0 INR",
                            //           )),
                            Text("N/A"))
                  ],
                ),
                //-----------------------------------------------------------
                SizedBox(
                  height: 10.0,
                ),

                isExpanded == true
                    ? Column(
                        children: [
                          new Row(
                            children: [
                              Expanded(
                                child: new Text(
                                  'Bill Summary',
                                  style: StyleElements.bookingDetailsTitle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          state.isOffline == false
                              ? state.bookingSummaryAll!.data!.indian != 0
                                  ? Column(
                                      children: [
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            new Text(
                                              'Indian X ' +
                                                  state.bookingSummaryAll!.data!
                                                      .indian
                                                      .toString(),
                                            ),
                                            new Text(
                                              state.bookingSummaryAll!.data!
                                                  .indianTotal
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink()
                              : widget.offlineBooking!.indianCount != 0
                                  ? Column(
                                      children: [
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            new Text(
                                              'Indian X ' +
                                                  widget.offlineBooking!
                                                      .indianCount
                                                      .toString(),
                                            ),
                                            new Text(
                                              widget.offlineBooking!.indianTotal
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                          state.isOffline == false
                              ? state.bookingSummaryAll!.data!.foreigner != 0
                                  ? Column(
                                      children: [
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            new Text(
                                              'Foreigner X ' +
                                                  state.bookingSummaryAll!.data!
                                                      .foreigner
                                                      .toString(),
                                            ),
                                            new Text(
                                              state.bookingSummaryAll!.data!
                                                  .foreignerTotal
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink()
                              : widget.offlineBooking!.foreignerCount != 0
                                  ? Column(
                                      children: [
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            new Text(
                                              'Foreigner X ' +
                                                  widget.offlineBooking!
                                                      .foreignerCount
                                                      .toString(),
                                            ),
                                            new Text(
                                              widget.offlineBooking!
                                                  .foreignerTotal
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                          state.isOffline == false
                              ? state.bookingSummaryAll!.data!.children != 0
                                  ? Column(
                                      children: [
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            new Text(
                                              'Children X ' +
                                                  state.bookingSummaryAll!.data!
                                                      .children
                                                      .toString(),
                                            ),
                                            new Text(
                                              state.bookingSummaryAll!.data!
                                                  .childrenTotal
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink()
                              : widget.offlineBooking!.childrenCount != 0
                                  ? Column(
                                      children: [
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            new Text(
                                              'Children X ' +
                                                  widget.offlineBooking!
                                                      .childrenCount
                                                      .toString(),
                                            ),
                                            new Text(
                                              widget
                                                  .offlineBooking!.childrenTotal
                                                  .toString(),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                          Divider(
                            color: Colors.white,
                            thickness: 1.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                new Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: new Text(
                        'Total',
                        style: StyleElements.bookingDetailsTitle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    state.isOffline == false
                        ? (state.bookingSummaryAll!.data!.indian! +
                                    state.bookingSummaryAll!.data!.foreigner! +
                                    state.bookingSummaryAll!.data!.children!) >
                                1
                            ? new Text(
                                (state.bookingSummaryAll!.data!.indian! +
                                            state.bookingSummaryAll!.data!
                                                .foreigner! +
                                            state.bookingSummaryAll!.data!
                                                .children!)
                                        .toString() +
                                    " Persons",
                              )
                            : new Text(
                                (state.bookingSummaryAll!.data!.indian! +
                                            state.bookingSummaryAll!.data!
                                                .foreigner! +
                                            state.bookingSummaryAll!.data!
                                                .children!)
                                        .toString() +
                                    " Person",
                              )
                        : (widget.offlineBooking!.indianCount! +
                                    widget.offlineBooking!.foreignerCount! +
                                    widget.offlineBooking!.childrenCount!) >
                                1
                            ? new Text(
                                (widget.offlineBooking!.indianCount! +
                                            widget.offlineBooking!
                                                .foreignerCount! +
                                            widget
                                                .offlineBooking!.childrenCount!)
                                        .toString() +
                                    " Persons",
                              )
                            : new Text(
                                (widget.offlineBooking!.indianCount! +
                                            widget.offlineBooking!
                                                .foreignerCount! +
                                            widget
                                                .offlineBooking!.childrenCount!)
                                        .toString() +
                                    " Person",
                              ),
                    state.isOffline == false
                        ? new Text(
                            totalAmount.toString() + ' INR',
                          )
                        : new Text(
                            widget.offlineBooking!.totalAmount.toString() +
                                ' INR',
                          )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),

                isExpanded == true
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = false;
                          });
                        },
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View Less",
                              style: TextStyle(
                                  color: HexColor("#838383"), fontSize: 12.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            new Icon(
                              Icons.arrow_circle_up_outlined,
                              color: HexColor("#838383"),
                              size: 15.0,
                            ),
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = true;
                          });
                          // Fluttertoast.showToast(msg: "View More");
                        },
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "View More",
                              style: TextStyle(
                                  color: HexColor("#838383"), fontSize: 12.0),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            new Icon(
                              Icons.arrow_circle_down_outlined,
                              color: HexColor("#838383"),
                              size: 15.0,
                            )
                          ],
                        ),
                      ),

                //-----------------------------------------------------------
              ],
            ),
          ),
        ],
      ),
    );
  }

  //-----------------------------------------------------------

  _guestNumber(BuildContext context, PartialBookingDataTwoReceived state) {
    return new Column(
      children: [
        new Row(
          children: [
            Expanded(
              child: new Text("Add More Guest Details"),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        widget.isOffline == false
            ?
            // new Column(
            //   children: _buildGuestAddList(context, state),
            // )
            // ------------------------------------------------------------------------
            // ------------------------------------------------------------------------
            state.bookingSummaryAll!.data!.isCottage == true
                ?
                // ------------------------------------------------------------------------
                new ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        state.bookingSummaryAll!.data!.roomAllocation!.length,
                    itemBuilder: (context, index) {
                      return new Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          textColor: HexColor("#53A874"),
                          iconColor: HexColor("#53A874"),
                          tilePadding: EdgeInsets.all(0),
                          title: Text(
                            "Room " + (index + 1).toString(),
                          ),
                          trailing: Text(
                            "Add Guest X " +
                                state.bookingSummaryAll!.data!
                                    .roomAllocation![index].totalCount
                                    .toString(),
                          ),
                          children: roomGuestInnerList(context, index, state),
                        ),
                      );
                    })
                :
                //------------------------------------------------------------------------
                new ListView.builder(
                    //firstlist
                    // key: Key(selected.toString()),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: customersList.length,
                    itemBuilder: (context, index) {
                      if (customersList[index].status == true) {
                        count = count! + 1;
                        return Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            textColor: HexColor("#53A874"),
                            iconColor: HexColor("#53A874"),
                            // key: Key(index.toString()),
                            // initiallyExpanded: index == selected,
                            // onExpansionChanged: ((state) {
                            //   if (state)
                            //     setState(() {
                            //       Duration(seconds: 20000);
                            //       selected = index;
                            //     });
                            //   else
                            //     setState(() {
                            //       selected = -1;
                            //     });
                            // }),
                            leading: Text(
                              (index + 1).toString(),
                            ),
                            title: Text(customersList[index].name.toString()),
                            trailing: Text(
                              customersList[index].count! > 1
                                  ? customersList[index].count.toString() +
                                      " Persons"
                                  : customersList[index].count.toString() +
                                      " Person",
                              style: StyleElements.bookingDetailsTitle,
                            ),
                            children: innerList(context, index, state),

                            // children: Builder(builder: (context, index){

                            // })
                          ),
                        );
                        // : Container();
                      }
                      return Container();
                    }

                    // separatorBuilder: (context, index) {
                    //   return Divider();
                    //   // return index == 1 ? Divider() : new SizedBox.shrink();
                    // },
                    )
            : widget.isCottage == true
                ? new ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.offlineRoomModel!.length,
                    itemBuilder: (context, index) {
                      return new Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          textColor: HexColor("#53A874"),
                          iconColor: HexColor("#53A874"),
                          tilePadding: EdgeInsets.all(0),
                          title: Text(
                            "Room " + (index + 1).toString(),
                          ),
                          trailing: Text(
                            "Add Guest X " +
                                widget.offlineRoomModel![index].roomCount
                                    .toString(),
                          ),
                          children: roomGuestInnerList(context, index, state),
                        ),
                      );
                    })
                :
                //------------------------------------------------------------------------
                new ListView.builder(
                    //firstlist
                    // key: Key(selected.toString()),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: customersList.length,
                    itemBuilder: (context, index) {
                      if (customersList[index].status == true) {
                        count = count! + 1;
                        return Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            textColor: HexColor("#53A874"),
                            iconColor: HexColor("#53A874"),
                            // key: Key(index.toString()),
                            // initiallyExpanded: index == selected,
                            // onExpansionChanged: ((state) {
                            //   if (state)
                            //     setState(() {
                            //       Duration(seconds: 20000);
                            //       selected = index;
                            //     });
                            //   else
                            //     setState(() {
                            //       selected = -1;
                            //     });
                            // }),
                            leading: Text(
                              (index + 1).toString(),
                            ),
                            title: Text(customersList[index].name.toString()),
                            trailing: Text(
                              customersList[index].count! > 1
                                  ? customersList[index].count.toString() +
                                      " Persons"
                                  : customersList[index].count.toString() +
                                      " Person",
                              style: StyleElements.bookingDetailsTitle,
                            ),
                            children: innerList(context, index, state),

                            // children: Builder(builder: (context, index){

                            // })
                          ),
                        );
                        // : Container();
                      }
                      return Container();
                    }

                    // separatorBuilder: (context, index) {
                    //   return Divider();
                    //   // return index == 1 ? Divider() : new SizedBox.shrink();
                    // },
                    ),

        BlocConsumer<BlocUpdateGuest, StateUpdateGuest>(
          builder: (context, state) {
            return SizedBox.shrink();
          },
          listener: (context, state) {
            if (state is PersonDeleted) {
              // if (deleted == true) {
              print("DELETED");
              setState(() {
                allCount = allCount! + 1;
                // newList[state.index!].isDetailsAdded = false;
                // print("New count - " + allCount.toString());
                state.list![state.index!].isDetailsAdded = false;
                state.list![state.index!].isEdStarted = false;
                // isActivated == true
                //     ? newList[state.index!].isEdStarted = false
                //     : newList[state.index!].isEdStarted = true;
              });

              print("Deleted " +
                  newList[state.index!].name.toString() +
                  " 's Data");

              // Navigator.pop(context);
              BlocProvider.of<BlocUpdateGuest>(context).add(RefreshStateOne());
              // }
              // Navigator.pop(context);

              //seatpd
            }
            if (state is PersonNotDeleted) {
              Navigator.pop(context);
              _showToast(context, "Not Deleted", Toast.LENGTH_SHORT);
            }
          },
        ),
        //barea
        BlocConsumer<AddPersonBloc, AddPersonState>(builder: (context, state) {
          return SizedBox.shrink();
        }, listener: (context, state) {
          if (state is PersonAdded) {
            //seatpa
            if (widget.isOffline == false) {
              setState(() {
                isActivated = false;
                newList[state.currentIndex!].isDetailsAdded = true;
                allCount = allCount! - 1;
                print("New Count " + allCount.toString());
                //------
                //COMMENTED - FINAL AMOUNT
                // totalAmount =
                //     state.bookingSummaryAll!.data!.finalAmount.toString();
                print(state.bookingSummaryAll!.data!.total.toString());
                // entranceTicket = state
                //     .bookingSummaryAll!.data!.entranceTickettotal
                //     .toString();
                //------
                newList[state.currentIndex!].isDetailsAdded = true;
                newList[state.currentIndex!].name = state.name;
                newList[state.currentIndex!].phoneNumber = state.phone;
                newList[state.currentIndex!].personUniqueID = state.id;
                newList[state.currentIndex!].dob = state.dob;
                newList[state.currentIndex!].type = state.type;
              });
              BlocProvider.of<AddPersonBloc>(context)
                  .add(RefreshAddPersonBloc());
            } else {
              setState(() {
                isRemoved = false;
                isAdded = true;
                isActivated = false;
                newList[state.currentIndex!].isDetailsAdded = true;
                allCount = allCount! - 1;
                newList[state.currentIndex!].isDetailsAdded = true;
                newList[state.currentIndex!].name = state.name;
                newList[state.currentIndex!].phoneNumber = state.phone;
                newList[state.currentIndex!].personUniqueID = state.id;
                newList[state.currentIndex!].dob = state.dob;
                newList[state.currentIndex!].type = state.type;
              });
              BlocProvider.of<AddPersonBloc>(context)
                  .add(RefreshAddPersonBloc());
              BlocProvider.of<BlocEntranceCharge>(context).add(RefreshBloc());

              // BlocProvider.of<BlocEntranceCharge>(context).add(RefreshBloc());
            }
          }
          if (state is PersonNotAdded) {
            print("Current Count " + allCount.toString());
            _showToast(context, state.message.toString(), Toast.LENGTH_SHORT);
          }
          if (state is PersonUpdated) {
            setState(() {
              newList[state.currentIndex!].isDetailsAdded = true;
              newList[state.currentIndex!].name = state.name;
              newList[state.currentIndex!].phoneNumber = state.phone;
              // newList[state.currentIndex!].email =
              //     state.email;
              newList[state.currentIndex!].personUniqueID = state.id;
              newList[state.currentIndex!].dob = state.dob;
              newList[state.currentIndex!].type = state.type;
            });
          }
          if (state is PersonNotUpdated) {
            print("Current Count " + allCount.toString());
            _showToast(context, state.message.toString(), Toast.LENGTH_SHORT);
          }
        }),

        BlocConsumer<BlocRoomUpdateGuest, StateRoomUpdateGuest>(
          builder: (context, state) {
            return Container();
          },
          listener: (context, state) {
            if (state is DeletionRoomInitialized) {
              // Navigator.pop(context);
              _openLoadingDialog(context, "Deleting");
              print("DeletionInitialized State Activated");
            }
            //rpd
            if (state is PersonRoomDeleted) {
              setState(() {
                allCount = allCount! + 1;
                print("New count after delete - " + allCount.toString());
                state.list![state.i!].isDetailsAdded = false;
                state.list![state.i!].isEdStarted = false;
              });
              _showToast(context, "Deleted Successfully", Toast.LENGTH_SHORT);

              BlocProvider.of<BlocRoomUpdateGuest>(context)
                  .add(RefreshStateOneRoom());
            }
            if (state is PersonRoomNotDeleted) {
              Navigator.pop(context);
              _showToast(context, "Not Deleted", Toast.LENGTH_SHORT);
            }
            if (state is RefreshStateOneRoomGuest) {
              Navigator.pop(context);
            }
          },
        ),

        BlocConsumer<BlocAddRoomPerson, StateAddRoomPerson>(
          builder: (context, state) {
            return SizedBox.shrink();
          },
          listenWhen: ((previous, current) =>
              current is RoomPersonAdded || current is RoomPersonNotAdded),
          listener: (context, state) {
            if (state is RoomPersonAdded) {
              //rpa
              print("RoomPersonAdded - Listener");
              if (widget.isOffline == false) {
                setState(() {
                  isActivated = false;
                  allCount = allCount! - 1;
                  print("New Count " + allCount.toString());
                  //COMMENTED - FINAL AMOUNT
                  // totalAmount =
                  //     state.bookingSummaryAll!.data!.finalAmount.toString();
                  print(state.bookingSummaryAll!.data!.total.toString());
                  // entranceTicket = state
                  //     .bookingSummaryAll!.data!.entranceTickettotal
                  //     .toString();

                  if (state.type == "indian") {
                    roomList[state.roomIndex!]
                        .indianList![state.currentIndex!]
                        .isDetailsAdded = true;

                    roomList[state.roomIndex!]
                        .indianList![state.currentIndex!]
                        .name = state.name;

                    roomList[state.roomIndex!]
                        .indianList![state.currentIndex!]
                        .dob = state.dob;

                    roomList[state.roomIndex!]
                        .indianList![state.currentIndex!]
                        .type = state.type;

                    roomList[state.roomIndex!]
                        .indianList![state.currentIndex!]
                        .personUniqueID = state.id;
                    print("Person Unique ID after saving (ROOM - indian)" +
                        state.id.toString());
                  } else if (state.type == "foreigner") {
                    roomList[state.roomIndex!]
                        .foreignerList![state.currentIndex!]
                        .isDetailsAdded = true;

                    roomList[state.roomIndex!]
                        .foreignerList![state.currentIndex!]
                        .name = state.name;

                    roomList[state.roomIndex!]
                        .foreignerList![state.currentIndex!]
                        .dob = state.dob;

                    roomList[state.roomIndex!]
                        .foreignerList![state.currentIndex!]
                        .type = state.type;

                    roomList[state.roomIndex!]
                        .foreignerList![state.currentIndex!]
                        .personUniqueID = state.id;
                    print("Person Unique ID after saving (ROOM - foreigner)" +
                        state.id.toString());
                  } else if (state.type == "children") {
                    roomList[state.roomIndex!]
                        .childrenList![state.currentIndex!]
                        .isDetailsAdded = true;

                    roomList[state.roomIndex!]
                        .childrenList![state.currentIndex!]
                        .name = state.name;

                    roomList[state.roomIndex!]
                        .childrenList![state.currentIndex!]
                        .dob = state.dob;

                    roomList[state.roomIndex!]
                        .childrenList![state.currentIndex!]
                        .type = state.type;

                    roomList[state.roomIndex!]
                        .childrenList![state.currentIndex!]
                        .personUniqueID = state.id;
                    print("Person Unique ID after saving (ROOM - children)" +
                        state.id.toString());
                  }
                });
                BlocProvider.of<BlocAddRoomPerson>(context).add(RefreshRoom());
              } else {
                print('Room Added');
                final id = ObjectId();
                setState(() {
                  isRemoved = false;
                  isAdded = true;
                  isActivated = false;
                  allCount = allCount! - 1;
                  print("New Count " + allCount.toString());
                  print("state.type ${state.type}");
                  // totalAmount =
                  //     state.bookingSummaryAll!.data!.finalAmount.toString();
                  // print(state.bookingSummaryAll!.data!.total.toString());
                  // entranceTicket = state
                  //     .bookingSummaryAll!.data!.entranceTickettotal
                  //     .toString();

                  if (state.type == "indian") {
                    roomList[state.roomIndex!]
                        .indianList![state.currentIndex!]
                        .isDetailsAdded = true;

                    roomList[state.roomIndex!]
                        .indianList![state.currentIndex!]
                        .name = state.name;

                    roomList[state.roomIndex!]
                        .indianList![state.currentIndex!]
                        .dob = state.dob;

                    roomList[state.roomIndex!]
                        .indianList![state.currentIndex!]
                        .type = state.type;

                    roomList[state.roomIndex!]
                        .indianList![state.currentIndex!]
                        .personUniqueID = id.toString();
                    print("Person Unique ID after saving (ROOM - indian)" +
                        id.toString());
                  } else if (state.type == "foreigner") {
                    roomList[state.roomIndex!]
                        .foreignerList![state.currentIndex!]
                        .isDetailsAdded = true;

                    roomList[state.roomIndex!]
                        .foreignerList![state.currentIndex!]
                        .name = state.name;

                    roomList[state.roomIndex!]
                        .foreignerList![state.currentIndex!]
                        .dob = state.dob;

                    roomList[state.roomIndex!]
                        .foreignerList![state.currentIndex!]
                        .type = state.type;

                    roomList[state.roomIndex!]
                        .foreignerList![state.currentIndex!]
                        .personUniqueID = id.toString();
                    print("Person Unique ID after saving (ROOM - foreigner)" +
                        id.toString());
                  } else if (state.type == "children") {
                    roomList[state.roomIndex!]
                        .childrenList![state.currentIndex!]
                        .isDetailsAdded = true;

                    roomList[state.roomIndex!]
                        .childrenList![state.currentIndex!]
                        .name = state.name;

                    roomList[state.roomIndex!]
                        .childrenList![state.currentIndex!]
                        .dob = state.dob;

                    roomList[state.roomIndex!]
                        .childrenList![state.currentIndex!]
                        .type = state.type;

                    roomList[state.roomIndex!]
                        .childrenList![state.currentIndex!]
                        .personUniqueID = id.toString();
                    print("Person Unique ID after saving (ROOM - children)" +
                        id.toString());
                  }
                });
                BlocProvider.of<BlocAddRoomPerson>(context).add(RefreshRoom());
              }
            }
            if (state is RoomPersonNotAdded) {
              print("RoomPersonNotAdded - Listner");
              print("Current Count " + allCount.toString());
              _showToast(context, state.msg.toString(), Toast.LENGTH_SHORT);
            }
          },
        ),

        SizedBox(
          height: 10.0,
        ),

        Divider(),
      ],
    );
  }

  _addVehicles(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Add Vehicle"),
            IconButton(
              onPressed: () {
                allCount == 0
                    ? isEnabled == true
                        ? setState(
                            () {
                              vehicleAddCount = vehicleAddCount! + 1;
                              vehicleDetailsSelected.add(
                                VeicleInformation(number: vehicleAddCount),
                              );
                            },
                          )
                        : _showToast(
                            context, "Button Disabled", Toast.LENGTH_SHORT)
                    : _showToast(context, "Please add all member(s) details",
                        Toast.LENGTH_SHORT);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          children: dropDownMenu(context),
        )
      ],
    );
  }

  dropDownMenu(BuildContext context) {
    List<Widget> itemsMenu = [];
    for (int i = 0; i < vehicleAddCount!; i++) {
      itemsMenu.add(
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton(
              // icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
              underline: SizedBox.shrink(),
              hint: Text(
                "Choose Vehicle",
                style: new TextStyle(fontSize: 13.0),
              ),
              value: vehicleDetailsSelected[i].type,
              onChanged: isEnabled == true
                  ? (newValue) {
                      print("onchange");
                      setState(() {
                        _openLoadingDialog(context, "Changing Vehicle Type");
                        vehicleDetailsSelected[i].type = newValue.toString();
                        vehicleDetailsSelected[i].type != null
                            ? vehicleDetailsSelected[i].type !=
                                    "Light Motor Vehicle"
                                ? vehicleDetailsSelected[i].amount =
                                    vehicleDetails[0].amount
                                : vehicleDetailsSelected[i].amount =
                                    vehicleDetails[1].amount
                            : SizedBox.shrink();

                        print(
                          'Index ' +
                              vehicleDetailsSelected[i].number.toString() +
                              ' - ' +
                              vehicleDetailsSelected[i].type.toString() +
                              ' - ' +
                              vehicleDetailsSelected[i].amount.toString(),
                        );
                      });
                      // vehicleDetailsSelected[i].id != null
                      //     ? print("not null")
                      //     : print(" null");
                      vehicleDetailsSelected[i].id == null
                          ? BlocProvider.of<BlocVehicle>(context).add(
                              AddVehicle(
                                date: widget.date,
                                index: i,
                                vehicleName: vehicleDetailsSelected[i].type,
                                bookingDate: widget.date,
                                cartId: cartId,
                                isOffline: widget.isOffline,
                                offlineBooking: widget.offlineBooking,
                                vehicleAmount: vehicleDetailsSelected[i].amount,
                                vehicleDetailsList: vehicleDetailsList,
                                //hmly
                              ),
                            )
                          : BlocProvider.of<BlocVehicle>(context).add(
                              UpdateVehicle(
                                index: i,
                                vehicleName: vehicleDetailsSelected[i].type,
                                vehicleAmount: vehicleDetailsSelected[i].amount,
                                bookingDate: widget.date,
                                offlineBooking: widget.offlineBooking,
                                id: vehicleDetailsSelected[i].id,
                                cartId: cartId,
                                isOffline: widget.isOffline,
                                vehicleDetailsList: vehicleDetailsList,
                              ),
                            );
                    }
                  : null,
              items: vehicleDetails.map((element) {
                return DropdownMenuItem(
                    value: element.type.toString(),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          element.type.toString(),
                          style: new TextStyle(fontSize: 13.0),
                        ),
                      ],
                    ));
              }).toList(),
            ),
            new SizedBox(
              width: 100.0,
              child: InkWell(
                onTap: () {
                  _showToast(context, vehicleDetailsSelected[i].id.toString(),
                      Toast.LENGTH_SHORT);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    vehicleDetailsSelected[i].type != null
                        ? vehicleDetailsSelected[i].type ==
                                "Heavy Motor Vehicle"
                            ? new Text(
                                vehicleDetails[0].amount.toString() + " INR",
                                style: new TextStyle(fontSize: 13.0),
                              )
                            : new Text(
                                vehicleDetails[1].amount.toString() + " INR",
                                style: new TextStyle(fontSize: 13.0),
                              )
                        : SizedBox.shrink(),
                    new IconButton(
                      onPressed: () {
                        setState(() {
                          // if (vehicleDetailsSelected[i].id != null) {
                          if (isEnabled == true) {
                            if (vehicleAddCount != 0) {
                              if (vehicleDetailsSelected[i].id != null) {
                                _openLoadingDialog(context, "Removing");
                                BlocProvider.of<BlocVehicle>(context).add(
                                  RemoveVehicle(
                                    index: i,
                                    vehicleName: vehicleDetailsSelected[i].type,
                                    vehicleAmount:
                                        vehicleDetailsSelected[i].amount,
                                    bookingDate: widget.date,
                                    id: vehicleDetailsSelected[i].id,
                                    cartId: cartId,
                                    offlineBooking: widget.offlineBooking,
                                    isOffline: widget.isOffline,
                                    vehicleDetailsList: vehicleDetailsList,
                                  ),
                                );
                              } else {
                                vehicleAddCount = vehicleAddCount! - 1;
                                vehicleDetailsSelected
                                    .removeAt(vehicleAddCount!);
                              }

                              // print(vehicleDetailsSelected.length);
                            }
                          } else {
                            _showToast(
                                context, "Button Disabled", Toast.LENGTH_SHORT);
                          }
                          // } else {
                          //   Fluttertoast.showToast(
                          //       msg: "Please select a vehicle.");
                          // }
                        });

                        // BlocProvider.of<BlocVehicle>(context).add(
                        //     UpdateVehicle(
                        //       index: i,
                        //       vehicleName: vehicleDetailsSelected[i].type,
                        //       bookingDate: widget.date,
                        //       id: vehicleDetailsSelected[i].id,
                        //       cartId: cartId,
                        //     ),
                        //   );
                      },
                      icon: new Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return itemsMenu;
  }

  void addToVehicleList(
      BuildContext context, PartialBookingDataTwoReceived state) {
    vehicleDetails.clear();
    if (state.isOffline == false) {
      vehicleDetails = [
        VeicleInformation(
          type: "Heavy Motor Vehicle",
          amount: state.vehicleModel!.data!.heavyVehicleCharge,
          id: "",
        ),
        VeicleInformation(
          type: "Light Motor Vehicle",
          amount: state.vehicleModel!.data!.lightVehicleCharge,
          id: "",
        ),
      ];
    } else {
      vehicleDetails = [
        VeicleInformation(
          type: "Heavy Motor Vehicle",
          amount: widget.vehicleInfo![0]['heavyVehicleCharge'],
          id: "",
        ),
        VeicleInformation(
          type: "Light Motor Vehicle",
          amount: widget.vehicleInfo![0]['lightVehicleCharge'],
          id: "",
        ),
      ];
    }
    //error
    // else {
    //   vehicleDetails = [
    //     VeicleInformation(
    //       type: "Heavy Motor Vehicle",
    //       amount: state.vehicleDetails![0]['heavyVehicleCharge'],
    //       id: "",
    //     ),
    //     VeicleInformation(
    //       type: "Light Motor Vehicle",
    //       amount: state.vehicleDetails![0]['lightVehicleCharge'],
    //       id: "",
    //     ),
    //   ];
    // }
  }

//-----------------------------------------------------------
  // getInnerList(int i, String? label) {
  //   List<Widget> newInnerList = [];
  //   for (int i = 0; i < innerListIndividual.length; i++) {
  //     label == innerListIndividual[i].label
  //         ? newInnerList.add(
  //             Text(
  //               innerListIndividual[i].label.toString(),
  //             ),
  //           )
  //         : SizedBox.shrink();
  //   }
  //   return newInnerList;
  // }
//-----------------------------------------------------------
  buildSeatList(BuildContext context, PartialBookingDataTwoReceived state) {
    customersList.clear();

    if (state.isOffline == false) {
      allCount = state.bookingSummaryAll!.data!.indian! +
          state.bookingSummaryAll!.data!.foreigner! +
          state.bookingSummaryAll!.data!.children!;
      print("Current Count " + allCount.toString());
      customersList = [
        Customers(
          name: "Indian",
          label: "indian",
          count: state.bookingSummaryAll!.data!.indian,
          status: state.bookingSummaryAll!.data!.indian == 0 ? false : true,
          isDetailsAdded: true,
        ),
        Customers(
          name: "Foreigner",
          label: "foreigner",
          count: state.bookingSummaryAll!.data!.foreigner,
          status: state.bookingSummaryAll!.data!.foreigner == 0 ? false : true,
          isDetailsAdded: true,
        ),
        Customers(
          name: "Children",
          label: "children",
          count: state.bookingSummaryAll!.data!.children,
          status: state.bookingSummaryAll!.data!.children == 0 ? false : true,
          isDetailsAdded: true,
        ),
      ];
    } else {
      if (widget.isCottage == false) {
        allCount = widget.offlineBooking!.indianCount! +
            widget.offlineBooking!.foreignerCount! +
            widget.offlineBooking!.childrenCount!;

        customersList = [
          Customers(
            name: "Indian",
            label: "indian",
            count: widget.offlineBooking!.indianCount!,
            status: widget.offlineBooking!.indianCount == 0 ? false : true,
            isDetailsAdded: true,
          ),
          Customers(
            name: "Foreigner",
            label: "foreigner",
            count: widget.offlineBooking!.foreignerCount!,
            status: widget.offlineBooking!.foreignerCount == 0 ? false : true,
            isDetailsAdded: true,
          ),
          Customers(
            name: "Children",
            label: "children",
            count: widget.offlineBooking!.childrenCount!,
            status: widget.offlineBooking!.childrenCount == 0 ? false : true,
            isDetailsAdded: true,
          ),
        ];
      }
    }

    for (int i = 0; i < customersList.length; i++) {
      if (customersList[i].status != false) {
        for (int j = 0; j < customersList[i].count!; j++) {
          newList.add(
            Customers(
              isDetailsAdded: false,
              isEdStarted: false,
              number: j,
              label: customersList[i].label,
            ),
          );
        }
      }
    }
  }

  innerList(
      //hello here
      BuildContext context,
      int index,
      PartialBookingDataTwoReceived state) {
    state.isOffline == false
        ? cartId = state.cartId.toString()
        : cartId = widget.offlineBooking!.slotId.toString();
    List<Widget> subList = [];
    for (int i = 0; i < newList.length; i++) {
      if (customersList[index].label == newList[i].label) {
        // int? cCount;
        final _formKey = new GlobalKey<FormState>();

        final TextEditingController nameController =
            new TextEditingController();
        final TextEditingController dobController = new TextEditingController();
        final TextEditingController phoneController =
            new TextEditingController();
        final TextEditingController idproofController =
            new TextEditingController();
        if (isEditing == true && editingIndex == i) {
          nameController.text = newList[i].name.toString();
          dobController.text = newList[i].dob.toString();
          phoneController.text = newList[i].phoneNumber.toString();
          // emailController.text = newList[i].email.toString();
        } else {
          nameController.text = "";
          dobController.text = "";
          phoneController.text = "";
        }
        //thenames
        // nameController.text = "Manohar Lal";
        // dobController.text = "1997-07-10";
        // phoneController.text = "8129322316";
        var entranceChargeSubmit = 0;
        print(index);
        currentCutomer = customersList[index].label.toString();

        //vehicleInfo
        // if (widget.isOffline == true) {
        //   if (currentCutomer == 'indian') {
        //     //entranceCharge = vehicleInfo[0]['indianEntranceCharge'];
        //     entranceChargeSubmit = vehicleInfo[0]['indianEntranceCharge'];
        //   } else if (currentCutomer == 'foreigner') {
        //     // entranceCharge = vehicleInfo[0]['foreignerEntraneCharge'];
        //     entranceChargeSubmit = vehicleInfo[0]['foreignerEntraneCharge'];
        //   } else {
        //     // entranceCharge = vehicleInfo[0]['childrenEntraneCharge'];
        //     entranceChargeSubmit = vehicleInfo[0]['childrenEntraneCharge'];
        //   }
        // }

        // path = "storage/emulated/0/Parambikulam/1636950075989.jpg";
        // idproofController.text =
        //     "storage/emulated/0/Parambikulam/1636950075989.jpg";
        // idproofController.text =
        //     "data/user/0/com.leopardtechlabs.periyartigerreserve/cache/scaled_25410d16-ac48-43e2-9ccf-ef5f2c6e37fa8881729862697693322.jpg";
        //
        // sms
        subList.add(ExpansionTile(
          // trailing: Icon(Icons.qr_code),
          textColor: HexColor("#53A874"),
          iconColor: HexColor("#53A874"),
          onExpansionChanged: ((state) {
            if (isActivated == false && newList[i].isEdStarted == false) {
              setState(() {
                isActivated = true;
                newList[i].isEdStarted = true;
              });
            } else {
              print("not allowed");
            }
          }),
          title: Text(
            "Person " + (i + 1).toString(),
            style: TextStyle(
                color: HexColor("#53A874"),
                fontSize: 12.0,
                fontWeight: FontWeight.w400),
          ),
          children: [
            newList[i].isDetailsAdded == false
                ? isActivated == true && newList[i].isEdStarted == true
                    ? Form(
                        key: _formKey,
                        child: new Container(
                          child: new Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      //  Navigator.push(context, MaterialPageRoute(builder: (context) =>   ScanIndividualData()));
                                      showDialog(
                                          context: context,
                                          builder: (contextAlert) {
                                            return AlertDialog(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  // Icon(CupertinoIcons.multiply),
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(CupertinoIcons
                                                        .multiply),
                                                  )
                                                ],
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: SizedBox(
                                                height: 250.0,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              16.0)),
                                                  child: QRView(
                                                    key: qrKey,
                                                    onQRViewCreated:
                                                        (qrViewController) {
                                                      qrViewController
                                                          .stopCamera();
                                                      qrViewController
                                                          .resumeCamera();
                                                      qrViewController
                                                          .scannedDataStream
                                                          .listen((scanData) {
                                                        if (scanData.code!
                                                            .startsWith(
                                                                '{"ticketId":')) {
                                                          qrViewController
                                                              .stopCamera()
                                                              .then(
                                                                  (value) async {
                                                            var deco =
                                                                jsonDecode(
                                                                    scanData
                                                                        .code!);
                                                            if (newList[i]
                                                                    .label ==
                                                                deco['type']) {
                                                              pguestId = deco[
                                                                  'guestId'];
                                                              pticketId = deco[
                                                                  'ticketId'];
                                                              nameController
                                                                      .text =
                                                                  deco['name'];
                                                              dobController
                                                                      .text =
                                                                  deco['dob'];
                                                              phoneController
                                                                      .text =
                                                                  deco['phone'];
                                                              currentCutomer =
                                                                  deco['type'];
                                                              Navigator.pop(
                                                                  contextAlert);
                                                            } else {
                                                              if (await Vibrate
                                                                  .canVibrate) {
                                                                Vibrate.feedback(
                                                                    FeedbackType
                                                                        .success);
                                                              }
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          "Please scan ${newList[i].label} visitor");
                                                              Future.delayed(
                                                                  Duration(
                                                                      seconds:
                                                                          2),
                                                                  () async {
                                                                qrViewController
                                                                    .resumeCamera();
                                                              });
                                                            }
                                                          });
                                                        } else {
                                                          print("no");
                                                        }
                                                      });
                                                    },
                                                    //    _onQRViewCreated,
                                                    overlay:
                                                        QrScannerOverlayShape(
                                                      borderColor:
                                                          Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Row(
                                      children: [
                                        Text("Scan QR code",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Icon(Icons.qr_code,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     TextButton(
                              //       onPressed: () {
                              //         //  Navigator.push(context, MaterialPageRoute(builder: (context) =>   ScanIndividualData()));
                              //         showDialog(
                              //             context: context,
                              //             builder: (context) {
                              //               return AlertDialog(
                              //                 title: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.end,
                              //                   children: [
                              //                     // Icon(CupertinoIcons.multiply),
                              //                     IconButton(
                              //                       onPressed: () {
                              //                         Navigator.pop(context);
                              //                       },
                              //                       icon: Icon(CupertinoIcons
                              //                           .multiply),
                              //                     )
                              //                   ],
                              //                 ),
                              //                 backgroundColor:
                              //                     Colors.transparent,
                              //                 content: SizedBox(
                              //                   height: 250.0,
                              //                   width: MediaQuery.of(context)
                              //                       .size
                              //                       .width,
                              //                   child: ClipRRect(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(
                              //                                 16.0)),
                              //                     child: QRView(
                              //                       key: qrKey,
                              //                       onQRViewCreated:
                              //                           (qrViewController) {
                              //                         qrViewController
                              //                             .scannedDataStream
                              //                             .listen((scanData) {
                              //                           if (scanData.code!
                              //                               .startsWith(
                              //                                   '{"ticketId":')) {
                              //                             qrViewController
                              //                                 .stopCamera()
                              //                                 .then(
                              //                                     (value) async {
                              //                               var deco =
                              //                                   jsonDecode(
                              //                                       scanData
                              //                                           .code!);
                              //                               if (newList[i]
                              //                                       .label ==
                              //                                   deco['type']) {
                              //                                 pguestId = deco[
                              //                                     'guestId'];
                              //                                 pticketId = deco[
                              //                                     'ticketId'];
                              //                                 nameController
                              //                                         .text =
                              //                                     deco['name'];
                              //                                 dobController
                              //                                         .text =
                              //                                     deco['dob'];
                              //                                 phoneController
                              //                                         .text =
                              //                                     deco['phone'];
                              //                                 currentCutomer =
                              //                                     deco['type'];
                              //                                 Navigator.pop(
                              //                                     context);
                              //                               } else {
                              //                                 if (await Vibrate
                              //                                     .canVibrate) {
                              //                                   Vibrate
                              //                                       .vibrate();
                              //                                 }
                              //                                 Fluttertoast
                              //                                     .showToast(
                              //                                         msg:
                              //                                             "Please scan ${newList[i].label} visitor");
                              //                                 Future.delayed(
                              //                                     Duration(
                              //                                         seconds:
                              //                                             2),
                              //                                     () async {
                              //                                   qrViewController
                              //                                       .resumeCamera();
                              //                                 });
                              //                               }
                              //                             });
                              //                           } else {
                              //                             print("no");
                              //                           }
                              //                           ;
                              //                         });
                              //                       },
                              //                       //    _onQRViewCreated,
                              //                       overlay:
                              //                           QrScannerOverlayShape(
                              //                         borderColor:
                              //                             Colors.transparent,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               );
                              //             });
                              //       },
                              //       child: Row(
                              //         children: [
                              //           Text("Scan QR code",
                              //               style:
                              //                   TextStyle(color: Colors.white)),
                              //           SizedBox(
                              //             width: 5.0,
                              //           ),
                              //           Icon(Icons.qr_code,
                              //               color: Colors.white),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 10.0,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     TextButton(
                              //       onPressed: () {
                              //         //  Navigator.push(context, MaterialPageRoute(builder: (context) =>   ScanIndividualData()));
                              //         showDialog(
                              //             context: context,
                              //             builder: (context) {
                              //               return AlertDialog(
                              //                 title: Row(
                              //                   mainAxisAlignment:
                              //                       MainAxisAlignment.end,
                              //                   children: [
                              //                     // Icon(CupertinoIcons.multiply),
                              //                     IconButton(
                              //                       onPressed: () {
                              //                         Navigator.pop(context);
                              //                       },
                              //                       icon: Icon(CupertinoIcons
                              //                           .multiply),
                              //                     )
                              //                   ],
                              //                 ),
                              //                 backgroundColor:
                              //                     Colors.transparent,
                              //                 content: SizedBox(
                              //                   height: 250.0,
                              //                   width: MediaQuery.of(context)
                              //                       .size
                              //                       .width,
                              //                   child: ClipRRect(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(
                              //                                 16.0)),
                              //                     child: QRView(
                              //                       key: qrKey,
                              //                       onQRViewCreated:
                              //                           (qrViewController) {
                              //                         qrViewController
                              //                             .scannedDataStream
                              //                             .listen((scanData) {
                              //                           if (scanData.code!
                              //                               .startsWith(
                              //                                   '{"ticketId":')) {
                              //                             qrViewController
                              //                                 .stopCamera()
                              //                                 .then(
                              //                                     (value) async {
                              //                               var deco =
                              //                                   jsonDecode(
                              //                                       scanData
                              //                                           .code!);
                              //                               if (newList[i]
                              //                                       .label ==
                              //                                   deco['type']) {
                              //                                 pguestId = deco[
                              //                                     'guestId'];
                              //                                 pticketId = deco[
                              //                                     'ticketId'];
                              //                                 nameController
                              //                                         .text =
                              //                                     deco['name'];
                              //                                 dobController
                              //                                         .text =
                              //                                     deco['dob'];
                              //                                 phoneController
                              //                                         .text =
                              //                                     deco['phone'];
                              //                                 currentCutomer =
                              //                                     deco['type'];
                              //                                 Navigator.pop(
                              //                                     context);
                              //                               } else {
                              //                                 if (await Vibrate
                              //                                     .canVibrate) {
                              //                                   Vibrate
                              //                                       .vibrate();
                              //                                 }
                              //                                 Fluttertoast
                              //                                     .showToast(
                              //                                         msg:
                              //                                             "Please scan ${newList[i].label} visitor");
                              //                                 Future.delayed(
                              //                                     Duration(
                              //                                         seconds:
                              //                                             2),
                              //                                     () async {
                              //                                   qrViewController
                              //                                       .resumeCamera();
                              //                                 });
                              //                               }
                              //                             });
                              //                           } else {
                              //                             print("no");
                              //                           }
                              //                           ;
                              //                         });
                              //                       },
                              //                       //    _onQRViewCreated,
                              //                       overlay:
                              //                           QrScannerOverlayShape(
                              //                         borderColor:
                              //                             Colors.transparent,
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               );
                              //             });
                              //       },
                              //       child: Row(
                              //         children: [
                              //           Text("Scan QR code",
                              //               style:
                              //                   TextStyle(color: Colors.white)),
                              //           SizedBox(
                              //             width: 5.0,
                              //           ),
                              //           Icon(Icons.qr_code,
                              //               color: Colors.white),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 10.0,
                              // ),

                              new Row(
                                children: [
                                  Expanded(
                                      child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controller: nameController,
                                    keyboardType: TextInputType.text,

                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return "Enter Name";
                                      }
                                      return null;
                                    },
                                    // inputFormatters: [
                                    //   new LengthLimitingTextInputFormatter(42),
                                    // ],
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      errorStyle:
                                          new TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      fillColor: Colors.white,
                                      // labelText: widget.labelText,
                                      hintStyle: new TextStyle(
                                          fontSize: 12.0,
                                          color: HexColor("#9E9E9E")),
                                      filled: true,
                                    ),
                                    style: new TextStyle(color: Colors.black),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              new Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _selectDate(context, i, dobController,
                                            newList[i].label);
                                      },
                                      child: IgnorePointer(
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: dobController,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Select DOB";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: "DOB",
                                            errorStyle: new TextStyle(
                                                color: Colors.white),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            fillColor: Colors.white,
                                            // labelText: widget.labelText,
                                            hintStyle: new TextStyle(
                                                fontSize: 12.0,
                                                color: HexColor("#9E9E9E")),
                                            filled: true,
                                          ),
                                          style: new TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
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
                                      child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controller: phoneController,
                                    // maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return "Enter Phone Number";
                                      }
                                      // else if (value.length < 10 ||
                                      //     value.length > 10) {
                                      //   return "Enter Valid Phone Number";
                                      // }
                                      return null;
                                    },
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(42),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "Phone Number",
                                      errorStyle:
                                          new TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      fillColor: Colors.white,
                                      // labelText: widget.labelText,
                                      hintStyle: new TextStyle(
                                          fontSize: 12.0,
                                          color: HexColor("#9E9E9E")),
                                      filled: true,
                                    ),
                                    style: new TextStyle(color: Colors.black),
                                  )
                                      // TextInputField(

                                      //   validator: (value) {
                                      //     if (value == null || value == "") {
                                      //       return "Enter Phone Number";
                                      //     } else if (value.length < 10 ||
                                      //         value.length > 10) {
                                      //       return "Enter A Valid Phone Number";
                                      //     }
                                      //   },
                                      //   textEditingController: phoneController,
                                      //   textInputType: TextInputType.number,
                                      //   labelText: "Phone Number",
                                      //   error: "Enter Phone Number",
                                      // ),

                                      ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 15.0,
                              // ),
                              // new Row(
                              //   children: [
                              //     Expanded(
                              //       child: TextFormField(
                              //         controller: emailController,
                              //         keyboardType: TextInputType.emailAddress,
                              //         validator: (value) {
                              //           if (value == null || value == "") {
                              //             return "Enter Email Address";
                              //           }
                              //         },
                              //         inputFormatters: [
                              //           new LengthLimitingTextInputFormatter(42),
                              //         ],
                              //         decoration: InputDecoration(
                              //           hintText: "Email Address",
                              //           errorStyle:
                              //               new TextStyle(color: Colors.white),
                              //           enabledBorder: OutlineInputBorder(
                              //             borderSide:
                              //                 BorderSide(color: Colors.white),
                              //           ),
                              //           focusedBorder: OutlineInputBorder(
                              //             borderSide:
                              //                 BorderSide(color: Colors.white),
                              //           ),
                              //           fillColor: Colors.white,
                              //           // labelText: widget.labelText,
                              //           hintStyle: new TextStyle(
                              //               fontSize: 12.0,
                              //               color: HexColor("#9E9E9E")),
                              //           filled: true,
                              //         ),
                              //         style: new TextStyle(color: Colors.black),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              SizedBox(
                                height: 15.0,
                              ),
                              new Column(
                                children: [
                                  new Row(
                                    children: [
                                      Expanded(child: Text("ID Proof")),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  new Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            var cameraStatus =
                                                await Permission.camera.status;
                                            var galleryStatus =
                                                await Permission.storage.status;
                                            if (cameraStatus ==
                                                    PermissionStatus.denied ||
                                                cameraStatus ==
                                                    PermissionStatus
                                                        .permanentlyDenied) {
                                              cameraStatus = await Permission
                                                  .camera
                                                  .request();
                                            }
                                            if (galleryStatus ==
                                                    PermissionStatus.denied ||
                                                galleryStatus ==
                                                    PermissionStatus
                                                        .permanentlyDenied) {
                                              galleryStatus = await Permission
                                                  .storage
                                                  .request();
                                            }

                                            if (cameraStatus ==
                                                    PermissionStatus.granted &&
                                                galleryStatus ==
                                                    PermissionStatus.granted) {
                                              cameraState == false
                                                  ? _showPicker(context,
                                                      idproofController)
                                                  : _showToast(
                                                      context,
                                                      "Initializing image source, please wait",
                                                      Toast.LENGTH_SHORT,
                                                    );
                                            }

                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) => MyPage()),
                                            // );
                                          },
                                          child: IgnorePointer(
                                            child: TextFormField(
                                              //sid
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: idproofController,
                                              validator: (value) {
                                                if (widget.isCottage == true) {
                                                  if (value == null ||
                                                      value == "") {
                                                    return "Upload ID Proof";
                                                  }
                                                }

                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Upload ID Proof Image",
                                                errorStyle: new TextStyle(
                                                    color: Colors.white),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                fillColor: Colors.white,
                                                // labelText: widget.labelText,
                                                hintStyle: new TextStyle(
                                                    fontSize: 12.0,
                                                    color: HexColor("#9E9E9E")),
                                                filled: true,
                                                suffixIcon: Icon(
                                                  Icons.file_upload,
                                                  color: HexColor("#9E9E9E"),
                                                ),
                                              ),
                                              style: new TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        // TextInputField(
                                        //   validator: (value) {
                                        //     if (value == null || value == "") {
                                        //       return "Enter ID Proof Number";
                                        //     }
                                        //   },
                                        //   formatter: textFormatter,
                                        //   textEditingController:
                                        //       idproofController,
                                        //   textInputType: TextInputType.
                                        //   labelText: "Upload ID Proof Image",
                                        //   error: "Upload ID Proof Image",
                                        // ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  // widget.isOffline == true
                                  //     ? new Container(
                                  //         padding: EdgeInsets.only(
                                  //             left: 12,
                                  //             right: 12,
                                  //             top: 16,
                                  //             bottom: 16),
                                  //         width:
                                  //             MediaQuery.of(context).size.width,
                                  //         decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.all(
                                  //             Radius.circular(4.0),
                                  //           ),
                                  //           color: Colors.white,
                                  //         ),
                                  //         child: new Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceBetween,
                                  //           children: [
                                  //             BlocConsumer<BlocEntranceCharge,
                                  //                     StateEntranceCharge>(
                                  //                 listener: (context, state) {
                                  //               if (state
                                  //                   is EntranceChargeAdded) {
                                  //                 entranceChargeSubmit =
                                  //                     state.newEntrance!;
                                  //               }
                                  //               if (state
                                  //                   is EntranceChargeRemoved) {
                                  //                 entranceChargeSubmit =
                                  //                     state.newEntrance!;
                                  //               }
                                  //             }, builder: (context, state) {
                                  //               if (state
                                  //                   is EntranceChargeAdded) {
                                  //                 return Text(
                                  //                   "Entrance charge Rs.$entranceCharge Applied",
                                  //                   style: new TextStyle(
                                  //                       fontSize: 14,
                                  //                       color: Colors.black),
                                  //                 );
                                  //               }
                                  //               if (state
                                  //                   is EntranceChargeRemoved) {
                                  //                 return Text(
                                  //                   "Entrance charge Rs.$entranceCharge Not Applied",
                                  //                   style: new TextStyle(
                                  //                       fontSize: 14,
                                  //                       color: Colors.black),
                                  //                 );
                                  //               }
                                  //               return Text(
                                  //                 "Entrance charge Rs.$entranceCharge Applied",
                                  //                 style: new TextStyle(
                                  //                     fontSize: 14,
                                  //                     color: Colors.black),
                                  //               );
                                  //             }),
                                  //             new Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment
                                  //                       .spaceBetween,
                                  //               children: [
                                  //                 IconButton(
                                  //                   padding: EdgeInsets.zero,
                                  //                   constraints:
                                  //                       BoxConstraints(),
                                  //                   onPressed: () {
                                  //                     if (isRemoved == false) {
                                  //                       isRemoved = true;
                                  //                       isAdded = false;
                                  //                       BlocProvider.of<
                                  //                                   BlocEntranceCharge>(
                                  //                               context)
                                  //                           .add(
                                  //                               AlterEntranceCharge(
                                  //                         value: false,
                                  //                         entranceCharge:
                                  //                             entranceCharge,
                                  //                         offlineBooking: widget
                                  //                             .offlineBooking,
                                  //                       ));
                                  //                     } else {
                                  //                       _showToast(
                                  //                           context,
                                  //                           'Entrance charge not applied',
                                  //                           Toast.LENGTH_SHORT);
                                  //                     }
                                  //                   },
                                  //                   icon: Icon(
                                  //                     Icons.remove,
                                  //                     color: Colors.black,
                                  //                     size: 18,
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   width:
                                  //                       MediaQuery.of(context)
                                  //                               .size
                                  //                               .width /
                                  //                           25,
                                  //                 ),
                                  //                 IconButton(
                                  //                   padding: EdgeInsets.zero,
                                  //                   constraints:
                                  //                       BoxConstraints(),
                                  //                   onPressed: () {
                                  //                     if (isAdded == false) {
                                  //                       isAdded = true;
                                  //                       isRemoved = false;
                                  //                       BlocProvider.of<
                                  //                                   BlocEntranceCharge>(
                                  //                               context)
                                  //                           .add(
                                  //                               AlterEntranceCharge(
                                  //                         value: true,
                                  //                         entranceCharge:
                                  //                             entranceCharge,
                                  //                         offlineBooking: widget
                                  //                             .offlineBooking,
                                  //                       ));
                                  //                     } else {
                                  //                       _showToast(
                                  //                           context,
                                  //                           'Entrance charge applied',
                                  //                           Toast.LENGTH_SHORT);
                                  //                     }
                                  //                   },
                                  //                   icon: Icon(
                                  //                     Icons.add,
                                  //                     color: Colors.black,
                                  //                     size: 18,
                                  //                   ),
                                  //                 )
                                  //               ],
                                  //             )
                                  //           ],
                                  //         ),
                                  //       )
                                  //     : SizedBox.shrink(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                              Container(
                                height: 45,
                                width: 270,
                                child: new TextButton(
                                  style:
                                      StyleElements.submitAddPersonButtonStyle,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      currentCutomer =
                                          customersList[index].label.toString();
                                      if (state.isOffline == false) {
                                        isEditing == false
                                            ? BlocProvider.of<AddPersonBloc>(
                                                    context)
                                                .add(
                                                //spd
                                                SavePersonData(
                                                  guestId: pguestId,
                                                  ticketId: pticketId,
                                                  name: nameController.text,
                                                  dob: dobController.text,
                                                  phoneno: phoneController.text,
                                                  guestType:
                                                      currentCutomer.toString(),
                                                  cartId: cartId!,
                                                  file: path,
                                                  currentIndex: i,
                                                  isOffline: state.isOffline,
                                                ),
                                              )
                                            : BlocProvider.of<AddPersonBloc>(
                                                    context)
                                                .add(
                                                EditPersonData(
                                                  name: nameController.text,
                                                  dob: dobController.text,
                                                  phoneno: phoneController.text,

                                                  // email: emailController.text,
                                                  guestType:
                                                      currentCutomer.toString(),
                                                  personId: newList[i]
                                                      .personUniqueID!,
                                                  cartId: cartId!,
                                                  // file: path!,
                                                  currentIndex: i,
                                                ),
                                              );
                                      } else {
                                        // Map map = {
                                        //   'name': nameController.text,
                                        //   'dob': dobController.text,
                                        //   'phoneno': phoneController.text,
                                        //   'guestType':
                                        //       currentCutomer.toString(),
                                        //   'personId':
                                        //       'newList[i].personUniqueID!',
                                        //   'cartId': cartId!,
                                        // };
                                        // try {
                                        //   widget.offlineBooking!.newListTwo!
                                        //       .add(map);
                                        //   print(widget
                                        //       .offlineBooking!.newListTwo);
                                        // } catch (e) {
                                        //   print(e);
                                        // }
                                        //SPB
                                        BlocProvider.of<AddPersonBloc>(context)
                                            //spd
                                            .add(SavePersonData(
                                          // entranceCharge: widget
                                          //     .offlineBooking!.entranceCharge,
                                          guestId: pguestId,
                                          ticketId: pticketId,
                                          entranceCharge: entranceChargeSubmit,
                                          date: widget.date,
                                          name: nameController.text,
                                          dob: dobController.text,
                                          phoneno: phoneController.text,

                                          guestType: currentCutomer.toString(),
                                          cartId: cartId!,
                                          file: path,
                                          currentIndex: i,
                                          isOffline: state.isOffline,
                                          offlineBooking: widget.offlineBooking,
                                        ));
                                      }
                                    }
                                    // } else {
                                    //   _showToast(
                                    //     context,
                                    //     "Please fill & save the opened tab",
                                    //     Toast.LENGTH_SHORT,
                                    //   );
                                    // }
                                  },
                                  child: BlocConsumer<AddPersonBloc,
                                      AddPersonState>(
                                    builder: (context, state) {
                                      if (state is AddingPerson) {
                                        return SizedBox(
                                          height: 28.0,
                                          width: 28.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.black),
                                            strokeWidth: 2,
                                          ),
                                        );
                                      } else if (state is UploadingFile) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Uploading File",
                                              style: StyleElements
                                                  .buttonTextStyleSemiBoldBlack,
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                              height: 20.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.black),
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (state is FileUploaded) {
                                        path = "";
                                        disablePsButton = true;
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 20.0,
                                              height: 20.0,
                                              child: Icon(Icons.check),
                                            ),
                                          ],
                                        );
                                      } else if (state is FileNotUploaded) {
                                        _showToast(
                                            context,
                                            "ID Proof not uploaded",
                                            Toast.LENGTH_SHORT);
                                        print("File Not Uploaded - " +
                                            state.msg.toString());
                                        return new Text('File Not Uploaded',
                                            style: StyleElements
                                                .buttonTextStyleSemiBoldBlack);
                                      }
                                      {
                                        //SAVE PERSON DATA
                                        return new Text('SAVE',
                                            style: StyleElements
                                                .buttonTextStyleSemiBoldBlack);
                                      }
                                    },
                                    listener: (context, state) {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: isActivated == true
                              ? Text("Please fill and save opened tab")
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      isActivated = true;
                                      newList[i].isEdStarted = true;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Add this person"),
                                      SizedBox(width: 5.0),
                                      Icon(
                                        Icons.add,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      )
                : new AppCard(
                    outLineColor: HexColor('#292929'),
                    color: HexColor('#292929'),
                    child: new Column(
                      children: [
                        new Row(
                          children: [
                            Expanded(
                              child: new Text(
                                'Name',
                                style: StyleElements.bookingDetailsTitle,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                'DOB',
                                style: StyleElements.bookingDetailsTitle,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                'Guest Type',
                                style: StyleElements.bookingDetailsTitle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        new Row(
                          children: [
                            Expanded(
                              child: new Text(
                                newList[i].name.toString(),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                newList[i].dob.toString(),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                newList[i].type.toString(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        new Row(
                          children: [
                            // onTap: () {
                            //     showAlert(
                            //       context,
                            //       newList[i].name,
                            //       i,
                            //       newList[i].personUniqueID,
                            //       newList,
                            //     );
                            //   },
                            new Container(
                              height: 20.0,
                              width: MediaQuery.of(context).size.width / 6,
                              padding: EdgeInsets.all(2.0),
                              decoration: new BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              //rdelete
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    child: Icon(Icons.done, size: 14),
                                  ),
                                  new Text(
                                    "Added",
                                    style: new TextStyle(fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        )

            //sme
            );
      }
    }
    return subList;
    //  customersList[index].label == newList[index].label ?
  }

  _finalSubmitButton(BuildContext context) {
    //finalbutton
    return new Container(
      height: 45,
      width: 290,
      child: BlocConsumer<BlocFinalBooking, StateFinalBooking>(
        builder: (context, state) {
          if (state is CheckingFinalData) {
            return new TextButton(
              style: StyleElements.submitButtonStyle,
              onPressed: () {},
              child: SizedBox(
                height: 28.0,
                width: 28.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              ),
            );
          } else if (state is FinalDataAdded) {
            return new TextButton(
              style: StyleElements.submitButtonStyle,
              child: widget.isOffline == false
                  ? new Text(
                      "TOTAL " + totalAmount.toString() + " INR, VIEW TICKET",
                      style: StyleElements.buttonTextStyleSemiBold)
                  : new Text(
                      "TOTAL " +
                          widget.offlineBooking!.totalAmount.toString() +
                          " INR, VIEW TICKET",
                      style: StyleElements.buttonTextStyleSemiBold),
              onPressed: () {
                _openLoadingDialog(context, "Please wait");
                BlocProvider.of<BlocFinalBooking>(context).add(ViewTicket(
                  finalSubmissionModel: state.finalSubmissionModel,
                  isOffline: widget.isOffline,
                ));
              },
            );
          }
          return BlocBuilder<BusBloc, BusState>(
            buildWhen: (((previous, current) =>
                current is BusChoosed || current is EventSwitched)),
            builder: ((context, state) {
              return new TextButton(
                style: StyleElements.submitButtonStyle,
                child: new Text(
                  "SUBMIT",
                  style: StyleElements.buttonTextStyleSemiBold,
                ),
                onPressed: () async {
                  var count = 0;
                  for (int i = 0;
                      i < context.read<BusBloc>().busAllocated.length;
                      i++) {
                    count = count +
                        context
                            .read<BusBloc>()
                            .busAllocated[i]
                            .busDetails!
                            .noOfPassengers!;
                  }
                  log('${context.read<BusBloc>().status!} -- ${context.read<BusBloc>().busAllocated.length} -- $count');

                  if (context.read<BusBloc>().busAllocated.length > 0 &&
                      count == 0) {
                    _showToast(context, "Please add all member(s) in the bus",
                        Toast.LENGTH_SHORT);
                  } else {
                    print("All Count : " + allCount.toString());
                    if (allCount == 0) {
                      setState(() {
                        isEnabled = false;
                      });
                      BlocProvider.of<BlocFinalBooking>(context)
                          .add(AddFinalData(
                        busId: getBusID().toString(),
                        busAllocated: context.read<BusBloc>().busAllocated,
                        ticketId: ticketId.toString(),
                        cartId: cartId,
                        finalAmount: totalAmount,
                        offlineFinalAmount:
                            widget.offlineBooking!.totalAmount.toString(),
                        isOffline: widget.isOffline,
                        offlineBooking: widget.offlineBooking,
                        //  state.slotDetails![0]['startTime'].toString() +
                        //           " - " +
                        //           state.slotDetails![0]['endTime'].toString(),
                        // startTime: startTime,
                        // endTime: endTime,
                      ));
                      // widget.isOffline == false
                      //     ? BlocProvider.of<BlocFinalBooking>(context)
                      //         .add(AddFinalData(
                      //         cartId: cartId,
                      //         finalAmount: totalAmount,
                      //         isOffline: widget.isOffline,
                      //         // offlineFinalAmount:
                      //         //     widget.offlineBooking!.totalAmount.toString(),

                      //         // offlineBooking: widget.offlineBooking,

                      //         //  state.slotDetails![0]['startTime'].toString() +
                      //         //           " - " +
                      //         //           state.slotDetails![0]['endTime'].toString(),
                      //         // startTime: startTime,
                      //         // endTime: endTime,
                      //       ))
                      //     :
                    } else {
                      _showToast(context, "Please add all member(s) details.",
                          Toast.LENGTH_SHORT);
                    }
                  }
                },
              );
            }),
          );
        },
        listener: (context, state) {
          if (state is ProceedToViewTicket) {
            if (widget.isOffline == false) {
              BlocProvider.of<ProgramsBloc>(context).add(
                InitialGetBookingDataFromBooking(
                  qrId: state.finalSubmissionModel!.ticket!.id.toString(),
                  isOffline: widget.isOffline,
                ),
              );
            } else {
              //ticketid

              BlocProvider.of<ProgramsBloc>(context).add(
                InitialGetBookingDataFromBooking(
                  qrId: ticketId.toString(),
                  isOffline: widget.isOffline,
                  databaseHelper: db,
                  offlineBooking: widget.offlineBooking,
                ),
              );
            }
          } else if (state is FinalDataNotAdded) {
            _showToast(context, state.msg.toString(), Toast.LENGTH_SHORT);
          }
        },
      ),
    );
  }
  //-----------------------------------------------------------

  Widget showCircular(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }) as Widget;
  }

//-----------------------------------------------------------
  // Future<void> _getFromCamera(
  //     BuildContext context, TextEditingController idproofController) async {
  //   cameraState = true;
  //   try {
  //     final ImagePicker _picker = ImagePicker();
  //     final pickedFile = await _picker.pickImage(
  //       source: ImageSource.camera,
  //       maxWidth: 1800,
  //       maxHeight: 1800,
  //     );
  //     if (pickedFile != null) {
  //       // String basename = basename(file.path);
  //       // idproofController.text = pickedFile.name.toString();
  //       idproofController.text = pickedFile.name.toString();
  //       path = pickedFile.path;
  //       cameraState = false;
  //       print("image path $path");
  //     } else {
  //       _showToast(context, "No Image Detected", Toast.LENGTH_SHORT);
  //       cameraState = false;
  //     }
  //   } catch (e) {
  //     print("Image Upload Exception - " + e.toString());
  //     _showToast(context, e.toString(), Toast.LENGTH_SHORT);
  //   }
  // }

  Future<void> _selectDate(
      BuildContext context, int i, TextEditingController dobController,
      [String? cutomerType]) async {
    DateTime now = DateTime.now();
    if (cutomerType == "children") {
      final date = DateTime.now();
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(date.year - 11, 2, 1),
        firstDate: new DateTime(date.year - 11, 2, 1),
        lastDate: new DateTime(date.year - 5, 2, 1),
        // builder: (context, child) {
        //   return Theme(
        //     data: ThemeData.light().copyWith(
        //       colorScheme: ColorScheme.fromSwatch(
        //         primarySwatch: Colors.teal,
        //         primaryColorDark: Colors.teal,
        //         accentColor: Colors.teal,
        //       ),
        //       dialogBackgroundColor: Colors.white,
        //     ),
        //     child: child!,
        //   );
        // },
      );
      if (picked != null && picked != now) {
        // final difference = now.difference(picked).inDays;
        // Fluttertoast.showToast(msg: difference.toString());
        dobController.text = g.format(DateTime.parse(picked.toString()));
      }
      // setState(() {
      //   // newList[i].textEditingController = picked as TextEditingController;
      //   dobController.text = picked.toString();
      // });
    } else {
      final date = DateTime.now();
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(date.year - 30, 1, 1),
        firstDate: new DateTime(date.year - 55, 1, 1),
        lastDate: new DateTime(date.year - 12, 1, 1),
        // builder: (context, child) {
        //   return Theme(
        //     data: ThemeData.light().copyWith(
        //       colorScheme: ColorScheme.fromSwatch(
        //         primarySwatch: Colors.green
        //         primaryColorDark: Colors.green,
        //         accentColor: Colors.green,
        //       ),
        //       dialogBackgroundColor: Colors.white,
        //     ),
        //     child: child!,
        //   );
        // },
      );
      if (picked != null && picked != now) {
        // final difference = now.difference(picked).inDays;
        // Fluttertoast.showToast(msg: difference.toString());
        dobController.text = g.format(DateTime.parse(picked.toString()));
      }
      // setState(() {
      //   // newList[i].textEditingController = picked as TextEditingController;
      //   dobController.text = picked.toString();
      // });
    }
  }

//-----------------------------------------------------------
  void showAlert(BuildContext context, String? name, int i,
      String? personUniqueID, List<Customers> newList) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Delete Guest"),
      content: Text("Are you sure you wnat to delete this guest " +
          name.toString() +
          " ?"),
      actions: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              deleted = true;
              Navigator.pop(context);
              //alldelete
              BlocProvider.of<BlocUpdateGuest>(context).add(
                DoDelete(
                  personUniqueID: personUniqueID,
                  index: i,
                  list: newList,
                ),
              );
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

//-----------------------------------------------------------
  _openLoadingDialog(BuildContext context, String? s) {
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
                  color: Colors.white, strokeWidth: 3),
            ),
            // SizedBox(
            //   height: 15.0,
            // ),
            // new Text("Add Vehicle", style: TextStyle(color: Colors.white)),
          ],
        );
      },
    );
  }

  // _buildGuestAddList(
  //     BuildContext context, PartialBookingDataTwoReceived state) {
  //   List<Widget> guestAddList = [];
  //   for (int i = 0; i < customersList.length; i++) {
  //     if (customersList[i].status == true) {
  //       guestAddList.add(Padding(
  //         padding: const EdgeInsets.all(12.0),
  //         child: Column(
  //           children: [
  //             InkWell(
  //               child: new Row(
  //                 children: [
  //                   Expanded(
  //                     flex: 1,
  //                     child: Text("1"),
  //                   ),
  //                   Expanded(
  //                     flex: 4,
  //                     child: Text("Indian"),
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: Text("1 Person"),
  //                   ),
  //                 ],
  //               ),
  //               onTap: () {
  //                 new Column(
  //                   children: innerList(context, i, state),
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       ));
  //     }
  //   }
  //   return guestAddList;
  // }
  //-----------------------------------------------------------
  _showToast(BuildContext context, String s, Toast length) {
    Fluttertoast.showToast(
      toastLength: length,
      msg: s,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }
  //-----------------------------------------------------------

  buildRoomList(BuildContext context, PartialBookingDataTwoReceived state) {
    cartId = state.cartId.toString();
    // totalGuests = ((state.bookingSummaryAll!.guestcounts![0].indian!) +
    //     (state.bookingSummaryAll!.guestcounts![1].foreigner!));
    // print("Total Guests = " + totalGuests.toString());
    roomList.clear();
    if (widget.isOffline == false) {
      for (int i = 0;
          i < state.bookingSummaryAll!.data!.roomAllocation!.length;
          i++) {
        roomList.add(
          //rmlist
          RoomCount(
            id: state.bookingSummaryAll!.data!.roomAllocation![i].id,
            childrenCount:
                state.bookingSummaryAll!.data!.roomAllocation![i].childrenCount,
            foreignerCount: state
                .bookingSummaryAll!.data!.roomAllocation![i].foreignerCount,
            indianCount:
                state.bookingSummaryAll!.data!.roomAllocation![i].indianCount,
            totalCount:
                state.bookingSummaryAll!.data!.roomAllocation![i].totalCount,
            indianList: [],
            foreignerList: [],
            childrenList: [],
          ),
        );
        allCount = allCount! +
            state.bookingSummaryAll!.data!.roomAllocation![i].totalCount!;
      }
    } else {
      print("indian count + ${widget.offlineRoomModel![0].indianCount}");
      print(
          "offline room model length ${widget.offlineRoomModel!.length.toString()}");
      print("offline room model${widget.offlineRoomModel.toString()}");
      for (int i = 0; i < widget.offlineRoomModel!.length; i++) {
        roomList.add(
          //rmlist
          RoomCount(
            // id: state.bookingSummaryAll!.data!.roomAllocation![i].id,
            childrenCount: widget.offlineRoomModel![i].childrenCount != null
                ? widget.offlineRoomModel![i].childrenCount
                : 0,
            foreignerCount: widget.offlineRoomModel![i].foreignerCount != null
                ? widget.offlineRoomModel![i].foreignerCount
                : 0,
            indianCount: widget.offlineRoomModel![i].indianCount != null
                ? widget.offlineRoomModel![i].indianCount
                : 0,
            totalCount: widget.offlineRoomModel!.length,
            indianList: [],
            foreignerList: [],
            childrenList: [],
          ),
        );
        var indianCount = widget.offlineRoomModel![i].indianCount != null
            ? widget.offlineRoomModel![i].indianCount
            : 0;
        var foreignerCount = widget.offlineRoomModel![i].foreignerCount != null
            ? widget.offlineRoomModel![i].foreignerCount
            : 0;
        var childrenCount = widget.offlineRoomModel![i].childrenCount != null
            ? widget.offlineRoomModel![i].childrenCount
            : 0;
        allCount = allCount! +
            (indianCount! +
                foreignerCount! +
                int.parse(childrenCount.toString()));
      }
    }
    print("RoomList length (Total Rooms) = " + roomList.length.toString());
    print("Total Guest Count = " + allCount.toString());
  }

  roomGuestInnerList(
      BuildContext context, int index, PartialBookingDataTwoReceived state) {
    List<Widget> roomInnerList = [];
    print("Index is = " + index.toString());

    if (roomList[index].indianCount != 0) {
      for (int i = 0; i < roomList[index].indianCount!; i++) {
        roomList[index].indianList!.add(
              Customers(
                isDetailsAdded: false,
                name: "",
                dob: "",
                type: "Indian",
                isEdStarted: false,
                personUniqueID: "",
              ),
            );
      }

      roomInnerList.add(
        new ExpansionTile(
          textColor: HexColor("#53A874"),
          iconColor: HexColor("#53A874"),
          title: Text(
            "Indian X " + (roomList[index].indianCount).toString(),
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
          children: _editAddRoomGuest(
            context,
            roomList[index].indianCount,
            roomList[index].id,
            "indian",
            index,
            roomList[index].indianList,
          ),
        ),
      );
    }
    if (roomList[index].foreignerCount != 0) {
      for (int i = 0; i < roomList[index].foreignerCount!; i++) {
        roomList[index].foreignerList!.add(
              Customers(
                isDetailsAdded: false,
                name: "",
                dob: "",
                type: "Foreigner",
                isEdStarted: false,
                personUniqueID: "",
              ),
            );
      }

      roomInnerList.add(
        new ExpansionTile(
          textColor: HexColor("#53A874"),
          iconColor: HexColor("#53A874"),
          title: Text(
            "Foreigner X " + (roomList[index].foreignerCount).toString(),
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
          children: _editAddRoomGuest(
            context,
            roomList[index].foreignerCount,
            roomList[index].id,
            "foreigner",
            index,
            roomList[index].foreignerList,
          ),
        ),
      );
    }

    if (roomList[index].childrenCount != 0) {
      for (int i = 0; i < roomList[index].childrenCount!; i++) {
        roomList[index].childrenList!.add(
              Customers(
                isDetailsAdded: false,
                name: "",
                dob: "",
                type: "",
                isEdStarted: false,
                personUniqueID: "",
              ),
            );
      }
      roomInnerList.add(
        new ExpansionTile(
          textColor: HexColor("#53A874"),
          iconColor: HexColor("#53A874"),
          title: Text(
            "Children X " + (roomList[index].childrenCount).toString(),
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
          children: _editAddRoomGuest(
            context,
            roomList[index].childrenCount,
            roomList[index].id,
            "children",
            index,
            roomList[index].childrenList,
          ),
        ),
      );
    }
    print("children count ${roomList[index].childrenCount}");
    return roomInnerList;
  }

  _editAddRoomGuest(BuildContext context, int? count, String? roomAllocationId,
      String cutomerType, int index, List<Customers>? list) {
    List<Widget> _editAddRoomGuestList = [];
    for (int i = 0; i < count!; i++) {
      final _formKey = new GlobalKey<FormState>();
      final TextEditingController nameController = new TextEditingController();
      final TextEditingController dobController = new TextEditingController();
      final TextEditingController phoneController = new TextEditingController();
      final TextEditingController idproofController =
          new TextEditingController();
      var entranceChargeSubmit = 0;
      // if (widget.isOffline == true) {
      //   // if (cutomerType == 'indian') {
      //   //   //entranceCharge = vehicleInfo[0]['indianEntranceCharge'];
      //   //   entranceChargeSubmit = vehicleInfo[0]['indianEntranceCharge'];
      //   // } else if (cutomerType == 'foreigner') {
      //   //   // entranceCharge = vehicleInfo[0]['foreignerEntraneCharge'];
      //   //   entranceChargeSubmit = vehicleInfo[0]['foreignerEntraneCharge'];
      //   // } else {
      //   //   // entranceCharge = vehicleInfo[0]['childrenEntraneCharge'];
      //   //   entranceChargeSubmit = vehicleInfo[0]['childrenEntraneCharge'];
      //   // }
      // }

      //thenames
      // nameController.text = "Madhav";
      // dobController.text = "01/03/2015";
      // phoneController.text = "1234567890";
      // path = "storage/emulated/0/Parambikulam/1636950075989.jpg";
      // idproofController.text =
      //     "storage/emulated/0/Parambikulam/1636950075989.jpg";

      //roomms
      _editAddRoomGuestList.add(ExpansionTile(
        textColor: HexColor("#53A874"),
        iconColor: HexColor("#53A874"),
        onExpansionChanged: ((state) {
          if (isActivated == false && list![i].isEdStarted == false) {
            setState(() {
              isActivated = true;
              list[i].isEdStarted = true;
            });
          }
        }),
        title: Text(
          "Person " + (i + 1).toString(),
          style: TextStyle(
              color: HexColor("#53A874"),
              fontSize: 12.0,
              fontWeight: FontWeight.w400),
        ),
        children: [
          list![i].isDetailsAdded == false
              ? isActivated == true && list[i].isEdStarted == true
                  ? Form(
                      key: _formKey,
                      child: new Container(
                        child: new Column(
                          children: [
                            new Container(
                              child: new Column(
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          //  Navigator.push(context, MaterialPageRoute(builder: (context) =>   ScanIndividualData()));
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      // Icon(CupertinoIcons.multiply),
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                            CupertinoIcons
                                                                .multiply),
                                                      )
                                                    ],
                                                  ),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content: SizedBox(
                                                    height: 250.0,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  16.0)),
                                                      child: QRView(
                                                        key: qrKey,
                                                        onQRViewCreated:
                                                            (qrViewController) {
                                                          qrViewController
                                                              .scannedDataStream
                                                              .listen(
                                                                  (scanData) {
                                                            if (scanData.code!
                                                                .startsWith(
                                                                    '{"ticketId":')) {
                                                              qrViewController
                                                                  .stopCamera()
                                                                  .then(
                                                                      (value) async {
                                                                var deco =
                                                                    jsonDecode(
                                                                        scanData
                                                                            .code!);
                                                                if (cutomerType ==
                                                                    deco[
                                                                        'type']) {
                                                                  pguestId = deco[
                                                                      'guestId'];
                                                                  pticketId = deco[
                                                                      'ticketId'];
                                                                  nameController
                                                                          .text =
                                                                      deco[
                                                                          'name'];
                                                                  dobController
                                                                          .text =
                                                                      deco[
                                                                          'dob'];
                                                                  phoneController
                                                                          .text =
                                                                      deco[
                                                                          'phone'];
                                                                  currentCutomer =
                                                                      deco[
                                                                          'type'];
                                                                  Navigator.pop(
                                                                      context);
                                                                } else {
                                                                  if (await Vibrate
                                                                      .canVibrate) {
                                                                    Vibrate.feedback(
                                                                        FeedbackType
                                                                            .success);
                                                                  }
                                                                  Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              "Please scan $cutomerType visitor");
                                                                  Future.delayed(
                                                                      Duration(
                                                                          seconds:
                                                                              2),
                                                                      () async {
                                                                    qrViewController
                                                                        .resumeCamera();
                                                                  });
                                                                }
                                                              });
                                                            } else {
                                                              print("no");
                                                            }
                                                          });
                                                        },
                                                        //    _onQRViewCreated,
                                                        overlay:
                                                            QrScannerOverlayShape(
                                                          borderColor: Colors
                                                              .transparent,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Row(
                                          children: [
                                            Text("Scan QR code",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Icon(Icons.qr_code,
                                                color: Colors.white),
                                          ],
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
                                        child: TextInputField(
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Enter Name";
                                            }
                                            return null;
                                          },
                                          textEditingController: nameController,
                                          textInputType: TextInputType.text,
                                          labelText: "Name",
                                          error: "Enter Name",
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
                                        child: InkWell(
                                          onTap: () {
                                            _selectDate(context, i,
                                                dobController, cutomerType);
                                          },
                                          child: IgnorePointer(
                                            child: TextFormField(
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              controller: dobController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value == "") {
                                                  return "Select DOB";
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText: "DOB",
                                                errorStyle: new TextStyle(
                                                    color: Colors.white),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                fillColor: Colors.white,
                                                // labelText: widget.labelText,
                                                hintStyle: new TextStyle(
                                                    fontSize: 12.0,
                                                    color: HexColor("#9E9E9E")),
                                                filled: true,
                                              ),
                                              style: new TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
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
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          controller: phoneController,
                                          // maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Enter Phone Number";
                                            }
                                            return null;
                                            // else if (value.length < 10 ||
                                            //     value.length > 10) {
                                            //   return "Enter Valid Phone Number";
                                            // }
                                          },
                                          inputFormatters: [
                                            new LengthLimitingTextInputFormatter(
                                                42),
                                          ],
                                          decoration: InputDecoration(
                                            hintText: "Phone Number",
                                            errorStyle: new TextStyle(
                                                color: Colors.white),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                              ),
                                            ),
                                            fillColor: Colors.white,
                                            // labelText: widget.labelText,
                                            hintStyle: new TextStyle(
                                                fontSize: 12.0,
                                                color: HexColor("#9E9E9E")),
                                            filled: true,
                                          ),
                                          style: new TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  new Column(
                                    children: [
                                      new Row(
                                        children: [
                                          Expanded(child: Text("ID Proof")),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      new Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                // setState(() {
                                                //   cameraState = true;
                                                // });

                                                var cameraStatus =
                                                    await Permission
                                                        .camera.status;
                                                var galleryStatus =
                                                    await Permission
                                                        .storage.status;
                                                if (cameraStatus ==
                                                    PermissionStatus.denied) {
                                                  cameraStatus =
                                                      await Permission.camera
                                                          .request();
                                                }
                                                if (cameraStatus ==
                                                    PermissionStatus
                                                        .permanentlyDenied) {
                                                  cameraStatus =
                                                      await Permission.camera
                                                          .request();
                                                }
                                                if (galleryStatus ==
                                                    PermissionStatus.denied) {
                                                  galleryStatus =
                                                      await Permission.storage
                                                          .request();
                                                }
                                                if (galleryStatus ==
                                                    PermissionStatus
                                                        .permanentlyDenied) {
                                                  galleryStatus =
                                                      await Permission.storage
                                                          .request();
                                                }
                                                //  if(galleryStatus = PermissionStatus.denied)
                                                if (cameraStatus ==
                                                        PermissionStatus
                                                            .granted &&
                                                    galleryStatus ==
                                                        PermissionStatus
                                                            .granted) {
                                                  cameraState == false
                                                      ? _showPicker(context,
                                                          idproofController)
                                                      : _showToast(
                                                          context,
                                                          "Initializing camera, please wait",
                                                          Toast.LENGTH_SHORT);
                                                } else {
                                                  print("no permissions");
                                                }
                                              },
                                              child: IgnorePointer(
                                                //ridproof
                                                child: TextFormField(
                                                  textCapitalization:
                                                      TextCapitalization.words,
                                                  controller: idproofController,
                                                  // validator: (value) {
                                                  //   if (widget.isCottage ==
                                                  //       true) {
                                                  //     if (value == null ||
                                                  //         value == "") {
                                                  //       return "Upload ID Proof";
                                                  //     }
                                                  //   }

                                                  //   return null;
                                                  // },
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Upload ID Proof Image",
                                                    errorStyle: new TextStyle(
                                                        color: Colors.white),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                    ),
                                                    fillColor: Colors.white,
                                                    // labelText: widget.labelText,
                                                    hintStyle: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: HexColor(
                                                            "#9E9E9E")),
                                                    filled: true,
                                                    suffixIcon: Icon(
                                                      Icons.file_upload,
                                                      color:
                                                          HexColor("#9E9E9E"),
                                                    ),
                                                  ),
                                                  style: new TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 15.0,
                                      // ),
                                    ],
                                  ),
                                  // ETFIELD
                                  // widget.isOffline == true
                                  //     ? new Container(
                                  //         padding: EdgeInsets.only(
                                  //             left: 12,
                                  //             right: 12,
                                  //             top: 16,
                                  //             bottom: 16),
                                  //         width:
                                  //             MediaQuery.of(context).size.width,
                                  //         decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.all(
                                  //             Radius.circular(4.0),
                                  //           ),
                                  //           color: Colors.white,
                                  //         ),
                                  //         child: new Row(
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.spaceBetween,
                                  //           children: [
                                  //             BlocConsumer<BlocEntranceCharge,
                                  //                     StateEntranceCharge>(
                                  //                 listener: (context, state) {
                                  //               if (state
                                  //                   is EntranceChargeAdded) {
                                  //                 entranceChargeSubmit =
                                  //                     state.newEntrance!;
                                  //               }
                                  //               if (state
                                  //                   is EntranceChargeRemoved) {
                                  //                 entranceChargeSubmit =
                                  //                     state.newEntrance!;
                                  //               }
                                  //             }, builder: (context, state) {
                                  //               if (state
                                  //                   is EntranceChargeAdded) {
                                  //                 return Text(
                                  //                   "Entrance charge Rs.$entranceCharge Applied",
                                  //                   style: new TextStyle(
                                  //                       fontSize: 14,
                                  //                       color: Colors.black),
                                  //                 );
                                  //               }
                                  //               if (state
                                  //                   is EntranceChargeRemoved) {
                                  //                 return Text(
                                  //                   "Entrance charge Rs.$entranceCharge Not Applied",
                                  //                   style: new TextStyle(
                                  //                       fontSize: 14,
                                  //                       color: Colors.black),
                                  //                 );
                                  //               }
                                  //               return Text(
                                  //                 "Entrance charge Rs.$entranceCharge Applied",
                                  //                 style: new TextStyle(
                                  //                     fontSize: 14,
                                  //                     color: Colors.black),
                                  //               );
                                  //             }),
                                  //             new Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment
                                  //                       .spaceBetween,
                                  //               children: [
                                  //                 IconButton(
                                  //                   padding: EdgeInsets.zero,
                                  //                   constraints:
                                  //                       BoxConstraints(),
                                  //                   onPressed: () {
                                  //                     if (isRemoved == false) {
                                  //                       isRemoved = true;
                                  //                       isAdded = false;
                                  //                       BlocProvider.of<
                                  //                                   BlocEntranceCharge>(
                                  //                               context)
                                  //                           .add(
                                  //                               AlterEntranceCharge(
                                  //                         value: false,
                                  //                         entranceCharge:
                                  //                             entranceCharge,
                                  //                         offlineBooking: widget
                                  //                             .offlineBooking,
                                  //                       ));
                                  //                     } else {
                                  //                       _showToast(
                                  //                           context,
                                  //                           'Entrance charge not applied',
                                  //                           Toast.LENGTH_SHORT);
                                  //                     }
                                  //                   },
                                  //                   icon: Icon(
                                  //                     Icons.remove,
                                  //                     color: Colors.black,
                                  //                     size: 18,
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   width:
                                  //                       MediaQuery.of(context)
                                  //                               .size
                                  //                               .width /
                                  //                           25,
                                  //                 ),
                                  //                 IconButton(
                                  //                   padding: EdgeInsets.zero,
                                  //                   constraints:
                                  //                       BoxConstraints(),
                                  //                   onPressed: () {
                                  //                     if (isAdded == false) {
                                  //                       isAdded = true;
                                  //                       isRemoved = false;
                                  //                       BlocProvider.of<
                                  //                                   BlocEntranceCharge>(
                                  //                               context)
                                  //                           .add(
                                  //                               AlterEntranceCharge(
                                  //                         value: true,
                                  //                         entranceCharge:
                                  //                             entranceCharge,
                                  //                         offlineBooking: widget
                                  //                             .offlineBooking,
                                  //                       ));
                                  //                     } else {
                                  //                       _showToast(
                                  //                           context,
                                  //                           'Entrance charge applied',
                                  //                           Toast.LENGTH_SHORT);
                                  //                     }
                                  //                   },
                                  //                   icon: Icon(
                                  //                     Icons.add,
                                  //                     color: Colors.black,
                                  //                     size: 18,
                                  //                   ),
                                  //                 )
                                  //               ],
                                  //             )
                                  //           ],
                                  //         ),
                                  //       )
                                  //     : SizedBox.shrink(),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Container(
                                    height: 45,
                                    width: 270,
                                    child: new TextButton(
                                      style: StyleElements
                                          .submitAddPersonButtonStyle,
                                      onPressed: () async {
                                        print("Cart ID = " + cartId.toString());
                                        if (_formKey.currentState!.validate()) {
                                          print(
                                            "Is Editing ? " +
                                                isEditing.toString(),
                                          );
                                          print("disabledbloc");
                                          //srd
                                          if (widget.isOffline == false) {
                                            BlocProvider.of<BlocAddRoomPerson>(
                                                    context)
                                                .add(
                                              //srp
                                              SaveRoomPersonData(
                                                guestid: pguestId != ""
                                                    ? pguestId
                                                    : ObjectId().toString(),
                                                ticketid: pticketId,
                                                name: nameController.text,
                                                dob: dobController.text,
                                                phoneno: phoneController.text,
                                                roomAllocationId:
                                                    roomAllocationId.toString(),
                                                guestType:
                                                    cutomerType.toString(),
                                                cartId: cartId!,
                                                file: path,
                                                currentIndex: i,
                                                roomIndex: index,
                                                isOffline: widget.isOffline,
                                              ),
                                            );
                                          } else {
                                            print("type ${widget.date}");

                                            BlocProvider.of<BlocEntranceCharge>(
                                                    context)
                                                .add(RefreshBloc());
                                            BlocProvider.of<BlocAddRoomPerson>(
                                                    context)
                                                .add(
                                              //srp
                                              SaveRoomPersonData(
                                                guestid: pguestId != ""
                                                    ? pguestId
                                                    : ObjectId().toString(),
                                                // guestid: pguestId,
                                                ticketid: pticketId,
                                                // entranceCharge: widget
                                                //     .offlineBooking!
                                                //     .entranceCharge,
                                                entranceCharge:
                                                    entranceChargeSubmit,
                                                date: widget.date,
                                                name: nameController.text,
                                                dob: dobController.text,
                                                phoneno: phoneController.text,
                                                // roomAllocationId:
                                                //     roomAllocationId.toString(),
                                                guestType:
                                                    cutomerType.toString(),
                                                cartId: cartId!,
                                                file: path,
                                                currentIndex: i,
                                                roomIndex: index,
                                                offlineBooking:
                                                    widget.offlineBooking,
                                                isOffline: widget.isOffline,
                                              ),
                                            );
                                          }
                                        }
                                        // } else {
                                        //   print("save person button disabled");
                                        // }
                                      },
                                      child: BlocConsumer<BlocAddRoomPerson,
                                          StateAddRoomPerson>(
                                        builder: (context, state) {
                                          if (state is AddPersonRoomInitial) {
                                            print(
                                                "AddRoomPersonInitial - Builder");
                                            return SizedBox(
                                              height: 28.0,
                                              width: 28.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.black),
                                                strokeWidth: 2,
                                              ),
                                            );
                                          } else if (state
                                              is UploadingFileInRoom) {
                                            print(
                                                "UploadingFileInRoom - Builder");
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Uploading File",
                                                  style: StyleElements
                                                      .buttonTextStyleSemiBoldBlack,
                                                ),
                                                SizedBox(
                                                  width: 15.0,
                                                ),
                                                SizedBox(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.black),
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              ],
                                            );
                                            //roomadd
                                          } else if (state
                                              is RoomFileUploaded) {
                                            print("RoomFileUploaded - Builder");
                                            path = "";
                                            disablePsButton = true;
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 20.0,
                                                  height: 20.0,
                                                  child: Icon(Icons.check),
                                                ),
                                              ],
                                            );
                                          }
                                          // else if (state
                                          //     is RoomFileNotUploaded) {
                                          //   BlocProvider.of<BlocAddRoomPerson>(
                                          //           context)
                                          //       .add(RefreshRoom());
                                          //   print(
                                          //       "RoomFileNotUploaded - Builder");
                                          //   _showToast(
                                          //       context,
                                          //       "ID proof has not been uploaded for this user due to some technical issues",
                                          //       Toast.LENGTH_LONG);
                                          //   print("File Not Uploaded - " +
                                          //       state.msg.toString());
                                          //   return new Text('File Not Uploaded',
                                          //       style: StyleElements
                                          //           .buttonTextStyleSemiBoldBlack);
                                          // }
                                          return new Text('SAVE',
                                              style: StyleElements
                                                  .buttonTextStyleSemiBoldBlack);
                                        },
                                        listener: (context, state) {
                                          // if (state is RoomPersonUpdated) {
                                          //   setState(() {
                                          //     newList[state.currentIndex!]
                                          //         .isDetailsAdded = true;
                                          //     newList[state.currentIndex!].name =
                                          //         state.name;
                                          //     newList[state.currentIndex!]
                                          //         .phoneNumber = state.phone;
                                          //     // newList[state.currentIndex!].email =
                                          //     //     state.email;
                                          //     newList[state.currentIndex!]
                                          //         .personUniqueID = state.id;
                                          //     newList[state.currentIndex!].dob =
                                          //         state.dob;
                                          //     newList[state.currentIndex!].type =
                                          //         state.type;
                                          //   });
                                          // }
                                          // if (state is RoomPersonNotUpdated) {
                                          //   print("Current Count " +
                                          //       allCount.toString());

                                          //   _showToast(
                                          //       context,
                                          //       state.message.toString(),
                                          //       Toast.LENGTH_SHORT);
                                          // }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: isActivated == true &&
                                list[i].isEdStarted == false
                            ? Text("Please fill and save opened tab")
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    print("customer type -- " +
                                        cutomerType.toString());
                                    isActivated = true;
                                    list[i].isEdStarted = true;
                                    // if (cutomerType == "indian") {
                                    //   isActivated = true;
                                    //   roomList[index]
                                    //       .indianList![i]
                                    //       .isEdStarted = true;
                                    // }
                                    // if (cutomerType == "foreigner") {
                                    //   isActivated = true;
                                    //   roomList[index]
                                    //       .foreignerList![i]
                                    //       .isEdStarted = true;
                                    // }
                                    // if (cutomerType == "children") {
                                    //   isActivated = true;
                                    //   roomList[index]
                                    //       .childrenList![i]
                                    //       .isEdStarted = true;
                                    // }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Add this person"),
                                    SizedBox(width: 5.0),
                                    Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    )
              : InkWell(
                  onTap: () {
                    // _showToast(context, i.toString(), Toast.LENGTH_SHORT);
                  },
                  child: new AppCard(
                    outLineColor: HexColor('#292929'),
                    color: HexColor('#292929'),
                    child: new Column(
                      children: [
                        new Row(
                          children: [
                            Expanded(
                              child: new Text(
                                'Name',
                                style: StyleElements.bookingDetailsTitle,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                'DOB',
                                style: StyleElements.bookingDetailsTitle,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                'Guest Type',
                                style: StyleElements.bookingDetailsTitle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        new Row(
                          children: [
                            Expanded(
                              child: new Text(
                                list[i].name.toString(),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                list[i].dob.toString(),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                list[i].type.toString(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        new Row(
                          children: [
                            new Container(
                              height: 20.0,
                              width: MediaQuery.of(context).size.width / 6,
                              padding: EdgeInsets.all(2.0),
                              decoration: new BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              //rdelete
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    child: Icon(Icons.done, size: 14),
                                  ),
                                  new Text(
                                    "Added",
                                    style: new TextStyle(fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ],
      )
          //rme
          // : Center(
          //     child: Padding(
          //       padding: const EdgeInsets.all(12.0),
          //       child: Text("Please fill and save opened tab - first mode"),
          //     ),
          //   ),
          );
    }
    return _editAddRoomGuestList;
  }

  void showAlertTwo(BuildContext context, String? name, int i,
      String? personUniqueID, List<Customers> list) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Delete Guest"),
      content: Text("Are you sure you wnat to delete this guest ?"),
      actions: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              deleted = true;
              Navigator.pop(context);
              //alldelete
              print("Guest Deletion - Initalized");
              BlocProvider.of<BlocRoomUpdateGuest>(context)
                  .add(DoDeleteRoomGuest(
                personUniqueID: personUniqueID,
                list: newList,
                i: i,
              ));
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

//-----------------------------------------------------------
//-----------------------------------------------------------
  void checkStatus() async {
    if (widget.isOffline == true) {
      // Fluttertoast.showToast(msg: "showing offline data");
      widget.slotDetails!.forEach((element) {
        print("and the details $element");
      });
      // startTime = slotDetails[0]['startTime'].toString();
      // endTime = slotDetails[0]['endTime'].toString();
      vehicleInfo = await db!.getVehicleInformation();
      print(vehicleInfo);

      // BlocProvider.of<BlocEntranceCharge>(context).add(RefreshBloc());

      BlocProvider.of<BookingBloc>(context).add(
        GetPartialBookingSummary(
          isOffline: widget.isOffline,
          slotDetails: widget.slotDetails,
          vehicleDetails: vehicleInfo,
        ),
      );
    } else {
      BlocProvider.of<BookingBloc>(context)
          .add(GetPartialBookingSummary(isOffline: widget.isOffline));
    }
  }

  _showPicker(BuildContext context, TextEditingController idproofController) {
    showModalBottomSheet(
        context: context,
        builder: (dialogContext) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.photo_camera, color: Colors.white),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                      _imgFromCamera(context, idproofController);
                    },
                  ),
                  new ListTile(
                      leading:
                          new Icon(Icons.photo_library, color: Colors.white),
                      title: new Text('Gallery'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _imgFromGallery(context, idproofController);
                      }),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _imgFromCamera(
      BuildContext context, TextEditingController idproofController) async {
    cameraState = true;
    print("fromcamera");
    try {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
          // imageQuality: 85,
          maxHeight: 200,
          maxWidth: 200);
      if (pickedFile != null) {
        // String basename = basename(file.path);
        // idproofController.text = pickedFile.name.toString();
        idproofController.text = pickedFile.path.split('/').last.toString();
        path = pickedFile.path;
        // path = await getCompressImage(pickedFile.path);
        cameraState = false;
      } else {
        _showToast(context, "No Image Detected", Toast.LENGTH_SHORT);
        cameraState = false;
      }
    } catch (e) {
      print("Image Upload Exception - " + e.toString());
      _showToast(context, e.toString(), Toast.LENGTH_SHORT);
      cameraState = false;
    }
  }

  Future<void> _imgFromGallery(
      BuildContext context, TextEditingController idproofController) async {
    cameraState = true;
    try {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        // String basename = basename(file.path);
        // idproofController.text = pickedFile.name.toString();
        idproofController.text = pickedFile.path.split('/').last.toString();
        path = pickedFile.path;

        // final bytes = _image.readAsBytesSync().lengthInBytes;
        // final kb = bytes / 1024;
        // final mb = kb / 1024;
        cameraState = false;
      } else {
        _showToast(context, "No Image Detected", Toast.LENGTH_SHORT);
        cameraState = false;
      }
    } catch (e) {
      print("Image Upload Exception - " + e.toString());
      _showToast(context, e.toString(), Toast.LENGTH_SHORT);
    }
  }

  void getPermission() async {}

  assignBus(BuildContext context, PartialBookingDataTwoReceived state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Assign Bus"),
            BlocBuilder<BusBloc, BusState>(
                buildWhen: (((previous, current) => current is EventSwitched)),
                builder: (context, state) {
                  return Checkbox(
                      activeColor: Colors.green,
                      value: context.read<BusBloc>().status,
                      onChanged: (status) {
                        context
                            .read<BusBloc>()
                            .add(SwitchEvent(status: status));
                      });
                }),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        BlocBuilder<BusBloc, BusState>(
            buildWhen: (((previous, current) =>
                current is EventSwitched || state is BusDataFetched)),
            builder: (context, state) {
              if (state is EventSwitched || state is BusDataFetched) {
                return context.read<BusBloc>().status!
                    ? SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () {
                            context.read<BusBloc>().busDataList.isNotEmpty
                                ? showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Please select a bus"),
                                        content: SizedBox(
                                          height:
                                              300.0, // Change as per your requirement
                                          width: 300.0,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: context
                                                  .read<BusBloc>()
                                                  .busDataList
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    if (context
                                                                .read<BusBloc>()
                                                                .busDataList[
                                                                    index]
                                                                .busDetails!
                                                                .noOfSeatsDummy! >
                                                            0 &&
                                                        context
                                                            .read<BusBloc>()
                                                            .busAllocated
                                                            .where((element) =>
                                                                element
                                                                    .busDetails!
                                                                    .busId ==
                                                                context
                                                                    .read<
                                                                        BusBloc>()
                                                                    .busDataList[
                                                                        index]
                                                                    .busDetails!
                                                                    .busId)
                                                            .isEmpty) {
                                                      List<BusData>
                                                          busDataList = context
                                                              .read<BusBloc>()
                                                              .busDataList;
                                                      print(busDataList);
                                                      context
                                                          .read<BusBloc>()
                                                          .add(BusChoosen(
                                                              choosenData: context
                                                                      .read<
                                                                          BusBloc>()
                                                                      .busDataList[
                                                                  index]));
                                                    } else if (context
                                                            .read<BusBloc>()
                                                            .busDataList[index]
                                                            .busDetails!
                                                            .noOfSeatsDummy! <=
                                                        0) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'All seats are occupied');
                                                    }
                                                  },
                                                  title: Text(context
                                                          .read<BusBloc>()
                                                          .busDataList[index]
                                                          .busDetails!
                                                          .busName ??
                                                      "N/A"),
                                                  subtitle: Text(
                                                    "Seats remaining - ${context.read<BusBloc>().busDataList[index].busDetails!.noOfSeatsDummy}",
                                                    style: TextStyle(
                                                        color: context
                                                                    .read<
                                                                        BusBloc>()
                                                                    .busDataList[
                                                                        index]
                                                                    .busDetails!
                                                                    .noOfSeatsDummy! >
                                                                2
                                                            ? Colors.green
                                                            : Colors.red),
                                                  ),
                                                );
                                              }),
                                        ),
                                      );
                                    })
                                : Fluttertoast.showToast(
                                    msg: 'No buses available');
                          },
                          child: Text(
                            "Select Bus",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : Center(child: Text("Bus not allocated"));
              }
              return SizedBox.shrink();
            }),

        BlocBuilder<BusBloc, BusState>(
            buildWhen: (((previous, current) => current is BusChoosed)),
            builder: (context, state) {
              return context.read<BusBloc>().busAllocated.isNotEmpty
                  ? ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 5.0,
                            ),
                            Divider(),
                            SizedBox(
                              height: 5.0,
                            )
                          ],
                        );
                      },
                      shrinkWrap: true,
                      itemCount:
                          context.read<BusBloc>().busAllocated.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return TextButton(
                              onPressed: () {
                                context.read<BusBloc>().add(ClearChoosenData());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Clear"),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(
                                    Icons.clear,
                                    size: 16,
                                  ),
                                ],
                              ));
                        }
                        index -= 1;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  context
                                      .read<BusBloc>()
                                      .busAllocated[index]
                                      .busDetails!
                                      .busName!,
                                ),
                                BlocBuilder<BusBloc, BusState>(
                                  buildWhen: (((previous, current) =>
                                      current is BSPersonRemoved ||
                                      current is BusChoosed ||
                                      current is BSPersonAdded)),
                                  builder: (context, state) {
                                    return Text(
                                      "Seats Remaining - ${context.read<BusBloc>().busDataList[index].busDetails!.noOfSeatsDummy}",
                                      style: TextStyle(
                                        color: context
                                                    .read<BusBloc>()
                                                    .busDataList[index]
                                                    .busDetails!
                                                    .noOfSeatsDummy! >
                                                2
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            BlocBuilder<BusBloc, BusState>(
                              buildWhen: (((previous, current) =>
                                  current is BSPersonRemoved ||
                                  current is BSPersonAdded)),
                              builder: (context, state) {
                                return Container(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              if (context
                                                          .read<BusBloc>()
                                                          .busAllocated[index]
                                                          .busDetails!
                                                          .noOfPassengers! >
                                                      0 ||
                                                  context
                                                          .read<BusBloc>()
                                                          .busAllocated[index]
                                                          .busDetails!
                                                          .noOfPassengers !=
                                                      0) {
                                                context.read<BusBloc>().add(
                                                    RemoveBSPerson(
                                                        index: index));
                                              }
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          ),
                                          new Text(
                                            context
                                                .read<BusBloc>()
                                                .busAllocated[index]
                                                .busDetails!
                                                .noOfPassengers
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (context
                                                          .read<BusBloc>()
                                                          .totalMembers >
                                                      context
                                                          .read<BusBloc>()
                                                          .remainingPersons &&
                                                  context
                                                          .read<BusBloc>()
                                                          .busAllocated[index]
                                                          .busDetails!
                                                          .noOfPassengers! <
                                                      context
                                                          .read<BusBloc>()
                                                          .totalMembers &&
                                                  context
                                                          .read<BusBloc>()
                                                          .busAllocated[index]
                                                          .busDetails!
                                                          .noOfSeatsDummy! >
                                                      context
                                                          .read<BusBloc>()
                                                          .busAllocated[index]
                                                          .busDetails!
                                                          .noOfPassengers!) {
                                                context.read<BusBloc>().add(
                                                    AddBSPerson(index: index));
                                              }
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
                              },
                            ),
                          ],
                        );
                      })
                  : SizedBox.shrink();
            }),

        //
      ],
    );
  }

  // dropDownMenuBus(BuildContext context) {
  //   return DropdownButton(
  //     underline: SizedBox.shrink(),
  //     hint: Text(
  //       "Choose Vehicle",
  //       style: new TextStyle(fontSize: 13.0),
  //     ),
  //     value: context.read<BusBloc>().busDataList[0].busDetails!.busName,
  //     onChanged: (value) {},
  //     items: context.read<BusBloc>().busDataList.map((element) {
  //       return DropdownMenuItem(
  //           value: element.busDetails!.busName.toString(),
  //           child: new Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 element.busDetails!.busName.toString(),
  //                 style: new TextStyle(fontSize: 13.0),
  //               ),
  //             ],
  //           ));
  //     }).toList(),
  //   );

  //   // for (int i = 0; i < vehicleAddCount!; i++) {
  //   //   itemsMenu.add(
  //   //     new Row(
  //   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //       children: [
  //   //        new SizedBox(
  //   //           width: 100.0,
  //   //           child: InkWell(
  //   //             onTap: () {
  //   //               _showToast(context, vehicleDetailsSelected[i].id.toString(),
  //   //                   Toast.LENGTH_SHORT);
  //   //             },
  //   //             child: Row(
  //   //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //               children: [
  //   //                 vehicleDetailsSelected[i].type != null
  //   //                     ? vehicleDetailsSelected[i].type ==
  //   //                             "Heavy Motor Vehicle"
  //   //                         ? new Text(
  //   //                             vehicleDetails[0].amount.toString() + " INR",
  //   //                             style: new TextStyle(fontSize: 13.0),
  //   //                           )
  //   //                         : new Text(
  //   //                             vehicleDetails[1].amount.toString() + " INR",
  //   //                             style: new TextStyle(fontSize: 13.0),
  //   //                           )
  //   //                     : SizedBox.shrink(),
  //   //                 new IconButton(
  //   //                   onPressed: () {
  //   //                     setState(() {
  //   //                       // if (vehicleDetailsSelected[i].id != null) {
  //   //                       if (isEnabled == true) {
  //   //                         if (vehicleAddCount != 0) {
  //   //                           if (vehicleDetailsSelected[i].id != null) {
  //   //                             _openLoadingDialog(context, "Removing");
  //   //                             BlocProvider.of<BlocVehicle>(context).add(
  //   //                               RemoveVehicle(
  //   //                                 index: i,
  //   //                                 vehicleName: vehicleDetailsSelected[i].type,
  //   //                                 vehicleAmount:
  //   //                                     vehicleDetailsSelected[i].amount,
  //   //                                 bookingDate: widget.date,
  //   //                                 id: vehicleDetailsSelected[i].id,
  //   //                                 cartId: cartId,
  //   //                                 offlineBooking: widget.offlineBooking,
  //   //                                 isOffline: widget.isOffline,
  //   //                                 vehicleDetailsList: vehicleDetailsList,
  //   //                               ),
  //   //                             );
  //   //                           } else {
  //   //                             vehicleAddCount = vehicleAddCount! - 1;
  //   //                             vehicleDetailsSelected
  //   //                                 .removeAt(vehicleAddCount!);
  //   //                           }

  //   //                           // print(vehicleDetailsSelected.length);
  //   //                         }
  //   //                       } else {
  //   //                         _showToast(
  //   //                             context, "Button Disabled", Toast.LENGTH_SHORT);
  //   //                       }
  //   //                       // } else {
  //   //                       //   Fluttertoast.showToast(
  //   //                       //       msg: "Please select a vehicle.");
  //   //                       // }
  //   //                     });

  //   //                     // BlocProvider.of<BlocVehicle>(context).add(
  //   //                     //     UpdateVehicle(
  //   //                     //       index: i,
  //   //                     //       vehicleName: vehicleDetailsSelected[i].type,
  //   //                     //       bookingDate: widget.date,
  //   //                     //       id: vehicleDetailsSelected[i].id,
  //   //                     //       cartId: cartId,
  //   //                     //     ),
  //   //                     //   );
  //   //                   },
  //   //                   icon: new Icon(Icons.remove),
  //   //                 ),
  //   //               ],
  //   //             ),
  //   //           ),
  //   //         ),
  //   //       ],
  //   //     ),
  //   //   );
  //   // }
  // }

  allocateBus(BuildContext context) {
    // int difference = 0;
    widgetList = [];
    List<BusData>? busDataList = [];
    busAllocation = [];
    int number = widget.offlineBooking!.indianCount! +
        widget.offlineBooking!.foreignerCount! +
        widget.offlineBooking!.childrenCount!;
    print(context.read<BusBloc>().busDataList);
    context
        .read<BusBloc>()
        .busDataList
        .removeWhere((element) => element.busDetails!.status == 'inactive');
    busDataList = context.read<BusBloc>().busDataList;

    if (busDataList.isNotEmpty) {
      for (int i = 0; i < busDataList.length; i++) {
        widgetList!.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: DropdownButton(
                  isDense: false,
                  isExpanded: true,
                  underline: SizedBox.shrink(),
                  hint: Text(
                    "Select Bus",
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  value: busDataList[i].busDetails!.busId,
                  onChanged: (value) {},
                  items: busDataList.map((element) {
                    return DropdownMenuItem(
                        value: element.busDetails!.busId,
                        child: Text(
                          element.busDetails!.busName!,
                          style: new TextStyle(fontSize: 13.0),
                        ));
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }
      // for (int i = 0; i < busDataList.length; i++) {
      //   if (busDataList[i].busDetails!.noOfSeatsDummy! >= number) {
      //     busAllocation!.add(
      //       BusAllocationModel(
      //         busId: busDataList[i].busDetails!.busId,
      //         noOfPassengers: number,
      //       ),
      //     );

      //     widgetList!.add(
      //       Row(
      //         children: [
      //           Text(
      //             number > 1
      //                 ? "$number  visitors allocated to ${busDataList[i].busDetails!.busName}"
      //                 : "$number  visitor allocated to ${busDataList[i].busDetails!.busName}",
      //           ),
      //         ],
      //       ),
      //     );
      //     number = 0;
      //     break;
      //   } else {
      //     for (int j = number; j >= 0; j--) {
      //       if (j <= busDataList[i].busDetails!.noOfSeatsDummy!) {
      //         number = number - j;
      //         busAllocation!.add(
      //           BusAllocationModel(
      //             busId: busDataList[i].busDetails!.busId,
      //             noOfPassengers: j,
      //           ),
      //         );
      //         widgetList!.add(
      //           Row(
      //             children: [
      //               Column(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   Text(
      //                     j > 1
      //                         ? "$j  visitors allocated to ${busDataList[i].busDetails!.busName}"
      //                         : "$j  visitor allocated to ${busDataList[i].busDetails!.busName}",
      //                   ),
      //                   SizedBox(
      //                     height: 10.0,
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         );
      //         break;
      //       }
      //     }
      //   }
      // }
      // print("Remaining non allocated visitors $number");
      // if (number > 0) {
      //   widgetList!.add(
      //     Row(
      //       children: [
      //         Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Text(
      //               number > 1
      //                   ? "$number  visitors not allocated, all seats full"
      //                   : "$number  visitor not allocated, all seats full",
      //               style: TextStyle(color: Colors.red),
      //             ),
      //             SizedBox(
      //               height: 10.0,
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   );
      // }
      // print(busAllocation);
    }
    return widgetList;
  }

  getBusID() {
    List busAllocationIds = [];
    List<BusData> busAllocated = context.read<BusBloc>().busAllocated;
    for (int index = 0; index < busAllocated.length; index++) {
      busAllocationIds.add(
        busAllocated[index].busDetails!.busId,
      );
    }
    return busAllocationIds;
  }

  // getCompressImage(String path) {
  //   print(path.le)
  // }

  // void _onQRViewCreated(QRViewController qrViewController) {
  //   // this.controller = qrViewController;
  //   qrViewController.scannedDataStream.listen((scanData) {
  //     if (scanData.code!.startsWith('{ticketId:')) {
  //       print("yes");
  //       print(scanData.code!);
  //       Navigator.pop(context);
  //     } else {
  //       print("no");
  //     }
  //     ;
  //   });
  // }
}

class BusAllocationModel {
  String? busId;
  int? noOfPassengers;
  BusAllocationModel({required this.busId, this.noOfPassengers});
}

class Customers {
  String? name, label, dob, type, id, personUniqueID, phoneNumber, email;
  String? photo;
  int? count, number, roomNumber;
  bool? isDetailsAdded, isEdStarted;
  TextEditingController? textEditingController;
  List? statusList;
  bool? status;
  List<InnerListIndividual>? innerListIndividual;
  Customers({
    this.count,
    this.name,
    this.id,
    this.personUniqueID,
    this.status,
    this.email,
    this.phoneNumber,
    this.dob,
    this.isEdStarted,
    this.roomNumber,
    this.photo,
    this.type,
    this.label,
    this.textEditingController,
    this.number,
    this.innerListIndividual,
    this.isDetailsAdded,
    this.statusList,
  });
}

class RoomCount {
  List<Customers>? indianList;
  List<Customers>? foreignerList;
  List<Customers>? childrenList;
  int? totalCount, indianCount, foreignerCount, childrenCount;
  String? id;
  RoomCount({
    this.childrenCount,
    this.indianList,
    this.foreignerList,
    this.foreignerCount,
    this.childrenList,
    this.id,
    this.indianCount,
    this.totalCount,
  });
}

class InnerListIndividual {
  String? name, label;
  int? count, number;
  bool? isAdded, status;
  Widget? fields;
  InnerListIndividual(
      {this.count,
      this.isAdded,
      this.label,
      this.name,
      this.number,
      this.fields,
      this.status});
}

class InduvicalSelection {
  bool? status;
  InduvicalSelection({this.status});
}

class VeicleInformation {
  int? number;
  String? type;
  int? amount;
  String? id;
  // bool? status;
  VeicleInformation({this.type, this.amount, this.id, this.number});
}

class AddedPerson {
  int? number;
  AddedPerson({this.number});
}
