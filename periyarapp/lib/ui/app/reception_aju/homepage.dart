import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:disk_space/disk_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:objectid/objectid.dart';
import 'package:parambikulam/bloc/download/downloadbloc.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/bloc/programs/programsevent.dart';
import 'package:parambikulam/bloc/programs/programsstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/data/models/bookingsummary.dart';
import 'package:parambikulam/data/models/busmodel.dart';
import 'package:parambikulam/data/models/offlineticket.dart';
import 'package:parambikulam/data/models/packagerate.dart';
import 'package:parambikulam/data/models/programmz.dart';
import 'package:parambikulam/data/models/test.dart';
import 'package:parambikulam/data/models/vehiclemodel.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/bus/busdetailed.dart';
import 'package:parambikulam/ui/app/datasync/uploaddata.dart';
import 'package:parambikulam/ui/app/nodatafound.dart';
import 'package:parambikulam/ui/app/reception_aju/downloadpage.dart';
import 'package:parambikulam/ui/app/reception_aju/drawerwidget.dart';
import 'package:parambikulam/ui/app/reception_aju/programdetails.dart';
import 'package:parambikulam/ui/app/scanner%20&%20ticket/qrscanner.dart';
import 'package:http/http.dart' as http;
import 'package:parambikulam/utils/helper.dart';
import 'package:parambikulam/utils/serverhelper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
///reception page
class HomePage extends StatefulWidget {
  final bool? isConnected;
  HomePage({this.isConnected});
  _NewHomePage createState() => _NewHomePage();
}

