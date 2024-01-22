import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationbloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationstate.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibprogrambloc/ibprogrambloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/downloadechoproducts.dart';
import 'package:parambikulam/bloc/assets/haltbloc/haltreportbloc/haltreportbloc.dart';
import 'package:parambikulam/bloc/assets/haltbloc/haltreportbloc/haltreportstate.dart';
import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeebloc.dart';
import 'package:parambikulam/bloc/assets/new/requestviewmainbloc/requestviewmainstate.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofilebloc.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofilestate.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsbloc.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsstate.dart';

import '../../../../bloc/assets/Ibmain/ibprogrambloc/ibprogramstate.dart';
import '../../../../bloc/assets/attendancebloc/attendancereportbloc/attendancereportbloc.dart';
import '../../../../bloc/assets/attendancebloc/attendancereportbloc/attendancereportstate.dart';
import '../../../../bloc/assets/icbloc/viewallemployeebloc/viewallemployeestate.dart';
import '../../../../bloc/assets/new/purchaseviewbloc/purchaseviewbloc.dart';
import '../../../../bloc/assets/new/purchaseviewbloc/purchaseviewstate.dart';
import '../../../../bloc/assets/new/requestviewmainbloc/requestviewmainbloc.dart';

class ICDownloadPage extends StatefulWidget {
  const ICDownloadPage({Key? key}) : super(key: key);

  @override
  State<ICDownloadPage> createState() => _ICDownloadPageState();
}

class _ICDownloadPageState extends State<ICDownloadPage> {
  bool? profiletrue = false;
  bool? assetstrue = false;
  bool? assetsrequesttrue = false;
  bool? purchaselist = false;

  bool? producttrue = false;
  bool? productimagetrue = false;
  bool? salesreports = false;
  //new

  bool? employeelist = false;

  bool? haltlist = false;
  bool? attendancelist = false;
  bool? ibprgmlist = false;
  bool? ibreservationlist = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Fluttertoast.showToast(msg: 'Please wait');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Downloading Offline Data"),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(14.0),
          children: [
            // BlocBuilder<DownloadBloc, DownloadState>(
            //     buildWhen: ((previous, current) =>
            //         current is CreateLocalDBState),
            //     builder: ((context, state) {
            //       if (state is CreateLocalDBState) {
            //         return ListTile(
            //           leading: Icon(
            //             Icons.check_circle,
            //             color: Colors.green[400],
            //           ),
            //           title: Text("Local database created"),
            //         );
            //       }
            //       return ListTile(
            //         leading: SizedBox(
            //           width: 20,
            //           height: 20,
            //           child: CircularProgressIndicator(
            //             color: Colors.white,
            //           ),
            //         ),
            //         title: Text("Creating local database"),
            //       );
            //     })),
            BlocConsumer<GetViewProfileBloc, ViewProfileState>(
              buildWhen: ((previous, current) =>
                  current is ProfileDownloadedSuccess),
              builder: ((context, state) {
                if (state is ProfileDownloadedSuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Profile data downloaded"),
                  );
                }
                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Profile data"),
                );
              }),
              listener: (context, state) {
                if (state is ProfileDownloadedSuccess) {
                  setState(() {
                    profiletrue = true;
                  });
                }
              },
            ),
            BlocConsumer<GetViewallAssetsBloc, ViewallAssetsState>(
              buildWhen: ((previous, current) => current is DownloadedSuccess),
              builder: ((context, state) {
                if (state is DownloadedSuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Assets data downloaded"),
                  );
                }

                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Assets data"),
                );
              }),
              listener: (context, state) {
                if (state is DownloadedSuccess) {
                  setState(() {
                    assetstrue = true;
                  });
                }
              },
            ),
            BlocConsumer<GetViewRequestMainBloc, ViewRequestMainState>(
              buildWhen: ((previous, current) =>
                  current is RequestDataDownloadedSuccesfully),
              builder: ((context, state) {
                if (state is RequestDataDownloadedSuccesfully) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Request data downloaded"),
                  );
                }
                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Request data"),
                );
              }),
              listener: (context, state) {
                if (state is RequestDataDownloadedSuccesfully) {
                  setState(() {
                    assetsrequesttrue = true;
                  });
                }
              },
            ),
/////new

            BlocConsumer<GetViewPurchaseOrderBloc, ViewPurchaseOrderState>(
              buildWhen: ((previous, current) =>
                  current is FetchPurchaseSuccess),
              builder: ((context, state) {
                if (state is FetchPurchaseSuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Purchase data downloaded"),
                  );
                }
                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Purchase data"),
                );
              }),
              listener: (context, state) {
                if (state is FetchPurchaseSuccess) {
                  setState(() {
                    purchaselist = true;
                  });
                }
              },
            ),

////sec
            BlocConsumer<GetViewAllEmployeeBloc, ViewAllEmployeeState>(
              buildWhen: ((previous, current) =>
                  current is EmployeeDownloadedSucces),
              builder: ((context, state) {
                if (state is EmployeeDownloadedSucces) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Employee data downloaded"),
                  );
                }
                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Employee data"),
                );
              }),
              listener: (context, state) {
                if (state is EmployeeDownloadedSucces) {
                  setState(() {
                    employeelist = true;
                  });
                }
              },
            ),

