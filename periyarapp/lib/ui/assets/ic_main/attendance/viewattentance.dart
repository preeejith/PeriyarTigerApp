import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/uploadattendancebloc/uploadattendancebloc.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/uploadattendancebloc/uploadattendanceevent.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/uploadattendancebloc/uploadattendancestate.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendancedatafetchingbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendenceuploadbloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

//////
class ViewAttendancePage extends StatefulWidget {
  const ViewAttendancePage({Key? key}) : super(key: key);

  @override
  State<ViewAttendancePage> createState() => _ViewAttendancePageState();
}

class _ViewAttendancePageState extends State<ViewAttendancePage> {
  late String _currentDate;
  bool? datealready = false;
  late List newList;
  List<AttendanceDetailsModel> attendancedetailslist = [];

  List<AttendanceUploadModel> attendanceuploadlist = [];
  @override
  void initState() {
    fetcher();
    super.initState();
  }

/////
  void fetcher() {
    BlocProvider.of<MarkAttendanceOfflineBloc>(context)
        .add(GetMarkAttendanceData());
    _currentDate = currentDate();
    // _currentDate = "2022-04-18";

    setState(() {});
  }

//////
//////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("VIEW ATTENDANCE"), actions: [
          datealready == true
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    print("yes");

                    datasync2();
                  },
                  icon: Icon(Icons.upload),
                ),
        ]),
        body: SingleChildScrollView(
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
              /////
              BlocConsumer<MarkAttendanceOfflineBloc, StateMarkAttendance>(
                  builder: (context, state) {
                if (state is MarkingAttendance) {
                  return state.items9!.length == 0
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Please Submit Attendance to View Details",
                            style: TextStyle(fontSize: 8, color: Colors.white),
                          )),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.items9!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.all(2.0),
                              child: ListTile(
                                  title: InkWell(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 4,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Employee Name : ',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        attendancedetailslist
                                                                    .length !=
                                                                0
                                                            ? attendancedetailslist[
                                                                    index]
                                                                .empname
                                                                .toString()
                                                            : "",
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      )
                                                    ]),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(children: [
                                                  Text(
                                                    "Phone Number: ",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  Text(
                                                    attendancedetailslist
                                                                .length !=
                                                            0
                                                        ? attendancedetailslist[
                                                                index]
                                                            .empPhone
                                                            .toString()
                                                        : "",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  )
                                                ]),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(children: [
                                                  Text(
                                                    "Attendance : ",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),

                                                  state.items9![index]
                                                              ['isPresent'] ==
                                                          '1'
                                                      ? Text(
                                                          "Present",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 14),
                                                        )
                                                      : Text(
                                                          state.items9![index]
                                                                  ['leaveType']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 14),
                                                        ),
                                                  /////
                                                  // Text(
                                                  //   state.items9![index]
                                                  //               ['isPresent'] ==
                                                  //           '1'
                                                  //       ? "Present"
                                                  //       : state.items9![index]
                                                  //               ['leaveType']
                                                  //           .toString(),
                                                  //   style: TextStyle(fontSize: 14),
                                                  // )

                                                  // Text(
                                                  //   d1.format(DateTime.parse(
                                                  //       state.items4![
                                                  //               index][
                                                  //           'bookingdate'])),
                                                  //   style: TextStyle(
                                                  //       fontSize: 14),
                                                  // )
                                                  /////
                                                ]),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           IbReservationDetailed(
                                  //             state: state,
                                  //             index: index,
                                  //           )),
                                  // );
                                },
                              )),
                            );
                          });
                } else {
                  return Center();
                }
              }, listener: (context, state) {
                if (state is MarkingAttendance) {
                  if (state.items9!.isNotEmpty) {
                    setState(() {
                      _currentDate = state.items9![0]['date'].toString();
                    });
                  }

                  attendancedetailslist.clear();
                  for (int i = 0; i < state.items6!.length; i++) {
                    for (int j = 0; j < state.items9!.length; j++) {
                      if (state.items9![j]['empId'] ==
                          state.items6![i]['empid']) {
                        attendancedetailslist.add(AttendanceDetailsModel(
                            empname: state.items6![i]['userName'],
                            empPhone: state.items6![i]['phonenumber'],
                            role: state.items6![i]['role'],
                            gender: state.items6![i]['gender']));
                      }
                    }
                  }

                  for (int k = 0; k < state.items11!.length; k++) {
                    if (state.items11![k]['date'] == _currentDate) {
                      setState(() {
                        datealready = true;
                      });
                    }
                  }
                }
              }),
              Container(
                child:
                    BlocConsumer<AttendanceUploadBloc, StateAttendanceUpload>(
                        builder: (context, state) {
                  if (state is AttendanceUploading) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                    );
                  } else {
                    return Center();
                  }
                }, listener: (context, state) {
                  if (state is AttendanceUploading) {
                    if (state.items9!.isNotEmpty) {
                      attendanceuploadlist.clear();
                      for (int i = 0; i < state.items9!.length; i++) {
                        attendanceuploadlist.add(AttendanceUploadModel(
                          date: _currentDate,
                          empId: state.items9![i]['empId'],
                          isPresent: state.items9![i]['isPresent'] == "1"
                              ? "true"
                              : "false",
                          leaveType: state.items9![i]['isPresent'] == "1"
                              ? ""
                              : state.items9![i]['leaveType'],
                          empPhone: getTime(state.items6!,
                              state.items9![i]['empId'], 'phonenumber'),
                          empName: getTime(state.items6!,
                              state.items9![i]['empId'], 'userName'),
                        ));
                      }

                      BlocProvider.of<GetUploadAttendanceBloc>(context).add(
                          UploadAttendanceEvent(
                              attendanceuploadlist: attendanceuploadlist));

                      Fluttertoast.showToast(
                          backgroundColor: Colors.white,
                          msg: "Data Uploading",
                          textColor: Colors.black);
                    } else {
                      Fluttertoast.showToast(
                          backgroundColor: Colors.white,
                          msg: "No Data Available for Upload",
                          textColor: Colors.black);
                    }
                  }
                }),
              ),
              Container(
                child: BlocConsumer<GetUploadAttendanceBloc,
                    UploadAttendanceState>(builder: (context, state) {
                  if (state is UploadAttendancesuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                    );
                  } else {
                    return Center();
                  }
                }, listener: (context, state) {
                  if (state is UploadAttendancesuccess) {
                    Fluttertoast.showToast(
                        backgroundColor: Colors.white,
                        msg: "Attendance Uploaded",
                        textColor: Colors.black);

                    //////for uploadin to the  attendnace report
                    ///
                    for (int i = 0; i < attendanceuploadlist.length; i++) {
                      final dateid = attendanceuploadlist[i].date.toString();
                      final attendanceid =
                          attendanceuploadlist[i].date.toString();
                      final isPresent =
                          attendanceuploadlist[i].isPresent.toString() == "true"
                              ? "1"
                              : "0";
                      final leaveType =
                          attendanceuploadlist[i].leaveType.toString();

                      final isSpecialDay = "";
                      final empId = attendanceuploadlist[i].empId.toString();
                      final phoneNumber =
                          attendancedetailslist[i].empPhone.toString();
                      final role = "";
                      final userName =
                          attendanceuploadlist[i].empName.toString();
                      final dob = "";
                      final gender = "";
                      final assignedUnitId = "";
                      final assignedTo = "";
                      final attendnaceDate =
                          attendanceuploadlist[i].date.toString();

                      if (empId.isEmpty) {
                        return null;
                      } else {
                        Map data = {
                          'dateid': dateid,
                          'attendanceid': attendanceid,
                          'isPresent': isPresent,
                          'leaveType': leaveType,
                          'isSpecialDay': isSpecialDay,
                          'empId': empId,
                          'phoneNumber': phoneNumber,
                          'role': role,
                          'userName': userName,
                          'dob': dob,
                          'gender': gender,
                          'assignedUnitId': assignedUnitId,
                          'assignedTo': assignedTo,
                          'attendnaceDate': attendnaceDate,
                        };
                        print(data);
                        attendanceDetails(data);
                      }
                    }

                    /////////to report end

                    /////datecheck for upload
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

                      datecheck2(data);
                      setState(() {});
                    }
////
                    fetcher();
                  }
                }),
              ),
            ],
          ),
        ));
  }

  String currentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  void datasync2() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 60,
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Upload Data'),
                InkWell(
                  child: Icon(Icons.upload),
                  onTap: () {
                    print('bloc called');

                    BlocProvider.of<AttendanceUploadBloc>(context)
                        .add(GetAttendanceUploadData());

                    setState(() {
                      Navigator.pop(context);
                      // fetcher();
                    });
                  },
                )
              ]),
            ]),
          ),
        );
      },
    );

    setState(() {});
  }

  String getTime(
    List list,
    param1,
    String s,
  ) {
    newList = list.where((element) => element['empid'] == param1).toList();
    print(newList[0][s]);

    return newList[0][s];
    // return d1.format(DateTime.parse(convert(newList[0][s])));
  }
}

class AttendanceDetailsModel {
  String? empname;
  String? role;
  String? gender;

  String? empPhone;

  AttendanceDetailsModel({
    this.empname,
    this.role,
    this.gender,
    this.empPhone,
  });
}

class AttendanceUploadModel {
  String? date;
  String? empId;
  String? empPhone;
  String? isPresent;

  String? leaveType;
  String? empName;
  String? reason;

  AttendanceUploadModel(
      {this.date,
      this.reason,
      this.empId,
      this.empPhone,
      this.isPresent,
      this.leaveType,
      this.empName});
}
