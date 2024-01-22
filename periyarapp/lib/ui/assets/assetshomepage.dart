import 'dart:io';
import 'package:badges/badges.dart' as badge;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationbloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibprogrambloc/ibprogrambloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibprogrambloc/ibprogramevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibprogrambloc/ibprogramstate.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationbloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationstate.dart';
import 'package:http/http.dart' as http;
import 'package:parambikulam/bloc/assets/attendancebloc/attendancereportbloc/attendancereportbloc.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/attendancereportbloc/attendancereportevent.dart';
import 'package:parambikulam/bloc/assets/echoshop/downloadechoproducts.dart';
import 'package:parambikulam/bloc/assets/haltbloc/haltreportbloc/haltreportbloc.dart';
import 'package:parambikulam/bloc/assets/haltbloc/haltreportbloc/haltreportevent.dart';
import 'package:parambikulam/bloc/assets/ic_viewunitsbloc/ic_viewunitsbloc.dart';
import 'package:parambikulam/bloc/assets/ic_viewunitsbloc/ic_viewunitsevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/damagerequest_blocaccept/damagerequest_blocaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/damagerequest_blocaccept/damagerequest_eventaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignunitbloc/employeeassign_blocunit.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignunitbloc/employeeassign_eventunit.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeoffline/viewemployeelistbloc/viewemployeelistbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeoffline/viewemployeelistbloc/viewemployeelistevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/iclogmainbloc/iclogmainbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/iclogmainbloc/iclogmainevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/newpurchasedropbloc/newpurchasedropbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/newpurchasedropbloc/newpurchasedropevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/productdeletebloc/productdeletebloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/productdeletebloc/productdeleteevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/producteditbloc/producteditbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/producteditbloc/producteditevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/repairrequestacceptbloc/repairrequest_blocaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/repairrequestacceptbloc/repairrequest_eventaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeebloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeeevent.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendancedatafetchingbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibprogramdeletebloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibreservationdatauploadbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibreservationdeletebloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibreservationdetailsbloc.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewbloc/purchaseviewbloc.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewbloc/purchaseviewevent.dart';
import 'package:parambikulam/bloc/assets/new/requestviewmainbloc/requestviewmainbloc.dart';
import 'package:parambikulam/bloc/assets/new/requestviewmainbloc/requestviewmainevent.dart';
import 'package:parambikulam/bloc/assets/new/sync/sync_icbloc/sync_icbloc.dart';
import 'package:parambikulam/bloc/assets/new/sync/sync_icbloc/sync_icevent.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofilebloc.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofileevent.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsbloc.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsevent.dart';
import 'package:parambikulam/data/models/assetsmodel/viewallassetsmodel.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/homepages_assets/unitsview/ic_viewunitspage.dart';
import 'package:parambikulam/ui/assets/ic_main/attendance/attendancedashboard.dart';
import 'package:parambikulam/ui/assets/ic_main/homepage/assetview.dart';
import 'package:parambikulam/ui/assets/ic_main/homepage/icdatadownload.dart';
import 'package:parambikulam/ui/assets/ic_main/iclogmain.dart';
import 'package:parambikulam/ui/assets/ic_main/viewemployees.dart';
import 'package:parambikulam/ui/assets/ic_main/viewrequestmain.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/commonsync.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/ibdashboard2.dart';
import 'package:parambikulam/ui/assets/profilepage.dart';
import 'package:parambikulam/ui/assets/purchaseorder/viewpurchaseorder.dart';
import 'package:parambikulam/utils/pref_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class AssestsHomePage extends StatefulWidget {
  const AssestsHomePage({Key? key}) : super(key: key);

  @override
  State<AssestsHomePage> createState() => _AssestsHomePageState();
}

class _AssestsHomePageState extends State<AssestsHomePage> {
  String? token;
  List<ViewAssetsModel> viewassetslist = [];
  int? quantitycount;
  int a = 0;
  int b = 0;
  int c = 0;
  int d = 0;
  int e = 0;
  int f = 0;
  int g = 0;
  int h = 0;
  int i = 0;
  int j = 0;

  bool? uploadon = false;
  bool? istart = false;
  bool? kstart = false;
  String? index1;
  num? totaluploadcount = 0;
  bool? haltpending = true, isMatched = false;
  int? haltcount;
  final folderName = "ParambikulamIBphotos";
  var path;
  Directory? newPath;
  String? coverImage2;
  bool? interneton = false;
  int? count;
  List items48 = [];
  bool? counton = false;
  bool? downloading = false;
  String dropdownvalue = 'Non consumable';
  var items = [
    'Non consumable',
    'Consumable',
  ];
  bool done = true;
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController producttypecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();
  final TextEditingController salepricecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController discountcontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();
  AppUpdateInfo? _updateInfo;
  @override

  ///
  void initState() {
    getData();
    fetcher();
    BlocProvider.of<GetViewallAssetsBloc>(context)
        .add(RefreshViewallAssetsEvent());
    testinternet();

    teststate();
    super.initState();
  }