class _NewHomePage extends State<HomePage> {
  final f = new DateFormat('MMMM dd, yyyy');
  final timeF = new DateFormat('hh:mm, a');
  List<ProgrammData> gridPrograms = [];
  List<BusData> busData = [];
  List previousBookings = [];
  List<ProgrammData> gridProgramsLocal = [];
  List<GridPrograms> searchedList = [];
  List<GridPrograms> offlineList = [];
  List<Map> vehicleInfo = [];
  List allIdProofs = [];
  List<BusUpload> busUpload = [];
  TextEditingController searchPController = new TextEditingController();
  DatabaseHelper? db = DatabaseHelper.instance;
  var connectivityResult;
  bool? isOffline = false;
  bool b = false;
  String? appDocumentsPath;
  double? currentPercent = 0.1;
  var token;
  double? percent = 0.0;
  ProgressDialog? progressDialog;
  final folderName = "Parambikulam";
  DateTime? currentBackPressedTime;
  Directory? path;

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context: context);
    context.read<ProgramsBloc>().add(CheckAndGetTicket());
    checkInternet();
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkInternet() async {
    // busUpload = await db!.getBusFinalData();
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isOffline = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Showing offline data",
              style: TextStyle(color: Colors.white)),
        ),
      );

      try {
        previousBookings = await db!.getFinalBookingData();
        vehicleInfo = await db!.getVehicleInformation();
        gridPrograms = await db!.queryAllRows();
        busData = await db!.queryAllBusRows();
      } catch (e) {
        _showToast(
            context,
            "Offline data not found, please go online and download data",
            Toast.LENGTH_LONG);
      }
      if (gridPrograms.length == 0) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => NoDataFoundPage()));
      } else {
        BlocProvider.of<ProgramsBloc>(context)
            .add(GetPrograms(isOffline: true));
      }
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.green,
      //     content: Text("Showing online data",
      //         style: TextStyle(color: Colors.white)),
      //   ),
      // );
      BlocProvider.of<ProgramsBloc>(context).add(
        GetPrograms(
          isOffline: false,
          date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
        ),
      );
      //  bool result = await checkConnection(context);
      // if (result == true) {
      //   isOffline = false;
      //   // Fluttertoast.showToast(
      //   //     msg: "Showing online data",
      //   //     backgroundColor: Colors.green,
      //   //     textColor: Colors.white);
      //   BlocProvider.of<ProgramsBloc>(context).add(GetPrograms(
      //       isOffline: false,
      //       date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()));
      // } else {
      //   Fluttertoast.showToast(
      //       msg:
      //           "This connection has no internet, please check the connection.",
      //       toastLength: Toast.LENGTH_LONG,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white);

      //   Timer.periodic(Duration(seconds: 10), (timer) {
      //     timer.cancel();
      //     checkInternet();
      //   });
      // }
    }
    //checkBookedData();
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    appDocumentsPath = appDocumentsDirectory.path;
  }

  showCircular(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  ),
                  Text("one")
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressedTime == null ||
            now.difference(currentBackPressedTime!) > Duration(seconds: 2)) {
          currentBackPressedTime = now;
          Helper.centerToast("Press again to exit from the app");
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: DefaultTabController(
              length: 2,
              child: BlocConsumer<ProgramsBloc, ProgramsState>(
                buildWhen: (((previous, current) =>
                    current is HomePageDataAvailabale)),
                builder: (context, state) {
                  if (state is HomePageDataAvailabale) {
                    return Scaffold(
                      drawer: Drawer(
                        child: DrawerWidget(),
                      ),
                      appBar: new AppBar(
                        surfaceTintColor: Colors.green,
                        title: new Text('RECEPTION'),

                        //  leading: InkWell(onTap: () {}, child: Icon(Icons.menu)),
                        actions: <Widget>[
                          // isOffline == false
                          //     ? IconButton(
                          //         onPressed: () {
                          //           initState();
                          //         },
                          //         icon: Icon(Icons.cloud_done_outlined,
                          //             size: 18, color: HexColor("#68D389")))
                          //     : IconButton(
                          //         onPressed: () {
                          //           initState();
                          //         },
                          //         icon: Icon(
                          //           Icons.cloud_off,
                          //           size: 18,
                          //         ),
                          //       ),

                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => BusDetailed()),
                                ),
                              );
                            },
                            icon: Icon(CupertinoIcons.bus),
                          ),

                          IconButton(
                            onPressed: () async {
                              // uploadBusData();

                              synData(context, state);
                            },
                            icon: Icon(Icons.sync_outlined),
                          ),
                          InkWell(
                            onTap: () {
                              // state.isOffline ?
                              // addToOfflineList(context, state);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => UserProfile(),
                              //   ),
                              // );
                              showAlert(context);
                            },
                            child: Padding(
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
                          ),
                        ],
                        bottom: TabBarWrapper(
                          tabBar: TabBar(
                            indicatorColor: HexColor("#53A874"),
                            isScrollable: false,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Programms',
                                  // style: StyleElements.tabbarstyle,
                                  style: StyleElements.tabbarstyle,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Bookings',
                                  style: StyleElements.tabbarstyle,
                                ),
                              ),
                            ],
                          ),
                          child: _rightSideWidget(context, isOffline),
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          _homePageBody(context, state),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: _bookingView(context, state),
                          )
                        ],
                      ),
                    );
                  } else if (state is NotFound) {
                    return new Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        strokeWidth: 3,
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3,
                    ),
                  );
                },
                listener: (context, state) async {
                  if (state is HomePageDataAvailabale) {
                    if (state.isOffline == false) {
                      await addProgramsToList(context, state);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (alertContext) {
                            return WillPopScope(
                              onWillPop: () async {
                                return false;
                              },
                              child: AlertDialog(
                                title: Text("Download offline data"),
                                content: Text(
                                  "Download/Update data from server for offline booking. Press close button if recently downloaded ",
                                  style: TextStyle(
                                    height: 1.2,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.pop(alertContext);
                                      },
                                      child: Text("CLOSE")),
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.pop(alertContext);
                                        // showDialog(
                                        //     barrierDismissible: false,
                                        //     context: context,
                                        //     builder: (context) {
                                        //       return WillPopScope(
                                        //         onWillPop: () async {
                                        //           Helper.centerToast(
                                        //               'Please wait');
                                        //           return false;
                                        //         },
                                        //         child: AlertDialog(
                                        //           content: Row(
                                        //             crossAxisAlignment:
                                        //                 CrossAxisAlignment
                                        //                     .center,
                                        //             children: [
                                        //               SizedBox(
                                        //                 width: 20,
                                        //                 height: 20,
                                        //                 child:
                                        //                     CircularProgressIndicator(),
                                        //               ),
                                        //               SizedBox(
                                        //                 width: 10,
                                        //               ),
                                        //               Text(
                                        //                 "Please wait",
                                        //                 overflow: TextOverflow
                                        //                     .visible,
                                        //               )
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       );
                                        //     });

                                        await checkIfDataExists(
                                          state,
                                        );
                                      },
                                      child: Text("DOWNLOAD NOW"))
                                ],
                              ),
                            );
                          });
                      // previousBookings = await db!.getFinalBookingData();
                      // vehicleInfo = await db!.getVehicleInformation();
                      // try {
                      //   gridPrograms = await db!.queryAllRows();
                      // } catch (e) {
                      //   // await db!.checkAndDelete('allprogramms_seven');
                      //   // await db!
                      //   //     .checkAndCreateSlotTable('slotdetails_table_two');
                      //   // await db!.clearSlotTable('slotdetails_table_two');
                      //   // await db!.checkAndCreateRoomCountTable();
                      //   // await db!.checkAndCreateTermsAndCondions();
                      //   // // await db!.checkAndDeleteTermsAndCondions();
                      //   // await db!.createVehicleTable();
                      //   // await db!.checkAndCreateFinalBookingTable();
                      //   // await db!.checkAndDeleteFinalBookingTable();
                      //   // await db!.checAndCreateTicketTable();
                      //   // await db!.deleteTicketTable();
                      //   // await db!.createTablePreviousBookingsUpdate();
                      //   // await db!.deleteTablePreviousBookingsUpdate();
                      // }

                      // if (gridPrograms.isEmpty) {
                      //   showDialog(
                      //       context: context,
                      //       builder: (context) {
                      //         return AlertDialog(
                      //           title: Text("Download offline data"),
                      //           content: Text(
                      //               "To book when there is no internet, Please download offline data.",
                      //               style: TextStyle(height: 1.5)),
                      //           actions: [
                      //             TextButton(
                      //                 onPressed: () async {
                      //                   Navigator.pop(context);
                      //                   await checkIfDataExists(state);
                      //                 },
                      //                 child: Text("Download now"))
                      //           ],
                      //         );
                      //       });
                      // }
                      // await addToOfflineList(context, state);
                    }

                    // await addToOfflineList(context, state);
                  } else if (state is TokensCleared) {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  }
                  if (state is TicketNumberNotFound) {
                    print("no ticket found");
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text("Download offline data"),
                    //         actions: [
                    //           TextButton(
                    //             onPressed: () {
                    //               if (connectivityResult ==
                    //                   ConnectivityResult.none) {
                    //                 Helper.centerToast(
                    //                     "No internet, please connect to internet");
                    //               } else {
                    //                 Navigator.pop(context);
                    //               }
                    //             },
                    //             child: Text("Download"),
                    //           )
                    //         ],
                    //       );
                    //     });
                  }
                },
              )),
        ),
      ),
    );
  }

  _homePageBody(BuildContext context, HomePageDataAvailabale state) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        child: new Column(
          children: [
            new SizedBox(
              height: 25.0,
            ),
            // _searchBar(),
            // new SizedBox(
            //   height: 10.0,
            // ),
            // _entranceTicket(context, state),
            // new SizedBox(
            //   height: 10.0,
            // ),
            _programs(context, state),
            new SizedBox(
              height: 15.0,
            ),
            // isOffline == false ?
            // state.previoousBookingData!.upcoming!.length != 0
            //     ? _previousBooking(context, state)
            //     : SizedBox.shrink(): SizedBox.shrink(),
            // new SizedBox(
            //   height: 10.0,
            // ),
          ],
        ),
      ),
    );
  }

  // _searchBar() {
  //   return SizedBox(
  //     child: new TextField(
  //       controller: searchPController,
  //       // onChanged: (value) {
  //       //   List<GridPrograms> searchItems = [];
  //       //   if (gridPrograms.) {
  //       //     searchItems.add(GridPrograms(
  //       //       progName: value
  //       //     ));
  //       //   }
  //       // },
  //       style: new TextStyle(
  //         fontSize: 12.0,
  //         color: Colors.white,
  //         fontWeight: FontWeight.w200,
  //       ),
  //       onChanged: (value) {
  //         _searchThis(context, value);
  //       },
  //       decoration: new InputDecoration(
  //         hintText: "Search Programms",
  //         hintStyle: new TextStyle(
  //             fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.w200),
  //         border: new OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: HexColor("#2C2C2C"),
  //             ),
  //             borderRadius: BorderRadius.all(Radius.circular(7))),
  //         focusedBorder: new OutlineInputBorder(
  //             borderSide: BorderSide(color: Colors.white),
  //             borderRadius: BorderRadius.all(Radius.circular(7))),
  //       ),
  //       cursorColor: Colors.white,
  //     ),
  //   );
  // }

  // _entranceTicket(BuildContext context, HomePageDataAvailabale state) {
  //   return MaterialButton(
  //     height: 40,
  //     minWidth: double.infinity,
  //     color: AppColors.appColor,
  //     onPressed: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => EntranceTicketBooking(),
  //         ),
  //       );
  //     },
  //     child: Text('Start Booking'),
  //   );
  // }

  _programs(BuildContext context, HomePageDataAvailabale state) {
    return searchedList.length == 0
        ? BlocListener<DownloadBloc, DownloadState>(
            listenWhen: ((previous, current) => current is DownloadOfflineNow),
            listener: (context, state) {
              if (state is DownloadOfflineNow) {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => DownloadPage())));
              }
            },
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: gridPrograms.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    if (gridPrograms[index].started == true) {
                      bool result = await checkTicket();
                      if (result) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProgramDetails(
                              image: gridPrograms[index].coverImage,
                              programId: gridPrograms[index].id,
                              progName: gridPrograms[index].progName,
                              isCottage: gridPrograms[index].isCottage,
                              isOffline: true,
                              vehicleInfo: vehicleInfo,
                            ),
                          ),
                        ).then((value) => context
                            .read<ProgramsBloc>()
                            .add(GetBookingData(showToast: false)));
                      } else {
                        if (await Vibrate.canVibrate) {
                          Vibrate.feedback(FeedbackType.success);
                        }
                        _showToast(context, 'Please download offline data',
                            Toast.LENGTH_SHORT);
                      }
                    } else {
                      _showToast(context, 'Booking closed', Toast.LENGTH_SHORT);
                    }
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 185.0,
                            height: 200.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: gridPrograms[index].coverImage != null
                                  ? CachedNetworkImage(
                                      imageUrl: WebClient.imageIp +
                                          gridPrograms[index]
                                              .coverImage
                                              .toString(),
                                      placeholder: (context, url) => Center(
                                        child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 4,
                                            )),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Icon(Icons.error),
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : Center(
                                      child: Text("No Preview Available"),
                                    ),
                            ),
                          ),
                        ),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new Row(
                          children: [
                            Flexible(
                              child: new Text(
                                gridPrograms[index].progName.toString(),
                                style: StyleElements.gridSubHead,
                              ),
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 5.0,
                        ),
                        new Row(
                          children: [
                            gridPrograms[index].started == true
                                ? new Text('Booking Available',
                                    style: StyleElements.gridBAvailable)
                                : new Text('Booking Closed',
                                    style: StyleElements.gridBNotAvailable),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: searchedList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  // searchedList[index].status == true
                  //     ? Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => ProgramDetails(
                  //             programId: searchedList[index].id,
                  //             progName: searchedList[index].progName,
                  //             isCottage: searchedList[index].isCottage,
                  //           ),
                  //         ),
                  //       )
                  //     : _showToast(
                  //         context, 'Booking closed', Toast.LENGTH_SHORT);
                },
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 185.0,
                          height: 200.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: searchedList[index].coverImage != null
                                ? CachedNetworkImage(
                                    imageUrl: WebClient.imageIp +
                                        searchedList[index]
                                            .coverImage
                                            .toString(),
                                    placeholder: (context, url) => Center(
                                      child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 4,
                                          )),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Icon(Icons.error),
                                      ),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : Center(
                                    child: Text("No Preview Available"),
                                  ),
                          ),
                        ),
                      ),
                      new SizedBox(
                        height: 5.0,
                      ),
                      new Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: new Text(
                              searchedList[index].progName.toString(),
                              style: StyleElements.gridSubHead,
                            ),
                          ),
                        ],
                      ),
                      new SizedBox(
                        height: 5.0,
                      ),
                      new Row(
                        children: [
                          searchedList[index].started == true
                              ? new Text('Booking Available',
                                  style: StyleElements.gridBAvailable)
                              : new Text('Booking Closed',
                                  style: StyleElements.gridBNotAvailable),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }

  // _previousBooking(BuildContext context, HomePageDataAvailabale state) {
  //   return new Column(
  //     children: [
  //       new Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           new Text("Previous Booking"),
  //           InkWell(
  //               child: new Row(
  //                 children: [
  //                   new Text("View All"),
  //                   new Icon(Icons.arrow_right),
  //                 ],
  //               ),
  //               onTap: () {
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => PreviousBookingAll()));
  //               }),
  //         ],
  //       ),
  //       SizedBox(height: 5.0),
  //       new ListView.separated(
  //         // physics: NeverScrollableScrollPhysics(),
  //         scrollDirection: Axis.vertical,
  //         shrinkWrap: true,
  //         itemCount: state.previoousBookingData!.upcoming!.length > 5
  //             ? 5
  //             : state.previoousBookingData!.upcoming!.length,
  //         itemBuilder: (context, indexUpcoming) {
  //           return new ListView.builder(
  //             shrinkWrap: true,
  //             physics: NeverScrollableScrollPhysics(),
  //             itemCount: state.previoousBookingData!.upcoming![indexUpcoming]
  //                 .booking!.length,
  //             itemBuilder: (context, indexBooking) {
  //               return new Container(
  //                 height: 60.0,
  //                 width: MediaQuery.of(context).size.width,
  //                 child: new Row(
  //                   children: [
  //                     ClipRRect(
  //                       borderRadius: BorderRadius.circular(6.0),
  //                       child: CachedNetworkImage(
  //                         imageUrl: WebClient.imageIp +
  //                             state
  //                                 .previoousBookingData!
  //                                 .upcoming![indexUpcoming]
  //                                 .booking![indexBooking]
  //                                 .programme!
  //                                 .coverImage
  //                                 .toString(),
  //                         placeholder: (context, url) => Center(
  //                           child: SizedBox(
  //                               width: 20,
  //                               height: 20,
  //                               child: CircularProgressIndicator(
  //                                 color: Colors.white,
  //                                 strokeWidth: 3,
  //                               )),
  //                         ),
  //                         errorWidget: (context, url, error) => Center(
  //                           child: SizedBox(
  //                             width: 20,
  //                             height: 20,
  //                             child: Icon(Icons.error),
  //                           ),
  //                         ),
  //                         width: 60.0,
  //                         height: 60.0,
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                     new SizedBox(
  //                       width: 10.0,
  //                     ),
  //                     Expanded(
  //                         child: new Column(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         new Text(state
  //                             .previoousBookingData!
  //                             .upcoming![indexUpcoming]
  //                             .booking![indexBooking]
  //                             .programme!
  //                             .progName
  //                             .toString()),
  //                         Container(
  //                           child: new Row(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               state
  //                                           .previoousBookingData!
  //                                           .upcoming![indexUpcoming]
  //                                           .booking![indexBooking]
  //                                           .indian! >
  //                                       0
  //                                   ? new Text(
  //                                       "Indian Adult X " +
  //                                           state
  //                                               .previoousBookingData!
  //                                               .upcoming![indexUpcoming]
  //                                               .booking![indexBooking]
  //                                               .indian
  //                                               .toString(),
  //                                       style: StyleElements.listViewSubOne,
  //                                     )
  //                                   : SizedBox(),
  //                               SizedBox(width: 10.0),
  //                               state
  //                                           .previoousBookingData!
  //                                           .upcoming![indexUpcoming]
  //                                           .booking![indexBooking]
  //                                           .foreignStudent! >
  //                                       0
  //                                   ? new Text(
  //                                       "Foreign Student X " +
  //                                           state
  //                                               .previoousBookingData!
  //                                               .upcoming![indexUpcoming]
  //                                               .booking![indexBooking]
  //                                               .foreignStudent
  //                                               .toString(),
  //                                       style: StyleElements.listViewSubOne)
  //                                   : SizedBox(),
  //                             ],
  //                           ),
  //                         ),
  //                         Container(
  //                           child: new Wrap(
  //                             spacing: 5,
  //                             runSpacing: 5,
  //                             children: [
  //                               new Text(
  //                                 f.format(
  //                                   DateTime.parse(
  //                                     state
  //                                         .previoousBookingData!
  //                                         .upcoming![indexUpcoming]
  //                                         .booking![indexBooking]
  //                                         .bookingDate
  //                                         .toString(),
  //                                   ),
  //                                 ),
  //                                 style: StyleElements.previousBookingDndTime,
  //                               ),
  //                               SizedBox(width: 30.0),
  //                               new Text(
  //                                 state
  //                                         .previoousBookingData!
  //                                         .upcoming![indexUpcoming]
  //                                         .booking![indexBooking]
  //                                         .slotDetail!
  //                                         .startTime
  //                                         .toString() +
  //                                     " - " +
  //                                     state
  //                                         .previoousBookingData!
  //                                         .upcoming![indexUpcoming]
  //                                         .booking![indexBooking]
  //                                         .slotDetail!
  //                                         .endTime
  //                                         .toString(),
  //                                 style: StyleElements.previousBookingDndTime,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ))
  //                   ],
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //         separatorBuilder: (BuildContext context, int index) {
  //           return new SizedBox(
  //             height: 10.0,
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

  _bookingView(BuildContext context, HomePageDataAvailabale state) {
    context.read<ProgramsBloc>().add(GetBookingData(showToast: false));
    return BlocBuilder<ProgramsBloc, ProgramsState>(
        buildWhen: ((previous, current) => current is TheFinalBookingData),
        builder: ((context, state) {
          if (state is TheFinalBookingData) {
            return previousBookingView(state.list!);
          }
          return Center(
              child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black12)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Refresh",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.refresh, color: Colors.white),
              ],
            ),
            onPressed: () {
              context.read<ProgramsBloc>().add(GetBookingData(showToast: true));
            },
          ));
        }));
    // List list = await db!.getFinalBookingData();
    // return list.length != 0
    //     //  ? SizedBox.shrink()
    //     ? previousBookingView(list)
    //     : new Center(
    //         child: Text("No Bookings Yet!"),
    //       );
    //  BlocConsumer<ProgramsBloc, ProgramsState>(
    //   builder: (context, state) {
    //     if (state is HomePageDataAvailabale) {
    //       return state.isOffline == false
    //           ? state.previoousBookingData != null
    //               ? state.previoousBookingData!.upcoming!.length != 0
    //                   ? SafeArea(
    //                       child: Padding(
    //                           padding: EdgeInsets.all(12.0),
    //                           child: _bookings(context, state)),
    //                     )
    //                   : new Center(
    //                       child: Text("No Bookings Yet!"),
    //                     )
    //               : previousBookings.length != 0
    //                   //  ? SizedBox.shrink()
    //                   ? previousBookingView()
    //                   : new Center(
    //                       child: Text("No Bookings Yet!"),
    //                     )
    //           : new Center(
    //               child: Text("No Bookings Yet!"),
    //             );
    //     } else {
    //       return new Center(
    //         child: CircularProgressIndicator(
    //           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    //           strokeWidth: 3,
    //         ),
    //       );
    //     }
    //   },
    //   listener: (context, state) {},
    // );
  }

  // _bookings(context, state) {
  //   return BlocConsumer<ProgramsBloc, ProgramsState>(
  //       builder: (context, state) {
  //         if (state is HomePageDataAvailabale) {
  //           return new ListView.separated(
  //             // physics: NeverScrollableScrollPhysics(),
  //             scrollDirection: Axis.vertical,
  //             shrinkWrap: true,
  //             itemCount: state.previoousBookingData!.upcoming!.length,
  //             itemBuilder: (context, indexUpcoming) {
  //               return new ListView.builder(
  //                 shrinkWrap: true,
  //                 physics: NeverScrollableScrollPhysics(),
  //                 itemCount: state.previoousBookingData!
  //                     .upcoming![indexUpcoming].booking!.length,
  //                 itemBuilder: (context, indexBooking) {
  //                   return new Container(
  //                     height: 60.0,
  //                     width: MediaQuery.of(context).size.width,
  //                     child: new Row(
  //                       children: [
  //                         ClipRRect(
  //                           borderRadius: BorderRadius.circular(6.0),
  //                           child: CachedNetworkImage(
  //                             imageUrl: WebClient.imageIp +
  //                                 state
  //                                     .previoousBookingData!
  //                                     .upcoming![indexUpcoming]
  //                                     .booking![indexBooking]
  //                                     .programme!
  //                                     .coverImage
  //                                     .toString(),
  //                             placeholder: (context, url) => Center(
  //                               child: SizedBox(
  //                                   width: 20,
  //                                   height: 20,
  //                                   child: CircularProgressIndicator(
  //                                     color: Colors.white,
  //                                     strokeWidth: 3,
  //                                   )),
  //                             ),
  //                             errorWidget: (context, url, error) => Center(
  //                               child: SizedBox(
  //                                 width: 20,
  //                                 height: 20,
  //                                 child: Icon(Icons.error),
  //                               ),
  //                             ),
  //                             width: 60.0,
  //                             height: 60.0,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                         new SizedBox(
  //                           width: 10.0,
  //                         ),
  //                         Expanded(
  //                             child: new Column(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             new Text(state
  //                                 .previoousBookingData!
  //                                 .upcoming![indexUpcoming]
  //                                 .booking![indexBooking]
  //                                 .programme!
  //                                 .progName
  //                                 .toString()),
  //                             Container(
  //                               child: new Row(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   state
  //                                               .previoousBookingData!
  //                                               .upcoming![indexUpcoming]
  //                                               .booking![indexBooking]
  //                                               .indian! >
  //                                           0
  //                                       ? new Text(
  //                                           "Indian Adult X " +
  //                                               state
  //                                                   .previoousBookingData!
  //                                                   .upcoming![indexUpcoming]
  //                                                   .booking![indexBooking]
  //                                                   .indian
  //                                                   .toString(),
  //                                           style: StyleElements.listViewSubOne,
  //                                         )
  //                                       : SizedBox(),
  //                                   SizedBox(width: 10.0),
  //                                   state
  //                                               .previoousBookingData!
  //                                               .upcoming![indexUpcoming]
  //                                               .booking![indexBooking]
  //                                               .foreignStudent! >
  //                                           0
  //                                       ? new Text(
  //                                           "Foreign Student X " +
  //                                               state
  //                                                   .previoousBookingData!
  //                                                   .upcoming![indexUpcoming]
  //                                                   .booking![indexBooking]
  //                                                   .foreignStudent
  //                                                   .toString(),
  //                                           style: StyleElements.listViewSubOne)
  //                                       : SizedBox(),
  //                                 ],
  //                               ),
  //                             ),
  //                             Container(
  //                               child: new Wrap(
  //                                 spacing: 5,
  //                                 runSpacing: 5,
  //                                 children: [
  //                                   new Text(
  //                                     f.format(
  //                                       DateTime.parse(
  //                                         state
  //                                             .previoousBookingData!
  //                                             .upcoming![indexUpcoming]
  //                                             .booking![indexBooking]
  //                                             .bookingDate
  //                                             .toString(),
  //                                       ),
  //                                     ),
  //                                     style:
  //                                         StyleElements.previousBookingDndTime,
  //                                   ),
  //                                   SizedBox(width: 30.0),
  //                                   new Text(
  //                                     state
  //                                             .previoousBookingData!
  //                                             .upcoming![indexUpcoming]
  //                                             .booking![indexBooking]
  //                                             .slotDetail!
  //                                             .startTime
  //                                             .toString() +
  //                                         " - " +
  //                                         state
  //                                             .previoousBookingData!
  //                                             .upcoming![indexUpcoming]
  //                                             .booking![indexBooking]
  //                                             .slotDetail!
  //                                             .endTime
  //                                             .toString(),
  //                                     style:
  //                                         StyleElements.previousBookingDndTime,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ))
  //                       ],
  //                     ),
  //                   );
  //                 },
  //               );
  //             },
  //             separatorBuilder: (BuildContext context, int index) {
  //               return new SizedBox(
  //                 height: 10.0,
  //               );
  //             },
  //           );
  //         } else {
  //           return CircularProgressIndicator();
  //         }
  //       },
  //       listener: (context, state) {});
  // }

  addProgramsToList(BuildContext context, HomePageDataAvailabale state) async {
    for (int i = 0; i < state.programmz!.programData!.length; i++) {
      state.programmz!.programData![i].isCottage == true ||
              state.programmz!.programData![i].started == true
          ? gridPrograms.add(
              ProgrammData(
                isCottage: state.programmz!.programData![i].isCottage,
                progName: state.programmz!.programData![i].progName,
                started: state.programmz!.programData![i].started,
                coverImage: state.programmz!.programData![i].coverImage,
                id: state.programmz!.programData![i].id,
                status: state.programmz!.programData![i].status,
              ),
            )
          : SizedBox.shrink();
    }
    // checkConnecion(context, state);
  }

  void synData(BuildContext context, HomePageDataAvailabale state) {
    AlertDialog alertDialog = new AlertDialog(
      contentPadding: EdgeInsets.zero,
      actions: <Widget>[
        new Container(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(children: <Widget>[
                    new Icon(Icons.upload),
                    Expanded(
                      child: MaterialButton(
                        child: Text(
                          "Upload offline data",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadDataSync())).then(
                              (value) => context
                                  .read<ProgramsBloc>()
                                  .add(GetBookingData(showToast: false)));
                          // .then((value) => HomePage());
                        },
                      ),
                    ),
                  ]),
                  // isOffline == false
                  //     ? SizedBox(
                  //         height: 20,
                  //       )
                  //     : SizedBox.shrink(),
                  new Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.download),
                        // SizedBox(
                        //   width: 40,
                        // ),
                        Expanded(
                          child: MaterialButton(
                            child: Text(
                              "Download offline data",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => DownloadDataSync()));
                              Navigator.pop(context);
                              // showDialog(
                              //     barrierDismissible: false,
                              //     context: context,
                              //     builder: (context) {
                              //       return WillPopScope(
                              //         onWillPop: () async {
                              //           Helper.centerToast('Please wait');
                              //           return false;
                              //         },
                              //         child: AlertDialog(
                              //           content: Row(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //             children: [
                              //               SizedBox(
                              //                 width: 20,
                              //                 height: 20,
                              //                 child:
                              //                     CircularProgressIndicator(),
                              //               ),
                              //               SizedBox(
                              //                 width: 10,
                              //               ),
                              //               Text(
                              //                 "Please wait",
                              //                 overflow:
                              //                     TextOverflow.visible,
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       );
                              //     });

                              await checkIfDataExists(state);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             DownloadOfflineData(state: state,)));
                            },
                          ),
                        )
                      ]),
                ]),
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

  void showAlert(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Logout"),
      content: Text("Would you like to logout from the app ?"),
      actions: [
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green[400])),
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            Navigator.pop(context);
            //  clearAll(context);
            //  await db!.deleteTicketTable();
          },
        ),
        TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green[400])),
            child: Text(
              "LOGOUT",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              BlocProvider.of<ProgramsBloc>(context).add(
                DoLogout(context: context),
              );
            }),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void _showToast(BuildContext context, String s, Toast length) {
    Fluttertoast.showToast(
      toastLength: length,
      msg: s,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }

  // void _searchThis(BuildContext context, String value) {
  //   // searchedList.clear();
  //   if (value.isNotEmpty) {
  //     gridPrograms.forEach((element) {
  //       if (element.progName!.contains(value)) {
  //         searchedList.add(
  //           GridPrograms(
  //             progName: element.progName,
  //             isCottage: element.isCottage,
  //             id: element.id,
  //             status: element.status,
  //           ),
  //         );
  //       }
  //     });
  //     setState(() {});
  //   } else {
  //     searchedList.clear();
  //     setState(() {});
  //     return;
  //   }
  // }

  addProgramDetail(int i) async {
    PackageRate packageRate;
    var url = '/programme/get?id=' + gridProgramsLocal[i].id.toString();
    packageRate = await AuthRepository().getProgramIndividualDetails(url: url);
    if (packageRate.status == true) {
      if (packageRate.package!.length != 0) {
        await db!.insertToPackageTable(packageRate, "package_tbl_one");
      }
    }
  }

  // addBookingSummaryOne(int i) async {
  BookingSummary? bookingSummary;
  // ----->>> this method will download image to a spec dir and add its pth to db
  // getImagePath() async {
  //   return imagePath;
  // }

  Future<void> saveImage(
      ProgrammData programmData, Directory imageDirectory) async {
    try {
      var url = WebClient.imageIp + programmData.coverImage.toString();
      var response = await http.get(Uri.parse(url));
      final imagePath =
          imageDirectory.path + '/images/' + programmData.coverImage.toString();
      // var theImage = path + programmData.coverImage.toString();
      final file = await new File(imagePath).create();
      file.writeAsBytes(response.bodyBytes);
    } catch (e) {
      print(e);
    }
  }

  void syncData() {
    showAlert(context);
  }

  void checkConnecion(
      BuildContext context, HomePageDataAvailabale state) async {
    // Navigator.pop(context);
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showConnectionRequired(context);
    } else {
      await downloadData(context, state);
    }
  }

  void showConnectionRequired(BuildContext context) {
    AlertDialog alertDialog = new AlertDialog(
      title: Text("Not connected"),
      content: Text("Please connect to the internet"),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("ok"))
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  //downloadall
  downloadData(BuildContext context, HomePageDataAvailabale state) async {
    bool storage = await checkStorage();
    if (storage == true) {
      // progressDialog!.show(max: maximum!, msg: 'Offline data downloading...');
      // showDownloadProgress(context, state);
      //    showCircular(context);
      await createFolder(context);
      _startDownloading(context, state);
    } else {
      _showAlert(context, "Not enough space",
          "Minimum 500MB needed. Please free up phone storage", false);
    }
  }

  // checkConnection(BuildContext context) async {
  //   bool status = false;
  //   try {
  //     http.Response response = await http
  //         .get(Uri.parse('https://www.google.com/'))
  //         .timeout(Duration(seconds: 30));
  //     if (response.statusCode == 200) {
  //       status = true;
  //     } else {
  //       status = false;
  //     }
  //   } catch (e) {
  //     status = false;
  //   }
  //   return status;
  // }

  // Future<void> clearAll(BuildContext context) async {
  //   // await db!.checkAndDelete('allprogramms_seven');
  //   // await db!.clearSlotTable('slotdetails_table_two');
  //   // await db!.deleteTicketTable();
  // }

  void showAlertTwo(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Empty Offline"),
      content: Text(
          "Offline date not found at this time, please go online and download data from server !",
          style: TextStyle(height: 1.5)),
      actions: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Icon(Icons.refresh, color: Colors.white, size: 24),
            onPressed: () async {
              await checkInternet();
              isOffline == true
                  ? _showToast(context, "No internet", Toast.LENGTH_SHORT)
                  : Navigator.pop(context);
            },
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

  checkStorage() async {
    var space = await DiskSpace.getFreeDiskSpace;
    print(space);
    if (space! < 100) {
      print("less");
      return false;
    } else {
      print("higher");
      return true;
    }
  }

  _showAlert(BuildContext context, String title, String content, bool goBack) {
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
                    TextButton(
                        child: Text("Ok", textAlign: TextAlign.center),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
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

  //startdownload
  void _startDownloading(
      BuildContext context, HomePageDataAvailabale state) async {
    _showToast(context, "Downloading offline data...", Toast.LENGTH_SHORT);
    context.read<DownloadBloc>().add(DownloadOfflineData());
    context.read<DownloadBloc>().add(CreateLocalDB());
    var num;
    // final imageDirectory = await getTemporaryDirectory();
    // ----->>> clear all records in the program table(first table)
    await db!.deleteTables();
    await db!.createTables();
    // await db!.checkAndCreateSlotTable('slotdetails_table_two');
    // await db!.clearSlotTable('slotdetails_table_two');
    // await db!.checkAndCreateRoomCountTable();
    // await db!.checkAndCreateTermsAndCondions();
    // await db!.createVehicleTable();
    // await db!.checkAndCreateFinalBookingTable();
    // await db!.checAndCreateTicketTable();
    // await db!.createTablePreviousBookingsUpdate();
    //=================================================================

    for (int i = 0; i < state.programmz!.programData!.length; i++) {
      for (int j = 0; j < state.programmz!.packageData!.length; j++) {
        if (state.programmz!.programData![i].id ==
            state.programmz!.packageData![j].programme) {
          num = await db!.insert(state.programmz!.programData![i], true,
              state.programmz, state.programmz!.packageData![j]);

          break;
        }
      }
    }

    // ----->>> read all records from the first table
    gridProgramsLocal = await db!.queryAllRows();
    context.read<DownloadBloc>().add(ProgramDataAdded());
    // ----->>> create new slot table if such not exists
    // ----->>> delete all records in the slot table if it has records
    // ----->>> adding slottdetails in the slot table (second table)
    for (int i = 0; i < gridProgramsLocal.length; i++) {
      BookingSummary? bookingSummary;
      var url = '/booking/getagentslots?programme=' +
          gridProgramsLocal[i].id.toString() +
          '&date=' +
          DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      // DateFormat('yyyy-MM-dd').format(DateTime(2021, 10, 28)).toString();
      bookingSummary = await AuthRepository().getBookingSummary(url: url);
      if (bookingSummary.status == true) {
        // print("slot count ${bookingSummary.data!.length}");
        for (int i = 0; i < bookingSummary.data!.length; i++) {
          num = await db!.addSlotDeatails(
              bookingSummary.data![i], 'slotdetails_table_two');
        }
      }
    }
    context.read<DownloadBloc>().add(SlotDataAdded());
    context.read<DownloadBloc>().busModel =
        await AuthRepository().getBusData(url: '/vehicle/get/list/app');
    if (context.read<DownloadBloc>().busModel.status!) {
      context.read<DownloadBloc>().add(BusDataDownloaded());
      for (int i = 0;
          i < context.read<DownloadBloc>().busModel.data!.length;
          i++) {
        var tripId = new ObjectId();
        await db!.addToBusTable(
            context.read<DownloadBloc>().busModel.data![i], tripId);
      }
      await db!.getBusDataInitial();
    } else {
      context.read<DownloadBloc>().add(BusDataNotDownloaded());
    }

    VehicleModel vehicleModel;
    vehicleModel = await AuthRepository()
        .getVehicleInformations(url: '/static/settings/get');
    if (vehicleModel.status == true) {
      //  print(await db!.addToVehicleTable(vehicleModel));
    }

    OfflineLineTicket offlineLineTicket;
    // ${DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()}
    // var now = DateTime.now();
    var url =
        '/booking/admingetlist/app?count=10000&page=1&fromDate=${DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()}&toDate=${DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2)).toString()}&type=offline';

    // '/booking/admingetlist?count=10000&page=1&fromDate=2021-11-10&toDate=2021-11-15&type=offline';
    offlineLineTicket = await AuthRepository().getAllTickets(url: url);

    var theResult;
    List ticketDetails = [];
    List programme = [], vehicles = [], entranceTickets = [];
    List details = [];
    List mainProgramme = [];
    if (offlineLineTicket.status == true) {
      _showToast(context, "Downloading tickets...", Toast.LENGTH_SHORT);

      // if (offlineLineTicket.count! > 0) {
      //   await getLastTicketNumber(offlineLineTicket);
      // }

      for (int i = 0; i < offlineLineTicket.ticketData!.length; i++) {
        var idproof, theTicket;
        theTicket = await dowloadPdf(
          context,
          offlineLineTicket.ticketData![i].payment!.ticket,
        );
        ticketDetails.add({
          'localTicket':
              offlineLineTicket.ticketData![i].ticketDetail!.ticketId,
          "ticketNo": offlineLineTicket.ticketData![i].ticketNo,
          "id": offlineLineTicket.ticketData![i].payment!.id,
          "total": offlineLineTicket.ticketData![i].payment!.total,
          "paymentStatus":
              offlineLineTicket.ticketData![i].payment!.paymentStatus,
          "type": offlineLineTicket.ticketData![i].payment!.type,
          "ticket": offlineLineTicket.ticketData![i].payment!.ticket,
          "name": offlineLineTicket.ticketData![i].payment!.name,
          "ticketPdf": theTicket,
        });

        if (offlineLineTicket.ticketData![i].vehicles != null) {
          for (int k = 0;
              k < offlineLineTicket.ticketData![i].vehicles!.length;
              k++) {
            vehicles.add({
              "vehicle": offlineLineTicket.ticketData![i].vehicles![k].vehicle,
              "type": offlineLineTicket.ticketData![i].vehicles![k].type,
              "ticket": offlineLineTicket.ticketData![i].vehicles![k].ticket,
              "status": offlineLineTicket.ticketData![i].vehicles![k].status,
              "id": offlineLineTicket.ticketData![i].vehicles![k].id,
              "charge": offlineLineTicket.ticketData![i].vehicles![k].charge,
              "bookingDate":
                  offlineLineTicket.ticketData![i].vehicles![k].bookingDate,
            });
          }
        }

        if (offlineLineTicket.ticketData![i].entranceTickets != null) {
          for (int k = 0;
              k < offlineLineTicket.ticketData![i].entranceTickets!.length;
              k++) {
            entranceTickets.add({
              "guest": offlineLineTicket
                  .ticketData![i].entranceTickets![k].entranceGuest!.name,
              "type": offlineLineTicket.ticketData![i].entranceTickets![k].type,
              "ticket":
                  offlineLineTicket.ticketData![i].entranceTickets![k].ticket,
              "status":
                  offlineLineTicket.ticketData![i].entranceTickets![k].status,
              "id": offlineLineTicket.ticketData![i].entranceTickets![k].id,
              "charge":
                  offlineLineTicket.ticketData![i].entranceTickets![k].charge,
              "bookingDate": offlineLineTicket
                  .ticketData![i].entranceTickets![k].bookingDate,
            });
          }
        } else {}

        for (int j = 0;
            j < offlineLineTicket.ticketData![i].booking!.length;
            j++) {
          programme.clear();
          details.clear();

          programme.clear();
          programme.add({
            "sId": offlineLineTicket.ticketData![i].booking![j].programme!.sId,
            "started":
                offlineLineTicket.ticketData![i].booking![j].programme!.started,
            "isCottage": offlineLineTicket
                .ticketData![i].booking![j].programme!.isCottage,
            "status":
                offlineLineTicket.ticketData![i].booking![j].programme!.status,
            "progName": offlineLineTicket
                .ticketData![i].booking![j].programme!.progName,
          });

          //downloading images

          for (int k = 0;
              k < offlineLineTicket.ticketData![i].booking![j].details!.length;
              k++) {
            if (offlineLineTicket
                    .ticketData![i].booking![j].details![k].guest!.idproofs !=
                null) {
              if (offlineLineTicket.ticketData![i].booking![j].details![k]
                      .guest!.idproofs!.image !=
                  null) {
                if (offlineLineTicket.ticketData![i].booking![j].details![k]
                        .guest!.idproofs!.image !=
                    null) {
                  if (offlineLineTicket.ticketData![i].booking![j].details![k]
                      .guest!.idproofs!.image!.isNotEmpty) {
                    idproof = offlineLineTicket.ticketData![i].booking![j]
                        .details![k].guest!.idproofs!.image![0];
                    if (idproof != null || idproof != "") {
                      idproof = await downloadImage(context, idproof);
                    }
                  }
                }
              }
            } else {
              idproof = null;
            }
            details.add({
              "sId": offlineLineTicket
                  .ticketData![i].booking![j].details![k].slotDetail!.sId,
              "status": offlineLineTicket
                  .ticketData![i].booking![j].details![k].slotDetail!.status,
              "slot": offlineLineTicket
                  .ticketData![i].booking![j].details![k].slotDetail!.slot,
              "startTime": offlineLineTicket
                  .ticketData![i].booking![j].details![k].slotDetail!.startTime,
              "endTime": offlineLineTicket
                  .ticketData![i].booking![j].details![k].slotDetail!.endTime,
              "availableNo": offlineLineTicket.ticketData![i].booking![j]
                  .details![k].slotDetail!.availableNo,
              "bookingDate": offlineLineTicket
                  .ticketData![i].booking![j].details![k].bookingDate,
              "bookType": offlineLineTicket
                  .ticketData![i].booking![j].details![k].bookType,
              "guestId": offlineLineTicket
                  .ticketData![i].booking![j].details![k].guest!.sId,
              "guestStatus": offlineLineTicket
                  .ticketData![i].booking![j].details![k].guest!.status,
              "name": offlineLineTicket
                  .ticketData![i].booking![j].details![k].guest!.name,
              "guestType": offlineLineTicket
                  .ticketData![i].booking![j].details![k].guest!.guestType,
              "dob": offlineLineTicket
                  .ticketData![i].booking![j].details![k].guest!.dob,
              "phoneno": offlineLineTicket
                  .ticketData![i].booking![j].details![k].guest!.phoneno,
              "age": offlineLineTicket
                  .ticketData![i].booking![j].details![k].guest!.age,
              "idProof": idproof,
            });
          }
          mainProgramme.add({
            "programme": jsonEncode(programme),
            "details": jsonEncode(details),
          });
        }

        String ticketDetailsString = jsonEncode(ticketDetails);
        String vehicleString = jsonEncode(vehicles);
        String entranceTicketString = jsonEncode(entranceTickets);
        String mainProgrammeString = jsonEncode(mainProgramme);

        mainProgramme.clear();

        vehicles.clear();
        entranceTickets.clear();
        ticketDetails.clear();

        theResult = await db!.insertToTicketTable(
          context,
          ticketDetailsString,
          mainProgrammeString,
          offlineLineTicket.ticketData![i].ticketNo.toString(),
          offlineLineTicket.ticketData![i].payment!.ticket.toString(),
          offlineLineTicket.ticketData![i].ticketDetail!.ticketId.toString(),
          vehicleString,
          entranceTicketString,
        );
      }

      List theDate = await db!.getAllTickets();
      for (int i = 0; i < theDate.length; i++) {}
    } else {}

    // ImageDownloader
    // print(allIdProofs);
    // if (allIdProofs.length > 0) {
    //   _showToast(context, "Downloading id proofs", Toast.LENGTH_SHORT);
    //   // for (int img = 0; img < allIdProofs.length; img++) {
    //   // var url = WebClient.imageIp;
    //   try {
    //     var imageId = await ImageDownloader.downloadImage(
    //         "http://13.126.157.44/u/1634712411075.jpg");
    //     if (imageId == null) {
    //       print("null");
    //       return;
    //     }
    //     var path = await ImageDownloader.findPath(imageId);
    //     print(path);
    //     _showToast(context, "Opening File", Toast.LENGTH_SHORT);
    //     await OpenFile.open(path);
    //   } on PlatformException catch (error) {
    //     print("platform exception $error");
    //   } catch (e) {
    //     print("Downloading id proofs exception $e");
    //   }
    //   // }
    // }

    // allIdProofs.clear();
    context.read<DownloadBloc>().add(TicketsAdded());

    // List list = await db!.getTermsAndConditionsOffline();
    // if (list.length == 0) {
    //   await db!.addIntialTerms("N/A", "N/A");
    // }

    TermsAndPolicy? termsAndPolicy;
    termsAndPolicy =
        await AuthRepository().getTermsAndConditions(url: '/static/getpolicy');
    dynamic response = await ServerHelper.get('/ticket/get/numbers');
    if (termsAndPolicy.status == true &&
        response['status'] &&
        response['data'] != null) {
      var cancel = termsAndPolicy.data!.cancel;
      var terms = termsAndPolicy.data!.terms;
      await db!.addIntialTerms(
          cancel, terms, int.parse(response['data'][0]['ticketNo'].toString()));
    } else {}

    // dynamic response = await ServerHelper.get('/ticket/get/numbers');
    // //get last ticket
    // if (response['status'] && response['data'] != null) {
    //   var responseUpdate = await db!
    //       .updateTicket(int.parse(response['data'][0]['ticketNo'].toString()));
    //   print(responseUpdate);
    //   print(await db!.getTermsAndConditionsOffline());
    // }
    context.read<DownloadBloc>().add(TermsAndConditionsAdded());
    _showToast(context, "Offline data downloaded", Toast.LENGTH_SHORT);
    if (await Vibrate.canVibrate) {
      Vibrate.feedback(FeedbackType.success);
    }
    // Navigator.pop(context);
    // list = await db!.getTermsAndConditionsOffline();
    // print(list);
    context.read<DownloadBloc>().add(OfflineDataDownloaded());
    //  Navigator.pop(context);
  }

  downloadImage(BuildContext? context, String? idproofs) async {
    var thePath;
    try {
      var url = WebClient.imageIp + idproofs!;
      http.Response response = await http.get(Uri.parse(url));

      var filePathAndName = '${path!.path}$idproofs';

      if (response.statusCode == 200) {
        File imageFile = File(filePathAndName);
        imageFile.writeAsBytesSync(response.bodyBytes);
        thePath = imageFile.path;
      } else {
        thePath = null;
      }
    } catch (e) {
      print("Image download exception $e");
      thePath = null;
    }
    return thePath;
  }

  createFolder(BuildContext context) async {
    var status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
      await Permission.storage.request();
      status = await Permission.storage.status;
    }
    if (status == PermissionStatus.granted) {
      Directory directory = await getApplicationDocumentsDirectory();
      path = Directory(directory.path.toString() + "/parambikulam/reception/");
      bool isExists = await path!.exists();
      if (isExists) {
        path!.deleteSync(recursive: true);
        await path!.create(recursive: true);
      } else {
        await path!.create(recursive: true);
      }
      // path = Directory("storage/emulated/0/$folderName/");
      // if (path.exists() == true) {
      //   path.deleteSync(recursive: true);
      //   path.create();
      // } else {
      //   path.create();
      //   print(path);
      // }
    }
  }

  dowloadPdf(BuildContext context, String? ticket) async {
    var theTicketOne;
    try {
      var url = WebClient.ip + "/booking/ticketbyticketpdf?id=" + ticket!;
      http.Response response = await http.get(Uri.parse(url));
      var filePathAndName = '${path!.path}$ticket.pdf';
      if (response.statusCode == 200) {
        File imageFile = File(filePathAndName);
        imageFile.writeAsBytesSync(response.bodyBytes);
        theTicketOne = imageFile.path;
      } else {
        theTicketOne = null;
      }
    } catch (e) {
      theTicketOne = null;
    }
    return theTicketOne;
  }

  Widget previousBookingView(List list) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return new Container(
          height: 60.0,
          width: MediaQuery.of(context).size.width,
          child: new Row(
            children: [
              // Icon(Icons.date)
              SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Image.asset(
                      "assets/bgptrr.png",
                      fit: BoxFit.cover,
                    )),
              ),
              new SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text(list[index]['title'].toString()),
                  Container(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        list[index]['indianCount'] > 0
                            ? new Text(
                                "Indian Adult X " +
                                    list[index]['indianCount'].toString(),
                                style: StyleElements.listViewSubOne,
                              )
                            : SizedBox(),
                        SizedBox(width: 10.0),
                        list[index]['foreignerCount'] > 0
                            ? new Text(
                                "Foreigner X " +
                                    list[index]['foreignerCount'].toString(),
                                style: StyleElements.listViewSubOne)
                            : SizedBox(),
                      ],
                    ),
                  ),
                  Container(
                    child: new Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        new Text(
                          f.format(
                            DateTime.parse(
                              list[index]['bookingDate'].toString(),
                            ),
                          ),
                          style: StyleElements.previousBookingDndTime,
                        ),
                        SizedBox(width: 30.0),
                        new Text(
                          list[index]['startTime'].toString() +
                              " - " +
                              list[index]['endTime'].toString(),
                          style: StyleElements.previousBookingDndTime,
                        ),
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return new SizedBox(
          height: 10.0,
        );
      },
    );
  }

  // getLastTicketNumber(response) {
  //   var lastTicketNumber = 0;
  //   // for (int i = 0; i < offlineLineTicket.ticketData!.length; i++) {
  //   //   if (lastTicketNumber < offlineLineTicket.ticketData![i].ticketNo!) {
  //   //     lastTicketNumber = offlineLineTicket.ticketData![i].ticketNo!;
  //   //     print("Last ticket number is $lastTicketNumber");
  //   //   }
  //   // }
  // }

  checkIfDataExists(HomePageDataAvailabale state) async {
    List<Map> uploadDataList = [];
    List failedData = [];
    try {
      uploadDataList = await db!.getFinalBookingData();
      failedData = await db!.getFinalFailedBookingData();
    } catch (e) {}

    if (uploadDataList.isNotEmpty || uploadDataList.length != 0) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Sync data"),
              content:
                  Text("Upload pending, please upload previous booking data"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadDataSync(),
                      ),
                    );
                  },
                  child: Text("Upload Now"),
                ),
              ],
            );
          });
    } else if (failedData.isNotEmpty || failedData.length != 0) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Require action"),
              content: Text("Some bookings failed to upload, please check"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadDataSync(),
                      ),
                    );
                  },
                  child: Text("Upload Now"),
                ),
              ],
            );
          });
    } else {
      checkConnecion(context, state);
    }
  }

  checkTicket() async {
    try {
      List ticketList = await db!.getTermsAndConditionsOffline();
      if (ticketList.isNotEmpty && ticketList[0]['ticketNumber'] != null) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  // uploadBusData() async {
  //   List busUpload = await db!.getBusFinalData();
  //   if (busUpload.isNotEmpty) {
  //     for (int index = 0; index < busUpload.length; index++) {
  //       CommonModel commonModel = CommonModel();
  //       try {
  //         Map busUploadData = {
  //           'tripId': busUpload[index]['tripId'],
  //           'tripCount': busUpload[index]['tripCount'],
  //           'busId': busUpload[index]['busId'],
  //           'isActive': busUpload[index]['isActive'],
  //           'noOfPassengers': busUpload[index]['noOfPassengers'],
  //           'tickets': busUpload[index]['tickets'],
  //         };
  //         print(busUploadData);
  //         commonModel = await AuthRepository().sendBookedData(
  //             url: '/vehicle/assign/ticket', data: busUploadData);
  //         if (commonModel.status == true) {
  //           print("*********************************");
  //           print("success");
  //           print("*********************************");
  //         } else {
  //           print("*********************************");
  //           print("failed -- ${commonModel.msg}");
  //           print("*********************************");
  //         }
  //       } catch (e) {
  //         print("Bus Data Upload Exception -- $e");
  //       }
  //     }
  //   } else {
  //     print("No data found");
  //   }
  // }

  // updateTicket() async {
  //   try {
  //     dynamic response = await ServerHelper.get('/ticket/get/numbers');
  //     //get last ticket
  //     if (response['status'] && response['data'] != null) {
  //       await db!.updateTicket(
  //           int.parse(response['data'][0]['ticketNo'].toString()));
  //       _showToast(context, "Last ticket ${response['data'][0]['ticketNo']}",
  //           Toast.LENGTH_SHORT);
  //       print(response['data'][0]['ticketNo']);
  //     }
  //   } catch (_) {}
  // }
}

// void updatePercent() {
//   Timer.periodic(new Duration(seconds: 1), (timer) {
//     print("count");
//     setState(() {
//       currentPercent = currentPercent! + 0.1;
//     });
//   });
// }
//   var url = '/booking/getagentslots?programme=' +
//       gridProgramsLocal[i].id.toString() +
//       '&date=' +
//       DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
//   bookingSummary = await AuthRepository().getBookingSummary(url: url);
//   if (bookingSummary.status == true) {
//     // print("true $i and the freecount is ${bookingSummary.data![0].freeCount}");
//     await db!.insertToSummaryTable(bookingSummary, 'booking_summary');
//   }
// }

_rightSideWidget(context, bool? isOffline) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QrScanner(
            isOffline: isOffline,
          ),
        ),
      );
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.qr_code, color: Colors.white, size: 20),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 16),
          child: Text(
            ('Scan Online Booking'),
            style: StyleElements.tabbarstyle,
          ),
        ),
      ],
    ),
  );
}

class GridPrograms {
  String? progName, id, coverImage, status;
  bool? isCottage, started;
  GridPrograms(
      {this.progName,
      this.isCottage,
      this.id,
      this.started,
      this.status,
      this.coverImage});
  Map<String, dynamic> toMap() {
    return {
      'started': started,
      'progname': progName,
      'coverimage': coverImage,
      'status': status,
      'iscottage': isCottage,
      'idstring': id,
      // 'id': id,
    };
  }
}

class TabBarWrapper extends StatelessWidget implements PreferredSize {
  final PreferredSizeWidget tabBar;
  final Widget child;
  const TabBarWrapper({required this.tabBar, required this.child, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IntrinsicWidth(child: tabBar),
        Expanded(child: child),
      ],
    );
  }

  @override
  Size get preferredSize => tabBar.preferredSize;
}
