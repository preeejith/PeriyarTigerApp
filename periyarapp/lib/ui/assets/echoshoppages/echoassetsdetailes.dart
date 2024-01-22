import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:parambikulam/data/models/assetsmodel/viewallassetsmodel.dart';

class EchoAssetsDetailedView extends StatefulWidget {
  final String assetId;
  final int index;
  final ViewAllAssetsModel viewAllAssetsModel;
  const EchoAssetsDetailedView(
      {Key? key,
      required this.assetId,
      required this.viewAllAssetsModel,
      required this.index})
      : super(key: key);

  @override
  State<EchoAssetsDetailedView> createState() => _EchoAssetsDetailedViewState();
}

class _EchoAssetsDetailedViewState extends State<EchoAssetsDetailedView> {
  @override
  void initState() {
    fetcher();

    super.initState();
  }

  void fetcher() async {
    // token = await PrefManager.getToken();

    // BlocProvider.of<GetViewAssetDetailedsBloc>(context)
    //     .add(ViewAssetDetailedEvent(
    //   assetId: widget.assetId,
    // ));
  }

  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: new AppBar(
        title: new Text('Details'),
        // leading: InkWell(onTap: () {}, child: Icon(Icons.menu)),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 3.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage("assets/echobag.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Assets Name",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  widget.viewAllAssetsModel.data[widget.index]
                                      .assetId.name,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         "Type",
                          //         style: TextStyle(fontSize: 12),
                          //       ),
                          //       Text(
                          //         widget
                          //             .viewAllAssetsModel
                          //             .data[widget.index]
                          //             .assetId
                          //             .productType
                          //             .toString(),
                          //         style: TextStyle(fontSize: 12),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  widget.viewAllAssetsModel.data[widget.index]
                                      .quantity
                                      .toString(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Issued Date",
                                      style: TextStyle(fontSize: 12)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    d1.format(DateTime.parse(convert(widget
                                            .viewAllAssetsModel
                                            .data[widget.index]
                                            .createDate
                                            .toString()))) +
                                        " | " +
                                        d2.format(DateTime.parse(convert(widget
                                            .viewAllAssetsModel
                                            .data[widget.index]
                                            .createDate
                                            .toString()))),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  )
                                ]),
                          ),

                          ////new
                          // ClipRRect(
                          //   // borderRadius: BorderRadius.circular(24),
                          //   child: SizedBox(
                          //     width: MediaQuery.of(context).size.width,
                          //     height: 50,
                          //     child: MaterialButton(
                          //       child: const Text(
                          //         "SALE ",
                          //         style: TextStyle(fontSize: 18),
                          //       ),
                          //       onPressed: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     EchoShopAssetsPage()));
                          //       },
                          //       // color: AppStyles.appColor,
                          //       color: const Color(0xff59AF73),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // BlocConsumer<GetViewAssetDetailedsBloc, ViewAssetDetailedsState>(
            //     builder: (context, state) {
            //       if (state is ViewAssetDetailedssuccess) {
            //         return Container(
            //           child: Column(
            //             children: [
            //               SizedBox(
            //                 height: 20,
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Container(
            //                   decoration: BoxDecoration(
            //                     color: Colors.black,
            //                     borderRadius: BorderRadius.circular(4),
            //                     boxShadow: [
            //                       BoxShadow(
            //                         color: Colors.grey.withOpacity(0.3),
            //                         spreadRadius: 4,
            //                         blurRadius: 4,
            //                       ),
            //                     ],
            //                   ),
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(12.0),
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                           height:
            //                               MediaQuery.of(context).size.height /
            //                                   3.5,
            //                           width: MediaQuery.of(context).size.width,
            //                           decoration: new BoxDecoration(
            //                             color: Colors.white,
            //                             image: DecorationImage(
            //                               image:
            //                                   AssetImage("assets/echobag.png"),
            //                               fit: BoxFit.cover,
            //                             ),
            //                           ),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(8.0),
            //                           child: Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Text(
            //                                 "Assets Name",
            //                                 style: TextStyle(fontSize: 12),
            //                               ),
            //                               Text(
            //                                 widget
            //                                     .viewAllAssetsModel
            //                                     .data[widget.index]
            //                                     .assetId
            //                                     .name,
            //                                 style: TextStyle(fontSize: 12),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                         // Padding(
            //                         //   padding: const EdgeInsets.all(8.0),
            //                         //   child: Row(
            //                         //     mainAxisAlignment:
            //                         //         MainAxisAlignment.spaceBetween,
            //                         //     children: [
            //                         //       Text(
            //                         //         "Type",
            //                         //         style: TextStyle(fontSize: 12),
            //                         //       ),
            //                         //       Text(
            //                         //         widget
            //                         //             .viewAllAssetsModel
            //                         //             .data[widget.index]
            //                         //             .assetId
            //                         //             .productType
            //                         //             .toString(),
            //                         //         style: TextStyle(fontSize: 12),
            //                         //       ),
            //                         //     ],
            //                         //   ),
            //                         // ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(8.0),
            //                           child: Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Text(
            //                                 "Quantity",
            //                                 style: TextStyle(fontSize: 12),
            //                               ),
            //                               Text(
            //                                 widget.viewAllAssetsModel
            //                                     .data[widget.index].quantity
            //                                     .toString(),
            //                                 style: TextStyle(fontSize: 12),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(8.0),
            //                           child: Row(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.spaceBetween,
            //                               children: [
            //                                 const Text("Issued Date",
            //                                     style: TextStyle(fontSize: 12)),
            //                                 const SizedBox(
            //                                   width: 10,
            //                                 ),
            //                                 Text(
            //                                   d1.format(DateTime.parse(convert(
            //                                           widget
            //                                               .viewAllAssetsModel
            //                                               .data[widget.index]
            //                                               .createDate
            //                                               .toString()))) +
            //                                       " | " +
            //                                       d2.format(DateTime.parse(
            //                                           convert(widget
            //                                               .viewAllAssetsModel
            //                                               .data[widget.index]
            //                                               .createDate
            //                                               .toString()))),
            //                                   style: const TextStyle(
            //                                     color: Colors.white,
            //                                     fontSize: 13,
            //                                   ),
            //                                 )
            //                               ]),
            //                         ),

            //                         ////new
            //                         // ClipRRect(
            //                         //   // borderRadius: BorderRadius.circular(24),
            //                         //   child: SizedBox(
            //                         //     width: MediaQuery.of(context).size.width,
            //                         //     height: 50,
            //                         //     child: MaterialButton(
            //                         //       child: const Text(
            //                         //         "SALE ",
            //                         //         style: TextStyle(fontSize: 18),
            //                         //       ),
            //                         //       onPressed: () {
            //                         //         Navigator.push(
            //                         //             context,
            //                         //             MaterialPageRoute(
            //                         //                 builder: (context) =>
            //                         //                     EchoShopAssetsPage()));
            //                         //       },
            //                         //       // color: AppStyles.appColor,
            //                         //       color: const Color(0xff59AF73),
            //                         //     ),
            //                         //   ),
            //                         // ),
            //                       ],
            //                     ),
            //                   ),
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
