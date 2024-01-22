import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:parambikulam/bloc/assets/haltbloc/uploadhaltbloc/uploadhaltbloc.dart';
import 'package:parambikulam/bloc/assets/haltbloc/uploadhaltbloc/uploadhaltevent.dart';
import 'package:parambikulam/bloc/assets/haltbloc/uploadhaltbloc/uploadhaltstate.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/haltmarkuploadbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendancedatafetchingbloc.dart';

import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

///////////
class HaltdetailsPage extends StatefulWidget {
  const HaltdetailsPage({Key? key}) : super(key: key);
  @override
  State<HaltdetailsPage> createState() => _HaltdetailsPageState();
}

class _HaltdetailsPageState extends State<HaltdetailsPage> {
  late String _currentDate;
  List<Halt2UploadModel> halt2uploadlist = [];
  bool? datealready = false;
  var d1 = new DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() {
    BlocProvider.of<MarkAttendanceOfflineBloc>(context)
        .add(GetMarkAttendanceData());
    // _currentDate = "2022-04-18";
    _currentDate = currentDate();

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HALT DETAILS'), actions: [
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
      body: Column(
        children: [
          BlocConsumer<MarkAttendanceOfflineBloc, StateMarkAttendance>(
              builder: (context, state) {
            if (state is MarkingAttendance) {
              return state.items13!.length == 0
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "Please Submit halt to View Details",
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      )),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            d1.format(
                                DateTime.parse(state.items13![0]['date'])),
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.items13!.length,
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
                                                          state.items13![index]
                                                              ['empname'],
                                                          style: TextStyle(
                                                              fontSize: 14),
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
                                                          fontSize: 14),
                                                    ),

                                                    Text(
                                                      state.items13![index]
                                                          ['empphone'],
                                                      style: TextStyle(
                                                          fontSize: 14),
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
              return Center();
            }
          }, listener: (context, state) {
            if (state is MarkingAttendance) {
              if (state.items13!.isNotEmpty) {
                //////
                _currentDate = state.items13![0]['date'].toString();
              }

              for (int k = 0; k < state.items15!.length; k++) {
                if (state.items15![k]['date'] == _currentDate) {
                  setState(() {
                    datealready = true;
                  });
                } else {
                  // setState(() {
                  //   datealready = false;
                  // });
                }
              }
            }
          }),
          Container(
            child: BlocConsumer<HaltUploadBloc, StateHaltUpload>(
                builder: (context, state) {
              if (state is HaltUploading) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                );
              } else {
                return Center();
              }
            }, listener: (context, state) {
              if (state is HaltUploading) {
                if (state.items13!.isNotEmpty) {
                  halt2uploadlist.clear();
                  for (int i = 0; i < state.items13!.length; i++) {
                    halt2uploadlist.add(Halt2UploadModel(
                      date: _currentDate,
                      empId: state.items13![i]['empid'],
                      empName: state.items13![i]['empname'],
                      empPhone: state.items13![i]['empphone'],
                    ));
                  }

                  BlocProvider.of<GetUploadHaltBloc>(context)
                      .add(UploadHaltEvent(halt2uploadlist: halt2uploadlist));

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
            child: BlocConsumer<GetUploadHaltBloc, UploadHaltState>(
                builder: (context, state) {
              if (state is UploadHaltsuccess) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                );
              } else {
                return Center();
              }
            }, listener: (context, state) {
              if (state is UploadHaltsuccess) {
                Fluttertoast.showToast(
                    backgroundColor: Colors.white,
                    msg: "Halt Uploaded",
                    textColor: Colors.black);

                ///widrawers
                // for (int k = 0; k < halt2uploadlist.length; k++) {
                //   final dateid = halt2uploadlist[k].date == null
                //       ? ""
                //       : halt2uploadlist[k].date;

                //   final haltid = "";
                //   final empid = halt2uploadlist[k].empId == null
                //       ? ""
                //       : halt2uploadlist[k].empId;
                //   final phoneNumber = halt2uploadlist[k].empPhone == null
                //       ? ""
                //       : halt2uploadlist[k].empPhone;
                //   final role = "";
                //   final userName = halt2uploadlist[k].empName == null
                //       ? ""
                //       : halt2uploadlist[k].empName;
                //   final dob = "";

                //   final gender = "";
                //   final assignedUnitId = "";

                //   final assingedTo = halt2uploadlist[k].assigned == null
                //       ? ""
                //       : halt2uploadlist[k].assigned;
                //   final haltDate = halt2uploadlist[k].date == null
                //       ? ""
                //       : halt2uploadlist[k].date;

                //   if (empid!.isEmpty) {
                //     return null;
                //   } else {
                //     Map data = {
                //       'dateid': dateid,
                //       'haltid': haltid,
                //       'empid': empid,
                //       'phoneNumber': phoneNumber,
                //       'role': role,
                //       'userName': userName,
                //       'dob': dob,
                //       'gender': gender,
                //       'assignedUnitId': assignedUnitId,
                //       'assingedTo': assingedTo,
                //       'haltDate': haltDate,
                //       'count': "1",
                //     };
                //     print(data);
                //     haltreport(data);
                //     /////
                //   }
                // }

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

                  datecheck(data);
                  setState(() {});
                }

                fetcher();
              }

              if (state is UploadHaltError) {
                Fluttertoast.showToast(msg: state.error);
              }
            }),
          ),
        ],
      ),
    );
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

                    // BlocProvider.of<AttendanceUploadBloc>(context)
                    //     .add(GetAttendanceUploadData());

                    BlocProvider.of<HaltUploadBloc>(context)
                        .add(GetHaltUploadData());

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

  String currentDate() {
    var now = new DateTime.now().subtract(Duration(days: 1));
    // var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}

class Halt2UploadModel {
  String? date;
  String? empId;
  String? empName;
  String? empPhone;
  String? assigned;

  Halt2UploadModel({
    this.date,
    this.empId,
    this.empName,
    this.empPhone,
  });
}
