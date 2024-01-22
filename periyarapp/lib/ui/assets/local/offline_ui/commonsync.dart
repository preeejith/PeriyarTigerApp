import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationbloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationbloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationstate.dart';
import 'package:parambikulam/bloc/assets/assetseditbloc/assetseditbloc.dart';
import 'package:parambikulam/bloc/assets/assetseditbloc/assetseditevent.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/uploadattendancebloc/uploadattendancebloc.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/uploadattendancebloc/uploadattendanceevent.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/uploadattendancebloc/uploadattendancestate.dart';
import 'package:parambikulam/bloc/assets/haltbloc/uploadhaltbloc/uploadhaltbloc.dart';
import 'package:parambikulam/bloc/assets/haltbloc/uploadhaltbloc/uploadhaltevent.dart';
import 'package:parambikulam/bloc/assets/haltbloc/uploadhaltbloc/uploadhaltstate.dart';
import 'package:parambikulam/bloc/assets/ic_viewunitsbloc/ic_viewunitsbloc.dart';
import 'package:parambikulam/bloc/assets/ic_viewunitsbloc/ic_viewunitsevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignbloc/employeeassignbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignbloc/employeeassignevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignbloc/employeeassignstate.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignunitbloc/employeeassign_blocunit.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignunitbloc/employeeassign_eventunit.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignunitbloc/employeeassign_stateunit.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/addproductbloc/addproductbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/addproductbloc/addproductevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/addproductbloc/addproductstate.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendancedatafetchingbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/commonsyncbloc/commonsyncbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/commonsyncbloc/commonsynchaltbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/commonsyncbloc/commonuploadattendancebloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibreservationdeletebloc.dart';

import 'package:parambikulam/bloc/assets/new/addassetsmainbloc/addassetsmainbloc.dart';
import 'package:parambikulam/bloc/assets/new/addassetsmainbloc/addassetsmainevent.dart';
import 'package:parambikulam/bloc/assets/new/addassetsmainbloc/addassetsmainstate.dart';
import 'package:parambikulam/bloc/assets/new/transferstockupdationbloc/transferstock_blocupdation.dart';
import 'package:parambikulam/bloc/assets/new/transferstockupdationbloc/transferstock_eventupdation.dart';
import 'package:parambikulam/bloc/assets/new/transferstockupdationbloc/transferstock_stateupdation.dart';
import 'package:parambikulam/bloc/assets/new/trasnferwithrequestbloc/transferwithrequest_blocmain.dart';
import 'package:parambikulam/bloc/assets/new/trasnferwithrequestbloc/transferwithrequest_eventmain.dart';
import 'package:parambikulam/bloc/assets/new/trasnferwithrequestbloc/transferwithrequest_statemain.dart';

import 'package:parambikulam/bloc/assetsbloc_withoutrequest/assetsbloc_withoutrequest.dart';
import 'package:parambikulam/bloc/assetsbloc_withoutrequest/assetsevent_withoutrequest.dart';
import 'package:parambikulam/bloc/assetsbloc_withoutrequest/assetsstate_withoutrequest.dart';

import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';
import 'package:parambikulam/ui/assets/bottomnav.dart';
import 'package:parambikulam/ui/assets/ic_main/attendance/viewattentance.dart';
import 'package:parambikulam/ui/assets/ic_main/halt/haltdetails.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

//////
class CommonSyncPage extends StatefulWidget {
  const CommonSyncPage({Key? key}) : super(key: key);

  @override
  State<CommonSyncPage> createState() => _CommonSyncPageState();
}

class _CommonSyncPageState extends State<CommonSyncPage> {
  late String _currentDate;
/////
  late List newList;
/////for taking the count
  List items24 = [];
  List items26 = [];
  List items27 = [];
  List items25 = [];
  List items22 = [];
  List items23 = [];
  List items21 = [];
  List items4 = [];
  List items9 = [];
  List items13 = [];
  int? count24 = 0;
  int? count26 = 0;
  int? count27 = 0;
  int? count25 = 0;
  int? count22 = 0;
  int? count23 = 0;
  int? count21 = 0;
  int? count4 = 0;
  int? count9 = 0;
  int? count13 = 0;
  int? count33 = 0;
  int? totalprogresscheck;
  num? a = 0;
  num? b = 0;
  num? c = 0;
  bool? haltdataalready = false;
  bool? interneton = false;
  bool? uploadbuttonon = false;
  bool? attendancedatealready = false;
  bool? reservationuploaded = false;
  bool? haltdateuploaded = false;
  bool? attendancedateuploaded = false;
  bool? stopuploading = false;

