import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendancedatafetchingbloc.dart';

/////for dropdown
class AttendanceMainReport extends StatefulWidget {
  final String dateref;
  const AttendanceMainReport({Key? key, required this.dateref})
      : super(key: key);
//////
  @override
  State<AttendanceMainReport> createState() => _AttendanceMainReportState();
}

class _AttendanceMainReportState extends State<AttendanceMainReport> {
  String dropdownvalue = 'All';
  final TextEditingController dropdowncontroller = TextEditingController();
  final TextEditingController dropdown2controller = TextEditingController();
  late String _currentDate;
  int count = 0;
  int count2 = 0;
  var d1 = new DateFormat('dd-MM-yyyy');

  var items = [
    'All',
    'Present',
    'Not Present',
  ];

  @override
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() {
    BlocProvider.of<MarkAttendanceOfflineBloc>(context)
        .add(GetMarkAttendanceData());
    dropdown2controller.text = "true";
    _currentDate = currentDate();

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ATTENDANCE DETAILS'), actions: []),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    : Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Text(
                                count2.toString() + "/" + count.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Center(
                              child: Container(
                                child: DropdownButtonFormField(
                                  focusColor: Colors.white,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none),
                                  value: dropdownvalue,
                                  dropdownColor: Colors.black,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;

                                      dropdowncontroller.text =
                                          newValue == "Present" ? "1" : "0";
                                      dropdown2controller.text =
                                          newValue == "All" ? "true" : "false";
                                      // producttypecontroller.text =
                                      //     newValue;
                                    });
                                  },
                                  // dropdownColor: Color(0xfff7f7f7),
                                ),
                              ),
                            ),
                          ),
                          dropdown2controller.text != "true"
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: state.items12!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return d1.format(DateTime.parse(state
                                                .items12![index]['dateid'])) !=
                                            d1.format(DateTime.parse(
                                                widget.dateref.toString()))
                                        ? Container()
                                        : state.items12![index]['isPresent'] !=
                                                dropdowncontroller.text
                                                    .toString()
                                            ? SizedBox()
                                            : Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: ListTile(
                                                    title: InkWell(
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white10,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 4,
                                                          blurRadius: 4,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
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
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                        ),

                                                                        Text(
                                                                          state.items12![index]
                                                                              [
                                                                              'userName'],
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                        ),

                                                                        // Text(
                                                                        //   attendancedetailslist
                                                                        //               .length !=
                                                                        //           0
                                                                        //       ? attendancedetailslist[
                                                                        //               index]
                                                                        //           .empname
                                                                        //           .toString()
                                                                        //       : "",
                                                                        //   style: TextStyle(
                                                                        //       fontSize: 14),
                                                                        // )
                                                                      ]),
                                                                  SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  Row(
                                                                      children: [
                                                                        Text(
                                                                          "Phone Number: ",
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                        ),

                                                                        Text(
                                                                          state.items12![index]
                                                                              [
                                                                              'phoneNumber'],
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                        )
                                                                        // Text(
                                                                        //   attendancedetailslist
                                                                        //               .length !=
                                                                        //           0
                                                                        //       ? attendancedetailslist[
                                                                        //               index]
                                                                        //           .empPhone
                                                                        //           .toString()
                                                                        //       : "",
                                                                        //   style:
                                                                        //       TextStyle(fontSize: 14),
                                                                        // )
                                                                      ]),
                                                                  SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  Row(
                                                                      children: [
                                                                        Text(
                                                                          "Attendance : ",
                                                                          style:
                                                                              TextStyle(fontSize: 14),
                                                                        ),

                                                                        state.items12![index]['isPresent'] ==
                                                                                "1"
                                                                            ? Text(
                                                                                "Present",
                                                                                style: TextStyle(color: Colors.green, fontSize: 14),
                                                                              )
                                                                            : Text(
                                                                                state.items12![index]['leaveType'].toString(),
                                                                                style: TextStyle(color: Colors.red, fontSize: 14),
                                                                              ),
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
                                                                      ]),
                                                                  SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  state.items12![index]
                                                                              [
                                                                              'description'] ==
                                                                          null
                                                                      ? SizedBox()
                                                                      : state.items12![index]['description'] ==
                                                                              ""
                                                                          ? SizedBox()
                                                                          : Row(children: [
                                                                              Text(
                                                                                "Reason : ",
                                                                                style: TextStyle(fontSize: 14),
                                                                              ),
                                                                              Text(
                                                                                state.items12![index]['description'].toString(),
                                                                                style: TextStyle(color: Colors.green, fontSize: 14),
                                                                              ),
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
                                  })
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: state.items12!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return d1.format(DateTime.parse(state
                                                .items12![index]['dateid'])) !=
                                            d1.format(DateTime.parse(
                                                widget.dateref.toString()))
                                        ? Container()
                                        : Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: ListTile(
                                                title: InkWell(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white10,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      spreadRadius: 4,
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
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
                                                                          fontSize:
                                                                              14),
                                                                    ),

                                                                    Text(
                                                                      state.items12![
                                                                              index]
                                                                          [
                                                                          'userName'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),

                                                                    // Text(
                                                                    //   attendancedetailslist
                                                                    //               .length !=
                                                                    //           0
                                                                    //       ? attendancedetailslist[
                                                                    //               index]
                                                                    //           .empname
                                                                    //           .toString()
                                                                    //       : "",
                                                                    //   style: TextStyle(
                                                                    //       fontSize: 14),
                                                                    // )
                                                                  ]),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Row(children: [
                                                                Text(
                                                                  "Phone Number: ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                ),

                                                                Text(
                                                                  state.items12![
                                                                          index]
                                                                      [
                                                                      'phoneNumber'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                )
                                                                // Text(
                                                                //   attendancedetailslist
                                                                //               .length !=
                                                                //           0
                                                                //       ? attendancedetailslist[
                                                                //               index]
                                                                //           .empPhone
                                                                //           .toString()
                                                                //       : "",
                                                                //   style:
                                                                //       TextStyle(fontSize: 14),
                                                                // )
                                                              ]),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Row(children: [
                                                                Text(
                                                                  "Attendance : ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14),
                                                                ),

                                                                state.items12![index]
                                                                            [
                                                                            'isPresent'] ==
                                                                        "1"
                                                                    ? Text(
                                                                        "Present",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.green,
                                                                            fontSize: 14),
                                                                      )
                                                                    : Text(
                                                                        state
                                                                            .items12![index]['leaveType']
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red,
                                                                            fontSize: 14),
                                                                      ),
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
                                                              ]),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              state.items12![index]
                                                                          [
                                                                          'description'] ==
                                                                      null
                                                                  ? SizedBox()
                                                                  : state.items12![index]
                                                                              [
                                                                              'description'] ==
                                                                          ""
                                                                      ? SizedBox()
                                                                      : state.items12![index]['isPresent'] ==
                                                                              "1"
                                                                          ? SizedBox()
                                                                          : Row(children: [
                                                                              Text(
                                                                                "Reason : ",
                                                                                style: TextStyle(fontSize: 14),
                                                                              ),
                                                                              Text(
                                                                                state.items12![index]['description'].toString(),
                                                                                style: TextStyle(color: Colors.green, fontSize: 14),
                                                                              ),
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
                                  }),
                        ],
                      );
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
            }, listener: (context, state) {
              if (state is MarkingAttendance) {
                count = 0;
                count2 = 0;
                for (int i = 0; i < state.items12!.length; i++) {
                  if (d1.format(DateTime.parse(state.items12![i]['dateid'])) ==
                      d1.format(DateTime.parse(widget.dateref.toString()))) {
                    if (state.items12![i]['isPresent'] == "1") {
                      count2 = count2 + 1;
                    }

                    count = count + 1;
                    setState(() {});
                  }
                }
                print(count);
                print(count2);
                // attendancedetailslist.clear();
                // for (int i = 0; i < state.items6!.length; i++) {
                //   for (int j = 0; j < state.items9!.length; j++) {
                //     if (state.items9![j]['empId'] ==
                //         state.items6![i]['empid']) {
                //       attendancedetailslist.add(AttendanceDetailsModel(
                //           empname: state.items6![i]['userName'],
                //           empPhone: state.items6![i]['phonenumber'],
                //           role: state.items6![i]['role'],
                //           gender: state.items6![i]['gender']));
                //     }
                //   }
                // }

                // for (int k = 0; k < state.items11!.length; k++) {
                //   if (state.items11![k]['date'] == _currentDate) {
                //     setState(() {
                //       datealready = true;
                //     });
                //   }
                // }
              }
            }),
          ],
        ),
      ),
    );
  }

  String currentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
