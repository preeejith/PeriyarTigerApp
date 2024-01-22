import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:disk_space/disk_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/download/downloadbloc.dart';
import 'package:parambikulam/bloc/entrypoint/entranceuploaddatabloc/entranceuploaddatabloc.dart';
import 'package:parambikulam/bloc/entrypoint/entranceuploaddatabloc/entranceuploaddataevent.dart';
import 'package:parambikulam/bloc/entrypoint/entranceuploaddatabloc/entranceuploaddatastate.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/bloc/programs/programsevent.dart';
import 'package:parambikulam/bloc/programs/programsstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/data/models/bookingsummary.dart';
import 'package:parambikulam/data/models/entrymodel/entrybookingmodel.dart';
import 'package:parambikulam/data/models/offlineticket.dart';
import 'package:parambikulam/data/models/packagerate.dart';
import 'package:parambikulam/data/models/programmz.dart';
import 'package:parambikulam/data/models/test.dart';
import 'package:parambikulam/data/models/vehiclemodel.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

import 'package:parambikulam/ui/app/entrypoint/entranceticketbooking.dart';
import 'package:parambikulam/ui/app/entrypoint/entrypointdownloadpage.dart';
import 'package:parambikulam/ui/app/reception_aju/programdetails.dart';
import 'package:parambikulam/ui/app/scanner%20&%20ticket/qrscanner.dart';
import 'package:http/http.dart' as http;
import 'package:parambikulam/utils/serverhelper.dart';
import 'package:parambikulam/utils/serverhelperlive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class EntryHomePage extends StatefulWidget {
  _EntryHomePage createState() => _EntryHomePage();
}

class _EntryHomePage extends State<EntryHomePage> {
  final f = new DateFormat('MMMM dd, yyyy');
  final timeF = new DateFormat('hh:mm, a');
  List<ProgrammData> gridPrograms = [];
  List previousBookings = [];
  List<ProgrammData> gridProgramsLocal = [];
  List<GridPrograms> searchedList = [];
  List<GridPrograms> offlineList = [];
  List<Map> vehicleInfo = [];
  List<Map> entryBookingDetails = [];
  List allIdProofs = [];
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
  List<EntryBookingModel> entryBookingModel = [];
  List? idProofBooking = [];
  var path;

  @override
  void initState() {
    super.initState();
    progressDialog = ProgressDialog(context: context);
    SchedulerBinding.instance.addPostFrameCallback((_) => checkInternet());
  }

  @override
  void dispose() {
    super.dispose();
  }

  checkInternet() async {
    setState(() {});

    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isOffline = true;
      Fluttertoast.showToast(
        msg: "Showing offline data",
      );

      try {
        previousBookings = await db!.getFinalBookingData();
        vehicleInfo = await db!.getVehicleInformation();
        gridPrograms = await db!.queryAllRows();
      } catch (e) {
        // _showToast(
        //     context,
        //     "Database exception, go online and please download data",
        //     Toast.LENGTH_LONG);
      }

      BlocProvider.of<ProgramsBloc>(context).add(GetPrograms(isOffline: true));
    } else {
      bool result = await checkConnection(context);
      if (result == true) {
        isOffline = false;

        BlocProvider.of<ProgramsBloc>(context).add(GetPrograms(
            isOffline: false,
            date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()));
      } else {
        Fluttertoast.showToast(
            msg:
                "This connection has no internet, please check the connection.",
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white);

        Timer.periodic(Duration(seconds: 10), (timer) {
          timer.cancel();
          checkInternet();
        });
      }
    }

    List<Map<String, dynamic>> entryBookingDetails =
        await db!.getEntryBookingData();

    idProofBooking = await db!.getAllPreviousBookingsUpdate();

