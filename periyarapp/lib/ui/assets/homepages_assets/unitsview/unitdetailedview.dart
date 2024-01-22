import 'package:flutter/material.dart';

import 'package:parambikulam/data/models/assetsmodel/ic_viewunnitsmodel.dart';

import 'package:parambikulam/ui/assets/homepages_assets/unitsview/assetsview_transfer.dart';
import 'package:parambikulam/ui/assets/homepages_assets/unitsview/inchargeview.dart';
import 'package:parambikulam/ui/assets/ic_main/assignemployee/assignemployee.dart';
import 'package:parambikulam/ui/assets/ic_main/icunitsassetsview.dart';

class UnitsDetailedView extends StatefulWidget {
  final String unitId, unitName, untitype;
  final int index;
  final bool busstatus;
  final IcViewUnitsModel icViewUnitsModel;
  const UnitsDetailedView(
      {Key? key,
      required this.unitId,
      required this.busstatus,
      required this.untitype,
      required this.unitName,
      required this.icViewUnitsModel,
      required this.index})
      : super(key: key);
////
  @override
  State<UnitsDetailedView> createState() => _UnitsDetailedViewState();
}

class _UnitsDetailedViewState extends State<UnitsDetailedView> {
  @override
  void initState() {
    fetcher();

    super.initState();
  }