  void getData() async {
    await checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
        _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
            ? showUpdate()
            : const SizedBox.shrink();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  final Uri _url = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.leopardtechlabs.periyartigerreserve');

  void _launchURL() async => await canLaunchUrl(_url)
      ? await launchUrl(_url, mode: LaunchMode.externalApplication)
      : throw 'Could not launch https://play.google.com/store/apps/details?id=com.leopardtechlabs.periyartigerreserve';

  showUpdate() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const ListTile(
          title: Text('Update Parambikulam'),
          subtitle: Text(
              'Parambikulam recommends that you to update to the latest version'),
        ),
        actions: <Widget>[
          Column(
            children: [
              MaterialButton(
                color: Colors.green,
                child: const Text(
                  'No Thanks',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  //_redirectToPage(msg);
                },
              ),
              MaterialButton(
                color: Colors.green,
                child: const Text(
                  'Update Now',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _launchURL();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  ViewAllAssetsModel? viewAllAssetsModel;

  void teststate() async {
    items48 = await getcheckdataonlinetabledata();
    items48.isEmpty ? testinternetstart() : SizedBox();

    items48.isEmpty
        ? BlocProvider.of<GetEchoShopProductBloc>(context)
            .add(ImageDownloadProduct())
        : "";
  }

  void testinternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      interneton = false;
    } else if (connectivityResult != ConnectivityResult.none) {
      ///taskeployee assign for the employee assign
      BlocProvider.of<GetEmployeeUnitAssignBloc>(context)
          .add(TaskEmployee2UnitAssign());
      ////
//////for assign duty  for employees
      BlocProvider.of<GetEmployeeUnitAssignBloc>(context)
          .add(DutyEmployeeassign());

      BlocProvider.of<GetViewProfileBloc>(context).add(GetViewProfileEvent());
      BlocProvider.of<GetIbReservationDetailedsBloc>(context)
          .add(EditIbReservationEvent());
      BlocProvider.of<GetDamageRequestAcceptBloc>(context)
          .add(FetchDamageRequestAccept());
      BlocProvider.of<GetRepairRequestAcceptBloc>(context)
          .add(FetchRepairRequestAccept());

      BlocProvider.of<GetIbReservationDetailedsBloc>(context)
          .add(RemoveIbReservationEvent());

      ///for download request view
      // BlocProvider.of<GetViewRequestMainBloc>(context)
      //     .add(FetchofflineRequestMainEvent());
      // BlocProvider.of<GetViewRequestMainBloc>(context)
      //     .add(FetchofflineRequestMainEvent());
      ///for delete product
      BlocProvider.of<GetProductDeleteBloc>(context).add(GetProductDelete());

      ///for edit the assets  not newly added
      BlocProvider.of<GetSyncOfflineDataBloc>(context)
          .add(GetSyncAssetsEditData());

      ////for damage accept
      // BlocProvider.of<GetDamageRequestAcceptBloc>(context)
      //     .add(FetchDamageRequestAccept());
      ///for edit the product  not tested finish
      BlocProvider.of<GetProductMainEditBloc>(context)
          .add(FetchProductMainEdit());

      interneton = true;
    }
  }

//////
////for
  void testinternetstart() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "No Internet Available",
          textColor: Colors.black);

      // interneton = false;
    } else if (connectivityResult != ConnectivityResult.none) {
      datasync();
    }
  }

  void fetcher() async {
///////for verify the data is there or not
    List items21 = [];

    DatabaseHelper? db = DatabaseHelper.instance;
    List items24 = await db.getICEmployeeeAssignListDownloadData();
    List items26 = await db.getICNewRequestTransferListDownloadData();

    List items27 = await db.getICAddProductListDownloadData();
    List items25 = await db.getICStockUpdateTransferListDownloadData();
    List items22 = await db.getICUnitsAssignListDownloadData();
    List items23 = await db.getICAssetsTrasnferListDownloadData();
    items21 = await db.getICAddAssetsListDownloadData();
    List items4 = await getAllReservationdata();
    // List items9 = await getAllMarkedAttendancedata();
    // List items13 = await getAllHaltDetailsdata();

    List items56 = await getattendancecheckuploaddata();
    List items57 = await gethaltcheckuploaddata();
    List items62 = await getassetswithoutrequestdata();
    print(items62);
    if (items24.isNotEmpty) {
      a = 1;
      uploadon = true;
      print("1");
    }

    if (items26.isNotEmpty) {
      b = 1;
      uploadon = true;
      print("2");
    }

    if (items27.isNotEmpty) {
      c = 1;
      uploadon = true;
      print("3");
    }
    if (items25.isNotEmpty) {
      d = 1;
      uploadon = true;
      print("4");
    }

    if (items22.isNotEmpty) {
      e = 1;
      uploadon = true;
      print("5");
    }

    if (items23.isNotEmpty) {
      f = 1;
      uploadon = true;
      print("6");
    }

    if (items21.isNotEmpty) {
      g = 1;
      uploadon = true;
      print("7");
    }
    if (items4.isNotEmpty) {
      h = 1;
      uploadon = true;
      print("8");
    }
//////////till
    if (items56.isNotEmpty) {
      i = 1;
      uploadon = true;
    }

    if (items57.isNotEmpty) {
      j = 1;
      uploadon = true;
    }

    // if (items13.isNotEmpty) {
    //   uploadon = true;
    // }
    setState(() {
      totaluploadcount = a + b + c + d + e + f + g + h + i + j;
    });
  }

  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      drawer: theDrawer(),
      appBar: new AppBar(
        title: new Text('Home'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              totaluploadcount != 0
                  ? Fluttertoast.showToast(
                      msg:
                          "Data is pending for upload, please try to upload before logout")
                  : PrefManager.clearToken();

              totaluploadcount != 0
                  ? SizedBox.shrink()
                  : Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
            },
            icon: Icon(
              Icons.logout_outlined,
              size: 18,
            ),
          ),
          badge.Badge(
            badgeColor: totaluploadcount == 0
                ? Colors.transparent
                : Color.fromARGB(255, 221, 6, 45),
            position: badge.BadgePosition.topEnd(top: 1, end: 2),
            padding: const EdgeInsets.all(5.0),
            badgeContent: totaluploadcount == 0
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(totaluploadcount.toString()),
                  ),
            child: IconButton(
              onPressed: () async {
                // BlocProvider.of<GetTransferStockUpdationBloc>(context)
                //     .add(FetchTransferStockUpdation());
                // BlocProvider.of<GetEchoShopProductBloc>(context)
                //     .add(ImageDownloadProduct());
                testinternet();
                // fetcher();
                print("yes");

                // BlocProvider.of<IBProgramdeleteBloc>(context)
                //     .add(GetIbdeleteData());

                // BlocProvider.of<IBProgramdeleteBloc>(context)
                //     .add(GetIbdeleteData());

                // BlocProvider.of<GetViewallAssetsBloc>(context)
                //     .add(FetchViewallAssetsEvent());
                // BlocProvider.of<GetViewallAssetsBloc>(context)
                //     .add(GetViewallAssetsEvent());

                // BlocProvider.of<GetSyncOfflineDataBloc>(context)
                //     .add(FetchSyncOfflineData());

                // await db.deletePurchasedata();
                // await db.deletePurchaseassetsdata();

                ///view purchase
                // BlocProvider.of<GetViewPurchaseOrderBloc>(context)
                //     .add(RefreshOfflinePurchaseOrderEvent());

                ///download
                //               BlocProvider.of<GetViewPurchaseOrderBloc>(context)
                //                   .add(FetchViewPurchaseOrderEvent());
                // ///////
                // ////assets
                // BlocProvider.of<GetViewallAssetsBloc>(context)
                //     .add(GetViewallAssetsEvent());
                // BlocProvider.of<GetIbReservationDetailedsBloc>(context)
                //     .add(EditIbReservationEvent());

                // BlocProvider.of<GetSyncOfflineDataBloc>(context)
                //     .add(FetchSyncallData());

                // ///for edit the assets
                // BlocProvider.of<GetSyncOfflineDataBloc>(context)
                //     .add(FetchSyncOfflineData());
                // BlocProvider.of<GetProductMainEditBloc>(context)
                //     .add(GetProductMainEdit());

                /////here we want to test the edit here and pls add it to the download sections
                // BlocProvider.of<GetProductMainEditBloc>(context)
                //     .add(FetchProductMainEdit());
                datasync();

                // BlocProvider.of<GetDamageRequestAcceptBloc>(context)
                //     .add(FetchDamageRequestAccept());
                // deletefullproductdelete();
                // BlocProvider.of<GetEchoShopProductBloc>(context)
                //     .add(OnlineProductsandDownload());
                // BlocProvider.of<GetEchoShopProductBloc>(context)
                //     .add(ImageDownloadProduct());
                // BlocProvider.of<GetEchoShopProductBloc>(context)
                //     .add(FetchProductsandDownload());

                // BlocProvider.of<GetIcLogmainBloc>(context).add(GetIcLogmain());
                // BlocProvider.of<GetViewPurchaseOrderBloc>(context)
                //     .add(FetchViewPurchaseOrderEvent());
                // List items35 = await getAlltransferlogdata();
                // print(items35);

                // List items6 = await getAllEmployeeListdata();
                // print(items6);

                // BlocProvider.of<GetEmployeeUnitAssignBloc>(context)
                //     .add(TaskEmployeeUnitAssign());
                //  await deletemasterviewtable();
                //   await deletestockupdation();
                //   await deletenewpurchase();
                //   await deletedamage();
                //   await deleterepair();
                ///
                ///for download request
                // BlocProvider.of<GetViewRequestMainBloc>(context)
                //     .add(FetchofflineRequestMainEvent());
                /////////
                ///for download requests
                // BlocProvider.of<GetViewRequestMainBloc>(context)
                //     .add(FetchofflineRequestMainEvent());
                //GetofflineRequestMainEvent
                ////for view request
                // BlocProvider.of<GetViewRequestMainBloc>(context)
                //     .add(GetofflineRequestMainEvent());
              },
              ////
              icon: Icon(Icons.sync_outlined),
            ),
          ),
          InkWell(
            onTap: () {},
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
      ),
      body: RefreshIndicator(
        displacement: 50,
        backgroundColor: Colors.white,
        color: Colors.green,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          physics: NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height / 1,
              //   child: const Image(
              //     image: AssetImage('assets/forest.png'),
              //   ),
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 50.0,
                                    spreadRadius: 50, //New
                                  )
                                ],
                              ),
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_basket_outlined,
                                      size: 32,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "Assets ",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(_createRoute(AssetViewPage(unit: "ic")));
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 12),
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.people_alt_rounded,
                                      color: Colors.green,
                                      size: 32,
                                    ),

                                    ///
                                    Text(
                                      "Attendance ",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(_createRoute(AttendanceDashboard()));
                          },
                        ),
                      ],
                    ),
                  ),
                  //
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.view_agenda,
                                      color: Colors.green,
                                      size: 32,
                                    ),
                                    Text(
                                      "Employee Data ",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(_createRoute(ViewAllEmployee()));
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 12),
                        InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.library_books,
                                      color: Colors.green,
                                      size: 32,
                                    ),
                                    Text(
                                      "IB Booking ",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .push(_createRoute(IBDashboard2()));
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                  ),
                  ClipPath(
                    clipper: WaveClipperOne(reverse: true),
                    child: Container(
                      height: 120,
                      color: Color(0xfff68D389),
                      // child:
                      //     Center(child: Text("WaveClipperOne(reverse: true)")),
                    ),
                  ),

                  Container(
                    child: BlocConsumer<GetIBprogramBloc, IBprogramState>(
                        builder: ((context, state) {
                      if (state is IBprogramSuccess) {
                        return Center();
                      }

                      return Container();
                    }), listener: (context, state) async {
                      if (state is IBprogramSuccess) {
                        await createFolder2(context);
                        await deletefullibprogramssloptsupload();
                        await deleteibprograms6upload();

                        if (done == true) {
                          fetcher();
////
                          ///
                          setState(() {
                            downloading = true;
                          });

                          for (int k = 0;
                              k < state.ibProgramsModel.data!.length;
                              k++) {
                            if (k == 0) {
                              setState(() {
                                kstart = true;
                              });
                            }
                            ////
                            if (kstart == true) {
                              print(k.toString() + "slotcout");
                              final status =
                                  state.ibProgramsModel.data![k].status == null
                                      ? ""
                                      : state.ibProgramsModel.data![k].status;
                              final _id =
                                  state.ibProgramsModel.data![k].id == null
                                      ? ""
                                      : state.ibProgramsModel.data![k].id;
                              final startTime = state
                                          .ibProgramsModel.data![k].startTime ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.data![k].startTime;
                              final endTime =
                                  state.ibProgramsModel.data![k].endTime == null
                                      ? ""
                                      : state.ibProgramsModel.data![k].endTime;
                              final availableNo = state.ibProgramsModel.data![k]
                                          .availableNo ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.data![k].availableNo;
                              final slotisDaywise = state.ibProgramsModel
                                          .data![k].slot!.isDaywise ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.data![k].slot!.isDaywise;
                              final slotstatus = state.ibProgramsModel.data![k]
                                          .slot!.status ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.data![k].slot!.status;

                              final slotid =
                                  state.ibProgramsModel.data![k].slot!.id ==
                                          null
                                      ? ""
                                      : state.ibProgramsModel.data![k].slot!.id;
                              final slotprogramme = state.ibProgramsModel
                                          .data![k].slot!.programme ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.data![k].slot!.programme;
                              final slotfromDate = state.ibProgramsModel
                                          .data![k].slot!.fromDate ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.data![k].slot!.fromDate;

                              // final image = image[0];
                              final slottoDate = state.ibProgramsModel.data![k]
                                          .slot!.toDate ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.data![k].slot!.toDate;
                              final slotslotType = state.ibProgramsModel
                                          .data![k].slot!.slotType ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.data![k].slot!.slotType;

                              if (status!.isEmpty || status.isEmpty) {
                                return;
                              } else {
                                Map data = {
                                  'status': status,
                                  '_id': _id,
                                  'startTime': startTime,
                                  'endTime': endTime,
                                  'availableNo': availableNo,
                                  'slotisDaywise': slotisDaywise,
                                  'slotstatus': slotstatus,
                                  'slot_id': slotid,
                                  'slotprogramme': slotprogramme,
                                  'slotfromDate': slotfromDate,
                                  'slottoDate': slottoDate,
                                  'slotslotType': slotslotType,
                                };
                                print(data);

                                //////////
                                slotIBprogramsdata(data);
                              }

                              if (k == state.ibProgramsModel.data!.length - 1) {
                                setState(() {
                                  kstart = false;
                                });
                              }
                            }
                          }

                          for (int i = 0;
                              i < state.ibProgramsModel.programData!.length;
                              i++) {
                            print(i.toString() + "programcount");
                            // if (i == 1) {

                            if (i == 0) {
                              setState(() {
                                istart = true;
                              });
                            }

                            if (istart == true) {
                              setState(() {
                                isMatched = false;
                              });
                              final started = state.ibProgramsModel
                                          .programData![i].started ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].started;
                              final isCottage = state.ibProgramsModel
                                          .programData![i].isCottage ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.programData![i]
                                      .isCottage;
                              final status = state.ibProgramsModel
                                          .programData![i].status ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].status;
                              final _id = state
                                          .ibProgramsModel.programData![i].id ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.programData![i].id;
                              final category = state.ibProgramsModel
                                          .programData![i].category ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].category;
                              final caption = state.ibProgramsModel
                                          .programData![i].caption ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].caption;
                              final progName = state.ibProgramsModel
                                          .programData![i].progName ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].progName;

                              final description = "";

                              // state.ibProgramsModel
                              //             .programData![i].description ==
                              //         null
                              //     ? ""
                              //     : state
                              //         .ibProgramsModel.programData![i].description;
                              final startPoint = state.ibProgramsModel
                                          .programData![i].startPoint ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.programData![i]
                                      .startPoint;
                              final endPoint = state.ibProgramsModel
                                          .programData![i].endPoint ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].endPoint;

                              // final image = image[0];
                              final duration = state.ibProgramsModel
                                          .programData![i].duration ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].duration;
                              final onlinePercent = state.ibProgramsModel
                                          .programData![i].onlinePercent ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.programData![i]
                                      .onlinePercent;

                              final minGuest = state.ibProgramsModel
                                          .programData![i].maxGuest ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].maxGuest;
                              final maxGuest = state.ibProgramsModel
                                          .programData![i].maxGuest ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].maxGuest;
                              final maxAge = state.ibProgramsModel
                                          .programData![i].maxAge ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].maxAge;

                              // final image = image[0];
                              final minAge = state.ibProgramsModel
                                          .programData![i].minAge ==
                                      null
                                  ? ""
                                  : state
                                      .ibProgramsModel.programData![i].minAge;
                              final reportingTime = state.ibProgramsModel
                                          .programData![i].reportingTime ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.programData![i]
                                      .reportingTime;

                              final rules = state.ibProgramsModel
                                          .programData![i].rules ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.programData![i].rules;
                              final notes = state.ibProgramsModel
                                          .programData![i].notes ==
                                      null
                                  ? ""
                                  : state.ibProgramsModel.programData![i].notes;

                              var coverImage2 = state.ibProgramsModel
                                          .programData![i].coverImage ==
                                      null
                                  ? "1620298762782.jpg"
                                  : state.ibProgramsModel.programData![i]
                                      .coverImage;

                              var coverImages2 = state.ibProgramsModel
                                          .programData![i].coverImage ==
                                      "1620299763585.jpg"
                                  ? "1620298762782.jpg"
                                  : state.ibProgramsModel.programData![i]
                                      .coverImage;

                              var coverImage3 =
                                  await downloadImage2(context, coverImage2);
                              final coverImage = coverImage3.toString();
                              // final coverImage = state
                              //             .ibProgramsModel.programData![i].coverImage ==
                              //         null
                              //     ? ""
                              //     : state.ibProgramsModel.programData![i].coverImage;

                              ///////////////////////////////////////////////////
                              final bookingAvailabilityindian = "";
                              //  state
                              //             .ibProgramsModel
                              //             .programData![i]
                              //             .bookingAvailability!
                              //             .indian ==
                              //         null
                              //     ? ""
                              //     : state.ibProgramsModel.programData![i]
                              //         .bookingAvailability!.indian;
                              final bookingAvailabilityforeigner = "";
                              //  state
                              //             .ibProgramsModel
                              //             .programData![i]
                              //             .bookingAvailability!
                              //             .foreigner ==
                              //         null
                              //     ? ""
                              //     : state.ibProgramsModel.programData![i]
                              //         .bookingAvailability!.foreigner;
                              final bookingAvailabilitychildren = "";
                              // state
                              //             .ibProgramsModel
                              //             .programData![i]
                              //             .bookingAvailability!
                              //             .children ==
                              //         null
                              //     ? ""
                              //     : state.ibProgramsModel.programData![i]
                              //         .bookingAvailability!.children;
                              final cottagemaxExtraGuestCount = "";
                              //  state
                              //             .ibProgramsModel
                              //             .programData![i]
                              //             .cottage!
                              //             .maxExtraGuestCount ==
                              //         null
                              //     ? ""
                              //     : state.ibProgramsModel.programData![i].cottage!
                              //         .maxExtraGuestCount;
                              final cottagemaxExtraIndianCount = "";
                              //  state
                              //             .ibProgramsModel
                              //             .programData![i]
                              //             .cottage!
                              //             .maxExtraIndianCount ==
                              //         null
                              //     ? ""
                              //     : state.ibProgramsModel.programData![i].cottage!
                              //         .maxExtraIndianCount;
                              final cottagemaxExtraForeignerCount = "";
                              // state
                              //             .ibProgramsModel
                              //             .programData![i]
                              //             .cottage!
                              //             .maxExtraForeignerCount ==
                              //         null
                              //     ? ""
                              //     : state.ibProgramsModel.programData![i].cottage!
                              //         .maxExtraForeignerCount;
                              final cottagemaxExtraChildrenCount = "";
                              // state
                              //             .ibProgramsModel
                              //             .programData![i]
                              //             .cottage!
                              //             .maxExtraChildrenCount ==
                              //         null
                              //     ? ""
                              //     : state.ibProgramsModel.programData![i].cottage!
                              //         .maxExtraChildrenCount;
                              final activities1 = "";

                              // state
                              //             .ibProgramsModel
                              //             .programData![i]
                              //             .cottage!
                              //             .activities!
                              //             .length ==
                              //         0
                              //     ? ""
                              //     : "";
                              final activities2 = "";
                              //  state
                              //             .ibProgramsModel
                              //             .programData![0]
                              //             .cottage!
                              //             .activities!
                              //             .length ==
                              //         2
                              //     ? ""
                              //     : "";
                              final activities3 = "";
                              // state
                              //             .ibProgramsModel
                              //             .programData![i]
                              //             .cottage!
                              //             .activities!
                              //             .length ==
                              //         3
                              //     ? ""
                              //     : "";
                              final activities4 = "";
                              //  state
                              //             .ibProgramsModel
                              //             .programData![i]
                              //             .cottage!
                              //             .activities!
                              //             .length ==
                              //         4
                              //     ? ""
                              //     : "";

                              ////////////////////////////////////
                              final photos = "";

                              // state.ibProgramsModel.programData![i]
                              //             .photos!.length ==
                              //         0
                              //     ? ""
                              //     : state
                              //         .ibProgramsModel.programData![i].photos![0];

                              if (progName!.isEmpty || progName.isEmpty) {
                                return;
                              } else {
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
                                  'bookingAvailabilityindian':
                                      bookingAvailabilityindian,
                                  'bookingAvailabilityforeigner':
                                      bookingAvailabilityforeigner,
                                  'bookingAvailabilitychildren':
                                      bookingAvailabilitychildren,
                                  'cottagemaxExtraGuestCount':
                                      cottagemaxExtraGuestCount,
                                  'cottagemaxExtraIndianCount':
                                      cottagemaxExtraIndianCount,
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

///////to check wheher ther is ther in the list or not

////////////

                                List items = await getAllIbProgramdata();

                                for (int r = 0; r < items.length; r++) {
                                  if (state
                                          .ibProgramsModel.programData![i].id ==
                                      items[r]['_id']) {
                                    isMatched = true;
                                  }
                                }
                                if (isMatched == false) {
                                  addIBprogramsdata(data);
                                }

                                if (i ==
                                    state.ibProgramsModel.programData!.length -
                                        1) {
                                  setState(() {
                                    istart = false;
                                    downloading = false;
                                  });
                                }
                              }
                            }
                          }
                          done = false;
                          setState(() {});

                          ///for slot database/////

                          ////////         /    //////////////////////////////////////////
                        }
                      }
                    }),
                  ),

                  // downloading == true ? showCircular(context) : Container(),
