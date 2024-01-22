// import 'dart:io';

// import 'package:connectivity/connectivity.dart';
// import 'package:disk_space/disk_space.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:parambikulam/bloc/programs/programsstate.dart';
// import 'package:parambikulam/local/db/dbhelper.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:permission_handler/permission_handler.dart';

// class DownloadOfflineData extends StatefulWidget {
//   final HomePageDataAvailabale? state;
//   DownloadOfflineData({this.state});
//   _DownloadOfflineData createState() => _DownloadOfflineData();
// }

// class _DownloadOfflineData extends State<DownloadOfflineData> {
//   var connectivityResult;
//   bool? downloadStarted = false;
//   String? theMessage = "Download started";
//   double? progress = 0.0;
//   DatabaseHelper? db = DatabaseHelper.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Download Offline Data"),
//         centerTitle: true,
//       ),
//       body: offlineDownloadMain(),
//     );
//   }

//   Widget offlineDownloadMain() {
//     return Center(
//       child: new Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           downloadStarted == false
//               ? SizedBox(
//                   width: MediaQuery.of(context).size.width / 1.5,
//                   child: MaterialButton(
//                       padding: EdgeInsets.all(12.0),
//                       color: HexColor('#069B56'),
//                       onPressed: () {
//                         checkInternet(context);
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Icon(Icons.download),
//                           Text("Download offline data"),
//                         ],
//                       )),
//                 )
//               : Column(
//                   children: [
//                     Text(theMessage!),
//                     SizedBox(
//                       height: 15.0,
//                     ),
//                     CircularPercentIndicator(
//                       animation: true,
//                       radius: 60.0,
//                       animateFromLastPercent: true,
//                       lineWidth: 5.0,
//                       percent: progress!,
//                       center: new Text(
//                           ((progress! * 100).round()).toString() + "%"),
//                       progressColor: HexColor('#069B56'),
//                     ),
//                   ],
//                 )
//         ],
//       ),
//     );
//   }

//   void checkInternet(BuildContext context) async {
//     connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       showConnectionRequired(context);
//     } else {
//       await downloadData(context);
//     }
//   }

//   void showConnectionRequired(BuildContext context) {
//     AlertDialog alertDialog = new AlertDialog(
//       title: Text("Not connected"),
//       content: Text("Please connect to the internet"),
//       actions: <Widget>[
//         MaterialButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text("ok"),
//         )
//       ],
//     );
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return alertDialog;
//         });
//   }

//   downloadData(BuildContext context) async {
//     bool storage = await checkStorage();
//     if (storage == true) {
//       var status = await Permission.storage.status;
//       // await Permission.storage.request();
//       if (status == PermissionStatus.denied) {
//         await Permission.storage.request();
//         status = await Permission.storage.status;
//       }
//       if (status == PermissionStatus.granted) {
//         final folderName = "Parambikulam";
//         final path = Directory("storage/emulated/0/$folderName");
//         final checkPathExistence = await path.exists();
//         if (checkPathExistence == true) {
//           await deleteAllData(path);
//           _startDownloading(context, path);
//         } else {
//           path.create();
//           if (checkPathExistence == true) {
//             _startDownloading(context, path);
//           } else {
//             Fluttertoast.showToast(msg: "Path not created");
//           }
//         }
//       }
//     } else {
//       _showAlert(context, "Not enough space",
//           "Minimum 500MB needed. Please free up phone storage", false);
//     }
//   }

//   checkStorage() async {
//     var space = await DiskSpace.getFreeDiskSpace;
//     print(space);
//     if (space! < 100) {
//       print("less");
//       return false;
//     } else {
//       print("higher");
//       return true;
//     }
//   }

//   _showAlert(BuildContext context, String title, String content, bool goBack) {
//     AlertDialog alertDialog = new AlertDialog(
//       title: Text(title),
//       content: Text(content),
//       actions: <Widget>[
//         new Container(
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Column(
//               children: <Widget>[
//                 new Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     TextButton(
//                         child: Text("Ok", textAlign: TextAlign.center),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         }),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return alertDialog;
//         });
//   }

//   void _startDownloading(BuildContext context, Directory path) async {
//     setState(() {
//       downloadStarted = true;
//       theMessage = "Downloading programms";
//     });
//     var num;
//     await db!.checkAndDelete('allprogramms_seven');
//     await db!.checkAndCreateSlotTable('slotdetails_table_two');
//     await db!.clearSlotTable('slotdetails_table_two');
//     await db!.checkAndCreateRoomCountTable();
//     await db!.checkAndCreateTermsAndCondions();
//     await db!.createVehicleTable();
//     await db!.checkAndCreateFinalBookingTable();
//     await db!.checkAndDeleteFinalBookingTable();
//     await db!.checAndCreateTicketTable();
//     await db!.deleteTicketTable();
//     await db!.createTablePreviousBookingsUpdate();
//     await db!.deleteTablePreviousBookingsUpdate();

//     for (int i = 0; i < widget.state!.programmz!.programData!.length; i++) {
//       print(
//           "cottage true @ ${widget.state!.programmz!.programData![i].progName}");
//       for (int j = 0; j < widget.state!.programmz!.packageData!.length; j++) {
//         if (widget.state!.programmz!.programData![i].id ==
//             widget.state!.programmz!.packageData![j].programme) {
//           num = await db!.insert(
//               widget.state!.programmz!.programData![i],
//               true,
//               widget.state!.programmz,
//               widget.state!.programmz!.packageData![j]);
//           print("inserted program $num");
//           break;
//         }
//       }
//       setState(() {
//         progress =
//             ((((i + 1) / widget.state!.programmz!.programData!.length) * 100) /
//                 100);
//       });
//     }

//     /////////---------------------------------------------------------------

//      for (int i = 0; i < gridProgramsLocal.length; i++) {
//       // progressDialog!.update(msg: "Adding programms...", value: i);
//       // setState(() {
//       //   percent = (i / gridProgramsLocal.length);
//       // });
//       BookingSummary? bookingSummary;
//       var url = '/booking/getagentslots?programme=' +
//           gridProgramsLocal[i].id.toString() +
//           '&date=' +
//           DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
//       // DateFormat('yyyy-MM-dd').format(DateTime(2021, 10, 28)).toString();
//       bookingSummary = await AuthRepository().getBookingSummary(url: url);
//       if (bookingSummary.status == true) {
//         // print("slot count ${bookingSummary.data!.length}");
//         for (int i = 0; i < bookingSummary.data!.length; i++) {
//           num = await db!.addSlotDeatails(
//               bookingSummary.data![i], 'slotdetails_table_two');
//         }
//       }
//     }
//   }

//   deleteAllData(Directory path) {
//     path.deleteSync(recursive: true);
//     path.create();
//   }
// }
