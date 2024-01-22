import 'package:badges/badges.dart' as badge;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequestbloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequestevent.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofilebloc.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofileevent.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/requestupdationbloc/requestupdationbloc.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/requestupdationbloc/requestupdationevent.dart';

import 'package:parambikulam/bloc/assets/sendrequestbloc/sendrequestbloc.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/sendrequestevent.dart';

import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsbloc.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsevent.dart';

import 'package:parambikulam/local/db/dbhelper.dart';

import 'package:parambikulam/ui/assets/echoshoppages/new/myrequestview.dart';
import 'package:parambikulam/ui/assets/ic_main/homepage/assetview.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';
import 'package:parambikulam/ui/assets/profilepage.dart';
import 'package:parambikulam/ui/assets/sendrequest/sendrequestpage.dart';

import 'package:parambikulam/utils/pref_manager.dart';
import 'package:badges/badges.dart' as badges;

class ProductionUnitHomePage extends StatefulWidget {
  const ProductionUnitHomePage({Key? key}) : super(key: key);

  @override
  State<ProductionUnitHomePage> createState() => _ProductionUnitHomePageState();
}

class _ProductionUnitHomePageState extends State<ProductionUnitHomePage> {
  String? token;
  List items66 = [];
  int newrequestcount = 0;
  int stockrequestcount = 0;
  int totalcount = 0;
  bool? interneton = false;
  String dropdownvalue = 'Non consumable';
  var items = [
    'Non consumable',
    'Consumable',
  ];

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController producttypecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();

  final TextEditingController salepricecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController discountcontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();

  @override
  void initState() {
    fetcher();
    teststate();
    testinternet();
    // _showDialog();
    super.initState();
  }

  void teststate() async {
    items66 = await getproductionunitcheckdataonlinedata();
    items66.isEmpty ? testinternetstart() : SizedBox();

    // items66.isEmpty
    //     ? BlocProvider.of<GetEchoShopProductBloc>(context)
    //         .add(ImageDownloadProduct())
    //     : "";
  }

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

  void testinternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      interneton = false;
    } else if (connectivityResult != ConnectivityResult.none) {
      interneton = true;
    }
  }