/////////for uploading data reservation data

                  Container(
                    child: BlocConsumer<IBReservationdatauploadBloc,
                            StateIbReservationdataupload>(
                        builder: (context, state) {
                      if (state is ReservationdataUploaded) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                        );
                      } else {
                        return Center();
                      }
                    }, listener: (context, state) {
                      if (state is ReservationdataUploaded) {
                        if (state.items4!.isNotEmpty) {
                          for (int i = 0; i < state.items4!.length; i++) {
                            BlocProvider.of<GetIbReservationDetailedsBloc>(
                                    context)
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
                              foodPreference: state.items4![i]
                                  ['foodpreference'],
                              numberOfVehicles: state.items4![i]
                                  ['numberofVehicle'],
                              vehicleNumbers: state.items4![i]
                                  ['vehicleNumbers'],
                              details: state.items4![i]['details'],
                            ));

                            //////to add to reservation list
                            ///

                            final reservedcount =
                                state.items4![i]['numberofRooms'] == null
                                    ? ""
                                    : state.items4![i]['numberofRooms'];

                            final status = "";

                            final foodprefered =
                                state.items4![i]['foodpreference'] == null
                                    ? ""
                                    : state.items4![i]['foodpreference'];

                            final vehicleno =
                                state.items4![i]['vehicleNumbers'] == null
                                    ? ""
                                    : state.items4![i]['vehicleNumbers'];

                            final bookingid = "";

                            final bookingdate =
                                state.items4![i]['bookingdate'] == null
                                    ? ""
                                    : state.items4![i]['bookingdate'];

                            final slotid =
                                state.items4![i]['slotdetailsid'] == null
                                    ? ""
                                    : state.items4![i]['slotdetailsid'];
                            final slotprogramid =
                                state.items8![i]['programid'] == null
                                    ? ""
                                    : state.items8![i]['programid'];
                            final programName = "Hello";
                            //  ==
                            //         null
                            //     ? ""
                            //     : ibGetReservationDataModel
                            //         .data![j].slotDetail!.slot!.programme!.progName;

                            final programid =
                                state.items8![i]['programid'] == null
                                    ? ""
                                    : state.items8![i]['programid'];

                            final guestName =
                                state.items4![i]['guestname'] == null
                                    ? ""
                                    : state.items4![i]['guestname'];

                            final noofCompaningPerson = state.items4![i]
                                        ['numberofpersonaccompanying'] ==
                                    null
                                ? ""
                                : state.items4![i]
                                    ['numberofpersonaccompanying'];

                            final guestPhone =
                                state.items4![i]['guestphone'] == null
                                    ? ""
                                    : state.items4![i]['guestphone'];

                            final refered =
                                state.items4![i]['reference'] == null
                                    ? ""
                                    : state.items4![i]['reference'];

                            final referedPhone =
                                state.items4![i]['referencephone'] == null
                                    ? ""
                                    : state.items4![i]['referencephone'];

                            final email = state.items4![i]['email'] == null
                                ? ""
                                : state.items4![i]['email'];

                            final noofVehicles =
                                state.items4![i]['numberofVehicle'] == null
                                    ? ""
                                    : state.items4![i]['numberofVehicle'];

                            final details = state.items4![i]['details'] == null
                                ? ""
                                : state.items4![i]['details'];
                            final edited = "false";
                            final removed = "false";

                            if (slotid!.isEmpty || slotid.isEmpty) {
                              return null;
                            } else {
                              Map data = {
                                'reservedcount': reservedcount,
                                'status': status,
                                'foodprefered': foodprefered,
                                'vehicleno': vehicleno,
                                'bookingid': bookingid,
                                'bookingdate': bookingdate,
                                'slotid': slotid,
                                'slotprogramid': slotprogramid,
                                'programName': programName,
                                'programid': programid,
                                'guestName': guestName,
                                'NoofCompaningPerson': noofCompaningPerson,
                                'guestPhone': guestPhone,
                                'refered': refered,
                                'referedPhone': referedPhone,
                                'email': email,
                                'noofVehicles': noofVehicles,
                                'details': details,
                                'edited': edited,
                                'removed': removed,
                                'added': "false"
                              };
                              print(data);
                              getonlineresevationdata(data);
                            }
                          }
                        } else {}
                      }
                    }),
                  ),
