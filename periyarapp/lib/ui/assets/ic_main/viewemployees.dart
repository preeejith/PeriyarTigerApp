import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignbloc/employeeassignbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignbloc/employeeassignevent.dart';

import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeebloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeeevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeestate.dart';

import 'package:parambikulam/bloc/assets/localbloc/attentance/employeelistofflinebloc.dart';

import 'package:parambikulam/ui/assets/bottomnav.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class ViewAllEmployee extends StatefulWidget {
  const ViewAllEmployee({Key? key}) : super(key: key);

  @override
  _ViewAllEmployee createState() => _ViewAllEmployee();
}

///
class _ViewAllEmployee extends State<ViewAllEmployee> {
  String? token;
  bool? bottombar = false;
  List<TaskAssignedmodel> taskassigned = [];
  final TextEditingController employeesearchcontroller =
      TextEditingController();
  bool? procced = false;
  var d1 = new DateFormat('dd-MMM-yyyy');
  late String _currentDate;
  final TextEditingController assigndutycontroller = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<GetViewAllEmployeeBloc>(context)
        .add(RefreshViewAllEmployeeEvent());
    super.initState();
    fetcher();
  }

//
  void fetcher() async {
    _currentDate = currentDate();

    BlocProvider.of<EmployeelistOfflineBloc>(context)
        .add(GetEmployeeListData());
    List items9 = await getAllMarkedAttendancedata();
    for (int i = 0; i < items9.length; i++) {
      if (items9[i]['isPresent'] == '1') {}
    }

    // BlocProvider.of<GetViewAllEmployeeBloc>(context)
    //     .add(FetchViewAllEmployeeEvent());
  }

