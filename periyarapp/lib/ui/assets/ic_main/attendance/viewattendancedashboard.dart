import 'package:flutter/material.dart';
import 'package:parambikulam/ui/assets/ic_main/attendance/attendancedashboard.dart';

import 'package:parambikulam/ui/assets/ic_main/attendance/attendancereport.dart';
import 'package:parambikulam/ui/assets/ic_main/attendance/markattendance.dart';



class ViewAttendanceDashboard extends StatefulWidget {
  const ViewAttendanceDashboard({Key? key}) : super(key: key);

  @override
  State<ViewAttendanceDashboard> createState() =>
      _ViewAttendanceDashboardState();
}

class _ViewAttendanceDashboardState extends State<ViewAttendanceDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => AttendanceDashboard())),
        ),
        title: Text("ATTENDANCE "),
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
                        "MARK ATTENDANCE",
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
                              height: 60,
                              child: Icon(
                                Icons.people_alt_rounded,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 35,
                        child: MaterialButton(
                          color: Colors.green,
                          child: const Text(
                            "MARK ATTENDANCE",
                          ),
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
                // Container(
                //   padding: const EdgeInsets.only(
                //       left: 12.0, right: 12.0, top: 20.0, bottom: 20.0),
                //   width: MediaQuery.of(context).size.width,
                //   decoration: BoxDecoration(
                //     color: Colors.black,
                //     borderRadius: BorderRadius.circular(2),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.1),
                //         spreadRadius: 4,
                //         blurRadius: 4,
                //       ),
                //     ],
                //   ),

                //   ///
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Text(
                //         " ATTENDANCE TO UPLOAD",
                //         overflow: TextOverflow.ellipsis,
                //         style: TextStyle(color: Colors.white),
                //       ),
                //       const SizedBox(
                //         height: 5.0,
                //       ),
                //       Divider(
                //         thickness: 0,
                //       ),
                //       const SizedBox(
                //         height: 5.0,
                //       ),
                //       Stack(
                //         children: [
                //           SizedBox(
                //               width: MediaQuery.of(context).size.width,
                //               height: 60,
                //               child: Icon(
                //                 Icons.people_alt_rounded,
                //                 color: Colors.white,
                //               )

                //               //  Image.asset(
                //               //   "assets/elephant2.webp",
                //               //   fit: BoxFit.cover,
                //               // ),
                //               ),
                //         ],
                //       ),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width,
                //         height: 35,
                //         child: MaterialButton(
                //           color: Colors.green,
                //           child: const Text(
                //             "ATTENDANCE TO UPLOAD",
                //           ),
                //           onPressed: () {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => ViewAttendancePage()),
                //             );
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