//thrid
            BlocConsumer<GetReportHaltBloc, ReportHaltState>(
              buildWhen: ((previous, current) => current is ReportHaltsuccess),
              builder: ((context, state) {
                if (state is ReportHaltsuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Halt data downloaded"),
                  );
                }
                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Halt data"),
                );
              }),
              listener: (context, state) {
                if (state is ReportHaltsuccess) {
                  setState(() {
                    haltlist = true;
                  });
                }
              },
            ),

            //forth
            BlocConsumer<GetAttendanceReportBloc, AttendanceReportState>(
              buildWhen: ((previous, current) =>
                  current is AttendanceReportsuccess),
              builder: ((context, state) {
                if (state is AttendanceReportsuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Attendnace data downloaded"),
                  );
                }
                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Attendnace data"),
                );
              }),
              listener: (context, state) {
                if (state is AttendanceReportsuccess) {
                  setState(() {
                    attendancelist = true;
                  });
                }
              },
            ),

//five
            BlocConsumer<GetIBprogramBloc, IBprogramState>(
              buildWhen: ((previous, current) => current is IBprogramSuccess),
              builder: ((context, state) {
                if (state is IBprogramSuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("IB Program data downloaded"),
                  );
                }
                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading IB Program data"),
                );
              }),
              listener: (context, state) {
                if (state is IBprogramSuccess) {
                  setState(() {
                    ibprgmlist = true;
                  });
                }
              },
            ),

            ///six
            BlocConsumer<GetIBGetReservationsBloc, IBGetReservationsState>(
              buildWhen: ((previous, current) =>
                  current is IBGetReservationsSuccess),
              builder: ((context, state) {
                if (state is IBGetReservationsSuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("IB Reservation data downloaded"),
                  );
                }
                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading IB Reservation data"),
                );
              }),
              listener: (context, state) {
                if (state is IBGetReservationsSuccess) {
                  setState(() {
                    ibreservationlist = true;
                  });
                }
              },
            ),

            BlocConsumer<GetEchoShopProductBloc, EchoShopProductState>(
              buildWhen: ((previous, current) =>
                  current is ProductDownloadedechoSucces),
              builder: ((context, state) {
                if (state is ProductDownloadedechoSucces) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Products downloaded"),
                  );
                }

                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Products"),
                );
              }),
              listener: (context, state) {
                if (state is ProductDownloadedechoSucces) {
                  setState(() {
                    producttrue = true;
                  });
                }
              },
            ),

            BlocConsumer<GetEchoShopProductBloc, EchoShopProductState>(
              buildWhen: ((previous, current) =>
                  current is EchoShopProductDownloadsuccess),
              builder: ((context, state) {
                if (state is EchoShopProductDownloadsuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("ProductsImage downloaded"),
                  );
                }

                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading ProductsImage"),
                );
              }),
              listener: (context, state) {
                if (state is ProductDownloadedSuccess) {
                  setState(() {
                    productimagetrue = true;
                  });
                }
              },
            ),

            // BlocConsumer<GetEchoShopProductBloc, EchoShopProductState>(
            //   buildWhen: ((previous, current) =>
            //       current is SalereportDownloadedSuccess),
            //   builder: ((context, state) {
            //     if (state is SalereportDownloadedSuccess) {
            //       return ListTile(
            //         leading: Icon(
            //           Icons.check_circle,
            //           color: Colors.green[400],
            //         ),
            //         title: Text("SalesReport downloaded"),
            //       );
            //     }

            //     return ListTile(
            //       leading: SizedBox(
            //         width: 20,
            //         height: 20,
            //         child: CircularProgressIndicator(
            //           color: Colors.white,
            //         ),
            //       ),
            //       title: Text("Downloading SalesReport"),
            //     );
            //   }),
            //   listener: (context, state) {
            //     if (state is ProductDownloadedSuccess) {
            //       setState(() {
            //         salesreports = true;
            //       });
            //     }
            //   },
            // ),

            // BlocBuilder<DownloadBloc, DownloadState>(
            //     builder: ((context, state) {
            //   if (state is AddingTicketofState) {
            //     return ListTile(
            //       leading: SizedBox.shrink(),
            //       title: Text("Adding ticket of #${state.ticketNumber}"),
            //     );
            //   }
            //   return SizedBox.shrink();
            // })),
            // BlocBuilder<DownloadBloc, DownloadState>(
            //     buildWhen: ((previous, current) =>
            //         current is TermsAndConditionsAddedState),
            //     builder: ((context, state) {
            //       if (state is TermsAndConditionsAddedState) {
            //         return ListTile(
            //           leading: Icon(
            //             Icons.check_circle,
            //             color: Colors.green[400],
            //           ),
            //           title: Text("Terms & conditions added"),
            //         );
            //       }
            //       return ListTile(
            //         leading: SizedBox(
            //           width: 20,
            //           height: 20,
            //           child: CircularProgressIndicator(
            //             color: Colors.white,
            //           ),
            //         ),
            //         title: Text("Adding terms & conditions"),
            //       );
            //     })),

            profiletrue != true ||
                    assetstrue != true ||
                    assetsrequesttrue != true ||
                    producttrue != true ||
                    productimagetrue != true ||
                    purchaselist != true ||
                    employeelist != true ||
                    haltlist != true ||
                    attendancelist != true ||
                    ibprgmlist != true ||
                    ibreservationlist != true
                ? ListTile(
                    leading: Icon(Icons.pending_actions),
                    title: Text("Offline data downloaded"),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.green[400],
                        ),
                        title: Text("Offline data downloaded"),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () {
                          Navigator.pop(context);

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: ((context) => MyApp()),
                          //   ),
                          //);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.home_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "GOTO HOME",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
//  profiletrue! == false &&
//   assetstrue == false &&
//    assetsrequesttrue! = false &&
//    producttrue = false ?

            Divider(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Is there a problem?")],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg:
                              "Press download button to start offline data download");
                    },
                    child: Text(
                      "DOWNLOAD AGAIN",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