////
  List<AssignEmployeeModel> assignemployeelislist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: AppBar(
        title: const Text("ASSIGN DUTY"),
      ),
      bottomNavigationBar: bottombar == false
          ? SizedBox()
          : BlocConsumer<GetViewAllEmployeeBloc, ViewAllEmployeeState>(
              listener: ((context, state) {}),
              builder: (context, state) {
                if (state is ViewAllEmployeeSuccess) {
                  return (SizedBox(
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
                            for (int k = 0;
                                k < state.viewAllEmployeeModel.data!.length;
                                k++) {
                              if (state.viewAllEmployeeModel.data![k].change ==
                                  true) {
                                assignemployeelislist.add(AssignEmployeeModel(
                                  empId: state.viewAllEmployeeModel.data![k].id,
                                  remark: state.viewAllEmployeeModel.data![k]
                                      .assigndutycontroller.text
                                      .toString(),
                                ));
                              }
                            }
                            validateData();
                          },
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
    return RefreshIndicator(
      displacement: 50,
      backgroundColor: Colors.black,
      color: Color(0xfff68D389),
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      child: SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                    //noted
                    controller: employeesearchcontroller,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Search Employee',
                    ),
                    onChanged: (string) {
                      print("hello");

                      // if (assetsearchcontroller.text.isNotEmpty) {
                      BlocProvider.of<EmployeelistOfflineBloc>(context)
                          .add(SearchEmployeeListData(
                        keyword: employeesearchcontroller.text,
                      ));

                      //   setState(() {

                      //     // listview = true;
                      //   });
                      // }
                    }),
              ),
              BlocConsumer<EmployeelistOfflineBloc, StateEmployeeList>(
                  builder: (context, state) {
                if (state is EmployeeListing) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.items6!.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return state.items6![index]['present'].toString() !=
                                "true"
                            ? SizedBox()
                            : SizedBox(
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Name : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      state.items6![index]
                                                              ['userName']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Assigned Place : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    // Text("Boat Number : "),
                                                    Text(
                                                      state.items6![index][
                                                                      'assignedTo']
                                                                  .toString() ==
                                                              ""
                                                          ? "-"
                                                          : state.items6![index]
                                                                  ['assignedTo']
                                                              .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Phone Number : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      state.items6![index]
                                                              ['phonenumber']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Gender : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      state.items6![index]
                                                              ['gender']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     Padding(
                                                //       padding:
                                                //           const EdgeInsets.all(4.0),
                                                //       child: Text(
                                                //         "Dob : ",
                                                //         style: TextStyle(
                                                //             color: Colors.white),
                                                //       ),
                                                //     ),
                                                //     Text(
                                                //         d1.format(DateTime.parse(
                                                //             convert(state
                                                //                 .viewAllEmployeeModel
                                                //                 .data![index]
                                                //                 .dob
                                                //                 .toString()))),
                                                //         style: const TextStyle(
                                                //           color: Colors.white,
                                                //           fontSize: 14,
                                                //         )),
                                                //   ],
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Task assigned  : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),

                                                    taskassigned.length == 0
                                                        ? Text(
                                                            state.items6![index]
                                                                    [
                                                                    'taskAsseigned']
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                            ))
                                                        : taskassigned[index]
                                                                    .duty ==
                                                                ""
                                                            ? Text(
                                                                state.items6![
                                                                        index][
                                                                        'taskAsseigned']
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                ))
                                                            : Text(
                                                                taskassigned[
                                                                        index]
                                                                    .duty
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                ))
                                                    // state.items6![index]
                                                    //                 ['taskAsseigned']
                                                    //             .toString() ==
                                                    //         ""
                                                    //     ? Text(
                                                    //         state.items6![index]
                                                    //                 ['taskAsseigned']
                                                    //             .toString(),
                                                    //         style: const TextStyle(
                                                    //           color: Colors.white,
                                                    //           fontSize: 14,
                                                    //         ))
                                                    //     : Text(
                                                    //         state.items6![index]
                                                    //                 ['taskAsseigned']
                                                    //             .toString(),
                                                    //         style: const TextStyle(
                                                    //           color: Colors.white,
                                                    //           fontSize: 14,
                                                    //         ))
                                                  ],
                                                ),
                                                Center(
                                                  child: MaterialButton(
                                                      child: Text(
                                                          "Assign Duty " +
                                                              " " +
                                                              "+"),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2)),
                                                      minWidth: 65,
                                                      height: 20,
                                                      color: Colors.green,
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return SingleChildScrollView(
                                                              child: SizedBox(
                                                                child:
                                                                    AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  title: Text(
                                                                      'Assign Duty'),
                                                                  content: Column(
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            TextFormField(
                                                                              controller: assigndutycontroller,
                                                                              inputFormatters: const [],
                                                                              decoration: const InputDecoration(
                                                                                labelText: "Duty",
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ]),
                                                                  actions: [
                                                                    MaterialButton(
                                                                      textColor:
                                                                          Colors
                                                                              .black,
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          assigndutycontroller
                                                                              .clear();
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'CANCEL',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                    MaterialButton(
                                                                        child: const Text(
                                                                            "SUBMIT",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                            )),
                                                                        onPressed:
                                                                            () async {
                                                                          await getupdateemployeedutyassigndata(
                                                                              assigndutycontroller.text.toString(),
                                                                              state.items6![index]['empid'].toString());
                                                                          assigndutycontroller.text.isEmpty
                                                                              ? Fluttertoast.showToast(
                                                                                  backgroundColor: Colors.white,
                                                                                  msg: "Please input a value",
                                                                                  textColor: Colors.black,
                                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                                  gravity: ToastGravity.CENTER,
                                                                                )
                                                                              : setState(() {
                                                                                  bottombar = true;
                                                                                  taskassigned[index].duty = assigndutycontroller.text.toString();

                                                                                  taskassigned[index].change = "true";

                                                                                  // taskassigned.add(TaskAssignedmodel(
                                                                                  //     duty: assigndutycontroller.text.toString(),
                                                                                  //     index: index.toString()));
                                                                                  // state.viewAllEmployeeModel.data![index].change = true;
                                                                                  // state.viewAllEmployeeModel.data![index].assigndutycontroller.text = assigndutycontroller.text.toString();
                                                                                  // state.viewAllEmployeeModel.data![index].taskAsseigned = assigndutycontroller.text.toString();

                                                                                  assigndutycontroller.clear();

                                                                                  bottombar = true;
                                                                                  Navigator.pop(context);
                                                                                });
                                                                        }),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }),
                                                )
                                              ]),
                                        ),
                                      ),
                                      onTap: () {
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
                }

                if (state is SearchSuccess) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.items06!.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return state.items06![index]['present'].toString() !=
                                "true"
                            ? SizedBox()
                            : SizedBox(
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Name : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      state.items06![index]
                                                              ['userName']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Assigned Place : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    // Text("Boat Number : "),
                                                    Text(
                                                      state.items06![index][
                                                                      'assignedTo']
                                                                  .toString() ==
                                                              ""
                                                          ? "-"
                                                          : state
                                                              .items06![index]
                                                                  ['assignedTo']
                                                              .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Phone Number : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      state.items06![index]
                                                              ['phonenumber']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Gender : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      state.items06![index]
                                                              ['gender']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                //     Padding(
                                                //       padding:
                                                //           const EdgeInsets.all(4.0),
                                                //       child: Text(
                                                //         "Dob : ",
                                                //         style: TextStyle(
                                                //             color: Colors.white),
                                                //       ),
                                                //     ),
                                                //     Text(
                                                //         d1.format(DateTime.parse(
                                                //             convert(state
                                                //                 .viewAllEmployeeModel
                                                //                 .data![index]
                                                //                 .dob
                                                //                 .toString()))),
                                                //         style: const TextStyle(
                                                //           color: Colors.white,
                                                //           fontSize: 14,
                                                //         )),
                                                //   ],
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Task assigned  : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),

                                                    taskassigned.length == 0
                                                        ? Text(
                                                            state
                                                                .items06![index]
                                                                    [
                                                                    'taskAsseigned']
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                            ))
                                                        : taskassigned[index]
                                                                    .duty ==
                                                                ""
                                                            ? Text(
                                                                state.items06![
                                                                        index][
                                                                        'taskAsseigned']
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                ))
                                                            : Text(
                                                                taskassigned[
                                                                        index]
                                                                    .duty
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                ))
                                                    // state.items6![index]
                                                    //                 ['taskAsseigned']
                                                    //             .toString() ==
                                                    //         ""
                                                    //     ? Text(
                                                    //         state.items6![index]
                                                    //                 ['taskAsseigned']
                                                    //             .toString(),
                                                    //         style: const TextStyle(
                                                    //           color: Colors.white,
                                                    //           fontSize: 14,
                                                    //         ))
                                                    //     : Text(
                                                    //         state.items6![index]
                                                    //                 ['taskAsseigned']
                                                    //             .toString(),
                                                    //         style: const TextStyle(
                                                    //           color: Colors.white,
                                                    //           fontSize: 14,
                                                    //         ))
                                                  ],
                                                ),
                                                Center(
                                                  child: MaterialButton(
                                                      child: Text(
                                                          "Assign Duty " +
                                                              " " +
                                                              "+"),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2)),
                                                      minWidth: 65,
                                                      height: 20,
                                                      color: Colors.green,
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return SingleChildScrollView(
                                                              child: SizedBox(
                                                                child:
                                                                    AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  title: Text(
                                                                      'Assign Duty'),
                                                                  content: Column(
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            TextFormField(
                                                                              controller: assigndutycontroller,
                                                                              inputFormatters: const [],
                                                                              decoration: const InputDecoration(
                                                                                labelText: "Duty",
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ]),
                                                                  actions: [
                                                                    MaterialButton(
                                                                      textColor:
                                                                          Colors
                                                                              .black,
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          assigndutycontroller
                                                                              .clear();
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'CANCEL',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                    MaterialButton(
                                                                        child: const Text(
                                                                            "SUBMIT",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                            )),
                                                                        onPressed:
                                                                            () async {
                                                                          await getupdateemployeedutyassigndata(
                                                                              assigndutycontroller.text.toString(),
                                                                              state.items06![index]['empid'].toString());
                                                                          assigndutycontroller.text.isEmpty
                                                                              ? Fluttertoast.showToast(
                                                                                  backgroundColor: Colors.white,
                                                                                  msg: "Please input a value",
                                                                                  textColor: Colors.black,
                                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                                  gravity: ToastGravity.CENTER,
                                                                                )
                                                                              : setState(() {
                                                                                  bottombar = true;
                                                                                  taskassigned[index].duty = assigndutycontroller.text.toString();

                                                                                  taskassigned[index].change = "true";

                                                                                  // taskassigned.add(TaskAssignedmodel(
                                                                                  //     duty: assigndutycontroller.text.toString(),
                                                                                  //     index: index.toString()));
                                                                                  // state.viewAllEmployeeModel.data![index].change = true;
                                                                                  // state.viewAllEmployeeModel.data![index].assigndutycontroller.text = assigndutycontroller.text.toString();
                                                                                  // state.viewAllEmployeeModel.data![index].taskAsseigned = assigndutycontroller.text.toString();

                                                                                  assigndutycontroller.clear();

                                                                                  bottombar = true;
                                                                                  Navigator.pop(context);
                                                                                });
                                                                        }),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }),
                                                )
                                              ]),
                                        ),
                                      ),
                                      onTap: () {
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
                  for (int i = 0; i < state.items6!.length; i++) {
                    taskassigned.add(TaskAssignedmodel(
                        duty: state.items6![i]['taskAsseigned'].toString(),
                        index: i.toString(),
                        empid: state.items6![i]['empid'].toString(),
                        change: "false"));
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

              //////////////////////////////end///////////////////////
              ///  for geting
            ],
          ),
        ),
      ),
      onRefresh: () async {
        fetcher();
      },
    );
  }

  void validateData() {
    if (assignemployeelislist.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "please assign task ",
          textColor: Colors.black);
    } else {
      BlocProvider.of<GetEmployeeAssignBloc>(context).add(GetEmployeeAssign(
        assignemployeelislist: assignemployeelislist,
      ));
//////////////////to assign duty
//       for (int k = 0;
//                               k < assignemployeelislist.length;
//                               k++) {
//                             final empId = assignemployeelislist[k].empId;
//                             final remark =
//                                 assignemployeelislist[k].remark;

//                             if (empId!.isEmpty) {
//                               return;
//                             } else {
//                               Map data = {
//                                 "empId": empId,
//                                 "remark": remark,
//                               };
//                               print(data);
//                               countcheck(data);
// ////////main
//                               setState(() {});
//                             }

//                             if (assetName!.isEmpty) {
//                               return;
//                             } else {
//                               Map data2 = {
//                                 "assetname": assetName,
//                                 "unitname": unitName,
//                                 "date": date,
//                                 "quantity": quantity,
//                               };
//                               print(data2);
//                               transferlog(data2);

//                               setState(() {});
//                             }
//                           }

//////////////////to assign duty

      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Duty Assigned ",
          textColor: Colors.black);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomerBottomNavigation()));
    }
  }

  String currentDate() {
    var now = new DateTime.now();

    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  String convert(String uTCTime) {
    var dateFormat =
        DateFormat("dd-MM-yyyy hh:mm"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(uTCTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    // String createdDate = dateFormat.format(DateTime.parse(localDate));
    return localDate;
  }
}

class TaskAssignedmodel {
  String? duty;
  String? change;
  String? index;
  String? empid;

  TaskAssignedmodel({this.duty, this.change, this.index, this.empid});
}

class AssignEmployeeModel {
  String? empId;
  String? remark;

  AssignEmployeeModel({
    this.empId,
    this.remark,
  });
}
