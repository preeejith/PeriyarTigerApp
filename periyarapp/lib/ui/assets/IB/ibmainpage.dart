////populated please chnage while pushing

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibprogrambloc/ibprogrambloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibprogrambloc/ibprogramevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibprogrambloc/ibprogramstate.dart';


import 'package:parambikulam/ui/assets/assetshomepage.dart';

import 'package:parambikulam/ui/assets/homepages_assets/unitsview/ic_viewunitspage.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

import 'package:parambikulam/ui/assets/profilepage.dart';

import 'package:parambikulam/utils/pref_manager.dart';

class IBMainPage extends StatefulWidget {
  const IBMainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IBMainPage> createState() => _IBMainPageState();
}

class _IBMainPageState extends State<IBMainPage> {
  String? token;
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  @override
  void initState() {
    fetcher();
    super.initState();
  }

  String? requesttype;
  void fetcher() async {
    BlocProvider.of<GetIBprogramBloc>(context).add(GetIBprogramEvent());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),

      // drawer: theDrawer(),
      appBar: new AppBar(
        title: new Text('IB Programs'),
        // leading: InkWell(onTap: () {}, child: Icon(Icons.menu)),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<GetIBprogramBloc, IBprogramState>(
                builder: (context, state) {
              if (state is IBprogramSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.ibProgramsModel.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              title: InkWell(
                            child: Column(children: [
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xfff292929),
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 4,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Purchase Id:",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.ibProgramsModel
                                                    .data![index].availableNo
                                                    .toString(),
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Purchase Id:",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.ibProgramsModel
                                                    .data![index].endTime
                                                    .toString(),
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Total Amount:",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                state.ibProgramsModel
                                                    .data![index].status
                                                    .toString(),
                                                style: TextStyle(fontSize: 12),
                                              )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text("Date:",
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                              // Text(
                                              //   d1.format(DateTime.parse(
                                              //           convert(state
                                              //               .viewPurchaseListModel
                                              //               .data![index]
                                              //               .createDate
                                              //               .toString()))) +
                                              //       " | " +
                                              //       d2.format(DateTime
                                              //           .parse(convert(state
                                              //               .viewPurchaseListModel
                                              //               .data![index]
                                              //               .createDate
                                              //               .toString()))),
                                              //   style: const TextStyle(
                                              //     fontSize: 12,
                                              //   ),
                                              // )
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           IBMainPageDetailed(
                                  //             purchaseId: state
                                  //                 .viewPurchaseListModel
                                  //                 .data![index]
                                  //                 .id
                                  //                 .toString(),
                                  //           )),
                                  // );

                                  setState(() {});
                                },
                              ),
                            ]),
                          ));
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: SizedBox(
                    height: 28.0,
                    width: 28.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  ),
                );
              }
            }, listener: (context, state) {
              if (state is IBprogramSuccess) {
                // state.ibProgramsModel.data![0].bookingAvailability.toString();
//  if (files3.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Take a Photo");
//     } else if (snarequantitycontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Enter Snare Quantity");
//     } else if (snaretypecontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Enter Snare Type");
//     } else if (landscapecontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Mention Landscape");
//     } else if (targetedspscontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Enter Targeted SPS");
//     } else if (nearbywatersourecontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Mention Nearby Water Source");
//     } else if (foresttypecontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Enter the Forest Type");
//     } else if (animalmarkscontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Enter the Animal Marks");
//     } else if (remarkcontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Enter the Remark");
//     } else if (snarestatuscontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Enter Snare Status");
//     } else if (nearbyvillagedistancecontroller.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Please Enter Near by Village Distance");
//     }

                // else {
                for (int i = 0;
                    i < state.ibProgramsModel.programData!.length;
                    i++) {
                  final started =
                      state.ibProgramsModel.programData![i].started == null
                          ? ""
                          : state.ibProgramsModel.programData![i].started;
                  final isCottage =
                      state.ibProgramsModel.programData![i].isCottage == null
                          ? ""
                          : state.ibProgramsModel.programData![i].isCottage;
                  final status =
                      state.ibProgramsModel.programData![i].status == null
                          ? ""
                          : state.ibProgramsModel.programData![i].status;
                  final _id = state.ibProgramsModel.programData![i].id == null
                      ? ""
                      : state.ibProgramsModel.programData![i].id;
                  final category =
                      state.ibProgramsModel.programData![i].category == null
                          ? ""
                          : state.ibProgramsModel.programData![i].category;
                  final caption =
                      state.ibProgramsModel.programData![i].caption == null
                          ? ""
                          : state.ibProgramsModel.programData![i].caption;
                  final progName =
                      state.ibProgramsModel.programData![i].progName == null
                          ? ""
                          : state.ibProgramsModel.programData![i].progName;

                  final description =
                      state.ibProgramsModel.programData![i].description == null
                          ? ""
                          : state.ibProgramsModel.programData![i].description;
                  final startPoint =
                      state.ibProgramsModel.programData![i].startPoint == null
                          ? ""
                          : state.ibProgramsModel.programData![i].startPoint;
                  final endPoint =
                      state.ibProgramsModel.programData![i].endPoint == null
                          ? ""
                          : state.ibProgramsModel.programData![i].endPoint;

                  // final image = image[0];
                  final duration =
                      state.ibProgramsModel.programData![i].duration == null
                          ? ""
                          : state.ibProgramsModel.programData![i].duration;
                  final onlinePercent =
                      state.ibProgramsModel.programData![i].onlinePercent ==
                              null
                          ? ""
                          : state.ibProgramsModel.programData![i].onlinePercent;

                  final minGuest =
                      state.ibProgramsModel.programData![i].maxGuest == null
                          ? ""
                          : state.ibProgramsModel.programData![i].maxGuest;
                  final maxGuest =
                      state.ibProgramsModel.programData![i].maxGuest == null
                          ? ""
                          : state.ibProgramsModel.programData![i].maxGuest;
                  final maxAge =
                      state.ibProgramsModel.programData![i].maxAge == null
                          ? ""
                          : state.ibProgramsModel.programData![i].maxAge;

                  // final image = image[0];
                  final minAge =
                      state.ibProgramsModel.programData![i].minAge == null
                          ? ""
                          : state.ibProgramsModel.programData![i].minAge;
                  final reportingTime =
                      state.ibProgramsModel.programData![i].reportingTime ==
                              null
                          ? ""
                          : state.ibProgramsModel.programData![i].reportingTime;

                  final rules =
                      state.ibProgramsModel.programData![i].rules == null
                          ? ""
                          : state.ibProgramsModel.programData![i].rules;
                  final notes =
                      state.ibProgramsModel.programData![i].notes == null
                          ? ""
                          : state.ibProgramsModel.programData![i].notes;
                  final coverImage =
                      state.ibProgramsModel.programData![i].coverImage == null
                          ? ""
                          : state.ibProgramsModel.programData![i].coverImage;
                  ///////////////////////////////////////////////////
                  final bookingAvailabilityindian = state.ibProgramsModel
                              .programData![i].bookingAvailability!.indian ==
                          null
                      ? ""
                      : state.ibProgramsModel.programData![i]
                          .bookingAvailability!.indian;
                  final bookingAvailabilityforeigner = state.ibProgramsModel
                              .programData![i].bookingAvailability!.foreigner ==
                          null
                      ? ""
                      : state.ibProgramsModel.programData![i]
                          .bookingAvailability!.foreigner;
                  final bookingAvailabilitychildren = state.ibProgramsModel
                              .programData![i].bookingAvailability!.children ==
                          null
                      ? ""
                      : state.ibProgramsModel.programData![i]
                          .bookingAvailability!.children;
                  final cottagemaxExtraGuestCount = state.ibProgramsModel
                              .programData![i].cottage!.maxExtraGuestCount ==
                          null
                      ? ""
                      : state.ibProgramsModel.programData![i].cottage!
                          .maxExtraGuestCount;
                  final cottagemaxExtraIndianCount = state.ibProgramsModel
                              .programData![i].cottage!.maxExtraIndianCount ==
                          null
                      ? ""
                      : state.ibProgramsModel.programData![i].cottage!
                          .maxExtraIndianCount;
                  final cottagemaxExtraForeignerCount = state
                              .ibProgramsModel
                              .programData![i]
                              .cottage!
                              .maxExtraForeignerCount ==
                          null
                      ? ""
                      : state.ibProgramsModel.programData![i].cottage!
                          .maxExtraForeignerCount;
                  final cottagemaxExtraChildrenCount = state.ibProgramsModel
                              .programData![i].cottage!.maxExtraChildrenCount ==
                          null
                      ? ""
                      : state.ibProgramsModel.programData![i].cottage!
                          .maxExtraChildrenCount;
                  final activities1 = state.ibProgramsModel.programData![i]
                              .cottage!.activities!.length ==
                          0
                      ? ""
                      : state.ibProgramsModel.programData![i].cottage!
                          .activities![i];
                  final activities2 = state.ibProgramsModel.programData![0]
                              .cottage!.activities!.length ==
                          2
                      ? state.ibProgramsModel.programData![i].cottage!
                          .activities![1]
                      : "";
                  final activities3 = state.ibProgramsModel.programData![i]
                              .cottage!.activities!.length ==
                          3
                      ? state.ibProgramsModel.programData![i].cottage!
                          .activities![2]
                      : "";
                  final activities4 = state.ibProgramsModel.programData![i]
                              .cottage!.activities!.length ==
                          4
                      ? ""
                      : state.ibProgramsModel.programData![i].cottage!
                          .activities![3];

////////////////////////////////////
                  final photos =
                      state.ibProgramsModel.programData![i].photos!.length == 0
                          ? ""
                          : state.ibProgramsModel.programData![i].photos![0];

                  if (description!.isEmpty || description.isEmpty) {
                    return;
                  }

                  // List list = [
                  Map data = {
                    'started': started,
                    'isCottage': isCottage,
                    'status': status,
                    '_id': _id,
                    'category': category,
                    'caption': caption,
                    'progName': progName,
                    'description': description,
                    'startPoint': startPoint,
                    'endPoint': endPoint,
                    'duration': duration,
                    'onlinePercent': onlinePercent,
                    'minGuest': minGuest,
                    'maxGuest': maxGuest,
                    'maxAge': maxAge,
                    'minAge': minAge,
                    'reportingTime': reportingTime,
                    'rules': rules,
                    'notes': notes,
                    'coverImage': coverImage,
                    'photos': photos,
                    'bookingAvailabilityindian': bookingAvailabilityindian,
                    'bookingAvailabilityforeigner':
                        bookingAvailabilityforeigner,
                    'bookingAvailabilitychildren': bookingAvailabilitychildren,
                    'cottagemaxExtraGuestCount': cottagemaxExtraGuestCount,
                    'cottagemaxExtraIndianCount': cottagemaxExtraIndianCount,
                    'cottagemaxExtraForeignerCount':
                        cottagemaxExtraForeignerCount,
                    'cottagemaxExtraChildrenCount':
                        cottagemaxExtraChildrenCount,
                    'activities1': activities1,
                    'activities2': activities2,
                    'activities3': activities3,
                    'activities4': activities4,
                  };
                  print(data);
                  addIBprogramsdata(data);

                  Fluttertoast.showToast(
                    msg: "Downloading Ib Programs",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                  );

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssestsHomePage()));
                }
              }
            })
          ],
        ),
      ),
    );
  }

  Widget theDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: const BoxDecoration(
                color: Color(0xfff68D389),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    SizedBox(
                      width: 120,
                      height: 80,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              )),
          Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  "Home",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text(
                  "Profile",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IcViewUnits()));
                },
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  "View Units",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  "####",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                  leading: const Icon(Icons.all_inbox, color: Colors.white),
                  title: const Text(
                    "All Reports",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              ListTile(
                onTap: () {
                  PrefManager.clearToken();

                 Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                },
                leading: const Icon(Icons.logout_outlined, color: Colors.white),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
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
}
