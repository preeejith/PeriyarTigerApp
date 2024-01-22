import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeebloc.dart';

import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeestate.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/employeelistofflinebloc.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/ui/assets/ic_main/attendance/attendanceedit.dart';
import 'package:parambikulam/ui/assets/ic_main/attendance/attendancereport.dart';
import 'package:parambikulam/ui/assets/ic_main/attendance/viewattentance.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class MarkAttendance extends StatefulWidget {
  const MarkAttendance({Key? key}) : super(key: key);

  @override
  _MarkAttendance createState() => _MarkAttendance();
}

class _MarkAttendance extends State<MarkAttendance> {
  String? token;
  bool? attentancetrue = false;
  bool? datealready = false;
  bool? uploadalready = false;
  bool? attentancefalse = false;

  bool? specialDay = false;
  bool? uploadprocced = true;
  var d1 = new DateFormat('dd-MMM-yyyy');
  List<MarkattentanceModel> markattantencelist = [];

  late String _currentDate;

  @override
  void initState() {
    super.initState();
    fetcher();
  }

  String currentDate() {
    var now = new DateTime.now();

    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  void fetcher() async {
    ///offline employee list
    BlocProvider.of<EmployeelistOfflineBloc>(context)
        .add(GetEmployeeListData());

    ///for taking the attendnace
    // BlocProvider.of<MarkAttendanceOfflineBloc>(context)
    //     .add(GetMarkAttendanceData());

    // _currentDate = "2022-06-19";
    _currentDate = currentDate();
    setState(() {});
  }

  List<AttendanceDetailsModel> attendancedetailslist = [];
  var day = DateFormat('EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: AppBar(
        title: const Text("Mark Attendance"),
        actions: [
          datealready == false
              ? SizedBox()
              : uploadalready == true
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                          color: Colors.black,
                          child: Text('Edit'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditMarkAttendance()));
                          }),
                    )
        ],
      ),
      bottomNavigationBar: markattantencelist.length == 0
          ? SizedBox()
          : datealready == true
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: MaterialButton(
                    child: Text("SUBMIT ATTENDANCE"),
                    color: Colors.green,
                    onPressed: () {
                      uploadprocced == false
                          ? Fluttertoast.showToast(
                              msg:
                                  "Please upload the previous attendance & download to continue")
                          : validate();
                    },
                  ),
                ),
      body: profileBody2(),
    );
  }

  Widget profileBody2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 35,
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                child: Text(_currentDate,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            BlocConsumer<EmployeelistOfflineBloc, StateEmployeeList>(
                builder: (context, state) {
              if (state is EmployeeListing) {
                return markattantencelist.length == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "Please download employees details for mark attentance",
                          style: TextStyle(fontSize: 8),
                        )),
                      )
                    : datealready != true
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.items6!.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                //width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xfff292929),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 4,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state.items6![index]
                                                                  ['userName']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          state.items6![index][
                                                                  'phonenumber']
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Transform.scale(
                                                      scale: 0.7,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          markattantencelist
                                                                      .length ==
                                                                  0
                                                              ? SizedBox()
                                                              : Container(
                                                                  decoration: true
                                                                      ? BoxDecoration(
                                                                          color: markattantencelist[index].change == false ? Colors.red.shade200 : Colors.white,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: AppColors.black,
                                                                              offset: Offset(0.8, 0.8),
                                                                              blurRadius: 4.0,
                                                                            ),
                                                                          ],
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                          borderRadius: BorderRadius.all(Radius.circular(25)))
                                                                      : BoxDecoration(),
                                                                  child: IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      datealready ==
                                                                              true
                                                                          ? Fluttertoast.showToast(
                                                                              backgroundColor: Colors.white,
                                                                              msg: "Today Attendance Marked Already",
                                                                              textColor: Colors.black)
                                                                          : setState(() {
                                                                              markattantencelist[index].startok = true;
                                                                              markattantencelist[index].markpresentfalse == true ? markattantencelist[index].markpresentfalse = false : markattantencelist[index].markpresentfalse = true;

                                                                              markattantencelist[index].markpresentfalse == true ? markattantencelist[index].markpresenttrue = false : markattantencelist[index].markpresenttrue = true;

                                                                              markattantencelist[index].markpresentfalse == true ? markattantencelist[index].change = false : markattantencelist[index].change = true;
                                                                            });

                                                                      // data[index].selected =
                                                                      //     !data[index].selected;
                                                                      // setState(() {});
                                                                    },
                                                                    color: Colors
                                                                        .red,
                                                                    icon: Icon(Icons
                                                                        .close),
                                                                  )),
                                                          SizedBox(
                                                            width: 15.0,
                                                          ),
                                                          InkWell(
                                                            child: markattantencelist
                                                                        .length ==
                                                                    0
                                                                ? SizedBox()
                                                                : Container(
                                                                    decoration: true
                                                                        ? BoxDecoration(
                                                                            color: datealready == true
                                                                                ? Colors.white
                                                                                : markattantencelist[index].change == true
                                                                                    ? Colors.green.shade200
                                                                                    : Colors.white,
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: AppColors.black,
                                                                                offset: Offset(0.1, 0.9),
                                                                                blurRadius: 5.0,
                                                                              ),
                                                                            ],
                                                                            border: Border.all(
                                                                              color: Colors.grey,
                                                                            ),
                                                                            borderRadius: BorderRadius.all(Radius.circular(25)))
                                                                        : BoxDecoration(),
                                                                    child: IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        datealready ==
                                                                                true
                                                                            ? Fluttertoast.showToast(
                                                                                backgroundColor: Colors.white,
                                                                                msg: "Today's Attendance Marked Already",
                                                                                textColor: Colors.black)
                                                                            : setState(() {
                                                                                markattantencelist[index].startok = true;
                                                                                markattantencelist[index].markpresenttrue == true ? markattantencelist[index].markpresenttrue = false : markattantencelist[index].markpresenttrue = true;

                                                                                markattantencelist[index].markpresenttrue == true ? markattantencelist[index].markpresentfalse = false : markattantencelist[index].markpresentfalse = true;

                                                                                markattantencelist[index].markpresenttrue == true ? markattantencelist[index].change = true : markattantencelist[index].change = false;
                                                                              });
                                                                      },
                                                                      color: Colors
                                                                          .green,
                                                                      icon: Icon(
                                                                          Icons
                                                                              .done),
                                                                    )),
                                                            onTap: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                markattantencelist.length == 0
                                                    ? SizedBox()
                                                    : markattantencelist[index]
                                                                .change ==
                                                            true
                                                        ? SizedBox()
                                                        : Row(
                                                            children: [
                                                              MaterialButton(
                                                                  child: Text(
                                                                      "Leave"),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  minWidth: 65,
                                                                  height: 20,
                                                                  color: markattantencelist[index]
                                                                              .leave ==
                                                                          false
                                                                      ? Colors
                                                                          .grey
                                                                      : Colors
                                                                          .green,
                                                                  onPressed:
                                                                      () {
                                                                    specialDay ==
                                                                            true
                                                                        ? Fluttertoast.showToast(
                                                                            backgroundColor: Colors
                                                                                .white,
                                                                            msg:
                                                                                "can't change",
                                                                            textColor: Colors
                                                                                .black)
                                                                        : setState(
                                                                            () {
                                                                            markattantencelist[index].leave == true
                                                                                ? markattantencelist[index].leave = false
                                                                                : markattantencelist[index].leave = true;

                                                                            markattantencelist[index].leave == true
                                                                                ? markattantencelist[index].absent = false
                                                                                : markattantencelist[index].absent = true;
                                                                          });
                                                                  }),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              MaterialButton(
                                                                  child: Text(
                                                                      "Absent"),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  minWidth: 65,
                                                                  height: 20,
                                                                  color: markattantencelist[index]
                                                                              .absent ==
                                                                          false
                                                                      ? Colors
                                                                          .grey
                                                                      : Colors
                                                                          .green,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      markattantencelist[index].absent ==
                                                                              true
                                                                          ? markattantencelist[index].absent =
                                                                              false
                                                                          : markattantencelist[index].absent =
                                                                              true;

                                                                      markattantencelist[index].absent ==
                                                                              true
                                                                          ? markattantencelist[index].leave =
                                                                              false
                                                                          : markattantencelist[index].leave =
                                                                              true;
                                                                    });
                                                                  })
                                                            ],
                                                          ),
                                              ]),
                                        ),
                                      ),
                                      onTap: () {
                                        /////
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           UnitsDetailedView(
                                        //             unitId: state
                                        //                 .viewAllEmployeeModel
                                        //                 .data![index]
                                        //                 .userName
                                        //                 .toString(),
                                        //           )),
                                        // );

                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                              ///////for
                            })
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.items6!.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                //width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xfff292929),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 4,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state.items6![index]
                                                                  ['userName']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          state.items6![index][
                                                                  'phonenumber']
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Transform.scale(
                                                      scale: 0.7,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          markattantencelist
                                                                      .length ==
                                                                  0
                                                              ? SizedBox()
                                                              : Container(
                                                                  decoration: true
                                                                      ? BoxDecoration(
                                                                          color: markattantencelist[index].change == false ? Colors.red.shade200 : Colors.white,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: AppColors.black,
                                                                              offset: Offset(0.8, 0.8),
                                                                              blurRadius: 4.0,
                                                                            ),
                                                                          ],
                                                                          border: Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                          borderRadius: BorderRadius.all(Radius.circular(25)))
                                                                      : BoxDecoration(),
                                                                  child: IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      datealready ==
                                                                              true
                                                                          ? Fluttertoast.showToast(
                                                                              backgroundColor: Colors.white,
                                                                              msg: "Today Attendance Marked Already",
                                                                              textColor: Colors.black)
                                                                          : setState(() {
                                                                              markattantencelist[index].startok = true;
                                                                              markattantencelist[index].markpresentfalse == true ? markattantencelist[index].markpresentfalse = false : markattantencelist[index].markpresentfalse = true;

                                                                              markattantencelist[index].markpresentfalse == true ? markattantencelist[index].markpresenttrue = false : markattantencelist[index].markpresenttrue = true;

                                                                              markattantencelist[index].markpresentfalse == true ? markattantencelist[index].change = false : markattantencelist[index].change = true;
                                                                            });

                                                                      // data[index].selected =
                                                                      //     !data[index].selected;
                                                                      // setState(() {});
                                                                    },
                                                                    color: Colors
                                                                        .red,
                                                                    icon: Icon(Icons
                                                                        .close),
                                                                  )),
                                                          SizedBox(
                                                            width: 15.0,
                                                          ),
                                                          InkWell(
                                                            child: markattantencelist
                                                                        .length ==
                                                                    0
                                                                ? SizedBox()
                                                                : Container(
                                                                    decoration: true
                                                                        ? BoxDecoration(
                                                                            color: datealready == true
                                                                                ? Colors.white
                                                                                : markattantencelist[index].change == true
                                                                                    ? Colors.green.shade200
                                                                                    : Colors.white,
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: AppColors.black,
                                                                                offset: Offset(0.1, 0.9),
                                                                                blurRadius: 5.0,
                                                                              ),
                                                                            ],
                                                                            border: Border.all(
                                                                              color: Colors.grey,
                                                                            ),
                                                                            borderRadius: BorderRadius.all(Radius.circular(25)))
                                                                        : BoxDecoration(),
                                                                    child: IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        datealready ==
                                                                                true
                                                                            ? Fluttertoast.showToast(
                                                                                backgroundColor: Colors.white,
                                                                                msg: "Today's Attendance Marked Already",
                                                                                textColor: Colors.black)
                                                                            : setState(() {
                                                                                markattantencelist[index].startok = true;
                                                                                markattantencelist[index].markpresenttrue == true ? markattantencelist[index].markpresenttrue = false : markattantencelist[index].markpresenttrue = true;

                                                                                markattantencelist[index].markpresenttrue == true ? markattantencelist[index].markpresentfalse = false : markattantencelist[index].markpresentfalse = true;

                                                                                markattantencelist[index].markpresenttrue == true ? markattantencelist[index].change = true : markattantencelist[index].change = false;
                                                                              });
                                                                      },
                                                                      color: Colors
                                                                          .green,
                                                                      icon: Icon(
                                                                          Icons
                                                                              .done),
                                                                    )),
                                                            onTap: () {},
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                markattantencelist.length == 0
                                                    ? SizedBox()
                                                    : markattantencelist[index]
                                                                .change ==
                                                            true
                                                        ? SizedBox()
                                                        : Row(
                                                            children: [
                                                              MaterialButton(
                                                                  child: Text(
                                                                      "Leave"),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  minWidth: 65,
                                                                  height: 20,
                                                                  color: markattantencelist[index]
                                                                              .leave ==
                                                                          false
                                                                      ? Colors
                                                                          .grey
                                                                      : Colors
                                                                          .green,
                                                                  onPressed:
                                                                      () {
                                                                    specialDay ==
                                                                            true
                                                                        ? Fluttertoast.showToast(
                                                                            backgroundColor: Colors
                                                                                .white,
                                                                            msg:
                                                                                "can't change",
                                                                            textColor: Colors
                                                                                .black)
                                                                        : datealready ==
                                                                                true
                                                                            ? Fluttertoast.showToast(
                                                                                backgroundColor: Colors.white,
                                                                                msg: "can't change",
                                                                                textColor: Colors.black)
                                                                            : setState(() {
                                                                                markattantencelist[index].leave == true ? markattantencelist[index].leave = false : markattantencelist[index].leave = true;

                                                                                markattantencelist[index].leave == true ? markattantencelist[index].absent = false : markattantencelist[index].absent = true;
                                                                              });
                                                                  }),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                              MaterialButton(
                                                                  child: Text(
                                                                      "Absent"),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  minWidth: 65,
                                                                  height: 20,
                                                                  color: markattantencelist[index]
                                                                              .absent ==
                                                                          false
                                                                      ? Colors
                                                                          .grey
                                                                      : Colors
                                                                          .green,
                                                                  onPressed:
                                                                      () {
                                                                    datealready ==
                                                                            true
                                                                        ? Fluttertoast.showToast(
                                                                            backgroundColor: Colors
                                                                                .white,
                                                                            msg:
                                                                                "can't change",
                                                                            textColor: Colors
                                                                                .black)
                                                                        : setState(
                                                                            () {
                                                                            markattantencelist[index].absent == true
                                                                                ? markattantencelist[index].absent = false
                                                                                : markattantencelist[index].absent = true;

                                                                            markattantencelist[index].absent == true
                                                                                ? markattantencelist[index].leave = false
                                                                                : markattantencelist[index].leave = true;
                                                                          });
                                                                  })
                                                            ],
                                                          ),
                                              ]),
                                        ),
                                      ),
                                      onTap: () {
                                        /////
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           UnitsDetailedView(
                                        //             unitId: state
                                        //                 .viewAllEmployeeModel
                                        //                 .data![index]
                                        //                 .userName
                                        //                 .toString(),
                                        //           )),
                                        // );

                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                              ///////for
                            });
              } else {
                return Center(
                  child: SizedBox(
                    height: 28.0,
                    width: 28.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  ),
                );
              }
            }, listener: (context, state) async {
              if (state is EmployeeListing) {
                if (state.items9!.isNotEmpty) {
                  setState(() {
                    uploadprocced = false;
                  });
                }
                setState(() {
                  day.toString() == "Saturday"
                      ? specialDay = true
                      : specialDay = false;

                  day.toString() == "Sunday"
                      ? specialDay = true
                      : specialDay = false;
                });

                for (int i = 0; i < state.items6!.length; i++) {
                  markattantencelist.add(MarkattentanceModel(
                      markpresentfalse: false,
                      change: true,
                      startok: false,
                      empid: state.items6![i]['empid'].toString(),
                      empName: state.items6![i]['userName'].toString(),
                      phone: state.items6![i]['phonenumber'].toString(),
                      markpresenttrue: false,
                      leave: specialDay == false ? true : false,
                      absent: specialDay == true ? true : false));
                }
/////
                for (int k = 0; k < state.items10!.length; k++) {
                  if (state.items10![k]['date'] == _currentDate) {
                    setState(() {
                      datealready = true;
                    });
                  }
                }

                List items56 = await getattendancecheckuploaddata();
                if (datealready == true) {
                  if (items56.isEmpty) {
                    uploadalready = true;
                  }
                }

///////////////////////////////////////////////////////////
                if (datealready == true) {
                  for (int i = 0; i < markattantencelist.length; i++) {
                    for (int j = 0; j < state.items9!.length; j++) {
                      if (markattantencelist[i].empid ==
                          state.items9![j]['empId']) {
                        if (state.items9![j]['isPresent'] == '1') {
                          setState(() {
                            markattantencelist[i].absent = false;
                          });
                        } else if (state.items9![j]['leaveType'] == 'Absent') {
                          setState(() {
                            markattantencelist[i].change = false;
                            markattantencelist[i].startok = true;
                            // markattantencelist[i].markpresentfalse = true;
                            markattantencelist[i].absent = true;
                            markattantencelist[i].leave = false;
                          });
                        } else if (state.items9![j]['leaveType'] == 'Leave') {
                          setState(() {
                            markattantencelist[i].change = false;
                            markattantencelist[i].startok = true;
                            // markattantencelist[i].markpresentfalse = true;
                            markattantencelist[i].absent = false;
                            markattantencelist[i].leave = true;
                          });
                        }
                      }
                    }
                  }
                  setState(() {});
                }

                setState(() {});
              }
            }),

            /////for doing the attendance history
            ///
          ],
        ),
      ),
    );
  }

  Widget profileBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 35,
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                child: Text(_currentDate,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            BlocConsumer<GetViewAllEmployeeBloc, ViewAllEmployeeState>(
                builder: (context, state) {
                  if (state is ViewAllEmployeeSuccess) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.viewAllEmployeeModel.data!.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            //width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 6,
                                ),
                                InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xfff292929),
                                      borderRadius: BorderRadius.circular(2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 4,
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      state.viewAllEmployeeModel
                                                          .data![index].userName
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      state
                                                          .viewAllEmployeeModel
                                                          .data![index]
                                                          .phoneNumber
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Transform.scale(
                                                  scale: 0.7,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                          decoration: true
                                                              ? BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: AppColors
                                                                          .black,
                                                                      offset: Offset(
                                                                          0.8,
                                                                          0.8),
                                                                      blurRadius:
                                                                          4.0,
                                                                    ),
                                                                  ],
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              25)))
                                                              : BoxDecoration(),
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            color: Colors.red,
                                                            icon: Icon(
                                                                Icons.close),
                                                          )),
                                                      SizedBox(
                                                        width: 15.0,
                                                      ),
                                                      Container(
                                                          decoration: true
                                                              ? BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: AppColors
                                                                          .black,
                                                                      offset: Offset(
                                                                          0.1,
                                                                          0.9),
                                                                      blurRadius:
                                                                          5.0,
                                                                    ),
                                                                  ],
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              25)))
                                                              : BoxDecoration(),
                                                          child: IconButton(
                                                            onPressed: () {},
                                                            color: Colors.green,
                                                            icon: Icon(
                                                                Icons.done),
                                                          )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                MaterialButton(
                                                    child: Text("Leave"),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    minWidth: 65,
                                                    height: 20,
                                                    color: Colors.green,
                                                    onPressed: () {}),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                MaterialButton(
                                                    child: Text("Absent"),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                    minWidth: 65,
                                                    height: 20,
                                                    color: Colors.green,
                                                    onPressed: () {})
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                  onTap: () {
                                    //

                                    setState(() {});
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: SizedBox(
                        height: 28.0,
                        width: 28.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                },
                listener: (context, state) {}),
          ],
        ),
      ),
    );
  }

