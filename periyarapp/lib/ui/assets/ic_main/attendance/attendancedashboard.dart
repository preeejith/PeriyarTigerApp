////maindrawer
////11111
import 'package:flutter/material.dart';
import 'package:parambikulam/ui/assets/bottomnav.dart';
import 'package:parambikulam/ui/assets/ic_main/attendance/markattendance.dart';

import 'package:parambikulam/ui/assets/ic_main/halt/haltdashboard.dart';

import 'package:parambikulam/ui/assets/ic_main/halt/markhaltmain.dart';

///
class AttendanceDashboard extends StatefulWidget {
  const AttendanceDashboard({Key? key}) : super(key: key);

  @override
  State<AttendanceDashboard> createState() => _AttendanceDashboardState();
}

/////////
class _AttendanceDashboardState extends State<AttendanceDashboard> {
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
        title: Text("ATTENDANCE "),
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
                    "MARK ATTENDANCE",
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
                            Icons.people_alt_rounded,
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
                      child: Text(" ATTENDNACE"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MarkAttendance()),
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
                    "MARK HALT",
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
                            Icons.home,
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
                      child: Text(" HALT"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MarkHaltPage()),
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
                    "REPORTS",
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
                            Icons.home,
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
                      child: Text(" REPORTS"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HaltMainDashBoard()),
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
