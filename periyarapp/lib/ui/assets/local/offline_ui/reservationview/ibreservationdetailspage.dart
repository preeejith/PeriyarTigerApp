//////main data to upload ///real page

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationbloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationbloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationstate.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/additionalupload/reservationdatafetchebloc.dart';

import 'package:parambikulam/bloc/assets/localbloc/ibreservationdeletebloc.dart';

import 'package:parambikulam/bloc/assets/localbloc/ibreservationdetailsbloc.dart';

import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/ibreservationdetailsmain.dart';

import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservationcompletedata.dart';

////
class ReservationDetails extends StatefulWidget {
  const ReservationDetails({Key? key}) : super(key: key);

  @override
  State<ReservationDetails> createState() => _ReservationDetailsState();
}

class _ReservationDetailsState extends State<ReservationDetails> {
  @override
  void initState() {
    BlocProvider.of<Ibreservation2datauploadBloc>(context)
        .add(RefreshIbreservation2datauploadData());

    fetcher();
    super.initState();
  }

  void fetcher() {
    BlocProvider.of<Ibreservation2datauploadBloc>(context)
        .add(GetIbreservation2datauploadData());

    setState(() {});
  }

  List<String> ibprogramlist = [];
  // void fetcher2() async {
  //   BlocProvider.of<IBReservationdatauploadBloc>(context)
  //       .add(GetIbreservationdatauploadData());
  // }
  bool? uploadcount = true;
  var newdate;
  bool? checkok;
  var d1 = new DateFormat('dd-MMM-yyyy');
  var d2 = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.sss'Z'");
  int? roomcount;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ReservationmainPage()),
            (Route<dynamic> route) => false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("RESERVATION DETAILS"), actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    print("yes");

                    // BlocProvider.of<IBProgramdeleteBloc>(context)
                    //     .add(GetIbdeleteData());

                    // BlocProvider.of<IBReservationdatauploadBloc>(context)
                    //     .add(GetIbreservationdatauploadData());

                    datasync2();
                  },
                  icon: Icon(Icons.sync_outlined),
                ),
              ],
            ),
          ]),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocConsumer<Ibreservation2datauploadBloc,
                    StateIbreservation2dataupload>(builder: (context, state) {
                  if (state is ReservationdataRecived) {
                    return state.items4!.length == 0
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text("No Result Found")),
                          )
                        : Column(
                            children: [
//                               BlocConsumer<IBReservationdataupload2Bloc,
//                                       StateIbReservationdataupload2>(
//                                   builder: (context, state) {
//                                 if (state is Reservationdata2Uploaded) {
//                                   return Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                   );
//                                 } else {
//                                   return Container();
//                                 }
//                               }, listener: (context, state) {
//                                 if (state is Reservationdata2Uploaded) {
//                                   if (state.items8!.isNotEmpty) {
//                                     for (int i = 0;
//                                         i < state.items8!.length;
//                                         i++) {
//                                       BlocProvider.of<
//                                                   GetIbReservationDetailedsBloc>(
//                                               context)
//                                           .add(IbReservationDetailedEvent(
//                                         programme: state.items8![i]
//                                             ['programid'],
//                                         slotDetail: state.items8![i]
//                                             ['slotdetailsid'],
//                                         bookingDate: state.items8![i]
//                                             ['bookingdate'],
//                                         numberOfRooms: state.items8![i]
//                                             ['numberofRooms'],
//                                         guestName: state.items8![i]
//                                             ['guestname'],
//                                         numberOfAccompanyigPersons:
//                                             state.items8![i]
//                                                 ['numberofpersonaccompanying'],
//                                         guestPhone: state.items8![i]
//                                             ['guestphone'],
//                                         referee: state.items8![i]['reference'],
//                                         refereePhone: state.items8![i]
//                                             ['referencephone'],
//                                         email: state.items8![i]['email'],
//                                         foodPreference: state.items8![i]
//                                             ['foodpreference'],
//                                         numberOfVehicles: state.items8![i]
//                                             ['numberofVehicle'],
//                                         vehicleNumbers: state.items8![i]
//                                             ['vehicleNumbers'],
//                                         details: state.items8![i]['details'],
//                                       ));

//                                       ///it changes to online download online
//                                       ///data to local reservation list
//                                       ///

//                                       // final reservedcount = state.items8![i]
//                                       //             ['numberofRooms'] ==
//                                       //         null
//                                       //     ? ""
//                                       //     : state.items8![i]['numberofRooms'];

//                                       // final status = "";

//                                       // final foodprefered = state.items8![i]
//                                       //             ['foodpreference'] ==
//                                       //         null
//                                       //     ? ""
//                                       //     : state.items8![i]['foodpreference'];

//                                       // final vehicleno = state.items8![i]
//                                       //             ['vehicleNumbers'] ==
//                                       //         null
//                                       //     ? ""
//                                       //     : state.items8![i]['vehicleNumbers'];

//                                       // final bookingid = "";

//                                       // final bookingdate = state.items8![i]
//                                       //             ['bookingdate'] ==
//                                       //         null
//                                       //     ? ""
//                                       //     : state.items8![i]['bookingdate'];

//                                       // final slotid = state.items8![i]
//                                       //             ['slotdetailsid'] ==
//                                       //         null
//                                       //     ? ""
//                                       //     : state.items8![i]['slotdetailsid'];
//                                       // final slotprogramid =
//                                       //     state.items8![i]['programid'] == null
//                                       //         ? ""
//                                       //         : state.items8![i]['programid'];
//                                       // final programName = "Hello";
//                                       // //  ==
//                                       // //         null
//                                       // //     ? ""
//                                       // //     : ibGetReservationDataModel
//                                       // //         .data![j].slotDetail!.slot!.programme!.progName;

//                                       // final programid =
//                                       //     state.items8![i]['programid'] == null
//                                       //         ? ""
//                                       //         : state.items8![i]['programid'];

//                                       // final guestName =
//                                       //     state.items8![i]['guestname'] == null
//                                       //         ? ""
//                                       //         : state.items8![i]['guestname'];

//                                       // final noofCompaningPerson = state
//                                       //                 .items8![i][
//                                       //             'numberofpersonaccompanying'] ==
//                                       //         null
//                                       //     ? ""
//                                       //     : state.items8![i]
//                                       //         ['numberofpersonaccompanying'];

//                                       // final guestPhone =
//                                       //     state.items8![i]['guestphone'] == null
//                                       //         ? ""
//                                       //         : state.items8![i]['guestphone'];

//                                       // final refered =
//                                       //     state.items8![i]['reference'] == null
//                                       //         ? ""
//                                       //         : state.items8![i]['reference'];

//                                       // final referedPhone = state.items8![i]
//                                       //             ['referencephone'] ==
//                                       //         null
//                                       //     ? ""
//                                       //     : state.items8![i]['referencephone'];

//                                       // final email =
//                                       //     state.items8![i]['email'] == null
//                                       //         ? ""
//                                       //         : state.items8![i]['email'];

//                                       // final noofVehicles = state.items8![i]
//                                       //             ['numberofVehicle'] ==
//                                       //         null
//                                       //     ? ""
//                                       //     : state.items8![i]['numberofVehicle'];

//                                       // final details =
//                                       //     state.items8![i]['details'] == null
//                                       //         ? ""
//                                       //         : state.items8![i]['details'];
//                                       // final edited = "false";
//                                       ///final removed="false";

//                                       // if (slotid!.isEmpty || slotid.isEmpty) {
//                                       //   return null;
//                                       // } else {
//                                       //   Map data = {
//                                       //     'reservedcount': reservedcount,
//                                       //     'status': status,
//                                       //     'foodprefered': foodprefered,
//                                       //     'vehicleno': vehicleno,
//                                       //     'bookingid': bookingid,
//                                       //     'bookingdate': bookingdate,
//                                       //     'slotid': slotid,
//                                       //     'slotprogramid': slotprogramid,
//                                       //     'programName': programName,
//                                       //     'programid': programid,
//                                       //     'guestName': guestName,
//                                       //     'NoofCompaningPerson':
//                                       //         noofCompaningPerson,
//                                       //     'guestPhone': guestPhone,
//                                       //     'refered': refered,
//                                       //     'referedPhone': referedPhone,
//                                       //     'email': email,
//                                       //     'noofVehicles': noofVehicles,
//                                       //     'details': details,
//                                       //     'edited': edited,
//                                       // 'removed':removed
//                                       //   };
//                                       //   print(data);
//                                       //   getonlineresevationdata(data);
//                                       // }

// ///////for testing

//                                       Fluttertoast.showToast(
//                                           backgroundColor: Colors.white,
//                                           msg: "Data Uploading",
//                                           textColor: Colors.black);
//                                     }
//                                   } else {
//                                     Fluttertoast.showToast(
//                                         backgroundColor: Colors.white,
//                                         msg: "No Data Available for Upload",
//                                         textColor: Colors.black);
//                                   }
//                                 }
//                               }),
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: state.items4!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: ListTile(
                                          title: InkWell(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.white10,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                spreadRadius: 4,
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
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
                                                                ibprogramlist
                                                                            .length ==
                                                                        0
                                                                    ? ""
                                                                    : ibprogramlist[
                                                                        index],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        14,
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
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                              Text(
                                                                state.items4![
                                                                        index][
                                                                    'guestname'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              )
                                                            ]),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Row(children: [
                                                          Text(
                                                            "Selected Date: ",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            d1.format(DateTime.parse(
                                                                state.items4![
                                                                        index][
                                                                    'bookingdate'])),
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          )
                                                        ]),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Row(children: [
                                                          Text(
                                                            "Referred Person: ",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            state.items4![index]
                                                                ['reference'],
                                                            style: TextStyle(
                                                                fontSize: 14),
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
                                                        style: TextStyle(
                                                            fontSize: 9),
                                                      ),
                                                      onPressed: () {
                                                        // deletereservationdata(state
                                                        //     .items4![index]['id']
                                                        //     .toString());

                                                        // d2.format(DateTime.parse(state
                                                        //     .items4![index]['bookingdate']));

                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              // title: Text('Welcome'),
                                                              content: Text(
                                                                  'Do you want to remove this reservation'),
                                                              actions: [
                                                                MaterialButton(
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  onPressed:
                                                                      () {
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
                                                                      Colors
                                                                          .black,
                                                                  onPressed:
                                                                      () {
                                                                    newdate = state
                                                                            .items4![index]
                                                                        [
                                                                        'bookingdate'];
                                                                    checkok =
                                                                        true;
                                                                    for (int i =
                                                                            0;
                                                                        i < state.items5!.length;
                                                                        i++) {
                                                                      if (state.items5![i]
                                                                              [
                                                                              'slotprogramid'] ==
                                                                          state.items4![index]
                                                                              [
                                                                              'programid']) {
                                                                        print(
                                                                            "check ok");
                                                                        if ((DateTime.parse(state.items5![i]['bookingDate'].toString())) ==
                                                                            DateTime.parse(newdate)) {
                                                                          print(
                                                                              'helo');
                                                                          if (state.items5![i]['reserveno'] ==
                                                                              state.items4![index]['numberofRooms']) {
                                                                            if (checkok ==
                                                                                true) {
                                                                              print('deleted');
                                                                              deletegetreservationdata(int.parse(state.items5![i]['id'].toString()));
                                                                              checkok = false;

                                                                              deletereservationdata(state.items4![index]['id'].toString());
                                                                            }

                                                                            print("object");
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
                              Container(
                                child: BlocConsumer<
                                        GetIbReservationDetailedsBloc,
                                        IbReservationDetailedsState>(
                                    builder: (context, state) {
                                  if (state is IbReservationDetailedssuccess) {
                                    ///changes

                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                    );
                                  } else {
                                    return Center();
                                  }
                                }, listener: (context, state) {
                                  if (state is IbReservationDetailedssuccess) {
                                    BlocProvider.of<IBReservationdeleteBloc>(
                                            context)
                                        .add(GetIbreservationdatadeleteData());

                                    BlocProvider.of<GetIBGetReservationsBloc>(
                                            context)
                                        .add(GetIBGetReservationsEvent());
                                    Fluttertoast.showToast(
                                        backgroundColor: Colors.white,
                                        msg: "Data Uploaded Succefully",
                                        textColor: Colors.black);

                                    ///
                                    fetcher();

///////to added to the reservation list
                                    ///

                                  } else if (state is IbReservationError) {
                                    // BlocProvider.of<IBReservationdeleteBloc>(context)
                                    //     .add(GetIbreservationdatadeleteData());
                                    Fluttertoast.showToast(
                                        backgroundColor: Colors.white,
                                        msg: state.error,
                                        textColor: Colors.black);
                                  }
                                }),
                              ),
                            ],
                          );
                  } else {
                    return Center();
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

                    state.items4!.length == 0
                        ? uploadcount = false
                        : uploadcount = true;
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void datasync2() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 60,
            child: Column(children: [
              InkWell(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Upload Data'), Icon(Icons.upload)]),
                onTap: () {
                  ///for geting the reserved data
                  ///
                  ///
                  uploadcount == true
                      ? BlocProvider.of<IBReservationdataupload2Bloc>(context)
                          .add(GetIbreservationdataupload2Data())
                      : Fluttertoast.showToast(
                          backgroundColor: Colors.white,
                          msg: "No Data Available for Upload",
                          textColor: Colors.black);
                  print('bloc called');

                  ///old for upload
                  // BlocProvider.of<IBReservationdatauploadBloc>(context)
                  //     .add(GetIbreservationdatauploadData());

                  ////////for deleing the reserved data after use
                  // BlocProvider.of<IBReservationdeleteBloc>(context)
                  //     .add(GetIbreservationdatadeleteData());
                  //for import new data
                  // fetcher2();

                  setState(() {
                    Navigator.pop(context);
                    // fetcher();
                  });
                },
              ),
            ]),
          ),
        );
      },
    );

    setState(() {});
  }
}