////////
//////
  void fetcher() async {
    stockrequestcount = 0;
    newrequestcount = 0;
    BlocProvider.of<GetViewallAssetsBloc>(context)
        .add(FetchViewallAssetsEvent());

    DatabaseHelper? db = DatabaseHelper.instance;

    List items29 = [];
    items29 = await db.getUnitNewRequestListDownloadData();

    List items31 = [];

    items31 = await db.getICRequestSendingListDownloadData();

    if (items29.isNotEmpty) {
      newrequestcount = items29.length;
    }

    if (items31.isNotEmpty) {
      stockrequestcount = items31.length;
    }
    setState(() {
      totalcount = 0;
      totalcount = newrequestcount + stockrequestcount;
      print(newrequestcount);
      print(stockrequestcount);
    });

    print(totalcount);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: theDrawer(),
      appBar: new AppBar(
        title: new Text('Home'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              PrefManager.clearToken();

              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
            icon: Icon(
              Icons.logout_outlined,
              size: 18,
            ),
          ),
          badge.Badge(
            badgeColor: totalcount == 0
                ? Colors.transparent
                : Color.fromARGB(255, 221, 6, 45),
            position: badge.BadgePosition.topEnd(top: 1, end: 2),
            padding: const EdgeInsets.all(5.0),
            badgeContent: totalcount == 0
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(totalcount.toString()),
                  ),
            child: IconButton(
              onPressed: () async {
                print("yes");

                // BlocProvider.of<GetViewMyRequestBloc>(context)
                //     .add(OnlinedataViewMyRequestEvent());
                datasync();

                ///
                //  synData(context, state);
              },
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
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  child: Icon(
                    Icons.shopping_basket,
                    size: 100,
                  ),
                ),
              ),
              ClipRRect(
                // borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: MaterialButton(
                    child: const Text(
                      "ASSETS VIEW",
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          _createRoute(AssetViewPage(unit: "production")));
                    },
                    // color: AppStyles.appColor,
                    color: const Color(0xff59AF73),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              // ClipPath(
              //   clipper: WaveClipperOne(reverse: true),
              //   child: Container(
              //     height: 120,
              //     color: Color(0xfff68D389),
              //   ),
              // ),
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
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: const BoxDecoration(
                color: Color(0xff59AF73),
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
                          builder: (context) => const SendRequestMasterPage(
                                homenav: 'productionunit',
                              )));
                },
                leading: const Icon(Icons.all_inbox, color: Colors.white),
                title: const Text(
                  "Request",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyRequestView()));
                },
                leading: const Icon(Icons.all_inbox, color: Colors.white),
                title: const Text(
                  "My Request ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              ///
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AssetViewPage(unit: "productionunit")));
                },
                leading: const Icon(Icons.all_inbox, color: Colors.white),
                title: const Text(
                  "Assets View ",
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

  void datasync() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 60,
            child: Column(children: [
              totalcount != 0
                  ? SizedBox()
                  : InkWell(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Download Data'),
                            Icon(Icons.download)
                          ]),
                      onTap: () async {
                        final data = "true";
                        Map map = {"data": data};

                        await insertproductionunitcheckdataonlinedataonline(
                            map);

                        BlocProvider.of<GetViewallAssetsBloc>(context)
                            .add(RefreshViewallAssetsEvent());
                        testinternet();

                        void _startdownloading() async {
                          Fluttertoast.showToast(
                              backgroundColor: Colors.white,
                              msg: "Data Downloading",
                              textColor: Colors.black);
                          BlocProvider.of<GetViewMyRequestBloc>(context)
                              .add(OnlinedataViewMyRequestEvent());

                          //    BlocProvider.of<GetViewallAssetsBloc>(context)
                          // .add(GetViewallAssetsEvent());
                          BlocProvider.of<GetViewallAssetsBloc>(context)
                              .add(GetViewallAssetsEvent());
                          BlocProvider.of<GetViewProfileBloc>(context)
                              .add(GetViewProfileEvent());

                          BlocProvider.of<GetViewMyRequestBloc>(context)
                              .add(GetViewMyRequestEvent());
                          Fluttertoast.showToast(
                              backgroundColor: Colors.white,
                              msg: "Download Successfully done",
                              textColor: Colors.black);
                          setState(() {
                            Navigator.pop(context);
                          });
                        }

                        interneton != true
                            ? Fluttertoast.showToast(
                                backgroundColor: Colors.white,
                                msg: "No Internet connection for Download",
                                textColor: Colors.black)
                            : _startdownloading();
                      },
                    ),
              SizedBox(
                height: 5,
              ),
              totalcount == 0
                  ? SizedBox()
                  : InkWell(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Upload Data' +
                                "(" +
                                totalcount.toString() +
                                ")"),
                            Icon(Icons.upload)
                          ]),
                      onTap: () {
                        setState(() {
                          totalcount = 0;
                        });

                        testinternet();
                        void _startuploading() {
                          BlocProvider.of<GetSendRequestBloc>(context)
                              .add(FetchSendRequest());

                          BlocProvider.of<GetRequestUpdationBloc>(context)
                              .add(FetchRequestUpdation());
                          // fetcher();
                          Fluttertoast.showToast(
                              backgroundColor: Colors.white,
                              msg: "Data Uploading",
                              textColor: Colors.black);
                          Fluttertoast.showToast(
                              backgroundColor: Colors.white,
                              msg: "Data Uploaded",
                              textColor: Colors.black);

                          Navigator.pop(context);
                        }

                        interneton != true
                            ? Fluttertoast.showToast(
                                backgroundColor: Colors.white,
                                msg: "No Internet connection for upload ",
                                textColor: Colors.black)
                            : _startuploading();
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