    entryBookingModel = entryBookingDetails
        .map((data) => new EntryBookingModel.fromJson(data))
        .toList();

    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    appDocumentsPath = appDocumentsDirectory.path;
  }

  _pendingbookings(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: entryBookingModel.length == 0
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.question_mark_rounded,
                          size: 46,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("No bookings found"),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    strokeWidth: 4.0,
                    onRefresh: () async {},
                    // Pull from top to show refresh indicator.
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: entryBookingModel.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          trailing: BlocListener<UploadEntryBookingBloc,
                                  UploadEntryBookingState>(
                              listener: (context, state) async {
                                List<Map<String, dynamic>> entryBookingDetails =
                                    await db!.getEntryBookingData();

                                entryBookingModel = entryBookingDetails
                                    .map((data) =>
                                        new EntryBookingModel.fromJson(data))
                                    .toList();
                                setState(() {});
                              },
                              child: IconButton(
                                icon: Icon(Icons.cloud_upload_outlined),
                                onPressed: () {
                                  BlocProvider.of<UploadEntryBookingBloc>(
                                          context)
                                      .add(UploadEntryBooking(
                                          entryBookingData:
                                              entryBookingModel[index]));
                                },
                              )),
                          title: Text(
                              "Ticket Id : ${entryBookingModel[index].ticketId!}",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          subtitle: Text(
                            "Total Amount : Rs ${jsonDecode(entryBookingModel[index].bookingData!)['totalAmount']}  Number of tickets : ${jsonDecode(entryBookingModel[index].bookingData!)['customers'].length} ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  )

            //  ListView.builder(
            //   padding: EdgeInsets.all(14.0),
            //   itemCount: 6,
            //   itemBuilder: ((context, index) {
            //     return Text("index $index");
            //   }),
            // ),
            ),
        Expanded(
            child: idProofBooking!.length == 0
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.question_mark_rounded,
                          size: 46,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("No ID Proof updations found"),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    strokeWidth: 4.0,
                    onRefresh: () async {},
                    // Pull from top to show refresh indicator.
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: idProofBooking!.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          trailing: BlocListener<UploadEntryBookingBloc,
                                  UploadEntryBookingState>(
                              listener: (context, state) async {
                                if (state is ImageUploaded) {
                                  idProofBooking =
                                      await db!.getAllPreviousBookingsUpdate();
                                  setState(() {});
                                }
                              },
                              child: IconButton(
                                icon: Icon(Icons.cloud_upload_outlined),
                                onPressed: () {
                                  context.read<UploadEntryBookingBloc>().add(
                                        UpdateIdProofs(
                                          index: idProofBooking![index]['id'],
                                          id: idProofBooking![index]
                                              ['personId'],
                                          imagePath: idProofBooking![index]
                                              ['imageFile'],
                                        ),
                                      );
                                  // BlocProvider.of<UploadEntryBookingBloc>(
                                  //         context)
                                  //     .add(
                                  //   UploadEntryBooking(
                                  //     entryBookingData:
                                  //         entryBookingModel[index],
                                  //   ),
                                  // );
                                },
                              )),
                          title: Text(
                              "Person Id : ${idProofBooking![index]['personId']}",
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          // subtitle: Text(
                          //   "Total Amount : Rs ${jsonDecode(entryBookingModel[index].bookingData!)['totalAmount']}  Number of tickets : ${jsonDecode(entryBookingModel[index].bookingData!)['customers'].length} ",
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //   ),
                          // ),
                        );
                      },
                    ),
                  ))
      ],
    );
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
    return DefaultTabController(
        length: 2,
        child: BlocConsumer<ProgramsBloc, ProgramsState>(
          buildWhen: (previous, current) {
            if (current is HomePageDataAvailabale) {
              return true;
            } else {
              return false;
            }
          },
          builder: (context, state) {
            if (state is HomePageDataAvailabale) {
              return new SafeArea(
                child: Scaffold(
                  appBar: new AppBar(
                    title: new Text('ENTRY POINT'),
                    // leading: InkWell(
                    //     onTap: () {
                    //       // Navigator.push(
                    //       //     context,
                    //       //     MaterialPageRoute(
                    //       //         builder: (context) => TestScreen()));
                    //       // _showToast(
                    //       //     context, 'Will work soon.', Toast.LENGTH_SHORT);
                    //     },
                    //     child: Icon(Icons.menu)),

                    actions: <Widget>[
                      InkWell(
                          onTap: () async {
                            List<Map<String, dynamic>> entryBookingDetails =
                                await db!.getEntryBookingData();
                            idProofBooking =
                                await db!.getAllPreviousBookingsUpdate();
                            entryBookingModel = entryBookingDetails
                                .map((data) =>
                                    new EntryBookingModel.fromJson(data))
                                .toList();
                            setState(() {});
                          },
                          child: new Icon(
                            Icons.refresh,
                            color: Colors.white,
                          )),
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
                          print("yes");
                          isOffline == false
                              ? synData(context, state)
                              : Fluttertoast.showToast(
                                  msg: "Go online to download");
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
                              'Book Ticket',
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
                      _pendingbookings(context)
                    ],
                  ),
                ),
              );
            } else if (state is NotFound) {
              return SafeArea(
                child: Scaffold(
                  body: new Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      strokeWidth: 3,
                    ),
                  ),
                ),
              );
            }

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
          },
          listener: (context, state) async {
            if (state is HomePageDataAvailabale) {
              if (state.isOffline == false) {
                await addProgramsToList(context, state);
                // await addToOfflineList(context, state);
              }

              // await addToOfflineList(context, state);
            } else if (state is TokensCleared) {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            }
          },
        ));
  }

  _homePageBody(BuildContext context, HomePageDataAvailabale state) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 12.0, right: 12.0),
        child: new Column(
          children: [
            new SizedBox(
              height: 15.0,
            ),
            // _searchBar(),
            // new SizedBox(
            //   height: 10.0,
            // ),
            _entranceTicket(context, state),
            new SizedBox(
              height: 10.0,
            ),
            // _programs(context, state),
            // new SizedBox(
            //   height: 15.0,
            // ),
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

  _entranceTicket(BuildContext context, HomePageDataAvailabale state) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(2),
        ),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Entrance Ticket Booking'),
              SizedBox(
                height: 16,
              ),
              MaterialButton(
                height: 40,
                minWidth: double.infinity,
                color: AppColors.appColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntranceTicketBooking(),
                    ),
                  );
                },
                child: Text('Start Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _programs(BuildContext context, HomePageDataAvailabale state) {
    return searchedList.length == 0
        ? GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: gridPrograms.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  gridPrograms[index].started == true
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProgramDetails(
                              programId: gridPrograms[index].id,
                              progName: gridPrograms[index].progName,
                              isCottage: gridPrograms[index].isCottage,
                              isOffline: state.isOffline,
                              vehicleInfo: vehicleInfo,
                            ),
                          ),
                        )
                      : _showToast(
                          context, 'Booking closed', Toast.LENGTH_SHORT);
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

  //  _recentBooking(BuildContext context) {
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
  //                 // Navigator.push(
  //                 //     context,
  //                 //     MaterialPageRoute(
  //                 //         builder: (context) => PreviousBookingAll()));
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
    return BlocConsumer<ProgramsBloc, ProgramsState>(
      builder: (context, state) {
        if (state is HomePageDataAvailabale) {
          return state.isOffline == false
              ? state.previoousBookingData!.upcoming!.length != 0
                  ? SafeArea(
                      child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: _bookings(context, state)),
                    )
                  : Container(
                      child: SafeArea(
                        child: Scaffold(
                          body: new Center(
                            child: Text("No Bookings Yet!"),
                          ),
                        ),
                      ),
                    )
              : previousBookings.length != 0
                  //  ? SizedBox.shrink()
                  ? previousBookingView()
                  : Container(
                      child: SafeArea(
                        child: Scaffold(
                          body: new Center(
                            child: Text("No Bookings Yet!"),
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

  _bookings(context, state) {
    return BlocConsumer<ProgramsBloc, ProgramsState>(
        builder: (context, state) {
          if (state is HomePageDataAvailabale) {
            return new ListView.separated(
              // physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: state.previoousBookingData!.upcoming!.length,
              itemBuilder: (context, indexUpcoming) {
                return new ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.previoousBookingData!
                      .upcoming![indexUpcoming].booking!.length,
                  itemBuilder: (context, indexBooking) {
                    return new Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width,
                      child: new Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: CachedNetworkImage(
                              imageUrl: WebClient.imageIp +
                                  state
                                      .previoousBookingData!
                                      .upcoming![indexUpcoming]
                                      .booking![indexBooking]
                                      .programme!
                                      .coverImage
                                      .toString(),
                              placeholder: (context, url) => Center(
                                child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    )),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(Icons.error),
                                ),
                              ),
                              width: 60.0,
                              height: 60.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          new SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                              child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Text(state
                                  .previoousBookingData!
                                  .upcoming![indexUpcoming]
                                  .booking![indexBooking]
                                  .programme!
                                  .progName
                                  .toString()),
                              Container(
                                child: new Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    state
                                                .previoousBookingData!
                                                .upcoming![indexUpcoming]
                                                .booking![indexBooking]
                                                .indian! >
                                            0
                                        ? new Text(
                                            "Indian Adult X " +
                                                state
                                                    .previoousBookingData!
                                                    .upcoming![indexUpcoming]
                                                    .booking![indexBooking]
                                                    .indian
                                                    .toString(),
                                            style: StyleElements.listViewSubOne,
                                          )
                                        : SizedBox(),
                                    SizedBox(width: 10.0),
                                    state
                                                .previoousBookingData!
                                                .upcoming![indexUpcoming]
                                                .booking![indexBooking]
                                                .foreignStudent! >
                                            0
                                        ? new Text(
                                            "Foreign Student X " +
                                                state
                                                    .previoousBookingData!
                                                    .upcoming![indexUpcoming]
                                                    .booking![indexBooking]
                                                    .foreignStudent
                                                    .toString(),
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
                                          state
                                              .previoousBookingData!
                                              .upcoming![indexUpcoming]
                                              .booking![indexBooking]
                                              .bookingDate
                                              .toString(),
                                        ),
                                      ),
                                      style:
                                          StyleElements.previousBookingDndTime,
                                    ),
                                    SizedBox(width: 30.0),
                                    new Text(
                                      state
                                              .previoousBookingData!
                                              .upcoming![indexUpcoming]
                                              .booking![indexBooking]
                                              .slotDetail!
                                              .startTime
                                              .toString() +
                                          " - " +
                                          state
                                              .previoousBookingData!
                                              .upcoming![indexUpcoming]
                                              .booking![indexBooking]
                                              .slotDetail!
                                              .endTime
                                              .toString(),
                                      style:
                                          StyleElements.previousBookingDndTime,
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
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return new SizedBox(
                  height: 10.0,
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
        listener: (context, state) {});
  }

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
                    //    new Icon(Icons.upload),
                    // SizedBox(
                    //   width: 40,
                    // ),
                    // Text("Upload data", textAlign: TextAlign.center)
                    // Expanded(
                    //   child: MaterialButton(
                    //     child: Text(
                    //       "Upload offline data",
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //     onPressed: () {
                    //       print("upload");
                    //       Navigator.pop(context);
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => UploadDataSync()));
                    //       // .then((value) => HomePage());
                    //     },
                    //   ),
                    // ),
                  ]),
                  // isOffline == false
                  //     ? SizedBox(
                  //         height: 20,
                  //       )
                  //     : SizedBox.shrink(),
                  // isOffline!
                  //     ?
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
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => DownloadDataSync()));
                              // Navigator.pop(context);
                              checkConnecion(context, state);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             DownloadOfflineData(state: state,)));
                            },
                          ),
                        )
                      ]),
                  // : SizedBox.shrink(),
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

  void _searchThis(BuildContext context, String value) {
    // searchedList.clear();
    if (value.isNotEmpty) {
      gridPrograms.forEach((element) {
        if (element.progName!.contains(value)) {
          searchedList.add(
            GridPrograms(
              progName: element.progName,
              isCottage: element.isCottage,
              id: element.id,
              status: element.status,
            ),
          );
        }
      });
      setState(() {});
    } else {
      searchedList.clear();
      setState(() {});
      return;
    }
  }

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

  //   print("the image path is $imagePath");
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
      print("the reposnse is $response");
    } catch (e) {
      print(e);
    }
  }

  void syncData() {
    showAlert(context);
  }

  void checkConnecion(
      BuildContext context, HomePageDataAvailabale state) async {
    Navigator.pop(context);
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
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EntryDataDownloadPage()));
    bool storage = await checkStorage();
    if (storage == true) {
      // progressDialog!.show(max: maximum!, msg: 'Offline data downloading...');
      // showDownloadProgress(context, state);
      //    showCircular(context);
      await createFolder(context);
      await _startDownloading(context, state);
    } else {
      _showAlert(context, "Not enough space",
          "Minimum 500MB needed. Please free up phone storage", false);
    }
  }

  checkConnection(BuildContext context) async {
    bool status = false;
    try {
      http.Response response = await http
          .get(Uri.parse('https://www.google.com/'))
          .timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        status = true;
      } else {
        status = false;
      }
    } catch (e) {
      status = false;
    }
    return status;
  }

  // Future<void> clearAll(BuildContext context) async {
  //   await db!.checkAndDelete('allprogramms_seven');
  //   await db!.clearSlotTable('slotdetails_table_two');
  //   await db!.deleteTicketTable();
  // }

  void showAlertTwo(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Empty Offline"),
      content: Text(
          "Offline date not found, please go online and download data from server!",
          style: TextStyle(height: 1.5)),
      actions: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Icon(Icons.refresh, color: Colors.white, size: 24),
            onPressed: () async {
              await checkInternet();
              // isOffline == true
              //     ? _showToast(context, "No internet", Toast.LENGTH_SHORT)
              //     : Navigator.pop(context);
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
  _startDownloading(BuildContext context, HomePageDataAvailabale state) async {
    _showToast(context, "Downloading offline data...", Toast.LENGTH_SHORT);
    // var num;
    // final imageDirectory = await getTemporaryDirectory();
    // ----->>> clear all records in the program table(first table)
    await db!.deleteTables();
    await db!.createTables();
    // await db!.checkAndCreateSlotTable('slotdetails_table_two');
    // await db!.clearSlotTable('slotdetails_table_two');
    // await db!.checkAndCreateRoomCountTable();
    // await db!.checkAndCreateTermsAndCondions();
    // await db!.checkAndDeleteTermsAndCondions();
    // await db!.createVehicleTable();
    // await db!.checkAndCreateFinalBookingTable();
    // await db!.checAndCreateTicketTable();
    // await db!.createTablePreviousBookingsUpdate();
    context.read<DownloadBloc>().add(DownloadOfflineData());
    //=================================================================
    // for (int i = 0; i < state.programmz!.programData!.length; i++) {
    //   print("cottage true @ ${state.programmz!.programData![i].progName}");
    //   for (int j = 0; j < state.programmz!.packageData!.length; j++) {
    //     if (state.programmz!.programData![i].id ==
    //         state.programmz!.packageData![j].programme) {
    //       num = await db!.insert(state.programmz!.programData![i], true,
    //           state.programmz, state.programmz!.packageData![j]);
    //       print("inserted program $num");
    //       break;
    //     }
    //   }
    // }
    // print("all programs added successfully");

    // ----->>> read all records from the first table
    // gridProgramsLocal = await db!.queryAllRows();
    // ----->>> create new slot table if such not exists

    // ----->>> delete all records in the slot table if it has records

    // ----->>> adding slottdetails in the slot table (second table)
    // print("gridprograms length is ${gridProgramsLocal.length}");
    // for (int i = 0; i < gridProgramsLocal.length; i++) {
    //   BookingSummary? bookingSummary;
    //   var url = '/booking/getagentslots?programme=' +
    //       gridProgramsLocal[i].id.toString() +
    //       '&date=' +
    //       DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    //   // DateFormat('yyyy-MM-dd').format(DateTime(2021, 10, 28)).toString();
    //   bookingSummary = await AuthRepository().getBookingSummary(url: url);
    //   print(url);
    //   if (bookingSummary.status == true) {
    //     // print("slot count ${bookingSummary.data!.length}");
    //     for (int i = 0; i < bookingSummary.data!.length; i++) {
    //       num = await db!.addSlotDeatails(
    //           bookingSummary.data![i], 'slotdetails_table_two');
    //     }
    //   }
    // }
    //print("all slot details added successfully");
    // VehicleModel vehicleModel;
    // vehicleModel = await AuthRepository()
    //     .getVehicleInformations(url: '/static/settings/get');
    // if (vehicleModel.status == true) {

    //   print(await db!.addToVehicleTable(vehicleModel));
    // }

    OfflineLineTicket offlineLineTicket;
    print("all slot details added successfully");
    VehicleModel vehicleModel;
    vehicleModel = await AuthRepository()
        .getVehicleInformations(url: '/static/settings/get');
    if (vehicleModel.status == true) {
      print(await db!.addToVehicleTable(vehicleModel));
    }
    context.read<DownloadBloc>().add(SlotDataAdded());
    // ${DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()}
    // var now = DateTime.now();
    var url =
        '/booking/admingetlist/app?count=10000&page=1&fromDate=${DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()}&toDate=${DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2)).toString()}&type=offline';
    print(url);
    // '/booking/admingetlist?count=10000&page=1&fromDate=2021-11-10&toDate=2021-11-15&type=offline';
    offlineLineTicket =
        OfflineLineTicket.fromJson(await ServerHelperLive.get(url));

    print(url);
    var theResult;
    List ticketDetails = [];
    List programme = [], vehicles = [], entranceTickets = [];
    List details = [];
    List mainProgramme = [];
    if (offlineLineTicket.status == true) {
      // _showToast(context, "Downloading tickets...", Toast.LENGTH_SHORT);
      print("the count ${offlineLineTicket.count.toString()}");

      print(
          "the length main ${offlineLineTicket.ticketData!.length.toString()}");
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
            print(
                "the length ${offlineLineTicket.ticketData![i].entranceTickets!.length}");
            print(k.toString());
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
        } else {
          print("null");
        }

        for (int j = 0;
            j < offlineLineTicket.ticketData![i].booking!.length;
            j++) {
          programme.clear();
          details.clear();
          print(
              "the programm name ${offlineLineTicket.ticketData![i].booking![j].programme!.progName}");
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

          print(programme);

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
                        .guest!.idproofs!.image!.length !=
                    0) {
                  idproof = offlineLineTicket.ticketData![i].booking![j]
                      .details![k].guest!.idproofs!.image![0];
                  idproof = await downloadImage(context, idproof);
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

        print(mainProgramme);

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
      print("---------------${theDate.length.toString()}---------------");
      for (int i = 0; i < theDate.length; i++) {
        print(theDate[i]);
      }

      // ticketDetails.forEach((element) {
      //   print(element);
      // });
      // print(ticketDetails);

      print("theResult $theResult");
    } else {
      print(offlineLineTicket.status);
    }
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
    print("Adding terms and conditions");

    TermsAndPolicy? termsAndPolicy;
    termsAndPolicy =
        await AuthRepository().getTermsAndConditions(url: '/static/getpolicy');
    dynamic response = await ServerHelper.get('/ticket/get/numbers');
    if (termsAndPolicy.status == true &&
        response['status'] &&
        response['data'] != null) {
      print(termsAndPolicy.msg);
      var cancel = termsAndPolicy.data!.cancel;
      var terms = termsAndPolicy.data!.terms;
      await db!.addIntialTerms(
          cancel, terms, int.parse(response['data'][0]['ticketNo'].toString()));
      context.read<DownloadBloc>().add(TermsAndConditionsAdded());
    } else {
      print(termsAndPolicy.msg);
    }
    _showToast(context, "Offline data downloaded", Toast.LENGTH_SHORT);

    // list = await db!.getTermsAndConditionsOffline();
    // print(list);
    //Navigator.pop(context);
  }

  downloadImage(BuildContext? context, String? idproofs) async {
    var thePath;
    try {
      var url = WebClient.imageIp + idproofs!;
      http.Response response = await http.get(Uri.parse(url));
      print(url);
      var filePathAndName = '${path.path}$idproofs';
      print(filePathAndName);
      if (response.statusCode == 200) {
        File imageFile = File(filePathAndName);
        imageFile.writeAsBytesSync(response.bodyBytes);
        thePath = imageFile.path;
        print(imageFile.path);
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
    print(status);
    if (status == PermissionStatus.denied) {
      await Permission.storage.request();
      status = await Permission.storage.status;
      print("now the status is + " + status.toString());
    }
    if (status == PermissionStatus.granted) {
      Directory directory = await getApplicationDocumentsDirectory();
      path = Directory(directory.path.toString() + "/parambikulam/entryhome/");
      bool isExists = await path!.exists();
      if (isExists) {
        path!.deleteSync(recursive: true);
        await path!.create(recursive: true);
      } else {
        await path!.create(recursive: true);
        print("false");
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
      print(url);
      var filePathAndName = '${path.path}$ticket.pdf';
      if (response.statusCode == 200) {
        print(filePathAndName);
        File imageFile = File(filePathAndName);
        imageFile.writeAsBytesSync(response.bodyBytes);
        theTicketOne = imageFile.path;
        print(imageFile.path);
      } else {
        theTicketOne = null;
      }
    } catch (e) {
      print("Ticket download exception $e");
      theTicketOne = null;
    }
    return theTicketOne;
  }

  Widget previousBookingView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: previousBookings.length,
      itemBuilder: (context, index) {
        return new Container(
          height: 60.0,
          width: MediaQuery.of(context).size.width,
          child: new Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundImage: AssetImage(
                    "assets/bgptrr.png",
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
              new SizedBox(
                width: 10.0,
              ),
              Expanded(
                  child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text(previousBookings[index]['title'].toString()),
                  Container(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        previousBookings[index]['indianCount'] > 0
                            ? new Text(
                                "Indian Adult X " +
                                    previousBookings[index]['indianCount']
                                        .toString(),
                                style: StyleElements.listViewSubOne,
                              )
                            : SizedBox(),
                        SizedBox(width: 10.0),
                        previousBookings[index]['foreignerCount'] > 0
                            ? new Text(
                                "Foreigner X " +
                                    previousBookings[index]['foreignerCount']
                                        .toString(),
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
                              previousBookings[index]['bookingDate'].toString(),
                            ),
                          ),
                          style: StyleElements.previousBookingDndTime,
                        ),
                        SizedBox(width: 30.0),
                        new Text(
                          previousBookings[index]['startTime'].toString() +
                              " - " +
                              previousBookings[index]['endTime'].toString(),
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
                )),
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
