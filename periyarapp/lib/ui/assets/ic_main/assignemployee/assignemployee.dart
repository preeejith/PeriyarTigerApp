import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignunitbloc/employeeassign_blocunit.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignunitbloc/employeeassign_eventunit.dart';

import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeebloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeeevent.dart';

import 'package:parambikulam/bloc/assets/localbloc/attentance/employeelistofflinebloc.dart';
import 'package:parambikulam/data/models/assetsmodel/ic_viewunnitsmodel.dart';


import 'package:parambikulam/ui/assets/homepages_assets/unitsview/ic_viewunitspage.dart';

/////view////////
class AssignEmployee extends StatefulWidget {
  final String unitid, untitype;
  final IcViewUnitsModel icViewUnitsModel;

  final int index;
  const AssignEmployee(
      {Key? key,
      required this.unitid,
      required this.untitype,
      required this.index,
      required this.icViewUnitsModel})
      : super(key: key);
//
  @override
  _AssignEmployee createState() => _AssignEmployee();
}

class _AssignEmployee extends State<AssignEmployee> {
  String? token;
  bool? confirmok = false;

  bool? confirmbutton = false;
  var d1 = new DateFormat('dd-MMM-yyyy');
  bool value = false;
  List<CheckboxModel> checkboxlist = [];

  @override
  void initState() {
    BlocProvider.of<GetViewAllEmployeeBloc>(context)
        .add(RefreshViewAllEmployeeEvent());
    fetcher();

    super.initState();
  }

/////
  void fetcher() async {
    BlocProvider.of<EmployeelistOfflineBloc>(context)
        .add(GetEmployeeListData());

        
    // BlocProvider.of<GetViewAllEmployeeBloc>(context)
    //     .add(FetchViewAllEmployeeEvent());
  }

  List<String> employeelist2 = [];

