import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:parambikulam/bloc/assets/sendrequestbloc/sendrequestbloc.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/sendrequestevent.dart';

import 'package:parambikulam/ui/assets/bottombarunits.dart';
import 'package:parambikulam/ui/assets/bottomnavechoshop.dart';

// /////////////
class SendRequestPage extends StatefulWidget {
  final String requesttype;
  final String homenav;
  const SendRequestPage(
      {Key? key, required this.requesttype, required this.homenav})
      : super(key: key);
  @override
  State<SendRequestPage> createState() => _SendRequestPageState();
}

class _SendRequestPageState extends State<SendRequestPage> {
  final TextEditingController assetnamecontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();
  final TextEditingController typecontroller = TextEditingController();
  final TextEditingController typeofrequestcontroller = TextEditingController();

  @override
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() async {
    // token = await PrefManager.getToken();

    setState(() {
      typecontroller.text = 'asset';
      typeofrequestcontroller.text = widget.requesttype.toString();
    });
  }

  // String? homenav = "echoshop";
  String dropdownvalue = 'New Purchase';
  var items = [
    'New Purchase',
    'transfer',
    'replace',
    'damage',
    'repair',
    'stock Updation'
  ];
  bool? buttonon = false;
  List<AssetrequestModel> assetrequestcartlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Request"), actions: [
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => SendRequestDetailed(
          //                 assetrequestcartlist: assetrequestcartlist)));
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
        ]),
        bottomNavigationBar: buttonon != true
            ? SizedBox()
            : SizedBox(
                height: 80,
                child: Column(
                  children: [
                    MaterialButton(
                      child: Text("SUBMIT",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12)),
                      height: 40,
                      minWidth: 300,

                      onPressed: () {
                        if (assetrequestcartlist.isEmpty) {
                          Fluttertoast.showToast(msg: "Please add Items ");
                        } else {
                          validateData();
                        }

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SnareDetails()));
                      },

                      // child: BlocConsumer<GetSendRequestBloc, SendRequestState>(
                      //     builder: (context, state) {
                      //   if (state is SendRequesting) {
                      //     return const SizedBox(
                      //       height: 18.0,
                      //       width: 18.0,
                      //       child: CircularProgressIndicator(
                      //         valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      //         strokeWidth: 2,
                      //       ),
                      //     );
                      //   } else {
                      //     return const Text(
                      //       "SUBMIT",
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.w600,
                      //           fontSize: 12),
                      //     );
                      //   }
                      // }, listener: (context, state) {
                      //   if (state is SendRequestsuccess) {
                      //     // groupid = state.snareWalkStartModel.data!.id;

                      //     Fluttertoast.showToast(
                      //         backgroundColor: Colors.white,
                      //         textColor: Colors.black,
                      //         msg: "Request Sended");
                      //     if (homenav == 'echoshop') {
                      //       Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) =>
                      //                   EchoShopBottomNavigation()));
                      //     } else {
                      //       Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => ProductionUnitHomePage()));
                      //     }
                      //   }
                      // }),

                      // color: AppStyles.appColor,
                      color: Colors.green,
                      // color: const Color(0xff59AF73),
                    ),
                  ],
                ),
              ),
        body: SingleChildScrollView(
          child: Container(
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(children: [
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        //noted
                        controller: assetnamecontroller,
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Asset Name',
                        ),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        //noted
                        maxLength: 5,
                        controller: quantitycontroller,
                        autocorrect: true,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        //noted
                        controller: remarkcontroller,
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Remark',
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: MaterialButton(
                          color: Colors.green,
                          child: Text(" Add Items"),
                          onPressed: () {
                            if (assetnamecontroller.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please Enter  Assetname");
                            } else if (quantitycontroller.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please Enter quantity");
                            } else if (remarkcontroller.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please Enter remark");
                            } else if (typecontroller.text.isEmpty) {
                              Fluttertoast.showToast(msg: "Please Enter type");
                            } else if (typeofrequestcontroller.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please Enter  typeof Request");
                            } else {
                              assetrequestcartlist.add(AssetrequestModel(
                                assetname: assetnamecontroller.text,
                                type: typecontroller.text,
                                quantity: quantitycontroller.text,
                                typeofrequest: typeofrequestcontroller.text,
                                remark: remarkcontroller.text,
                              ));
                              setState(() {
                                buttonon = true;
                                assetnamecontroller.clear();
                                quantitycontroller.clear();
                                remarkcontroller.clear();
                              });
                            }
                          },
                        ),
                      )
                    ])),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: assetrequestcartlist.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(9),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 4,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(""),
                                            InkWell(
                                              child: const Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.grey),
                                              onTap: () {
                                                setState(() {
                                                  assetrequestcartlist
                                                      .removeWhere((item) =>
                                                          item.assetname ==
                                                          assetrequestcartlist[
                                                                  index]
                                                              .assetname);
                                                });

                                                // participantlislist.removeAt(0);
                                              },
                                            ),
                                          ]),
                                    ),

                                    // Text("Hello"),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Name  :",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              assetrequestcartlist[index]
                                                  .assetname
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            )
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Quantity  :",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              assetrequestcartlist[index]
                                                  .quantity
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            )
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Remark  :",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              assetrequestcartlist[index]
                                                  .type
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            )
                                          ]),
                                    ),

// Text(widget.itemaddtocartlist.length.toString(),style: TextStyle(color: Colors.black),),
                                  ]),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      }),
                ),
              ]),
            ),
          ),
        ));
  }

  void validateData() {
    BlocProvider.of<GetSendRequestBloc>(context).add(GetSendRequest(
      assetrequestcartlist: assetrequestcartlist,
    ));

    Fluttertoast.showToast(
        backgroundColor: Colors.white,
        textColor: Colors.black,
        msg: "Request Sended");
    if (widget.homenav == 'echoshop') {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => EchoShopBottomNavigation()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => UnitsAssetsBottomNavigation()));
    }
  }
}

class AssetrequestModel {
  String? typeofrequest;
  String? type;

  String? quantity;
  String? assetname;
  String? remark;
  AssetrequestModel({
    this.typeofrequest,
    this.type,
    this.quantity,
    this.assetname,
    this.remark,
  });
}
