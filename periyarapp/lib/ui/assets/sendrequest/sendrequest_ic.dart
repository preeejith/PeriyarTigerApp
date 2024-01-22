///tempoarary not in use page

import 'package:flutter/material.dart';
import 'package:parambikulam/ui/assets/echoshoppages/sendrequestpage.dart';

import 'package:parambikulam/ui/assets/sendrequest/sendstockupdationrequest.dart';

////
class SendRequestIcMainPage extends StatefulWidget {
  final String? homenav;
  const SendRequestIcMainPage({Key? key, this.homenav}) : super(key: key);

  @override
  State<SendRequestIcMainPage> createState() => _SendRequestIcMainPageState();
}

class _SendRequestIcMainPageState extends State<SendRequestIcMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Request"), actions: []),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(),
            SizedBox(
              height: 18,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.shopping_cart_checkout_rounded,
                                      color: Colors.white),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Purchase Items"),
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
                            builder: (context) => SendRequestPage(
                                  homenav: "",
                                  requesttype: 'New Purchase',
                                )));
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(children: [
                          Icon(Icons.update, color: Colors.white),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Update Stock"),
                        ])),
                        Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white),
                      ]),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StockUpdationRequest(
                                requesttype: 'stock Updation',
                                title: "Stock Request",
                                homenav: widget.homenav.toString())));
                  }),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 16,
            //   width: MediaQuery.of(context).size.width,
            //   child: MaterialButton(
            //       child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Container(
            //                 child: Row(children: [
            //               Icon(Icons.replay_circle_filled, color: Colors.white),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text("Replace"),
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
            //                       requesttype: 'replace',
            //                       title: "Replace Request",
            //                       homenav: widget.homenav.toString(),
            //                     )));
            //       }),
            // ),

            //////
            //////
            ///
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: Row(children: [
                          Icon(Icons.add_business_rounded, color: Colors.white),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Damage"),
                        ])),
                        Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white),
                      ]),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StockUpdationRequest(
                                  requesttype: 'damage',
                                  title: "Damage Report",
                                  homenav: widget.homenav.toString(),
                                )));
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width,
              child: MaterialButton(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(Icons.home_repair_service,
                                  color: Colors.white),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Repair"),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white),
                      ]),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StockUpdationRequest(
                                  requesttype: 'repair',
                                  title: "Repair Report",
                                  homenav: widget.homenav.toString(),
                                )));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
