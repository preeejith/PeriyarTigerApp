import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:parambikulam/data/models/assetsmodel/viewallassetsmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

import 'package:parambikulam/ui/assets/assetshomepage.dart';
import 'package:parambikulam/ui/assets/echoshoppages/productsale/todaysSale.dart';
import 'package:parambikulam/ui/assets/homepages_assets/echoshopsaledetailed.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({
    Key? key,
  }) : super(key: key);

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  List<ViewAssetsModel> viewassetslist = [];
  List items = [];
  var d1 = DateFormat('dd-MMM-yyyy');
  ViewAllAssetsModel? viewAllAssetsModel;
  DatabaseHelper? db = DatabaseHelper.instance;
  void initState() {
    fetcher();
    super.initState();
  }

  fetcher() async {
    items = await db!.getEchoSalesReportData();
    log(items.length);
    print(items.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sales Report"), actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: SizedBox(
                height: 6,
                width: MediaQuery.of(context).size.width / 4.6,
                child: MaterialButton(
                  color: Colors.white,
                  child: Text(
                    "Pending",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TodaysSale()));
                  },
                ),
              ),
            ),
          )
        ]),
        body: 
        
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                reverse: false,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: items.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return items.length == 0
                      ? Center(
                          child: Text(
                          "No Sale Available",
                          style: TextStyle(color: Colors.white),
                        ))
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xfff292929),
                                borderRadius: BorderRadius.circular(8),
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
                                child: ListTile(
                                    title: InkWell(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              (index + 1).toString() +
                                                  ".Sales Id:",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              items[index]['_id'],
                                              style: TextStyle(fontSize: 12),
                                            )
                                          ]),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Container(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Total Amount:",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    items[index]['totalAmount'],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      items[index]['isEmployee'] != "true"
                                          ? SizedBox.shrink()
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                  const Text(
                                                    "Employee:",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green[400],
                                                    size: 16,
                                                  ),
                                                ]),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Date:",
                                                style: TextStyle(fontSize: 12)),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              d1.format(DateTime.parse(convert(
                                                  items[index]['create_date']
                                                      .toString()))),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ]),
                                    ],
                                  ),
                                )),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SalesDetailed(
                                            totalamount: items[index]
                                                ['totalAmount'],
                                            isemployee: items[index]
                                                ['isEmployee'],
                                            salesid: items[index]['_id'],
                                          )));
                            },
                          ),
                        );
                },
              ),

              // BlocConsumer<GetViewallAssetsBloc, ViewallAssetsState>(
              //     builder: (context, state) {
              //   if (state is FetchAssetsSuccess) {
              //     // viewAllAssetsModel = state.viewAllAssetsModel;
              //     return
              //     ListView.builder(
              //       reverse: true,
              //       scrollDirection: Axis.vertical,
              //       shrinkWrap: true,
              //       itemCount: items.length,
              //       physics: const NeverScrollableScrollPhysics(),
              //       itemBuilder: (BuildContext context, int index) {
              //         return items.length == 0
              //             ? Center(
              //                 child: Text(
              //                 "No Sale Available",
              //                 style: TextStyle(color: Colors.white),
              //               ))
              //             : ListTile(
              //                 title: InkWell(
              //                 child: Column(children: [
              //                   InkWell(
              //                     child: Padding(
              //                       padding: const EdgeInsets.all(1.0),
              //                       child: Container(
              //                         width:
              //                             MediaQuery.of(context).size.width * 2,
              //                         // height: MediaQuery.of(context).size.height / 3.5,
              //                         decoration: BoxDecoration(
              //                           color: Color(0xfff292929),
              //                           borderRadius: BorderRadius.circular(8),
              //                           boxShadow: [
              //                             BoxShadow(
              //                               color: Colors.grey.withOpacity(0.3),
              //                               spreadRadius: 4,
              //                               blurRadius: 4,
              //                             ),
              //                           ],
              //                         ),
              //                         child: Padding(
              //                           padding: const EdgeInsets.all(1.0),
              //                           child: Column(
              //                             children: [
              //                               Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.start,
              //                                 children: [
              //                                   Container(
              //                                     color: Colors.white,
              //                                     height: 85,
              //                                     width: MediaQuery.of(context)
              //                                             .size
              //                                             .width /
              //                                         5,
              //                                     child: SizedBox(
              //                                         width:
              //                                             MediaQuery.of(context)
              //                                                     .size
              //                                                     .width /
              //                                                 6,
              //                                         child: Icon(
              //                                           Icons.shopping_basket,
              //                                           color: Colors.black,
              //                                         )),
              //                                   ),
              //                                   SizedBox(
              //                                     width: MediaQuery.of(context)
              //                                             .size
              //                                             .width /
              //                                         16,
              //                                   ),
              //                                   Column(
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.start,
              //                                     children: [
              //                                       Row(
              //                                           mainAxisAlignment:
              //                                               MainAxisAlignment
              //                                                   .spaceBetween,
              //                                           children: [
              //                                             const Text(
              //                                               "Asset Name:",
              //                                               style: TextStyle(
              //                                                   fontSize: 12),
              //                                             ),
              //                                             const SizedBox(
              //                                               width: 10,
              //                                             ),
              //                                             Text(
              //                                               items[index]
              //                                                   ['totalAmount'],
              //                                               style: TextStyle(
              //                                                   fontSize: 12),
              //                                             )
              //                                           ]),
              //                                       const SizedBox(
              //                                         height: 8,
              //                                       ),
              //                                       Row(
              //                                           mainAxisAlignment:
              //                                               MainAxisAlignment
              //                                                   .spaceBetween,
              //                                           children: [
              //                                             const Text(
              //                                               "Quantity:",
              //                                               style: TextStyle(
              //                                                   fontSize: 12),
              //                                             ),
              //                                             const SizedBox(
              //                                               width: 8,
              //                                             ),
              //                                             Text(
              //                                               items[index]
              //                                                   ['totalAmount'],
              //                                               style: TextStyle(
              //                                                   fontSize: 12),
              //                                             )
              //                                           ]),
              //                                       const SizedBox(
              //                                         height: 8,
              //                                       ),
              //                                       Row(
              //                                           mainAxisAlignment:
              //                                               MainAxisAlignment
              //                                                   .spaceBetween,
              //                                           children: [
              //                                             const Text(
              //                                                 "Description:",
              //                                                 style: TextStyle(
              //                                                     fontSize:
              //                                                         12)),
              //                                             const SizedBox(
              //                                               width: 8,
              //                                             ),
              //                                             Text(
              //                                               items[index]
              //                                                   ['totalAmount'],
              //                                               style: TextStyle(
              //                                                   fontSize: 12),
              //                                             )
              //                                           ]),
              //                                     ],
              //                                   ),
              //                                 ],
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                     onTap: () {
              //                       // Navigator.push(
              //                       //   context,
              //                       //   MaterialPageRoute(
              //                       //       builder: (context) =>
              //                       //           AssetsDetailedView(
              //                       //               unit: widget.unit,
              //                       //               viewassetslist:
              //                       //                   viewassetslist,
              //                       //               assetId: state
              //                       //                   .viewassetsModel[
              //                       //                       index]
              //                       //                   .assetid
              //                       //                   .toString(),
              //                       //               viewassetsModel:
              //                       //                   state.viewassetsModel,
              //                       //               assetMasterTable: state
              //                       //                   .assetMasterTable,
              //                       //               index: index)),
              //                       // );

              //                       setState(() {});
              //                     },
              //                   ),
              //                   SizedBox(
              //                     height: 8,
              //                   ),
              //                 ]),
              //               ));
              //       },
              //     );

              //   } else {
              //     return viewAllAssetsModel.toString() == null.toString()
              //         ? Center(
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Icon(
              //                   Icons.not_interested,
              //                   size: 50,
              //                 ),
              //               ],
              //             ),
              //           )
              //         : Center(
              //             child: SizedBox(
              //               height: 28.0,
              //               width: 28.0,
              //               child: CircularProgressIndicator(
              //                 valueColor:
              //                     AlwaysStoppedAnimation<Color>(Colors.white),
              //                 strokeWidth: 2,
              //               ),
              //             ),
              //           );
              //   }
              // }, listener: (context, state) async {
              //   if (state is ViewallAssetsSuccess) {}
              // }),
            ],
          ),
        ));
  }

  String convert(String uTCTime) {
    var dateFormat = DateFormat("dd-MM-yyyy"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(uTCTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    // String createdDate = dateFormat.format(DateTime.parse(localDate));
    return localDate;
  }
}
