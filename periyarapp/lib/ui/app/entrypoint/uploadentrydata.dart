import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/bloc/syncoffline/blocsyncoffline.dart';
import 'package:parambikulam/bloc/syncoffline/eventsyncoffline.dart';
import 'package:parambikulam/bloc/syncoffline/statesyncoffline.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/data/models/commonmodel.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:http/http.dart' as http;
import 'package:parambikulam/ui/app/datasync/notuploadedlist.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';
import 'package:parambikulam/utils/pref_manager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wakelock/wakelock.dart';

class UploadDataSync extends StatefulWidget {
  _UploadDataSync createState() => _UploadDataSync();
}

class _UploadDataSync extends State<UploadDataSync> {
  DatabaseHelper? db = DatabaseHelper.instance;
  bool isDataFound = false,
      uploadStarted = false,
      backPop = true,
      uploadSuccess = false,
      uploadNotSuccess = false;
  int? failedCount = 0, successCount = 0;
  double? progress = 0.0;
  List<Map> allDataList = [];
  List previousUpdated = [];
  List roomAllocation = [];
  List vehicleList = [];
  List guestData = [];
  List finalList = [], newFinalList = [];

  var successNewCount = 0;
  List exceptionList = [];
  List entranceTicket = [];
  var successRate = 0;
  var tableId = 0;
  // ProgressDialog? progressDialog;
  var connectivityResult;

