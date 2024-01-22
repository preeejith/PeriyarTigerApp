//real Page////new work
////
///
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:parambikulam/data/models/echoshopdownloadmodel.dart'
    as echomodel;

import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';
import 'package:parambikulam/ui/assets/products/productmaindetailedview.dart';

class ViewProductMain extends StatefulWidget {
  const ViewProductMain({Key? key}) : super(key: key);

  @override
  State<ViewProductMain> createState() => _ViewProductMainState();
}

//
class _ViewProductMainState extends State<ViewProductMain> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController producttypecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();

  final TextEditingController salepricecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController discountcontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();
  echomodel.EchoShopProductDownloadModel echoShopProductDownloadModel =
      echomodel.EchoShopProductDownloadModel();
  echomodel.Data echoData = echomodel.Data();
  DatabaseHelper db = DatabaseHelper.instance;
  bool? interneton = false;
  bool? navdone = false;
  List items51 = [];
  List items58 = [];
////
  @override
  void initState() {
    fetcher();
    testinternet();
    super.initState();
  }

//////////////////
////////////////
  void fetcher() async {
    items51 = await getproductmastertabletabledata();
    print(items51);
    if (items51.isNotEmpty) {
      setState(() {
        navdone = true;
      });
    }

    items58 = await getproductimagesdata();
    print(items58);
    // BlocProvider.of<GetViewProductMainBloc>(context)
    //     .add(GetViewProductMainEvent());
    // print(await db.getEchoDownloadData());
    echoShopProductDownloadModel = await db.getEchoDownloadData();
    print(echoShopProductDownloadModel);
    setState(() {});
  }

  void testinternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      interneton = false;
    } else if (connectivityResult != ConnectivityResult.none) {
      interneton = false;
    }
  }

  ///
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text('My Products'),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                items51.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      )
                    : items51.length == 0
                        ? Center(child: Text("No Product Available"))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: items51.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return items51[index]['remove'] == "true"
                                  ? SizedBox()
                                  : ListTile(
                                      title: InkWell(
                                      child: Column(children: [
                                        InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  2,
                                              // height: MediaQuery.of(context).size.height / 3.5,
                                              decoration: BoxDecoration(
                                                color: Color(0xfff292929),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 4,
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        items58.isNotEmpty
                                                            ? Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    6,
                                                                width: 100,
                                                                decoration:
                                                                    new BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        FileImage(
                                                                      File(
                                                                        items58[index]
                                                                            [
                                                                            'imageurl'],
                                                                      ),
                                                                    ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    6,
                                                                width: 100,
                                                                decoration:
                                                                    new BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  image:
                                                                      DecorationImage(
                                                                    image: AssetImage(
                                                                        "assets/echobag.png"),
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .45,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3,
                                                                      child:
                                                                          Text(
                                                                        items51[index]
                                                                            [
                                                                            'productname'],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  items51[index]
                                                                      [
                                                                      'speciality'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  d1.format(DateTime
                                                                          .parse(
                                                                              convert(
                                                                        items51[index]
                                                                            [
                                                                            'date'],
                                                                      ))) +
                                                                      " | " +
                                                                      d2.format(
                                                                          DateTime.parse(convert(items51[index]
                                                                              [
                                                                              'date']))),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              22,
                                                        ),
                                                        Container(
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          6.0),
                                                                  child:
                                                                      InkWell(
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    onTap: () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            // title:
                                                                            //     Text('Welcome'),
                                                                            content:
                                                                                Text('Do you want to delete the product..?'),
                                                                            actions: [
                                                                              MaterialButton(
                                                                                textColor: Colors.white,
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Text('NO'),
                                                                              ),
                                                                              MaterialButton(
                                                                                textColor: Colors.white,
                                                                                onPressed: () async {
                                                                                  getupdatechangestatusmastertabledata("true", items51[index]['idno']);
                                                                                  fetcher();
                                                                                  Map map2 = {
                                                                                    "productid": items51[index]['_id'].toString(),
                                                                                    "added": items51[index]['added'].toString()
                                                                                  };
                                                                                  await insertproductdeleteid(map2);
                                                                                  Navigator.pop(context);

                                                                                  // deleteproductmastertable(
                                                                                  //     items51[index]
                                                                                  //         [
                                                                                  //         'idno']);
                                                                                },
                                                                                child: Text('YES'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );

                                                                      // Navigator.pushReplacement(
                                                                      //     context,
                                                                      //     MaterialPageRoute(
                                                                      //         builder: (context) => AssestsHomePage()));
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    8,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          /////
                                          onTap: () {
                                            items51.length == 0
                                                ? SizedBox()
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetailedMainView(
                                                              index: index,
                                                            )),
                                                  );
//
                                            // setState(() {});
                                          },
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ]),
                                    ));
                            },
                          ),
              ],
            ),
          ],
        ),
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
