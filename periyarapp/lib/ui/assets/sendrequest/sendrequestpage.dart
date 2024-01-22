import 'package:flutter/material.dart';
import 'package:parambikulam/ui/assets/echoshoppages/sendrequestpage.dart';

import 'package:parambikulam/ui/assets/sendrequest/sendstockupdationrequest.dart';

class SendRequestMasterPage extends StatefulWidget {
  final String? homenav;
  const SendRequestMasterPage({Key? key, this.homenav}) : super(key: key);

  @override
  State<SendRequestMasterPage> createState() => _SendRequestMasterPageState();
}

class _SendRequestMasterPageState extends State<SendRequestMasterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Request"), actions: []),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart_checkout_rounded,
                                color: Colors.white),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Purchase Items"),
                          ]),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SendRequestPage(
                                    homenav: widget.homenav.toString(),
                                    requesttype: 'New Purchase',
                                  )));
                    },
                  ),
                  InkWell(
                    child: Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.update, color: Colors.white),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Update Stock"),
                          ]),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StockUpdationRequest(
                                  requesttype: 'stock Updation',
                                  title: "Stock Request",
                                  homenav: widget.homenav.toString())));
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_business_rounded,
                                color: Colors.white),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Damage"),
                          ]),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StockUpdationRequest(
                                    requesttype: 'damage',
                                    title: "Damage Report",
                                    homenav: widget.homenav.toString(),
                                  )));
                    },
                  ),
                  InkWell(
                    child: Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.home_repair_service,
                                color: Colors.white),
                            SizedBox(
                              height: 2,
                            ),
                            Text("Repair"),
                          ]),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StockUpdationRequest(
                                    requesttype: 'repair',
                                    title: "Repair Report",
                                    homenav: widget.homenav.toString(),
                                  )));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 19,
            ),

            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 12,
            //   width: MediaQuery.of(context).size.width,
            //   child: MaterialButton(
            //       child: Align(
            //           alignment: Alignment.centerLeft,
            //           child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Container(
            //                   child: Row(
            //                     children: [
            //                       Icon(Icons.shopping_cart_checkout_rounded,
            //                           color: Colors.white),
            //                       SizedBox(
            //                         width: 10,
            //                       ),
            //                       Text("Purchase Items"),
            //                     ],
            //                   ),
            //                 ),
            //                 Icon(Icons.arrow_forward_ios_rounded,
            //                     color: Colors.white),
            //               ])),
            //       color: Colors.black,
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => SendRequestPage(
            //                       homenav: widget.homenav.toString(),
            //                       requesttype: 'New Purchase',
            //                     )));
            //       }),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 12,
            //   width: MediaQuery.of(context).size.width,
            //   child: MaterialButton(
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Container(
            //                 child: Row(children: [
            //               Icon(Icons.update, color: Colors.white),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text("Update Stock"),
            //             ])),
            //             Icon(Icons.arrow_forward_ios_rounded,
            //                 color: Colors.white),
            //           ]),
            //       color: Colors.black,
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => StockUpdationRequest(
            //                     requesttype: 'stock Updation',
            //                     title: "Stock Request",
            //                     homenav: widget.homenav.toString())));
            //       }),
            // ),
            // // SizedBox(
            // //   height: 10,
            // // ),
            // // SizedBox(
            // //   height: MediaQuery.of(context).size.height / 16,
            // //   width: MediaQuery.of(context).size.width,
            // //   child: MaterialButton(
            // //       child: Row(
            // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // //           children: [
            // //             Container(
            // //                 child: Row(children: [
            // //               Icon(Icons.replay_circle_filled, color: Colors.white),
            // //               SizedBox(
            // //                 width: 10,
            // //               ),
            // //               Text("Replace"),
            // //             ])),
            // //             Icon(Icons.arrow_forward_ios_rounded,
            // //                 color: Colors.white),
            // //           ]),
            // //       color: Colors.black,
            // //       onPressed: () {
            // //         Navigator.push(
            // //             context,
            // //             MaterialPageRoute(
            // //                 builder: (context) => StockUpdationRequest(

            // //                     requesttype: 'replace',
            // //                     title: "Replace Request",

            // //                      homenav: widget.homenav.toString(),)));
            // //       }),
            // // ),
            // SizedBox(
            //   height: 10,
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 12,
            //   width: MediaQuery.of(context).size.width,
            //   child: MaterialButton(
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Container(
            //                 child: Row(children: [
            //               Icon(Icons.add_business_rounded, color: Colors.white),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text("Damage"),
            //             ])),
            //             Icon(Icons.arrow_forward_ios_rounded,
            //                 color: Colors.white),
            //           ]),
            //       color: Colors.black,
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => StockUpdationRequest(
            //                       requesttype: 'damage',
            //                       title: "Damage Report",
            //                       homenav: widget.homenav.toString(),
            //                     )));
            //       }),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 12,
            //   width: MediaQuery.of(context).size.width,
            //   child: MaterialButton(
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Container(
            //               child: Row(
            //                 children: [
            //                   Icon(Icons.home_repair_service,
            //                       color: Colors.white),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text("Repair"),
            //                 ],
            //               ),
            //             ),
            //             Icon(Icons.arrow_forward_ios_rounded,
            //                 color: Colors.white),
            //           ]),
            //       color: Colors.black,
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => StockUpdationRequest(
            //                       requesttype: 'repair',
            //                       title: "Repair Report",
            //                       homenav: widget.homenav.toString(),
            //                     )));
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}