  @override
  void initState() {
    Wakelock.enable();
    super.initState();
    checkOfflineData();
  }

  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }

  void checkOfflineData() async {
    // progressDialog = ProgressDialog(context: context);
    // progressDialog!.show(max: 100, msg: 'File Downloading...');
    BlocProvider.of<BlocSyncOffline>(context).add(UploadEventInitial());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => backPop,
      child: Scaffold(
          appBar: new AppBar(
            title: Text("Upload Offline Data"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: InkWell(
                    onTap: () async {
                      var deleteResult = await db!.deleteFromBookings(10);
                      print("deleted result $deleteResult");
                      setState(() {});
                    },
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
          body: BlocConsumer<BlocSyncOffline, StateSyncOffline>(
              builder: (context, state) {
            if (state is DataFoundState) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppCard(
                        outLineColor: HexColor('#292929'),
                        child: Column(
                          children: [
                            new Text(
                              state.length.toString(),
                              style: TextStyle(fontSize: 58.0),
                            ),
                            SizedBox(height: 20),
                            state.length! > 1
                                ? new Text(
                                    'Bookings Total',
                                    style: TextStyle(fontSize: 18.0),
                                  )
                                : new Text(
                                    'Booking Found',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                            SizedBox(height: 20),
                            uploadSuccess
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Icon(
                                        Icons.sync_rounded,
                                        size: 25.0,
                                        color: HexColor('#069B56'),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      new Text(
                                        "Sync Completed",
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                            uploadStarted
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : uploadSuccess
                                    ? SizedBox.shrink()
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.8,
                                        child: TextButton(
                                          style:
                                              StyleElements.submitButtonStyle,
                                          onPressed: () async {
                                            checkInternet();
                                            // for (int i = 0; i <= 100; i++) {
                                            //   if (i == 20 ||
                                            //       i == 30 ||
                                            //       i == 40 ||
                                            //       i == 50 ||
                                            //       i == 60 ||
                                            //       i == 70 ||
                                            //       i == 80) {
                                            //     setState(() {
                                            //       failedCount = failedCount! + 1;
                                            //     });
                                            //   } else {
                                            //     await Future.delayed(
                                            //         Duration(milliseconds: 500), () {});
                                            //     setState(() {
                                            //       progress = (((i / 100) * 100) / 100);
                                            //       print(progress);
                                            //     });
                                            //   }
                                            // }
                                            // setState(() {
                                            //   back = true;
                                            // });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(Icons.upload,
                                                  color: Colors.white),
                                              Text(
                                                "Upload Now",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                          ],
                        ),
                        color: HexColor('#292929'),
                        // color: Colors.black,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      uploadStarted
                          ? AppCard(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircularPercentIndicator(
                                    animation: true,
                                    radius: 60.0,
                                    animateFromLastPercent: true,
                                    lineWidth: 5.0,
                                    percent: progress!,
                                    center: new Text(
                                        ((progress! * 100).round()).toString() +
                                            "%"),
                                    progressColor: HexColor('#069B56'),
                                  ),
                                  // ),
                                  Text("Uploading data...")
                                ],
                              ),
                              color: HexColor('#292929'),
                              outLineColor: HexColor('#292929'),
                            )
                          : SizedBox.shrink(),
                      uploadStarted
                          ? SizedBox(
                              height: 10.0,
                            )
                          : SizedBox.shrink(),
                      successCount! > 0
                          ? AppCard(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    successCount.toString(),
                                    style: TextStyle(
                                      fontSize: 28,
                                    ),
                                  ),
                                  Text("Booking(s) Uploaded"),
                                ],
                              ),
                              color: HexColor('#292929'),
                              outLineColor: Colors.green,
                            )
                          : SizedBox.shrink(),
                      successCount! > 0
                          ? SizedBox(height: 10)
                          : SizedBox.shrink(),
                      failedCount! > 0
                          ? AppCard(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    failedCount.toString(),
                                    style: TextStyle(
                                      fontSize: 28,
                                    ),
                                  ),
                                  Text("Upload Failed"),
                                  uploadNotSuccess
                                      ? IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NotUploadedList(
                                                            finalList:
                                                                finalList)));
                                          },
                                          icon: Icon(Icons.navigate_next_sharp))
                                      : SizedBox.shrink(),
                                ],
                              ),
                              color: HexColor('#292929'),
                              outLineColor: Colors.red,
                            )
                          : SizedBox.shrink(),
                      failedCount! > 0
                          ? SizedBox(
                              height: 10.0,
                            )
                          : SizedBox.shrink(),
                      // AppCard(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text("View All Bookings"),
                      //       IconButton(
                      //           padding: EdgeInsets.zero,
                      //           constraints: BoxConstraints(),
                      //           onPressed: () {},
                      //           icon: Icon(Icons.navigate_next_sharp)),
                      //     ],
                      //   ),
                      //   color: HexColor('#292929'),
                      //   outLineColor: HexColor('#292929'),
                      // ),
                    ]),
              );
            }
            if (state is CheckingSync) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UploadingData) {
              Fluttertoast.showToast(msg: "Uploading data");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UploadingFinishedState) {
              Fluttertoast.showToast(msg: "Data uploaded successfully");
              return Center(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(
                        Icons.check_circle_outline,
                        size: 75.0,
                        color: HexColor('#069B56'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      new Text(
                        "Upload success",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ]),
              );
            }

            if (state is UploadingNotFinishedState) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppCard(
                        outLineColor: HexColor('#ff6e4a'),
                        color: HexColor('#292929'),
                        child: new Column(children: <Widget>[
                          new Text(
                            state.length.toString(),
                            style: TextStyle(fontSize: 58.0),
                          ),
                          SizedBox(height: 20),
                          new Text(
                            'Booking(s) not uploaded',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            style: StyleElements.submitButtonStyle,
                            onPressed: () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NotUploadedList(
                                          finalList: finalList)));
                            },
                            child: Text(
                              "View",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Container();

            // return SingleChildScrollView(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Column(
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Container(
            //               width: MediaQuery.of(context).size.width / 2.2,
            //               height: MediaQuery.of(context).size.height / 4,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Text("Hello"),
            //               ),
            //               decoration: BoxDecoration(
            //                   color: Colors.black,
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(8))),
            //             ),
            //             Container(
            //               width: MediaQuery.of(context).size.width / 2.2,
            //               height: MediaQuery.of(context).size.height / 4,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Text("Hello"),
            //               ),
            //               decoration: BoxDecoration(
            //                   color: Colors.black,
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(8))),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          }, listener: (context, state) async {
            if (state is UploadingNotFinishedState) {
              setState(() {
                backPop = true;
              });
            }
            if (state is UploadingFinishedState) {
              setState(() {
                backPop = true;
              });
            }
            if (state is CheckingSync) {
              getData(context);
            }
            if (state is DataNotFoundState) {
              await _showAlert(
                  context, 'No bookings', 'No bookings found', true);
            }

            if (state is NoInternetState) {
              _showAlert(context, 'No internet',
                  'connection failed, please check the internet', false);
              BlocProvider.of<BlocSyncOffline>(context)
                  .add(UploadEventInitial());
            }
          })),
    );
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
                      child: Text("Ok"),
                      onPressed: () {
                        if (goBack == true) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
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

  void getData(BuildContext context) async {
    List failedData = [];
    allDataList = await db!.getFinalBookingData();
    failedData = await db!.getFinalFailedBookingData();
    previousUpdated = await db!.getAllPreviousBookingsUpdate();
    // allDataList.forEach((element) {
    //   print(element);
    // });

    if (allDataList.length != 0) {
      print("data found");
      BlocProvider.of<BlocSyncOffline>(context).add(DataFound(
          length: allDataList.length, failedLength: failedData.length));
    } else {
      print("data not found");
      BlocProvider.of<BlocSyncOffline>(context).add(DataNotFound());
    }
  }

  Future<void> uploadData() async {
    if (allDataList.length != 0) {
      // BlocProvider.of<BlocSyncOffline>(context).add(UploadingInitiated());
      await uploadBookingData(context);
    }
    print("previousUpdated.length ${previousUpdated.length}");
    if (previousUpdated.length != 0) {
      _showToast(
          context, "Upload previous tickets id proofs", Toast.LENGTH_LONG);
      print(previousUpdated);
      await uploadPreviousTicketUpdates(context);
      await checkDb();
    } else {
      await checkDb();
    }
  }

  void checkInternet() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      setState(() {
        uploadStarted = true;
        backPop = false;
      });
      await uploadData();
    } else {
      Fluttertoast.showToast(msg: "Please connect to the internet");
    }
    // await uploadData();
    // await checkDb();
  }

  checkDb() async {
    finalList = await db!.getFinalBookingData();
    if (finalList.length == 0) {
      // BlocProvider.of<BlocSyncOffline>(context).add(UploadingFinished());
      setState(() {
        uploadStarted = false;
        uploadSuccess = true;
        backPop = true;
        uploadNotSuccess = false;
      });
    } else {
      print("++++++++++++++++++++++++++++++++++++++++");
      print(finalList);
      print("++++++++++++++++++++++++++++++++++++++++");
      setState(() {
        uploadStarted = false;
        uploadSuccess = true;
        uploadNotSuccess = true;
        backPop = true;
      });
      // BlocProvider.of<BlocSyncOffline>(context)
      //     .add(UploadingNotFinished(length: finalList.length));
    }
  }

  checkConnection() async {
    bool status = false;
    try {
      http.Response response =
          await http.get(Uri.parse('https://www.parambikulam.org/'));
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

  uploadIdProof(List<GuestData> list, int tableId, List guestData,
      int mainLength, int mainIndex) async {
    if (list.length == guestData.length) {
      successRate = successRate + 1;
      for (int k = 0; k < list.length; k++) {
        try {
          var token = await PrefManager.getToken();
          if (list[k].id != null) {
            var request = http.MultipartRequest(
                'POST', Uri.parse(WebClient.ip + '/guest/uploadproof'));
            request.fields.addAll({"id": list[k].id.toString()});
            request.files.add(await http.MultipartFile.fromPath(
                'image', guestData[k]['image'].toString()));
            request.headers.addAll(
                {"Content-Type": "application/json", "token": token ?? ""});
            http.StreamedResponse response = await request.send();
            if (response.statusCode == 200) {
              setState(() {
                successNewCount = successRate;
                progress = ((((mainIndex + 1) / mainLength) * 100) / 100);
                successCount = successRate;
              });
              print("File Uploaded" + await response.stream.bytesToString());
              var deleteResult = await db!.deleteFromBookings(tableId);
              print("deleted result $deleteResult");
            } else {
              setState(() {
                progress = ((((mainIndex + 1) / mainLength) * 100) / 100);
                print("the progress " + progress.toString());
              });
              setState(() {
                failedCount = failedCount! + 1;
              });
              await db!.updateReason(
                  "Booking data uploaded, id proof not uploaded  - status code" +
                      response.statusCode.toString(),
                  tableId);
              _showToast(
                  context,
                  "Booking data uploaded, id proof not uploaded  - status code" +
                      response.statusCode.toString(),
                  Toast.LENGTH_LONG);
            }
          }
        } catch (e) {
          setState(() {
            failedCount = failedCount! + 1;
          });
          print("image upload exception $e");
          _showToast(context, "Id proof not uploaded" + e.toString(),
              Toast.LENGTH_LONG);
          await db!.updateReason(e.toString(), tableId);
        }
      }
      // if (mainIndex == (guestData.length / 2).round()) {
      //   Fluttertoast.showToast(msg: "Half of data uploaded, continuing...");
      // }
    } else {
      print("upload exception");
    }
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

  //uploadall
  uploadBookingData(BuildContext context) async {
    print("the length + " + allDataList.length.toString());
    for (int i = 0; i < allDataList.length; i++) {
      print("the I + " + i.toString());
      var theStatus = await checkConnection();
      if (theStatus == true) {
        try {
          print("Connected");
          String vehicle = "";
          vehicle = allDataList[i]['vehicle'];
          if (vehicle == 'null') {
            print('yes');
            vehicleList = [];
          } else {
            print('no');
            vehicleList = json.decode(vehicle);
          }

          tableId = allDataList[i]['id'];
          roomAllocation = allDataList[i]['members'] != null
              ? json.decode(allDataList[i]['members'])
              : [];

          guestData = allDataList[i]['newListTwo'] != null
              ? json.decode(allDataList[i]['newListTwo'])
              : [];
          entranceTicket = allDataList[i]['entranceTicket'] != null
              ? json.decode(allDataList[i]['entranceTicket'])
              : [];

          CommonModel commonModel = CommonModel();
          var url = "/cart/bookeddata";
          // Map data = {};
          Map data = {
            'programme': allDataList[i]['programId'],
            'slotDetail': allDataList[i]['slotId'],
            'bookingDate': allDataList[i]['bookingDate'],
            'numberOfRooms': allDataList[i]['roomcount'],
            'indianCount': allDataList[i]['indianCount'],
            'childrenCount': allDataList[i]['childrenCount'],
            'foreignerCount': allDataList[i]['foreignerCount'],
            'roomAllocation': roomAllocation,
            'guestData': guestData,
            //-----------------
            'vehicle': vehicleList,
            'amount': allDataList[i]['totalAmount'],
            'ticketNumber': allDataList[i]['ticketNumber'],
            'entranceTicket': entranceTicket,
            'ticketid': allDataList[i]['ticketId'],
            //below not required
            'guest': [],
          };

          // print("the image of $i is ${guestData[j]['image']}");
          // var deleteResult = await db!.deleteFromBookings(tableId);
          // print("deleted result $deleteResult");
          // print("the data $data");
          commonModel =
              await AuthRepository().sendBookedData(url: url, data: data);

          if (commonModel.status == true) {
            print("-----------------");
            print("success ${commonModel.msg}");
            print("-----------------");
            print(commonModel.data!.guest);
            await uploadIdProof(commonModel.data!.guest!, tableId, guestData,
                allDataList.length, i);
          } else {
            setState(() {
              progress = ((((i + 1) / allDataList.length) * 100) / 100);
              print("the progress " + progress.toString());
            });
            // await uploadIdProof(commonModel.data!.guest!, tableId, guestData,
            //     allDataList.length, i);
            // var deleteResult = await db!.deleteFromBookings(tableId);
            // print("deleted result $deleteResult");
            print("-----------------");
            print("failed ${commonModel.msg}");
            // _showToast(context, commonModel.msg.toString(), Toast.LENGTH_LONG);
            print("-----------------");
            //update db
            await db!.updateReason(commonModel.msg, tableId);
            print("the data $data");
            setState(() {
              failedCount = failedCount! + 1;
            });
            // exceptionList.add({
            //   "tableId": tableId,
            //   "reason": commonModel.msg,
            // });
            // allDataList.removeAt(i);
            // setState(() {
            //   allDataList.removeAt(i);
            // });
          }
        } catch (e) {
          _showToast(context, e.toString(), Toast.LENGTH_SHORT);
        }
      } else {
        print("Not Connected");
        _showToast(context, "Connection lost", Toast.LENGTH_LONG);
        BlocProvider.of<BlocSyncOffline>(context).add(NoInternet());
        break;
      }
    }
  }

  uploadPreviousTicketUpdates(BuildContext context) async {
    for (int k = 0; k < previousUpdated.length; k++) {
      try {
        Fluttertoast.showToast(msg: "Uploading");
        var token = await PrefManager.getToken();
        var request = http.MultipartRequest(
            'POST', Uri.parse(WebClient.ip + '/guest/uploadproof'));
        request.fields
            .addAll({"id": previousUpdated[k]['personId'].toString()});
        request.fields
            .addAll({"ticket": previousUpdated[k]['ticketId'].toString()});
        request.files.add(await http.MultipartFile.fromPath(
            'image', previousUpdated[k]['imageFile']));
        request.headers.addAll(
            {"Content-Type": "application/multipart", "token": token ?? ""});
        http.StreamedResponse response = await request.send();
        print(response);
        if (response.statusCode == 200) {
          setState(() {
            progress =
                ((((previousUpdated.length + 1) / allDataList.length) * 100) /
                    100);
            print("the progress " + progress.toString());
          });
          print("File Uploaded - " + await response.stream.bytesToString());
        } else {
          Fluttertoast.showToast(msg: "Some id proofs are not uploaded");
          setState(() {
            progress =
                ((((previousUpdated.length + 1) / allDataList.length) * 100) /
                    100);
            print("the progress " + progress.toString());
          });
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Image Upload Failed Due To - " + e.toString());

        print("Image Upload Failed Due To - " + e.toString());
      }
    }
  }
}