  int? reservationlength = 0;
  int? attendancelength = 1;
  int? haltlength = 1;
  bool? employeeunit = true;
  bool? transferwithrequest = true;
  bool? addproduct = true;
  bool? stocktransfer = true;
  bool? employeeassign = true;
  bool? assetswithtrasnfer = true;
  bool? refreshon = true;
  bool? addassetmain = true;
  bool? reservation = true;
  bool? attendance = true;
  bool? halt = true;

  bool? transferrequest = true;

  List<AttendanceDetailsModel> attendancedetailslist = [];
  List<Halt2UploadModel> halt2uploadlist = [];
  List<AttendanceUploadModel> attendanceuploadlist = [];
  double? progress = 0.0;

  String currentDate() {
    var now = new DateTime.now().subtract(Duration(days: 1));
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    fetcher();
    testinternet();

    BlocProvider.of<MarkAttendanceOfflineBloc>(context)
        .add(GetMarkAttendanceData());

    _currentDate = currentDate();

    //  _currentDate = "2022-04-18";

    setState(() {});
  }

  void testinternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      interneton = false;
    } else if (connectivityResult != ConnectivityResult.none) {
      interneton = true;
    }
  }

  void fetcher() async {
    BlocProvider.of<GetEmployeeAssignBloc>(context).add(RefreshBlocEvent());

    BlocProvider.of<GetAddProductMainBloc>(context)
        .add(RefreshAddProductMain());

    BlocProvider.of<GetTransferStockUpdationBloc>(context)
        .add(RefreshTransferStockUpdation());
    BlocProvider.of<GetEmployeeUnitAssignBloc>(context)
        .add(RefreshEmployeeUnitAssign());

    BlocProvider.of<GetAssetsWithoutRequestBloc>(context)
        .add(RefreshAssetsWithoutRequest());
/////////
    DatabaseHelper? db = DatabaseHelper.instance;
    items24 = await db.getICEmployeeeAssignListDownloadData();
    items26 = await db.getICNewRequestTransferListDownloadData();
    items27 = await db.getICAddProductListDownloadData();
    items25 = await db.getICStockUpdateTransferListDownloadData();
    items22 = await db.getICUnitsAssignListDownloadData();
    items23 = await db.getICAssetsTrasnferListDownloadData();
    items21 = await db.getICAddAssetsListDownloadData();
    List items4 = await getAllReservationdata();
    List items9 = await getAllMarkedAttendancedata();
    List items13 = await getAllHaltDetailsdata();
    List items33 = await db.getICDamageacceptedListDownloadData();
    if (items24.isNotEmpty) {
      count24 = items24.length;
      print(count24.toString());
    }

    if (items26.isNotEmpty) {
      count26 = items26.length;
      print(count26.toString());
    }

    if (items27.isNotEmpty) {
      count27 = items27.length;
      print(count27.toString() + "gf");
    }
    if (items25.isNotEmpty) {
      count25 = items25.length;
      print(count25.toString() + "gf");
    }

    if (items22.isNotEmpty) {
      count22 = items22.length;
      print(count22.toString() + "gf");
    }

    if (items23.isNotEmpty) {
      count23 = items23.length;
      print(count23.toString() + "gf");
    }

    if (items21.isNotEmpty) {
      count21 = items21.length;
      print(count21.toString() + "gf33");
    }
    if (items4.isNotEmpty) {
      count4 = items4.length;
      print(count4.toString() + "reservation");
    }
    if (items9.isNotEmpty) {
      count9 = 1;
      print(count9.toString() + "attendance");
    }
    if (items13.isNotEmpty) {
      count13 = 1;
      print(count13.toString() + "halt");
    }

    if (items33.isNotEmpty) {
      count33 = items33.length;
      print(count33.toString() + "Damage");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Offline Data"), actions: [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: AssetImage(
            "assets/bgptrr.png",
          ),
          backgroundColor: Colors.transparent,
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 6,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  count4 != 0
                      ? Text("Total Reservation:" + count4.toString())
                      : SizedBox(),
                  count4 != 0
                      ? SizedBox(
                          height: 2,
                        )
                      : SizedBox(),
                  count9 != 0
                      ? Text("Attendance:" + count9.toString())
                      : SizedBox(),
                  count9 != 0
                      ? SizedBox(
                          height: 2,
                        )
                      : SizedBox(),
                  count13 != 0
                      ? Text("Halt:" + count13.toString())
                      : SizedBox(),
                  count13 != 0
                      ? SizedBox(
                          height: 2,
                        )
                      : SizedBox(),
                  count23 != 0
                      ? Text("Asset Transfer:" + count23.toString())
                      : SizedBox(),
                  count23 != 0
                      ? SizedBox(
                          height: 2,
                        )
                      : SizedBox(),
                  count21 != 0
                      ? Text("Add Assets:" + count21.toString())
                      : SizedBox(),
                  count21 != 0
                      ? SizedBox(
                          height: 2,
                        )
                      : SizedBox(),
                  count24 != 0
                      ? Text("Employee Assign:" + count24.toString())
                      : SizedBox(),
                  count24 != 0
                      ? SizedBox(
                          height: 2,
                        )
                      : SizedBox(),
                  count26 != 0
                      ? Text("New Request Trasnfer:" + count26.toString())
                      : SizedBox(),
                  count26 != 0
                      ? SizedBox(
                          height: 2,
                        )
                      : SizedBox(),
                  count27 != 0
                      ? Text("Add Product:" + count27.toString())
                      : SizedBox(),
                  count27 != 0
                      ? SizedBox(
                          height: 2,
                        )
                      : SizedBox(),
                  count25 != 0
                      ? Text("Stock Updation Transfer:" + count25.toString())
                      : SizedBox(),
                  count25 != 0
                      ? SizedBox(
                          height: 2,
                        )
                      : SizedBox(),
                  count22 != 0
                      ? Text("Unit Employee Assign:" + count22.toString())
                      : SizedBox(),
                  // count33 != 0
                  //     ? Text("Damage Accepted:" + count33.toString())
                  //     : SizedBox(),
                  // count33 != 0
                  //     ? SizedBox(
                  //         height: 2,
                  //       )
                  //     : SizedBox(),
                ],
              )),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            BlocListener<GetAddAssetsmainBloc, AddAssetsmainState>(
              listener: ((context, addassetsstate) {
                if (addassetsstate is AddAssetsmainsuccess) {
                  print("Sucesss7");
                  setState(() {
                    stopuploading = true;
                    progress = 0.6;
                  });

                  addassetmain == true
                      ? BlocProvider.of<CommonDatauploadBloc>(context)
                          .add(GetCommonDataUpload())
                      : SizedBox();

                  addassetmain == true
                      ? BlocProvider.of<GetIbReservationDetailedsBloc>(context)
                          .add(EditIbReservationEvent())
                      : SizedBox();
                  addassetmain = false;
                }

                // else if (addassetsstate is RefreshAssests) {
                //   SchedulerBinding.instance!.addPostFrameCallback((_) {
                //     refreshon == true
                //         ? transferwithrequest == true
                //             ? BlocProvider.of<CommonDatauploadBloc>(context)
                //                 .add(GetCommonDataUpload())
                //             : SizedBox()
                //         : SizedBox();

                //     refreshon = false;
                //   });
                // }
              }),
              child: BlocListener<GetAssetsWithoutRequestBloc,
                  AssetsWithoutRequestState>(
                listener: ((context, assettrasnferstate) {
                  if (assettrasnferstate is AssetsWithoutRequestsuccess) {
                    print("Sucesss6");

                    assetswithtrasnfer == true
                        ? BlocProvider.of<GetAddAssetsmainBloc>(context)
                            .add(FetchAddAssetsmain())
                        : SizedBox();
/////to syn
                    assetswithtrasnfer = false;
                    setState(() {
                      progress = 0.5;
                    });

                    BlocProvider.of<GetAssetsWithoutRequestBloc>(context)
                        .add(RefreshAssetsWithoutRequest());
                  }
                }),
                child: BlocListener<GetEmployeeUnitAssignBloc,
                    EmployeeUnitAssignState>(
                  listener: ((context, emplyunitstate) {
                    if (emplyunitstate is EmployeeUnitAssignsuccess) {
                      employeeunit == true ? print("Sucesss5") : SizedBox();

                      employeeunit = false;
                      BlocProvider.of<GetAssetsWithoutRequestBloc>(context)
                          .add(FetchAssetsWithoutRequest());

                      context
                          .read<GetEmployeeUnitAssignBloc>()
                          .add(RefreshEmployeeUnitAssign());
                      setState(() {
                        progress = 0.4;
                      });

                      BlocProvider.of<GetEmployeeUnitAssignBloc>(context)
                          .add(RefreshEmployeeUnitAssign());
                    }
                  }),
                  child:
                      BlocListener<GetEmployeeAssignBloc, EmployeeAssignState>(
                    listenWhen: (previous, current) =>
                        current is EmployeeAssignsuccess,
                    listener: ((context, employeeasssignstate) {
                      if (employeeasssignstate is EmployeeAssignsuccess) {
                        print("Sucesss4");
                        employeeassign == true
                            ? BlocProvider.of<GetEmployeeUnitAssignBloc>(
                                    context)
                                .add(TaskEmployeeUnitAssign())

                            //  BlocProvider.of<GetEmployeeUnitAssignBloc>(
                            //         context)
                            //     .add(FetchEmployeeUnitAssign())
                            : SizedBox();
////to

                        employeeassign == true
                            ? BlocProvider.of<GetIcViewUnitsBloc>(context)
                                .add(GetIcViewUnitsEvent())
                            : SizedBox();

                        employeeassign = false;

                        setState(() {
                          progress = 0.4;

                          BlocProvider.of<GetEmployeeAssignBloc>(context)
                              .add(RefreshBlocEvent());
                        });
                      } else {
                        print("cecece");
                      }
                    }),
                    child: BlocListener<GetTransferStockUpdationBloc,
                        TransferStockUpdationState>(
                      listener: ((context, transferstate) {
                        if (transferstate is TransferStockUpdationsuccess) {
                          print("Sucesss3");
                          stocktransfer == true
                              ? BlocProvider.of<GetEmployeeAssignBloc>(context)
                                  .add(FetchEmployeeAssign())
                              : SizedBox();
/////chnage
                          stocktransfer == true
                              ? BlocProvider.of<GetAssetsEditDetailedsBloc>(
                                      context)
                                  .add(FetchAssetsEditDetailedEvent())
                              : SizedBox();
                          stocktransfer = false;

                          setState(() {
                            progress = 0.3;
                          });
//
                          BlocProvider.of<GetTransferStockUpdationBloc>(context)
                              .add(RefreshTransferStockUpdation());
                        }
                      }),
                      child: BlocListener<GetAddProductMainBloc,
                          AddProductMainState>(
                        listener: ((context, addproductstate) {
                          if (addproductstate is AddProductMainsuccess) {
                            print("Sucesss2");
//////some problems
                            addproduct == true
                                ? BlocProvider.of<GetTransferStockUpdationBloc>(
                                        context)
                                    .add(FetchTransferStockUpdation())
                                : SizedBox();
                            addproduct = false;
                            setState(() {
                              progress = 0.2;
                            });
////
                            BlocProvider.of<GetAddProductMainBloc>(context)
                                .add(RefreshAddProductMain());
                          }
                        }),
                        child: BlocListener<GetTransferwithRequestBloc,
                            TransferwithRequestState>(
                          listener: ((context, tranferstate) {
                            if (tranferstate is TransferwithRequestsuccess) {
                              print("Sucesss1");
                              transferwithrequest == true
                                  ? BlocProvider.of<GetAddProductMainBloc>(
                                          context)
                                      .add(FetchAddProductMain())
                                  : SizedBox();

                              transferwithrequest = false;
                              setState(() {
                                progress = 0.1;
                              });
                            }
                          }),
                          child: Center(
                            child: MaterialButton(
                              color: Colors.green,
                              child: Text("UPLOAD ALL"),
                              onPressed: () async {
                                testinternet();
                                uploadbuttonon = true;
                                interneton != true
                                    ? Fluttertoast.showToast(
                                        backgroundColor: Colors.white,
                                        msg:
                                            "No Internet connection for Upload",
                                        textColor: Colors.black)
                                    : BlocProvider.of<
                                            GetTransferwithRequestBloc>(context)
                                        .add(FetchTransferwithRequest());

                                /////////////////////start/////////
                                ///for transfering new request
                                // BlocProvider.of<GetTransferwithRequestBloc>(context)
                                //     .add(FetchTransferwithRequest());
                                // setState(() {
                                //   progress = 0.1;
                                // });
                                // /////for uploading addproduct
                                // // BlocProvider.of<GetAddProductMainBloc>(context)
                                // //     .add(FetchAddProductMain());
                                // setState(() {
                                //   progress = 0.2;
                                // });
                                // //for uploading the stock updationrequest stock
                                // BlocProvider.of<GetTransferStockUpdationBloc>(
                                //         context)
                                //     .add(FetchTransferStockUpdation());
                                // setState(() {
                                //   progress = 0.3;
                                // });
                                // //for uploading the stock updationrequest stock
                                // // // BlocProvider.of<GetTransferStockUpdationBloc>(context)
                                // ////     .add(FetchTransferStockUpdation());

                                // //for uploading employeedata
                                // // BlocProvider.of<GetEmployeeAssignBloc>(context)
                                // //     .add(FetchEmployeeAssign());

                                // setState(() {
                                //   progress = 0.4;
                                // });

                                // /////here

                                // ///assignemployeefrm units
                                // // BlocProvider.of<GetEmployeeUnitAssignBloc>(context)
                                // //     .add(FetchEmployeeUnitAssign());

                                // setState(() {
                                //   progress = 0.6;
                                // });

                                // // BlocProvider.of<GetAssetsWithoutRequestBloc>(context)
                                // //     .add(FetchAssetsWithoutRequest());

                                // setState(() {
                                //   progress = 0.8;
                                // });

                                // BlocProvider.of<GetAddAssetsmainBloc>(context)
                                //     .add(FetchAddAssetsmain());
                                // print("done");

                                // setState(() {
                                //   progress = 1.0;
                                // });

                                // BlocProvider.of<CommonDatauploadBloc>(context)
                                //     .add(GetCommonDataUpload());
                                // print("okok");

                                // BlocProvider.of<CommonHaltUploadBloc>(context)
                                //     .add(GetCommonHaltUploadData());

                                // BlocProvider.of<CommonAttendanceUploadBloc>(context)
                                //     .add(GetCommonAttendanceUploadData());
                                /////////////////////end/////////
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => CustomerBottomNavigation()));
                                /////special uploadstart///
                                ////for uploading employeedata
                                // BlocProvider.of<GetEmployeeAssignBloc>(context)
                                //     .add(FetchEmployeeAssign());

                                // BlocProvider.of<GetAssetsWithoutRequestBloc>(context)
                                //     .add(FetchAssetsWithoutRequest());
                                // /////special uploadend///

                                // reservationlength == 0
                                //     ? SizedBox()
                                //     : BlocProvider.of<CommonDatauploadBloc>(context)
                                //         .add(GetCommonDataUpload());

                                // haltdataalready == true
                                //     ? SizedBox()
                                //     : BlocProvider.of<CommonHaltUploadBloc>(context)
                                //         .add(GetCommonHaltUploadData());
                                // attendancedatealready == true
                                //     ? SizedBox()
                                //     : BlocProvider.of<CommonAttendanceUploadBloc>(context)
                                //         .add(GetCommonAttendanceUploadData());
                                /////////special upload ends/////
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Text(haltdataalready.toString()),
            // Text(attendancedatealready.toString()),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5.0,
            ),
            uploadbuttonon != true
                ? SizedBox()
                : AppCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircularPercentIndicator(
                          animation: true,
                          radius: 60.0,
                          animateFromLastPercent: true,
                          lineWidth: 5.0,
                          percent: progress!,
                          center: new Text(
                              ((progress! * 100).round()).toString() + "%"),
                          progressColor: HexColor('#069B56'),
                        ),
                        // ),
                        Text("Uploading data...")
                      ],
                    ),
                    color: HexColor('#292929'),
                    outLineColor: HexColor('#292929'),
                  ),

            SizedBox(
              height: 10,
            ),

//////////////////////////////attendance upload

/////////////////////////////////reservation upload  start //////////
            Container(
              child: BlocConsumer<CommonDatauploadBloc, StateCommonDataUpload>(
                  builder: (context, state) {
                if (state is CommondataUploaded) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                  );
                } else {
                  return Center();
                }
              }, listener: (context, state) {
                if (state is CommondataUploaded) {
                  a = 1;
                  b = state.items4!.length;
                  // c = a / b;

                  // setState(() {
                  //   totalprogresscheck = ab;
                  // });
                  if (state.items4!.isNotEmpty) {
                    // setState(() {
                    //   reservationlength = state.items4!.length;
                    // });
                    for (int i = 0; i < state.items4!.length; i++) {
                      BlocProvider.of<GetIbReservationDetailedsBloc>(context)
                          .add(IbReservationDetailedEvent(
                        programme: state.items4![i]['programid'],
                        slotDetail: state.items4![i]['slotdetailsid'],
                        bookingDate: state.items4![i]['bookingdate'],
                        numberOfRooms: state.items4![i]['numberofRooms'],
                        guestName: state.items4![i]['guestname'],
                        numberOfAccompanyigPersons: state.items4![i]
                            ['numberofpersonaccompanying'],
                        guestPhone: state.items4![i]['guestphone'],
                        referee: state.items4![i]['reference'],
                        refereePhone: state.items4![i]['referencephone'],
                        email: state.items4![i]['email'],
                        foodPreference: state.items4![i]['foodpreference'],
                        numberOfVehicles: state.items4![i]['numberofVehicle'],
                        vehicleNumbers: state.items4![i]['vehicleNumbers'],
                        details: state.items4![i]['details'],
                      ));
                    }
                    print("succes8");
                  } else {
                    print("succes8");
                    reservation == true
                        ? BlocProvider.of<CommonHaltUploadBloc>(context)
                            .add(GetCommonHaltUploadData())
                        : SizedBox();
                    reservation = false;

                    // Fluttertoast.showToast(
                    //     backgroundColor: Colors.white,
                    //     msg: "No Data Available for Upload",
                    //     textColor: Colors.black);
                  }
                }
              }),
            ),

            Container(
              child: BlocConsumer<GetIbReservationDetailedsBloc,
                  IbReservationDetailedsState>(builder: (context, state) {
                if (state is IbReservationDetailedssuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                  );
                } else {
                  return Center();
                }
              }, listener: (context, state) {
                if (state is IbReservationDetailedssuccess) {
                  setState(() {
                    progress = 0.7;
                  });
                  BlocProvider.of<IBReservationdeleteBloc>(context)
                      .add(GetIbreservationdatadeleteData());

                  reservation == true
                      ? BlocProvider.of<CommonHaltUploadBloc>(context)
                          .add(GetCommonHaltUploadData())
                      : SizedBox();
////////////chnages
                  ///
                  reservation == true
                      ? BlocProvider.of<GetIBGetReservationsBloc>(context)
                          .add(GetIBGetReservationsEvent())
                      : SizedBox();
                  reservation = false;

                  setState(() {
                    // progress = 0.3;
                    reservationuploaded = true;
                  });

                  // fetcher();
                } else if (state is IbReservationError) {
                  Fluttertoast.showToast(
                      backgroundColor: Colors.white,
                      msg: state.error,
                      textColor: Colors.black);
                }
              }),
            ),
/////////////////////////////////reservation upload  end //////////
            ///////        ////////halt uploading start///////////////////////////
            Container(
              child: BlocConsumer<CommonHaltUploadBloc, StateCommonHaltUpload>(
                  builder: (context, state) {
                if (state is CommonHaltUploadFetching) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                  );
                } else {
                  return Center();
                }
              }, listener: (context, state) {
                if (state is CommonHaltUploading) {
                  if (state.items13!.isNotEmpty) {
                    halt2uploadlist.clear();
                    for (int i = 0; i < state.items13!.length; i++) {
                      halt2uploadlist.add(Halt2UploadModel(
                        date: state.items13![i]['date'],
                        empId: state.items13![i]['empid'],
                        empName: state.items13![i]['empname'],
                        empPhone: state.items13![i]['empphone'],
                      ));
                    }

                    BlocProvider.of<GetUploadHaltBloc>(context)
                        .add(UploadHaltEvent(halt2uploadlist: halt2uploadlist));

                    setState(() {
                      progress = 0.4;
                    });
                  } else {
                    setState(() {
                      progress = 0.8;
                    });
                    halt == true
                        ? BlocProvider.of<CommonAttendanceUploadBloc>(context)
                            .add(GetCommonAttendanceUploadData())
                        : SizedBox();
                    halt = false;

                    // Fluttertoast.showToast(
                    //     backgroundColor: Colors.white,
                    //     msg: "No Data Available for Upload",
                    //     textColor: Colors.black);
                  }
                }
              }),
            ),

            Container(
              child: BlocConsumer<GetUploadHaltBloc, UploadHaltState>(
                  builder: (context, state) {
                if (state is UploadHaltsuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                  );
                } else {
                  return Center();
                }
              }, listener: (context, state) {
                if (state is UploadHaltsuccess) {
                  deletefullhaltcheckupload();
                  setState(() {
                    progress = 0.8;
                  });
                  halt == true
                      ? BlocProvider.of<CommonAttendanceUploadBloc>(context)
                          .add(GetCommonAttendanceUploadData())
                      : SizedBox();
                  halt = false;

                  setState(() {
                    haltdateuploaded = true;
                    // progress = 0.5;
                  });

                  for (int k = 0; k < halt2uploadlist.length; k++) {
                    final dateid = halt2uploadlist[k].date == null
                        ? ""
                        : halt2uploadlist[k].date;

                    final haltid = "";
                    final empid = halt2uploadlist[k].empId == null
                        ? ""
                        : halt2uploadlist[k].empId;
                    final phoneNumber = halt2uploadlist[k].empPhone == null
                        ? ""
                        : halt2uploadlist[k].empPhone;
                    final role = "";
                    final userName = halt2uploadlist[k].empName == null
                        ? ""
                        : halt2uploadlist[k].empName;
                    final dob = "";

                    final gender = "";
                    final assignedUnitId = "";

                    final assingedTo = halt2uploadlist[k].assigned == null
                        ? ""
                        : halt2uploadlist[k].assigned;
                    final haltDate = halt2uploadlist[k].date == null
                        ? ""
                        : halt2uploadlist[k].date;

                    if (empid!.isEmpty) {
                      return null;
                    } else {
                      Map data = {
                        'dateid': dateid,
                        'haltid': haltid,
                        'empid': empid,
                        'phoneNumber': phoneNumber,
                        'role': role,
                        'userName': userName,
                        'dob': dob,
                        'gender': gender,
                        'assignedUnitId': assignedUnitId,
                        'assingedTo': assingedTo,
                        'haltDate': haltDate,
                        'count': "1",
                      };
                      print(data);
                      haltreport(data);
                    }
                  }

                  /////datecheck for upload
                  final date = _currentDate.toString();
                  final keyword = "done";

                  if (date.isEmpty) {
                    return;
                  } else {
                    Map data = {
                      "date": date,
                      "keyword": keyword,
                    };
                    print(data);

                    datecheck(data);
                    setState(() {});
                  }

                  // fetcher();
                }

                if (state is UploadHaltError) {
                  Fluttertoast.showToast(msg: state.error);
                }
              }),
            ),
