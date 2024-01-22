import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendancedatafetchingbloc.dart';

import 'package:parambikulam/ui/assets/ic_main/attendance/attendancereportmain.dart';

import 'package:parambikulam/ui/assets/ic_main/halt/haltdashboard.dart';
///////

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({Key? key}) : super(key: key);

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  late String _currentDate;
  final TextEditingController datecheckcontroller = TextEditingController();
  final TextEditingController date2controller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<AttendanceDetailsMainModel> attendancedetailsmainlist = [];
  var d1 = new DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() {
    BlocProvider.of<MarkAttendanceOfflineBloc>(context)
        .add(GetMarkAttendanceData());

    _currentDate = currentDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('ATTENDANCE REPORT'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HaltMainDashBoard())),
          ),
          actions: []),
      body: SingleChildScrollView(
        child: Column(
          children: [
/////
            BlocConsumer<MarkAttendanceOfflineBloc, StateMarkAttendance>(
                builder: (context, state) {
              if (state is MarkingAttendance) {
                return state.items12!.length == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "No Data Found",
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        )),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: attendancedetailsmainlist.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
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
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(d1.format(DateTime.parse(
                                              attendancedetailsmainlist[index]
                                                  .dateid
                                                  .toString()))),
                                        ),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.white,
                                      ),
                                    )
                                  ]),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AttendanceMainReport(
                                        dateref:
                                            attendancedetailsmainlist[index]
                                                .dateid
                                                .toString())),
                              );
                            },
                          ));
                        });
              } else if (state is AttendanceFetching) {
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
              } else {
                return Container();
              }
            }, listener: (context, state) {
              if (state is MarkingAttendance) {
                attendancedetailsmainlist.clear();

                for (int i = 0; i < state.items12!.length; i++) {
                  if (attendancedetailsmainlist.any((element) =>
                      element.dateid == state.items12![i]['dateid'])) {
                  } else {
                    attendancedetailsmainlist.add(AttendanceDetailsMainModel(
                      dateid: state.items12![i]['dateid'],
                      attendanceid: state.items12![i]['attendanceid'],
                      isPresent: state.items12![i]['isPresent'],
                      leaveType: state.items12![i]['leaveType'],
                      isSpecialDay: state.items12![i]['isSpecialDay'],
                      empId: state.items12![i]['empId'],
                      phoneNumber: state.items12![i]['phoneNumber'],
                      role: state.items12![i]['role'],
                      userName: state.items12![i]['userName'],
                      dob: state.items12![i]['dob'],
                      gender: state.items12![i]['gender'],
                      assignedUnitId: state.items12![i]['assignedUnitId'],
                      assignedTo: state.items12![i]['assignedTo'],
                      attendnaceDate: state.items12![i]['attendnaceDate'],
                    ));
                  }
                }
              }
            }),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2028),
    );

    setState(() {
      selectedDate = selected!;
      datecheckcontroller.text =
          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}/${selectedDate.hour}/${selectedDate.minute}/${selectedDate.second}";

      date2controller.text = selected.toString();
      print(date2controller.text.toString());

      // date2checkcontroler.text = selected.toString();

      // print(date2checkcontroler.text);

      //  DateTime dt1 =  DateTime.parse(datecheckyearcontroller.text.toString());

      setState(() {});
    });
  }

  String currentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}

//     attendancedetailsmainlist.add(AttendanceDetailsMainModel(
//       dateid: state.items12![i]['dateid'],
//       attendanceid: state.items12![i]['attendanceid'],
//       isPresent: state.items12![i]['isPresent'],
//       leaveType: state.items12![i]['leaveType'],
//       isSpecialDay: state.items12![i]['isSpecialDay'],
//       empId: state.items12![i]['empId'],
//       phoneNumber: state.items12![i]['phoneNumber'],
//       role: state.items12![i]['role'],
//       userName: state.items12![i]['userName'],
//       dob: state.items12![i]['dob'],
//       gender: state.items12![i]['gender'],
//       assignedUnitId: state.items12![i]['assignedUnitId'],
//       assignedTo: state.items12![i]['assignedTo'],
//       attendnaceDate: state.items12![i]['attendnaceDate'],
//     ));

class AttendanceDetailsMainModel {
  String? dateid;
  String? attendanceid;
  String? isPresent;

  String? leaveType;

  String? isSpecialDay;
  String? empId;
  String? phoneNumber;

  String? role;

  String? userName;

  String? dob;

  String? gender;

  String? assignedUnitId;

  String? assignedTo;
  String? attendnaceDate;
  AttendanceDetailsMainModel({
    this.dateid,
    this.attendanceid,
    this.isPresent,
    this.leaveType,
    this.isSpecialDay,
    this.empId,
    this.phoneNumber,
    this.role,
    this.userName,
    this.dob,
    this.gender,
    this.assignedUnitId,
    this.assignedTo,
    this.attendnaceDate,
  });
}