  void fetcher() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: new AppBar(
        title: new Text('Details '),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 3.2,
                          width: MediaQuery.of(context).size.width,
                          // child: SizedBox(
                          //     child: Icon(
                          //   Icons.forest,
                          //   size: 110,
                          // )),
                          decoration: new BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              image: AssetImage("assets/bgptrr.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Unit Name :",
                                style: TextStyle(fontSize: 14),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Container(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.icViewUnitsModel
                                          .user![widget.index].name
                                          .toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Unit Type :",
                                style: TextStyle(fontSize: 14),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Container(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.icViewUnitsModel
                                          .user![widget.index].type
                                          .toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Description :",
                                style: TextStyle(fontSize: 14),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Container(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.icViewUnitsModel
                                          .user![widget.index].description
                                          .toString(),
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Divider(
                          color: Colors.white,
                        ),
                        widget.busstatus == true
                            ? SizedBox()
                            : SizedBox(
                                height: MediaQuery.of(context).size.height / 16,
                                width: MediaQuery.of(context).size.width,
                                child: MaterialButton(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .shopping_cart_checkout_rounded,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("View Items"),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: Colors.white),
                                            ])),
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IcUnitsassetsview(
                                                      untiName: widget.unitName,
                                                      unitId: widget
                                                          .icViewUnitsModel
                                                          .user![widget.index]
                                                          .id
                                                          .toString(),
                                                      icViewUnitsModel: widget
                                                          .icViewUnitsModel,
                                                      index: widget.index)));
                                    }),
                              ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height / 16,
                          width: MediaQuery.of(context).size.width,
                          child: MaterialButton(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(Icons.person,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("InCharge"),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_ios_rounded,
                                            color: Colors.white),
                                      ])),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UnitInCharge(
                                            unitId: widget.unitId,
                                            icViewUnitsModel:
                                                widget.icViewUnitsModel,
                                            index: widget.index)));
                              }),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 16,
                          width: MediaQuery.of(context).size.width,
                          child: MaterialButton(
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(Icons.person_add,
                                                  color: Colors.white),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Assign Employee"),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_ios_rounded,
                                            color: Colors.white),
                                      ])),
                              color: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AssignEmployee(
                                              untitype: widget.untitype,
                                              icViewUnitsModel:
                                                  widget.icViewUnitsModel,
                                              index: widget.index,

                                              unitid: widget.icViewUnitsModel
                                                  .user![widget.index].id
                                                  .toString(),
                                              // title:
                                              //     "Stock Request"
                                            )));
                              }),
                        ),

                        widget.busstatus == true
                            ? SizedBox()
                            : SizedBox(
                                height: MediaQuery.of(context).size.height / 16,
                                width: MediaQuery.of(context).size.width,
                                child: MaterialButton(
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .shopping_basket_outlined,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Transfer Assets"),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: Colors.white),
                                            ])),
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AssetsTransfer(
                                                      untiName: widget.unitName,
                                                      transferedtoId: widget
                                                          .icViewUnitsModel
                                                          .user![widget.index]
                                                          .id
                                                          .toString())));
                                    }),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // BlocConsumer<GetUnitsDetailedViewBloc, UnitsDetailedViewState>(
            //     builder: (context, state) {
            //       if (state is UnitsDetailedViewsuccess) {
            //         return Container(
            //           child: Column(
            //             children: [
            //               SizedBox(
            //                 height: 20,
            //               ),
            //               Container(
            //                 decoration: BoxDecoration(
            //                   color: Colors.black,
            //                   borderRadius: BorderRadius.circular(4),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       color: Colors.grey.withOpacity(0.3),
            //                       spreadRadius: 4,
            //                       blurRadius: 4,
            //                     ),
            //                   ],
            //                 ),
            //                 child: Column(
            //                   children: [
            //                     Container(
            //                       height:
            //                           MediaQuery.of(context).size.height / 3.5,
            //                       width: MediaQuery.of(context).size.width,
            //                       decoration: new BoxDecoration(
            //                         color: Colors.white,
            //                         image: DecorationImage(
            //                           image: AssetImage("assets/echobag.png"),
            //                           fit: BoxFit.cover,
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 10,
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.all(6.0),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Text(
            //                             "Unit Name :",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           ClipRRect(
            //                             borderRadius: BorderRadius.circular(24),
            //                             child: Container(
            //                               color: Colors.green,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child: Text(
            //                                   widget.icViewUnitsModel
            //                                       .user[widget.index].name,
            //                                   style: TextStyle(fontSize: 12),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),

            //                     Padding(
            //                       padding: const EdgeInsets.all(6.0),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Text(
            //                             "Unit Type :",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           ClipRRect(
            //                             borderRadius: BorderRadius.circular(24),
            //                             child: Container(
            //                               color: Colors.green,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child: Text(
            //                                   widget.icViewUnitsModel
            //                                       .user[widget.index].type,
            //                                   style: TextStyle(fontSize: 12),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),

            //                     Padding(
            //                       padding: const EdgeInsets.all(6.0),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Text(
            //                             "Description :",
            //                             style: TextStyle(fontSize: 14),
            //                           ),
            //                           ClipRRect(
            //                             borderRadius: BorderRadius.circular(24),
            //                             child: Container(
            //                               color: Colors.green,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child: Text(
            //                                   widget
            //                                       .icViewUnitsModel
            //                                       .user[widget.index]
            //                                       .description,
            //                                   style: TextStyle(fontSize: 12),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     // SizedBox(
            //                     //   height: 5,
            //                     // ),
            //                     Divider(
            //                       color: Colors.white,
            //                     ),
            //                     SizedBox(
            //                       height:
            //                           MediaQuery.of(context).size.height / 16,
            //                       width: MediaQuery.of(context).size.width,
            //                       child: MaterialButton(
            //                           child: Align(
            //                               alignment: Alignment.centerLeft,
            //                               child: Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment
            //                                           .spaceBetween,
            //                                   children: [
            //                                     Container(
            //                                       child: Row(
            //                                         children: [
            //                                           Icon(
            //                                               Icons
            //                                                   .shopping_cart_checkout_rounded,
            //                                               color: Colors.white),
            //                                           SizedBox(
            //                                             width: 10,
            //                                           ),
            //                                           Text("View Items"),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                     Icon(
            //                                         Icons
            //                                             .arrow_forward_ios_rounded,
            //                                         color: Colors.white),
            //                                   ])),
            //                           color: Colors.black,
            //                           onPressed: () {
            //                             Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(
            //                                     builder: (context) =>
            //                                         IcUnitsassetsview(
            //                                           unitId: widget
            //                                               .icViewUnitsModel
            //                                               .user[widget.index]
            //                                               .id,
            //                                         )));
            //                           }),
            //                     ),

            //                     SizedBox(
            //                       height:
            //                           MediaQuery.of(context).size.height / 16,
            //                       width: MediaQuery.of(context).size.width,
            //                       child: MaterialButton(
            //                           child: Align(
            //                               alignment: Alignment.centerLeft,
            //                               child: Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment
            //                                           .spaceBetween,
            //                                   children: [
            //                                     Container(
            //                                       child: Row(
            //                                         children: [
            //                                           Icon(Icons.person,
            //                                               color: Colors.white),
            //                                           SizedBox(
            //                                             width: 10,
            //                                           ),
            //                                           Text("InCharge"),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                     Icon(
            //                                         Icons
            //                                             .arrow_forward_ios_rounded,
            //                                         color: Colors.white),
            //                                   ])),
            //                           color: Colors.black,
            //                           onPressed: () {
            //                             Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(
            //                                     builder: (context) =>
            //                                         UnitInCharge(
            //                                           unitId: widget.unitId,
            //                                         )));
            //                           }),
            //                     ),
            //                     SizedBox(
            //                       height:
            //                           MediaQuery.of(context).size.height / 16,
            //                       width: MediaQuery.of(context).size.width,
            //                       child: MaterialButton(
            //                           child: Align(
            //                               alignment: Alignment.centerLeft,
            //                               child: Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment
            //                                           .spaceBetween,
            //                                   children: [
            //                                     Container(
            //                                       child: Row(
            //                                         children: [
            //                                           Icon(Icons.person_add,
            //                                               color: Colors.white),
            //                                           SizedBox(
            //                                             width: 10,
            //                                           ),
            //                                           Text("Assign Employee"),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                     Icon(
            //                                         Icons
            //                                             .arrow_forward_ios_rounded,
            //                                         color: Colors.white),
            //                                   ])),
            //                           color: Colors.black,
            //                           onPressed: () {
            //                             Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(
            //                                     builder: (context) =>
            //                                         AssignEmployee(
            //                                           unitid: widget
            //                                               .icViewUnitsModel
            //                                               .user[widget.index]
            //                                               .id
            //                                               .toString(),
            //                                           // title:
            //                                           //     "Stock Request"
            //                                         )));
            //                           }),
            //                     ),

            //                     SizedBox(
            //                       height:
            //                           MediaQuery.of(context).size.height / 16,
            //                       width: MediaQuery.of(context).size.width,
            //                       child: MaterialButton(
            //                           child: Align(
            //                               alignment: Alignment.centerLeft,
            //                               child: Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment
            //                                           .spaceBetween,
            //                                   children: [
            //                                     Container(
            //                                       child: Row(
            //                                         children: [
            //                                           Icon(
            //                                               Icons
            //                                                   .shopping_basket_outlined,
            //                                               color: Colors.white),
            //                                           SizedBox(
            //                                             width: 10,
            //                                           ),
            //                                           Text("Transfer Assets"),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                     Icon(
            //                                         Icons
            //                                             .arrow_forward_ios_rounded,
            //                                         color: Colors.white),
            //                                   ])),
            //                           color: Colors.black,
            //                           onPressed: () {
            //                             Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(
            //                                     builder: (context) =>
            //                                         AssetsTransfer(
            //                                             transferedtoId: widget
            //                                                 .icViewUnitsModel
            //                                                 .user[widget.index]
            //                                                 .id
            //                                                 .toString())));
            //                           }),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       } else
            //         return Container();
            //     },
            //     listener: (context, state) {})
          ],
        ),
      ),
    );
  }
}