/////// //////////halt uploading end///////////////////////////
//////////attendance upload start/////////
            ///
            Container(
              child: BlocConsumer<CommonAttendanceUploadBloc,
                  StateCommonAttendanceUpload>(builder: (context, state) {
                if (state is CommonAttendanceUploading) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                  );
                } else {
                  return Center();
                }
              }, listener: (context, state) {
                if (state is CommonAttendanceUploading) {
                  if (state.items9!.isNotEmpty) {
                    attendanceuploadlist.clear();
                    for (int i = 0; i < state.items9!.length; i++) {
                      attendanceuploadlist.add(AttendanceUploadModel(
                          date: state.items9![i]['date'],

                          // _currentDate,
                          empId: state.items9![i]['empId'],
                          isPresent: state.items9![i]['isPresent'] == "1"
                              ? "true"
                              : "false",
                          leaveType: state.items9![i]['isPresent'] == "1"
                              ? ""
                              : state.items9![i]['leaveType'],
                          empPhone: getTime(state.items6!,
                              state.items9![i]['empId'], 'phonenumber'),
                          empName: getTime(state.items6!,
                              state.items9![i]['empId'], 'userName'),
                          reason: state.items9![i]['reason']));
                    }

                    // attendance = false;
                    BlocProvider.of<GetUploadAttendanceBloc>(context).add(
                        UploadAttendanceEvent(
                            attendanceuploadlist: attendanceuploadlist));
                  } else {
                    setState(() {
                      progress = 1.0;
                    });
                    attendance == true
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomerBottomNavigation()))
                        : SizedBox();
                    attendance = false;

                    // Fluttertoast.showToast(
                    //     backgroundColor: Colors.white,
                    //     msg: "No Data Available for Upload",
                    //     textColor: Colors.black);
                  }
                }
              }),
            ),
