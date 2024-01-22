import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:parambikulam/bloc/assets/echoshop/downloadechoproducts.dart';
import 'package:parambikulam/bloc/assets/echoshop/placeorderbloc.dart';
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
import 'package:parambikulam/ui/assets/echoshoppages/echosale/echodownloaddata.dart';
import 'package:parambikulam/ui/assets/echoshoppages/new/myrequestview.dart';
import 'package:parambikulam/ui/assets/echoshoppages/productsale/echoproductview.dart';
import 'package:parambikulam/ui/assets/echoshoppages/productsale/salesreport.dart';
import 'package:parambikulam/ui/assets/echoshoppages/productsale/todaysSale.dart';
import 'package:parambikulam/ui/assets/ic_main/homepage/assetview.dart';
import 'package:parambikulam/ui/assets/profilepage.dart';
import 'package:parambikulam/ui/assets/sendrequest/sendrequestpage.dart';
import 'package:parambikulam/utils/pref_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class EchoShopHomePage extends StatefulWidget {
  const EchoShopHomePage({Key? key}) : super(key: key);

  @override
  State<EchoShopHomePage> createState() => _EchoShopHomePageState();
}

class _EchoShopHomePageState extends State<EchoShopHomePage> {
  String? token;
  int newrequestcount = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  int stockrequestcount = 0;
  int totalcount = 0;
  AppUpdateInfo? _updateInfo;
  String uploadcount = "0";

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
    getData();
    fetcher();
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

  downloaddata() {
    BlocProvider.of<GetEchoShopProductBloc>(context)
        .add(ImageDownloadProduct());
    BlocProvider.of<GetViewProfileBloc>(context).add(GetViewProfileEvent());

    BlocProvider.of<GetViewallAssetsBloc>(context).add(GetViewallAssetsEvent());

    BlocProvider.of<GetViewMyRequestBloc>(context).add(GetViewMyRequestEvent());

    BlocProvider.of<GetEchoShopProductBloc>(context)
        .add(GetProductsandDownload());

    BlocProvider.of<GetEchoShopProductBloc>(context).add(GetSalesReport());
  }

  void fetcher() async {
    stockrequestcount = 0;
    newrequestcount = 0;
    DatabaseHelper db = DatabaseHelper.instance;
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

    var uploadData = await db.getPlaceorderData();
    uploadcount = (uploadData.length + totalcount).toString();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: theDrawer(),
      appBar: new AppBar(
        title: new Text('Echo Shop '),
        actions: <Widget>[
          SizedBox(
            child: BlocConsumer<GetEchoShopPlaceOrderBloc,
                EchoShopPlaceOrderState>(listener: (context, state) {
              if (state is UploadDone) {
                downloaddata();
                fetcher();
                BlocProvider.of<GetEchoShopProductBloc>(context)
                    .add(GetProductsandDownload());
              }
            }, builder: (context, state) {
              if (state is EchoShopPlacingOrder) {
                return SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 3,
                    ),
                  ),
                );
              } else {
                return uploadcount == "0"
                    ? IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(msg: "No data left to upload");
                        },
                        icon: Icon(Icons.upload),
                      )
                    : badge.Badge(
                        badgeColor: Color(0XFF53A874),
                        position: badge.BadgePosition.topEnd(top: 3, end: 5),
                        padding: const EdgeInsets.all(5.0),
                        badgeContent: Text(
                          uploadcount,
                        ),
                        child: IconButton(
                          onPressed: () {
                            const snackBar = SnackBar(
                              content: Text('Uploading data'),
                            );
                            BlocProvider.of<GetSendRequestBloc>(context)
                                .add(FetchSendRequest());
                            BlocProvider.of<GetRequestUpdationBloc>(context)
                                .add(FetchRequestUpdation());
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            BlocProvider.of<GetEchoShopPlaceOrderBloc>(context)
                                .add(PlaceOrder());
                            fetcher();
                          },
                          icon: Icon(Icons.upload),
                        ));
              }
            }),
          ),
//           uploadcount != "0"
//               ? SizedBox()
//               : IconButton(
//                   onPressed: () {
//                     BlocProvider.of<GetEchoShopProductBloc>(context)
//                         .add(ImageDownloadProduct());
//                     BlocProvider.of<GetEchoShopProductBloc>(context)
//                         .add(GetProductsandDownload());
//                     BlocProvider.of<GetViewallAssetsBloc>(context)
//                         .add(GetViewallAssetsEvent());
//                     BlocProvider.of<GetViewProfileBloc>(context)
//                         .add(GetViewProfileEvent());
// // /////unitsrequestview
//                     BlocProvider.of<GetViewMyRequestBloc>(context)
//                         .add(GetViewMyRequestEvent());
//                     // synData(context, state);
//                   },
//                   icon: Icon(Icons.download),
//                 ),

          uploadcount != "0"
              ? SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height / 12,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Download Data'),
                                        Icon(Icons.download)
                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      BlocProvider.of<GetEchoShopProductBloc>(
                                              context)
                                          .add(ImageDownloadProduct());
                                      BlocProvider.of<GetViewProfileBloc>(
                                              context)
                                          .add(GetViewProfileEvent());

                                      BlocProvider.of<GetViewallAssetsBloc>(
                                              context)
                                          .add(GetViewallAssetsEvent());

                                      BlocProvider.of<GetViewMyRequestBloc>(
                                              context)
                                          .add(GetViewMyRequestEvent());

                                      BlocProvider.of<GetEchoShopProductBloc>(
                                              context)
                                          .add(GetProductsandDownload());

                                      BlocProvider.of<GetEchoShopProductBloc>(
                                              context)
                                          .add(GetSalesReport());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EchoDownloadPage()));
                                    },
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 0.0),
                                //   child: Row(
                                //     children: [
                                //       Text('Upload Data'),
                                //       Icon(Icons.upload)
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.sync_outlined),
                ),
          InkWell(
            onTap: () {
              AlertDialog alertDialog = AlertDialog(
                  title: Text("Logout"),
                  content: Text("Would you like to logout from the app ?"),
                  actions: [
                    Padding(
                        padding: EdgeInsets.all(12.0),
                        child: TextButton(
                            child: Text(
                              "Ok",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              PrefManager.clearToken();

                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                            }))
                  ]);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alertDialog;
                  });
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
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
                height: MediaQuery.of(context).size.height / 15,
                child: MaterialButton(
                  child: const Text(
                    "SALE START",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EchoShopProducts()));
                  },
                  // color: AppStyles.appColor,
                  color: const Color(0xff59AF73),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Container(
                child: Column(
                  children: [
                    Divider(),
                    Icon(
                      Icons.all_inbox,
                      size: 50,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: MaterialButton(
                        color: Colors.white,
                        child: Text(
                          "Sales Report",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SalesReport()));
                        },
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            )
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
                          builder: (context) =>
                              AssetViewPage(unit: "Echo Shop")));
                },
                leading: const Icon(Icons.all_inbox, color: Colors.white),
                title: const Text(
                  "Assets  ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TodaysSale()));
                },

                ///
                leading: const Icon(Icons.all_inbox, color: Colors.white),
                title: const Text(
                  "Pending Sales",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SalesReport()));
                },
                leading: const Icon(Icons.all_inbox, color: Colors.white),
                title: const Text(
                  "Sales Report",
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
                                homenav: 'echoshop',
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
}