///////////////////////////////////for uploading the halt
                  ///
                  ///

                  BlocConsumer<MarkAttendanceOfflineBloc, StateMarkAttendance>(
                      builder: (context, state) {
                    if (state is MarkingAttendance) {
                      return SizedBox();
                    } else {
                      return Center();
                    }
                  }, listener: (context, state) {
                    if (state is MarkingAttendance) {
                      if (state.items13!.length != 0) {
                        setState(() {
                          haltpending = true;
                          haltcount =
                              int.parse(state.items13!.length.toString());
                        });
                      }
                    }
                  }),

//////////////////////////////////////////////for uploading halt
////for taking the count of reservation
                  ///////
                  Container(
                    child: BlocConsumer<Ibreservation2datauploadBloc,
                            StateIbreservation2dataupload>(
                        builder: (context, state) {
                      if (state is ReservationdataRecived) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                        );
                      } else {
                        return Center();
                      }
                    }, listener: (context, state) {
                      if (state is ReservationdataRecived) {
                        if (state.items4!.isNotEmpty) {
                          setState(() {
                            counton = true;
                            count = state.items4!.length;
                          });
                        } else {
                          setState(() {
                            counton = false;
                          });
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
                        BlocProvider.of<IBReservationdeleteBloc>(context)
                            .add(GetIbreservationdatadeleteData());

                        // fetcher();
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
              ),
              // downloading!
              //     ? Positioned(
              //         top: MediaQuery.of(context).size.height * .40,
              //         right: MediaQuery.of(context).size.width * .40,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Text(
              //               "Downloading..",
              //               style: TextStyle(color: Colors.green),
              //             ),
              //             SizedBox(
              //               height: 5,
              //             ),
              //             CircularProgressIndicator(
              //               color: Colors.green,
              //             ),
              //           ],
              //         ))
              //     : SizedBox()
            ],
          ),
        ),
        onRefresh: () async {
          fetcher();
        },
      ),
    );
  }

  Widget theDrawer() {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.6,
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
                        height: 30,
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
//////
///////////
                ///for ic remove
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IcViewUnits()));
                  },
                  leading: const Icon(Icons.view_agenda, color: Colors.white),
                  title: const Text(
                    "Units",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),

                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewRequestMain()));
                  },
                  leading: const Icon(Icons.view_agenda, color: Colors.white),
                  title: const Text(
                    "Request",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
/////for reuse immedialty
                // ListTile(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => SendRequestIctoIc(
                //                 requesttype: "New Purchase")));
                //   },
                //   leading: const Icon(Icons.view_agenda, color: Colors.white),
                //   title: const Text(
                //     "New Request",
                //     style: TextStyle(
                //         fontWeight: FontWeight.bold, color: Colors.white),
                //   ),
                // ),

                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewPurchaseOrder()));
                  },
                  leading: const Icon(Icons.view_agenda, color: Colors.white),
                  title: const Text(
                    "My Purchase",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
////
                ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => IcLogmain()));
                  },
                  leading: const Icon(Icons.view_agenda, color: Colors.white),
                  title: const Text(
                    "My Assets Log ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),

                ListTile(
                  onTap: () {
                    PrefManager.clearToken();

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                  leading:
                      const Icon(Icons.logout_outlined, color: Colors.white),
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
      ),
    );
  }

  void datasync() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Welcome'),
          content: SizedBox(
            height: 60,
            child: Column(children: [
              uploadon == true
                  ? Container()
                  : InkWell(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Download Data'),
                            InkWell(
                              child: Icon(Icons.download),
                            )
                          ]),
                      onTap: () async {
                        //  Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ICDownloadPage()));
                        items48.isNotEmpty
                            ? BlocProvider.of<GetEchoShopProductBloc>(context)
                                .add(ImageDownloadProduct())
                            : "";
                        // BlocProvider.of<GetEchoShopProductBloc>(context)
                        //     .add(ImageDownloadProduct());
                        final data = "true";
                        Map map = {"data": data};

                        await insertcheckdataonline(map);

                        await PrefManager.setOnline("done");

                        // await PrefManager.setOnline("done");
                        await deletefullnewrequestnewassets();
                        await deletefullassetswithoutrequest();
                        testinternet();
                        void _startdownloading() async {
                          ///
                          ///
                          ///   ///for purchase view
                          // BlocProvider.of<GetViewPurchaseOrderBloc>(context)
                          //     .add(FetchViewPurchaseOrderEvent());
                          //log
                          // BlocProvider.of<GetIcLogmainBloc>(context)
                          //     .add(GetIcLogmain());

                          // BlocProvider.of<GetViewallAssetsBloc>(context)
                          //     .add(GetViewallAssetsEvent());   ///product download
                          ///upload reservation edit ///
                          BlocProvider.of<GetViewRequestMainBloc>(context)
                              .add(FetchofflineRequestMainEvent());
                          BlocProvider.of<GetIcViewUnitsBloc>(context)
                              .add(RefreshIcViewUnitsEvent());
                          BlocProvider.of<GetNewPurchasedropBloc>(context)
                              .add(GetNewPurchasedropEvent());
                          BlocProvider.of<GetEchoShopProductBloc>(context)
                              .add(OnlineProductsandDownload());

                          // BlocProvider.of<GetViewRequestMainBloc>(context)
                          //     .add(GetViewRequestMainEvent(
                          //   filters: "",
                          // ));
////
                          ///
                          setState(() {
                            downloading = true;
                          });

                          BlocProvider.of<GetEchoShopProductBloc>(context)
                              .add(GetProductsandDownload());
                          //new
                          BlocProvider.of<GetViewallAssetsBloc>(context)
                              .add(GetViewallAssetsEvent());
//////newly added for download
                          BlocProvider.of<GetViewPurchaseOrderBloc>(context)
                              .add(FetchViewPurchaseOrderEvent());
                          // BlocProvider.of<GetViewPurchaseOrderBloc>(context)
                          //     .add(GetViewPurchaseOrderEvent());

                          BlocProvider.of<GetIcLogmainBloc>(context)
                              .add(GetIcLogmain());
                          BlocProvider.of<GetIcViewUnitsBloc>(context)
                              .add(GetIcViewUnitsEvent());
                          BlocProvider.of<GetViewAllEmployeeBloc>(context)
                              .add(GetViewAllEmployeeEvent());
                          //////////////////new end///////
                          //for geting the holidays///important to activate
                          //  BlocProvider.of<GetIBGetHolidaysBloc>(context)
                          //                 .add(GetIBGetHolidaysEvent());
//
                          //////////////////////////////IB Urgent start/////////////////////////////
                          ////////
                          // /needed//regular///
                          BlocProvider.of<IBProgramdeleteBloc>(context)
                              .add(GetIbdeleteData());

                          BlocProvider.of<GetReportHaltBloc>(context)
                              .add(ReportHaltEvent(
                            from: "",
                            to: "",
                            empId: "",
                            date: "",
                          ));

                          BlocProvider.of<GetAttendanceReportBloc>(context)
                              .add(GetAttendanceReport(
                            requestId: "jghj",
                          ));

                          // await createFolder2(context);
                          /////

                          // // // ////        ///delete alll
                          // // // // BlocProvider.of<IBProgramdeleteBloc>(context)
                          // // // //     .add(GetIbdeleteData());
                          // // // //for import new data
                          // // // // /employee list

//////
////////
                          BlocProvider.of<GetViewEmployeeListBloc>(context)
                              .add(GetViewEmployeeListEvent());
                          BlocProvider.of<GetIBGetReservationsBloc>(context)
                              .add(GetIBGetReservationsEvent());

                          BlocProvider.of<GetIBprogramBloc>(context)
                              .add(GetIBprogramEvent());
                          ////////////////////////////////////////Ib ////////
                          // fetcher();

                          setState(() {
                            // Navigator.pop(context);
                            done = true;
                          });
                        }

                        // Navigator.pop(context);
                        interneton != true
                            ? Fluttertoast.showToast(
                                backgroundColor: Colors.white,
                                msg: "No Internet connection for Download",
                                textColor: Colors.black)
                            : _startdownloading();

                        ///                   //////////////////////////////IB Urgent end/////////////////////////////
                      },
                    ),
              SizedBox(
                height: 5,
              ),
              uploadon == true
                  ? InkWell(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Upload Data'),
                            InkWell(
                                child: Icon(Icons.upload),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CommonSyncPage()));
                                })
                          ]),
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommonSyncPage()));
                      },
                    )
                  : SizedBox(),
            ]),
          ),
        );
      },
    );

    setState(() {});
  }

  Route _createRoute(_path) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => _path,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  downloadImage2(BuildContext? context, String? coverimage2) async {
    var thePath;
    try {
      var url = WebClient.imageIp + coverimage2!;
      http.Response response = await http.get(Uri.parse(url));
      print(url);
      print(coverimage2);

      var filePathAndName = '${newPath!.path}$coverimage2';
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

  Widget showCircular(BuildContext context) {
    return showDialog(
        barrierColor: Colors.black87,
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Downloading..",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 3,
              ),
              CircularProgressIndicator()
            ]),
          );
        }) as Widget;
  }

  createFolder2(BuildContext context) async {
    var status = await Permission.storage.status;
    print(status);
    if (status == PermissionStatus.denied) {
      await Permission.storage.request();
      status = await Permission.storage.status;
      print("now the status is + " + status.toString());
    }
    if (status == PermissionStatus.granted) {
      Directory directory = await getApplicationDocumentsDirectory();
      path = directory.path.toString() + "/parambikulam/";

      newPath = Directory(path);
      bool isExists = await newPath!.exists();
      print(newPath);
      if (isExists) {
        newPath!.deleteSync(recursive: true);
        newPath!.create();
      } else {
        await newPath!.create();
        print("false");
      }
      // if (directory.path / "param".exists()) {}
      // print(directory);
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

class ViewAssetsModel {
  String? assetname;
  String? quantity, description, assetid, producttype;

  String? date;

  ViewAssetsModel({
    this.assetname,
    this.quantity,
    this.date,
    this.description,
    this.assetid,
    this.producttype,
  });
}