/////attendance
            Container(
              child:
                  BlocConsumer<MarkAttendanceOfflineBloc, StateMarkAttendance>(
                      builder: (context, state) {
                if (state is MarkingAttendance) {
                  return SizedBox();
                } else {
                  return Center();
                }
              }, listener: (context, state) {
                if (state is MarkingAttendance) {
                  attendancedetailslist.clear();
                  for (int i = 0; i < state.items6!.length; i++) {
                    for (int j = 0; j < state.items9!.length; j++) {
                      if (state.items9![j]['empId'] ==
                          state.items6![i]['empid']) {
                        attendancedetailslist.add(AttendanceDetailsModel(
                            empname: state.items6![i]['userName'],
                            empPhone: state.items6![i]['phonenumber'],
                            role: state.items6![i]['role'],
                            gender: state.items6![i]['gender']));
                      }
                    }
                  }

                  for (int k = 0; k < state.items11!.length; k++) {
                    if (state.items11![k]['date'] == _currentDate) {
                      setState(() {
                        attendancedatealready = true;
                        attendancelength = 0;
                      });
                    }
                  }
                  for (int p = 0; p < state.items15!.length; p++) {
                    if (state.items15![p]['date'] == _currentDate) {
                      setState(() {
                        haltdataalready = true;
                        haltlength = 0;
                      });
                    }
                  }
                }
              }),
            ),

            Container(
              child:
                  BlocConsumer<GetUploadAttendanceBloc, UploadAttendanceState>(
                      builder: (context, state) {
                if (state is UploadAttendancesuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                  );
                } else {
                  return Center();
                }
              }, listener: (context, state) {
                if (state is UploadAttendancesuccess) {
                  deletefullattendancecheckupload();
                  setState(() {
                    progress = 1.0;
                  });
                  attendance == true
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerBottomNavigation()))
                      : SizedBox();
                  attendance = false;
                  setState(() {
                    attendancedateuploaded = true;
                    progress = 1.0;
                  });

                  //////for uploadin to the  attendnace report
                  ///
                  for (int i = 0; i < attendanceuploadlist.length; i++) {
                    final dateid = attendanceuploadlist[i].date.toString();
                    final attendanceid =
                        attendanceuploadlist[i].date.toString();
                    final isPresent =
                        attendanceuploadlist[i].isPresent.toString() == "true"
                            ? "1"
                            : "0";
                    final leaveType =
                        attendanceuploadlist[i].leaveType.toString();

                    final isSpecialDay = "";
                    final empId = attendanceuploadlist[i].empId.toString();
                    final phoneNumber =
                        attendancedetailslist[i].empPhone.toString();
                    final role = "";
                    final userName = attendanceuploadlist[i].empName.toString();
                    final dob = "";
                    final gender = "";
                    final assignedUnitId = "";
                    final assignedTo = "";
                    final attendnaceDate =
                        attendanceuploadlist[i].date.toString();
                    final description = "";

                    if (empId.isEmpty) {
                      return null;
                    } else {
                      Map data = {
                        'dateid': dateid,
                        'attendanceid': attendanceid,
                        'isPresent': isPresent,
                        'leaveType': leaveType,
                        'isSpecialDay': isSpecialDay,
                        'empId': empId,
                        'phoneNumber': phoneNumber,
                        'role': role,
                        'userName': userName,
                        'dob': dob,
                        'gender': gender,
                        'assignedUnitId': assignedUnitId,
                        'assignedTo': assignedTo,
                        'attendnaceDate': attendnaceDate,
                        "description": description
                      };
                      print(data);
                      attendanceDetails(data);
                    }
                  }

                  /////////to report end

                  /////datecheck for upload
                  final date = _currentDate.toString();
                  final keyword = "done";

                  if (date.isEmpty) {
                    return;
                  } else {
                    Map data = {
                      "date": date,
                      "keyword": keyword,
                    };
                    print(data);

                    datecheck2(data);
                    setState(() {});
                  }

                  // fetcher();
                }
              }),
            ),

            ///////////////////////////to get the total reservation count///////
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
          ],
        ),
      ),
    );
  }

  String getTime(
    List list,
    param1,
    String s,
  ) {
    newList = list.where((element) => element['empid'] == param1).toList();
    print(newList[0][s]);

    return newList[0][s];
    // return d1.format(DateTime.parse(convert(newList[0][s])));
  }
}