  List<EmployeeIdModel> employeeidlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: AppBar(
        title: const Text("Employees"),
      ),
      bottomNavigationBar:
          BlocConsumer<EmployeelistOfflineBloc, StateEmployeeList>(
              listener: ((context, state) {}),
              builder: (context, state) {
                if (state is EmployeeListing) {
                  return confirmok != true
                      ? SizedBox()
                      : (SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              MaterialButton(
                                child: Text(
                                  "CONFIRM",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),

                                height: 40,
                                minWidth: 300,

                                onPressed: () {
                                  setState(() {
                                    confirmbutton = true;
                                  });
                                  for (int k = 0;
                                      k < state.items6!.length;
                                      k++) {
                                    if (checkboxlist[k].checkon == true) {
                                      employeelist2.add(
                                          state.items6![k]['empid'].toString());
                                    }
                                  }
                                  validateData();
                                },

                                // child: BlocConsumer<GetEmployeeUnitAssignBloc,
                                //         EmployeeUnitAssignState>(
                                //     builder: (context, state) {
                                //   if (state is EmployeeUnitAssigning) {
                                //     return const SizedBox(
                                //       height: 18.0,
                                //       width: 18.0,
                                //       child: CircularProgressIndicator(
                                //         valueColor: AlwaysStoppedAnimation<Color>(
                                //             Colors.black),
                                //         strokeWidth: 2,
                                //       ),
                                //     );
                                //   } else {
                                //     return const Text(
                                //       "CONFIRM",
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.w600,
                                //           fontSize: 12),
                                //     );
                                //   }
                                // }, listener: (context, state) {
                                //   if (state is EmployeeUnitAssignsuccess) {
                                //     // groupid = state.snareWalkStartModel.data!.id;

                                //     Fluttertoast.showToast(
                                //         backgroundColor: Colors.white,
                                //         msg: "Employee assigned",
                                //         textColor: Colors.black);

                                //     Navigator.pushReplacement(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 CustomerBottomNavigation()));
                                //   }

                                //   if (state is EmployeeUnitAssignError) {
                                //     Fluttertoast.showToast(
                                //         backgroundColor: Colors.white,
                                //         msg: state.error,
                                //         textColor: Colors.black);
                                //   }
                                // }),

                                // color: AppStyles.appColor,
                                color: Color(0xfff68D389),
                              ),
                            ],
                          ),
                        ));
                } else {
                  return SizedBox.shrink();
                }
              }),
      body: profileBody(),
    );
  }

  Widget profileBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocConsumer<EmployeelistOfflineBloc, StateEmployeeList>(
                builder: (context, state) {
              if (state is EmployeeListing) {
                return confirmok == false
                    ? Center(child: Text("All Employess Are assigned"))
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.items6!.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return state.items6![index]['assignedUnitId']
                                      .toString() !=
                                  ""
                              ? SizedBox()
                              :

                              // state.viewAllEmployeeModel.data![index].present ==
                              //         false
                              //     ? SizedBox()
                              //     :

                              SizedBox(
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
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 4,
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              "Name : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          Text(
                                                            state.items6![index]
                                                                    ['userName']
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              "Assigned Place : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          // Text("Boat Number : "),
                                                          Text(
                                                            state.items6![index]
                                                                            [
                                                                            'assignedTo']
                                                                        .toString() ==
                                                                    ""
                                                                ? "-"
                                                                : state.items6![
                                                                        index][
                                                                        'assignedTo']
                                                                    .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              "Phone Number : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          // Text("Boat Number : "),
                                                          Text(
                                                            state.items6![index]
                                                                    [
                                                                    'phonenumber']
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              "Gender : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          // Text("Boat Number : "),
                                                          Text(
                                                            state.items6![index]
                                                                    ['gender']
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              "DOB : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          // Text("Boat Number : "),
                                                          Text(
                                                              d1.format(DateTime
                                                                  .parse(convert(state
                                                                      .items6![
                                                                          index]
                                                                          [
                                                                          'dob']
                                                                      .toString()))),
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                              )),
                                                        ],
                                                      ),
                                                    ]),
                                                Checkbox(
                                                  activeColor: Colors.green,
                                                  value:
                                                      checkboxlist.length != 0
                                                          ? checkboxlist[index]
                                                              .checkon
                                                          : false,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      checkboxlist[index]
                                                          .checkon = value!;
                                                      // state.viewAllEmployeeModel
                                                      //     .data![index].change = value!;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          //
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
                checkboxlist.clear();
                for (int i = 0; i < state.items6!.length; i++) {
                  checkboxlist.add(CheckboxModel(checkon: false));

                  employeeidlist.add(EmployeeIdModel(
                      employeeid: state.items6![i]['empid'],
                      assignedplace: state.items6![i]['assignedTo']));

                  state.items6![i]['assignedUnitId'].toString() == ""
                      ? confirmok = true
                      : SizedBox();
                  setState(() {});
                }

//                 for (int k = 0;
//                     k < state.viewAllEmployeeModel.data!.length;
//                     k++) {
//                   for (int j = 0;
//                       j <
//                           widget.icViewUnitsModel.user![widget.index]
//                               .unitincharge!.length;
//                       j++) {
//                     if (state.viewAllEmployeeModel.data![k].phoneNumber
//                             .toString() ==
//                         widget.icViewUnitsModel.user![widget.index]
//                             .unitincharge![j].phoneNumber
//                             .toString()) {
//                       setState(() {
//                         state.viewAllEmployeeModel.data![k].present = false;
//                       });
//                     } else {
//                       setState(() {
//                         state.viewAllEmployeeModel.data![k].present = true;
//                       });
//                     }
//                   }
//                 }

// //////to add removed employee list
//                 List items39 = await getAllremoveassignedemployeedata();
//                 if (items39.isNotEmpty) {
//                   for (int k = 0; k < items39.length; k++) {
//                     for (int j = 0;
//                         j <
//                             widget.icViewUnitsModel.user![widget.index]
//                                 .unitincharge!.length;
//                         j++) {
//                       if (items39[k]['phoneNumber'].toString() ==
//                           widget.icViewUnitsModel.user![widget.index]
//                               .unitincharge![j].phoneNumber
//                               .toString()) {
//                         for (int m = 0;
//                             m < state.viewAllEmployeeModel.data!.length;
//                             m++) {
//                           if (widget.icViewUnitsModel.user![widget.index]
//                                   .unitincharge![j].phoneNumber
//                                   .toString() ==
//                               state.viewAllEmployeeModel.data![m].phoneNumber
//                                   .toString()) {
//                             setState(() {
//                               state.viewAllEmployeeModel.data![m].present =
//                                   true;
//                             });
//                           }
//                         }
//                       } else {}
//                     }
//                   }
//                 }
//                 setState(() {});
              }
            }),
          ],
        ),
      ),
    );
  }

  void validateData() {
    if (employeelist2.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Please add employees ",
          textColor: Colors.black);
    } else {
      BlocProvider.of<GetEmployeeUnitAssignBloc>(context).add(
          GetEmployeeUnitAssign(
              unittype: widget.untitype,
              requestId: widget.unitid,
              employeelist2: employeelist2,
              employeeidlist: employeeidlist));

      Fluttertoast.showToast(
          msg: "Employee Assigned",
          textColor: Colors.black,
          backgroundColor: Colors.white,
          gravity: ToastGravity.BOTTOM);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => IcViewUnits()));
    }
  }

  String convert(String uTCTime) {
    var dateFormat =
        DateFormat("dd-MM-yyyy hh:mm"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(uTCTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();

    return localDate;
  }
}

class CheckboxModel {
  bool? checkon;
  CheckboxModel({this.checkon});
}

class EmployeeIdModel {
  String? employeeid;
  String? assignedplace;

  EmployeeIdModel({this.employeeid, this.assignedplace});
}
// class EmployeedetailsModel{

//   EmployeedetailsModel({

//   })
// }
