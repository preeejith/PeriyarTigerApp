////maindrawer

import 'package:flutter/material.dart';

import 'package:parambikulam/ui/assets/ic_main/attendance/attendancedashboard.dart';
import 'package:parambikulam/ui/assets/ic_main/attendance/attendancereport.dart';

import 'package:parambikulam/ui/assets/ic_main/halt/haltreportmain.dart';


class HaltMainDashBoard extends StatefulWidget {
  const HaltMainDashBoard({Key? key}) : super(key: key);

  @override
  State<HaltMainDashBoard> createState() => _HaltMainDashBoardState();
}

class _HaltMainDashBoardState extends State<HaltMainDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AttendanceDashboard())),
        ),
        title: Text("REPORTS "),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
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
                  const Text(
                    "ATTENDANCE REPORT",
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
                          height: 60,
                          child: Icon(
                            Icons.library_books,
                            color: Colors.white,
                          )
                       
                          ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    child: MaterialButton(
                      color: Colors.green,
                      child: Text("ATTENDANCE REPORT"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AttendanceReport()),
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
                    "VIEW HALT REPORT",
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
                          height: 60,
                          child: Icon(
                            Icons.library_books,
                            color: Colors.white,
                          )
                          //  Image.asset(
                          //   "assets/elephant2.webp",
                          //   fit: BoxFit.cover,
                          // ),
                          ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    child: MaterialButton(
                      color: Colors.green,
                      child: Text("HALT REPORT"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HaltMainReport()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
