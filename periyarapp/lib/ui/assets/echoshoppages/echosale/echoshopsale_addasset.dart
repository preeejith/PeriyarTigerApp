import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsbloc.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsevent.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsstate.dart';

import 'package:parambikulam/ui/app/auth/loginnew.dart';

import 'package:parambikulam/ui/assets/profilepage.dart';

import 'package:parambikulam/utils/pref_manager.dart';

//
class EchoShopSalePage extends StatefulWidget {
  const EchoShopSalePage({Key? key}) : super(key: key);

  @override
  State<EchoShopSalePage> createState() => _EchoShopSalePageState();
}

class _EchoShopSalePageState extends State<EchoShopSalePage> {
  String? token;
  int? totalamount;
  int? sum = 0;
  String dropdownvalue = 'Non consumable';
  List<ItemtocartModel> itemaddtocartlist = [];
  var items = [
    'Non consumable',
    'Consumable',
  ];

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController producttypecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();

  final TextEditingController salepricecontroller = TextEditingController();

  final TextEditingController quantitycontroller2 = TextEditingController();

  final TextEditingController ticketcontroller2 = TextEditingController();

  final TextEditingController salepricecontroller2 = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController discountcontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();

  @override
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() async {
    BlocProvider.of<GetViewallAssetsBloc>(context).add(GetViewallAssetsEvent());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Echo Asset'),
        actions: <Widget>[
          // InkWell(
          //   onTap: () {
          //     // Navigator.push(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //         builder: (context) =>
          //     //             EchoCart(itemaddtocartlist: itemaddtocartlist)));
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: SizedBox(
          //       width: 40,
          //       height: 40,
          //       child: CircleAvatar(
          //         radius: 30.0,
          //         child: Icon(Icons.shopping_basket),
          //         backgroundColor: Colors.transparent,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<GetViewallAssetsBloc, ViewallAssetsState>(
                builder: (context, state) {
                  if (state is ViewallAssetsSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),

                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.viewAllAssetsModel.data.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  title: InkWell(
                                child: Column(children: [
                                  InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 4,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        "Assets Name:",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        state
                                                            .viewAllAssetsModel
                                                            .data[index]
                                                            .assetId
                                                            .name
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )
                                                    ]),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text("Description:",
                                                          style: TextStyle(
                                                              fontSize: 12)),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        state
                                                            .viewAllAssetsModel
                                                            .data[index]
                                                            .assetId
                                                            .description
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )
                                                    ]),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        "Quantity:",
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        state
                                                            .viewAllAssetsModel
                                                            .data[index]
                                                            .quantity
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )
                                                    ]),
                                                const SizedBox(
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: SizedBox(
                                                height: 30,
                                                width: 70,
                                                child: state
                                                            .viewAllAssetsModel
                                                            .data[index]
                                                            .change ==
                                                        false
                                                    ? MaterialButton(
                                                        child: Text("Add"),
                                                        color: Colors.grey,
                                                        onPressed: () {
                                                          setState(() {
                                                            state
                                                                .viewAllAssetsModel
                                                                .data[index]
                                                                .change = true;
                                                          });
                                                        })
                                                    : Row(children: [
                                                        InkWell(
                                                          child: Icon(
                                                            Icons.remove,
                                                          ),
//                                                               onTap: () {
//                                                                 // _decrementCount;
//                                                                 quantitycontroller
//                                                                         .text =
//                                                                     state
//                                                                         .viewAllAssetsModel
//                                                                         .data[
//                                                                             index]
//                                                                         .count
//                                                                         .toString();
//                                                                 setState(() {
//                                                                   state
//                                                                       .viewAllAssetsModel
//                                                                       .data[
//                                                                           index]
//                                                                       .count = state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .count! -
//                                                                       1;

//                                                                   state.viewAllAssetsModel.data[index].count! <
//                                                                           1
//                                                                       ? state.viewAllAssetsModel
//                                                                               .data[index].change =
//                                                                           false
//                                                                       : state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .change = true;

//                                                                   quantitycontroller.text = state
//                                                                       .viewAllAssetsModel
//                                                                       .data[
//                                                                           index]
//                                                                       .count
//                                                                       .toString();
//                                                                   assetsidcontroller
//                                                                           .text =
//                                                                       state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .assetId
//                                                                           .id;
//                                                                 });

// ////main

//                                                                 setState(() {
//                                                                   if (assetrequestcartlist
//                                                                       .isNotEmpty) {
//                                                                     final tile = assetrequestcartlist.firstWhere((item) =>
//                                                                         item.productid ==
//                                                                         state
//                                                                             .viewAllAssetsModel
//                                                                             .data[index]
//                                                                             .assetId
//                                                                             .id);
//                                                                     setState(() => tile.quantity = state
//                                                                         .viewAllAssetsModel
//                                                                         .data[
//                                                                             index]
//                                                                         .count
//                                                                         .toString());

//                                                                     if (assetrequestcartlist[assetrequestcartlist.length]
//                                                                             .productid !=
//                                                                         state
//                                                                             .viewAllAssetsModel
//                                                                             .data[index]
//                                                                             .assetId
//                                                                             .id) {
//                                                                       assetrequestcartlist
//                                                                           .add(
//                                                                               Assetrequest2Model(
//                                                                         productid: state
//                                                                             .viewAllAssetsModel
//                                                                             .data[index]
//                                                                             .assetId
//                                                                             .id,
//                                                                         type: typecontroller
//                                                                             .text,
//                                                                         quantity: state
//                                                                             .viewAllAssetsModel
//                                                                             .data[index]
//                                                                             .count
//                                                                             .toString(),
//                                                                         typeofrequest:
//                                                                             typeofrequestcontroller.text,
//                                                                         remark: state
//                                                                             .viewAllAssetsModel
//                                                                             .data[index]
//                                                                             .remarkcontroller
//                                                                             .text,
//                                                                       ));
//                                                                     }
//                                                                     // for (int k =
//                                                                     //         0;
//                                                                     //     k < assetrequestcartlist.length;
//                                                                     //     k++) {
//                                                                     //   if (assetrequestcartlist[assetrequestcartlist.length]
//                                                                     //           .productid !=
//                                                                     //       assetsidcontroller
//                                                                     //           .text) {
//                                                                     //   } else {
//                                                                     //     if (k ==
//                                                                     //         assetrequestcartlist.length) if (assetrequestcartlist[assetrequestcartlist.length]
//                                                                     //             .productid !=
//                                                                     //         assetsidcontroller.text)
//                                                                     //       assetrequestcartlist
//                                                                     //           .add(Assetrequest2Model(
//                                                                     //         productid:
//                                                                     //             state.viewAllAssetsModel.data[index].assetId.id,
//                                                                     //         type:
//                                                                     //             typecontroller.text,
//                                                                     //         quantity:
//                                                                     //             quantitycontroller.text,
//                                                                     //         typeofrequest:
//                                                                     //             typeofrequestcontroller.text,
//                                                                     //         remark:
//                                                                     //             state.viewAllAssetsModel.data[index].remarkcontroller.text,
//                                                                     //       ));
//                                                                     //   }
//                                                                     // }
//                                                                   } else {
//                                                                     assetrequestcartlist
//                                                                         .add(
//                                                                             Assetrequest2Model(
//                                                                       productid: state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .assetId
//                                                                           .id,
//                                                                       type: typecontroller
//                                                                           .text,
//                                                                       quantity: state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .count
//                                                                           .toString(),
//                                                                       typeofrequest:
//                                                                           typeofrequestcontroller
//                                                                               .text,
//                                                                       remark: state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .remarkcontroller
//                                                                           .text,
//                                                                     ));
//                                                                   }
//                                                                 });
//                                                               },
                                                        ),

                                                        state
                                                                    .viewAllAssetsModel
                                                                    .data[index]
                                                                    .count! <
                                                                0
                                                            ? Container()
                                                            : Text(state
                                                                .viewAllAssetsModel
                                                                .data[index]
                                                                .count
                                                                .toString()),
                                                        // Text(state),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        InkWell(
                                                          child:
                                                              Icon(Icons.add),
//                                                               onTap: () {
//                                                                 setState(() {
//                                                                   state
//                                                                       .viewAllAssetsModel
//                                                                       .data[
//                                                                           index]
//                                                                       .count = state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .count! +
//                                                                       1;

//                                                                   quantitycontroller.text = state
//                                                                       .viewAllAssetsModel
//                                                                       .data[
//                                                                           index]
//                                                                       .count
//                                                                       .toString();

//                                                                   assetsidcontroller
//                                                                           .text =
//                                                                       state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .assetId
//                                                                           .id;
//                                                                 });

//                                                                 setState(() {
//                                                                   if (assetrequestcartlist
//                                                                       .isNotEmpty) {
//                                                                     final tile = assetrequestcartlist.firstWhere((item) =>
//                                                                         item.productid ==
//                                                                         state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .assetId
//                                                                           .id);
//                                                                     setState(() => tile.quantity = state
//                                                                         .viewAllAssetsModel
//                                                                         .data[
//                                                                             index]
//                                                                         .count
//                                                                         .toString());

//                                                                     if (assetrequestcartlist[assetrequestcartlist.length ]
//                                                                             .productid !=
//                                                                          state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .assetId
//                                                                           .id) {
//                                                                       assetrequestcartlist
//                                                                           .add(
//                                                                               Assetrequest2Model(
//                                                                         productid:
//                                                                             state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .assetId
//                                                                           .id,
//                                                                         type: typecontroller
//                                                                             .text,
//                                                                         quantity: state
//                                                                             .viewAllAssetsModel
//                                                                             .data[index]
//                                                                             .count
//                                                                             .toString(),
//                                                                         typeofrequest:
//                                                                             typeofrequestcontroller.text,
//                                                                         remark: state
//                                                                             .viewAllAssetsModel
//                                                                             .data[index]
//                                                                             .remarkcontroller
//                                                                             .text,
//                                                                       ));
//                                                                     }

//                                                                     // for (int k =
//                                                                     //         0;
//                                                                     //     k < assetrequestcartlist.length;
//                                                                     //     k++) {
//                                                                     //   if (assetrequestcartlist[k]
//                                                                     //           .productid ==
//                                                                     //       assetsidcontroller
//                                                                     //           .text) {
//                                                                     //   } else {
//                                                                     //     if (k ==
//                                                                     //         assetrequestcartlist.length) {
//                                                                     //       if (assetrequestcartlist[assetrequestcartlist.length].productid !=
//                                                                     //           state.viewAllAssetsModel.data[index].assetId.id) {
//                                                                     //         assetrequestcartlist.add(Assetrequest2Model(
//                                                                     //           productid: state.viewAllAssetsModel.data[index].assetId.id,
//                                                                     //           type: typecontroller.text,
//                                                                     //           quantity: quantitycontroller.text,
//                                                                     //           typeofrequest: typeofrequestcontroller.text,
//                                                                     //           remark: state.viewAllAssetsModel.data[index].remarkcontroller.text,
//                                                                     //         ));
//                                                                     //       }
//                                                                     //     }
//                                                                     //   }
//                                                                     // }
//                                                                   } else {
//                                                                     assetrequestcartlist
//                                                                         .add(
//                                                                             Assetrequest2Model(
//                                                                       productid:
//                                                                            state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .assetId
//                                                                           .id,
//                                                                       type: typecontroller
//                                                                           .text,
//                                                                       quantity: state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .count
//                                                                           .toString(),
//                                                                       typeofrequest:
//                                                                           typeofrequestcontroller
//                                                                               .text,
//                                                                       remark: state
//                                                                           .viewAllAssetsModel
//                                                                           .data[
//                                                                               index]
//                                                                           .remarkcontroller
//                                                                           .text,
//                                                                     ));
//                                                                   }
//                                                                 });

// //
//                                                               },
                                                        ),
                                                      ]),
                                              ),
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
                                      //           EchoAssetsDetailedView(
                                      //               assetId: state
                                      //                   .viewAllAssetsModel
                                      //                   .data[index]
                                      //                   .assetId
                                      //                   .id)),
                                      // );

                                      // setState(() {});
                                    },
                                  ),

                                  //           Image.network(
                                  //   WebClient.imageUrl +
                                  //      state.viewEachReportModel
                                  //                 .records[index].photo[0]
                                  //                 ,
                                  //   width: 110,
                                  //   height: 180,
                                  // ),

                                  //  Image.network(
                                  //     WebClient.imageUrl +
                                  //      state.viewEachReportModel.records[index].photo.length.,
                                  //     width: 110,
                                  //     height: 180,
                                  //   ),
                                ]),
                              ));
                            },
                          ),