////
  String convert(String uTCTime) {
    var dateFormat =
        DateFormat("dd-MM-yyyy hh:mm"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(uTCTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    // String createdDate = dateFormat.format(DateTime.parse(localDate));
    return localDate;
  }

  void validate() {
    for (int i = 0; i < markattantencelist.length; i++) {
      final datecontroller = _currentDate.toString();
      final empid = markattantencelist[i].empid;

      final isPresent = markattantencelist[i].change == true ? true : false;
      final leaveType = markattantencelist[i].change == true
          ? ""
          : markattantencelist[i].absent == true
              ? "Absent"
              : "Leave";
      final phone = markattantencelist[i].phone;
      final name = markattantencelist[i].empName;
      final reason = "";
      final edited = false;
      if (empid!.isEmpty) {
        return;
      } else {
        Map data = {
          "date": datecontroller,
          "empId": empid,
          "isPresent": isPresent,
          "leaveType": leaveType,
          "reason": reason,
          "edited": edited,
        };

        print(data);

        markAttendance(data);
////for adding to local list start
///////
        Map data2 = {
          'dateid': datecontroller,
          'attendanceid': "",
          'isPresent': isPresent,
          'leaveType': leaveType,
          'isSpecialDay': "",
          'empId': empid,
          'phoneNumber': phone,
          'role': "",
          'userName': name,
          'dob': "",
          'gender': "",
          'assignedUnitId': "",
          'assignedTo': "",
          'attendnaceDate': datecontroller,
          "description": reason
        };
        print(data2);
        attendanceDetails(data2);

        getupdatepresentdata(isPresent, empid);
////////////////////attendance to local list end

        if (i == markattantencelist.length - 1) {
          final date = _currentDate.toString();
          final keyword = "done";

          if (date.isEmpty) {
            return;
          } else {
            Map data = {
              "date": date,
              "keyword": keyword,
            };
            print(data);

            datecheck(data);
            Map data2 = {"data": "not uploaded"};
            uploadattendancecheck(data2);
          }

          Fluttertoast.showToast(
              backgroundColor: Colors.white,
              msg: "Attendance Marked",
              textColor: Colors.black);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AttendanceReport()));
        }
      }
    }
  }
}

class MarkattentanceModel {
  bool? markpresenttrue = false;
  String? empid;
  bool? markpresentfalse = false;
  bool? startok = false;
  String? phone;

  String? empName;
  bool? leave = false;
  bool? absent = false;
  bool? change = false;

  MarkattentanceModel({
    this.markpresenttrue,
    this.startok,
    this.markpresentfalse,
    this.empid,
    this.phone,
    this.empName,
    this.leave,
    this.change,
    this.absent,
  });
}
