import 'package:flutter/material.dart';
////
import 'package:parambikulam/ui/assets/local/offline_ui/ibdashboard2.dart';

import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/ibreservationdetailspage.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservationfullview.dart';

class ReservationmainPage extends StatefulWidget {
  const ReservationmainPage({Key? key}) : super(key: key);

  @override
  State<ReservationmainPage> createState() => _ReservationmainPageState();
}

class _ReservationmainPageState extends State<ReservationmainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => IBDashboard2())),
        ),
        title: Text("RESERVATION DETAILS"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 20.0, bottom: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "RESERVATION LIST TO UPLOAD",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        thickness: 0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Stack(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: Icon(
                                Icons.upload,
                                color: Colors.white,
                              )

                              // Image.asset(
                              //   "assets/elephant2.webp",
                              //   fit: BoxFit.cover,
                              // ),
                              ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: MaterialButton(
                          color: Colors.green,
                          child: const Text(
                            "RESERVATION TO UPLOAD",
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReservationDetails()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 12.0, right: 12.0, top: 20.0, bottom: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "RESERVATION DETAILS",
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Stack(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: Icon(Icons.list_alt)

                              // Image.asset(
                              //   "assets/elephant2.webp",
                              //   fit: BoxFit.cover,
                              // ),
                              ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: MaterialButton(
                          color: Colors.green,
                          child: Text("RESERVATION DETAILS"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReservationOnlineDetails()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