////ppng
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                listener: (context, state) {}),
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
                // image: const DecorationImage(
                //   image: AssetImage("assets/images/wti_logo.png"),
                //   // fit: BoxFit.cover,
                // ),
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
                      // child: CircleAvatar(
                      //   radius: 50.0,
                      //   backgroundImage: AssetImage(
                      //     "assets/images/wti_logo.png",
                      //   ),
                      //   backgroundColor: Colors.transparent,
                      // ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    // Text(
                    //   "Welcome to",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 18.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Text(
                    //   "Anti Snare Walk",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 20.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
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
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const ParticipentsPage()));
                // },
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  "####",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              ListTile(
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const SignupSuccess()));
                // },
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  "####",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              ListTile(
                  // onTap: () {
                  //   Navigator.pop(context);
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const Completesnarereport()));
                  // },
                  leading: const Icon(Icons.all_inbox, color: Colors.white),
                  title: const Text(
                    "All Reports",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              /////very very important

              //    ListTile(
              // onTap: () {
              //   Navigator.pop(context);
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>  MyPendingdata()));
              // },
              // leading: const Icon(Icons.all_inbox, color: Colors.blueGrey),
              // title: const Text(
              //   "Local Data",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold, color: Colors.blueGrey),
              // )),
              // ListTile(
              // onTap: () {
              //   Navigator.pop(context);
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               const SnareDetailsOffline()));
              // },
              // leading: const Icon(Icons.data_array, color: Colors.blueGrey),
              // title: const Text("Report a Snare")),
              // ListTile(
              //     onTap: () {
              //       Navigator.pop(context);
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) =>
              //                   const ParticipentsOfflinePage()));
              //     },
              //     leading: const Icon(Icons.data_array, color: Colors.blueGrey),
              //     title: const Text("Pending List")),
              ListTile(
                onTap: () {
                  PrefManager.clearToken();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginNew()));
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

class ItemtocartModel {
  String? name;
  String? type;
  String? id;
  int? quantity;
  int? salesPrice;
  int? totalamount;
  ItemtocartModel({
    this.name,
    this.type,
    this.id,
    this.quantity,
    this.salesPrice,
    this.totalamount,
  });
}
