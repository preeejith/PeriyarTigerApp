import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/sendictoicrequestbloc/sendictoicrequestbloc.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/sendictoicrequestbloc/sendictoicrequestevent.dart';

import 'package:parambikulam/ui/assets/bottomnav.dart';

// //////
class SendRequestIctoIc extends StatefulWidget {
  final String requesttype;
  const SendRequestIctoIc({Key? key, required this.requesttype})
      : super(key: key);
  @override
  State<SendRequestIctoIc> createState() => _SendRequestIctoIcState();
}

class _SendRequestIctoIcState extends State<SendRequestIctoIc> {
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

  String? homenav = "echoshop";
  String dropdownvalue = 'New Purchase';
  var items = [
    'New Purchase',
    'transfer',
    'replace',
    'damage',
    'repair',
    'stock Updation'
  ];

  List<AssetrequestIcModel> asseticrequestcartlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Request"), actions: []),
        bottomNavigationBar: asseticrequestcartlist.isEmpty
            ? SizedBox()
            : SizedBox(
                height: 80,
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 9,
                    // ),
                    MaterialButton(
                      height: 40,
                      minWidth: 300,
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                      onPressed: () {
                        if (asseticrequestcartlist.isEmpty) {
                          Fluttertoast.showToast(
                              backgroundColor: Colors.white,
                              msg: "please add items ",
                              textColor: Colors.black);
                        } else {
                          validateData();
                        }

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SnareDetails()));
                      },

                      // child: BlocConsumer<GetSendRequestIctoIcBloc,
                      //     SendRequestIctoIcState>(builder: (context, state) {
                      //   if (state is SendRequestIctoIcing) {
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
                      //   if (state is SendRequestIctoIcsuccess) {
                      //     // groupid = state.snareWalkStartModel.data!.id;

                      //     Fluttertoast.showToast(
                      //         backgroundColor: Colors.white,
                      //         textColor: Colors.black,
                      //         msg: "Request Sended");

                      //     Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => CustomerBottomNavigation()));
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
                        maxLength: 5,
                        textInputAction: TextInputAction.next,
                        //noted
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
                                  backgroundColor: Colors.white,
                                  msg: "please enter  assetname",
                                  textColor: Colors.black);
                            } else if (quantitycontroller.text.isEmpty) {
                              Fluttertoast.showToast(
                                  backgroundColor: Colors.white,
                                  msg: "please enter quantity",
                                  textColor: Colors.black);
                            } else {
                              asseticrequestcartlist.add(AssetrequestIcModel(
                                assetname: assetnamecontroller.text,

                                quantity: quantitycontroller.text,

                                // remark: remarkcontroller.text,
                              ));
                              setState(() {
                                assetnamecontroller.clear();
                                quantitycontroller.clear();
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
                      itemCount: asseticrequestcartlist.length,
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
                                                  asseticrequestcartlist
                                                      .removeWhere((item) =>
                                                          item.assetname ==
                                                          asseticrequestcartlist[
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
                                              asseticrequestcartlist[index]
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
                                              asseticrequestcartlist[index]
                                                  .quantity
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            )
                                          ]),
                                    ),

                                    // Padding(
                                    //   padding: const EdgeInsets.all(4.0),
                                    //   child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceBetween,
                                    //       children: [
                                    //         const Text(
                                    //           "Remark  :",
                                    //           style: TextStyle(
                                    //             fontSize: 12,
                                    //           ),
                                    //         ),
                                    //         Text(
                                    //           asseticrequestcartlist[index]
                                    //               .type
                                    //               .toString(),
                                    //           style: TextStyle(
                                    //             fontSize: 12,
                                    //           ),
                                    //         )
                                    //       ]),
                                    // ),

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
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    //noted
                    controller: remarkcontroller,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Remark',
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }

  void validateData() {
    BlocProvider.of<GetSendRequestIctoIcBloc>(context).add(GetSendRequestIctoIc(
      remark: remarkcontroller.text == "" ? "" : remarkcontroller.text,
      asseticrequestcartlist: asseticrequestcartlist,
    ));

    Fluttertoast.showToast(
        backgroundColor: Colors.white,
        textColor: Colors.black,
        msg: "Request Sended");

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => CustomerBottomNavigation()));
  }
}

class AssetrequestIcModel {
  String? quantity;
  String? assetname;

  AssetrequestIcModel({
    this.quantity,
    this.assetname,
  });
}
