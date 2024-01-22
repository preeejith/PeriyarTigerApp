import 'package:flutter/material.dart';
import 'package:parambikulam/ui/assets/bottomnav.dart';

import 'package:parambikulam/ui/assets/local/offline_ui/ibmainmian.dart';

import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservationfullview.dart';

//////1
class IBDashboard2 extends StatefulWidget {
  const IBDashboard2({Key? key}) : super(key: key);
////
  @override
  State<IBDashboard2> createState() => _IBDashboard2State();
}

class _IBDashboard2State extends State<IBDashboard2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomerBottomNavigation())),
        ),
        title: Text("IB DASHBOARD"),
        automaticallyImplyLeading: true,
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
                        "IB PROGRAMS",
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
                            height: 150,
                            child: Image.asset(
                              "assets/elephant2.webp",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: MaterialButton(
                          color: Colors.green,
                          child: const Text(
                            "IB PROGRAMS",
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyPendingdata2()),
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
                            height: 150,
                            child: Image.asset(
                              "assets/elephant2.webp",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ReservationmainPage()),
                            // );
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
