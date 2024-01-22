import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/employeelistofflinebloc.dart';

import 'package:parambikulam/ui/assets/ic_main/halt/haltreportmain.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class MarkHaltPage extends StatefulWidget {
  const MarkHaltPage({Key? key}) : super(key: key);

  @override
  State<MarkHaltPage> createState() => _MarkHaltPageState();
}

class _MarkHaltPageState extends State<MarkHaltPage> {
  late String _currentDate;
  bool? datealready = false;
  bool? availabilitycheck = true;
  bool? uploadproceed = true;
  List<MarkhaltModel> markhaltlist = [];

  @override
  void initState() {
    super.initState();
    fetcher();
  }

  String currentDate() {
    var now = new DateTime.now().subtract(Duration(days: 1));
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  void fetcher() async {
    ///offline employee list
    BlocProvider.of<EmployeelistOfflineBloc>(context)
        .add(GetEmployeeListData());
    // _currentDate = "2022-04-21";

    _currentDate = currentDate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MARK HALT'), actions: []),
      bottomNavigationBar: availabilitycheck != true
          ? SizedBox()
          : datealready == true
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: MaterialButton(
                      color: Colors.green,
                      child: Text("CONFIRM"),
                      onPressed: () {
                        uploadproceed == false
                            ? Fluttertoast.showToast(
                                msg:
                                    "Please upload the previous halt & download to continue")
                            : validate();
                      }),
                ),
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
            BlocConsumer<EmployeelistOfflineBloc, StateEmployeeList>(
                builder: (context, state) {
              if (state is EmployeeListing) {
                return datealready != true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.items6!.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return state.items6!.length == 0
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Center(child: Text('No data found')),
                                    )
                                  : Column(
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
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              state.items6![
                                                                      index][
                                                                      'userName']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              state.items6![
                                                                      index][
                                                                      'phonenumber']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                            Text("")
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    activeColor: Colors.green,
                                                    value: markhaltlist
                                                                .length !=
                                                            0
                                                        ? markhaltlist[index]
                                                            .markcheck
                                                        : false,
                                                    onChanged: (bool? value) {
                                                      datealready == true
                                                          ? Fluttertoast.showToast(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              msg:
                                                                  "Already Marked",
                                                              textColor:
                                                                  Colors.black)
                                                          : setState(() {
                                                              markhaltlist[
                                                                          index]
                                                                      .markcheck =
                                                                  value!;
                                                            });
                                                    },
                                                  ),
                                                ],
                                              ),
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
                                    );
                            }),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.items6!.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return state.items6!.length == 0
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Center(child: Text('No data found')),
                                    )
                                  : Column(
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
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              state.items6![
                                                                      index][
                                                                      'userName']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              state.items6![
                                                                      index][
                                                                      'phonenumber']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15),
                                                            ),
                                                            Text("")
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Checkbox(
                                                    activeColor: Colors.green,
                                                    value: markhaltlist
                                                                .length !=
                                                            0
                                                        ? markhaltlist[index]
                                                            .markcheck
                                                        : false,
                                                    onChanged: (bool? value) {
                                                      datealready == true
                                                          ? Fluttertoast.showToast(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              msg:
                                                                  "Already Marked",
                                                              textColor:
                                                                  Colors.black)
                                                          : setState(() {
                                                              markhaltlist[
                                                                          index]
                                                                      .markcheck =
                                                                  value!;
                                                            });
                                                    },
                                                  ),
                                                ],
                                              ),
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
                                    );
                            }),
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
              if (state is EmployeeListing) {
                if (state.items13!.isNotEmpty) {
                  setState(() {
                    uploadproceed = false;
                  });
                }
                for (int i = 0; i < state.items6!.length; i++) {
                  markhaltlist.add(MarkhaltModel(
                      markcheck: false,
                      empId: state.items6![i]['empid'].toString(),
                      empName: state.items6![i]['userName'].toString(),
                      empPhone: state.items6![i]['phonenumber'].toString(),
                      assignedid: state.items6![i]['assignedTo'].toString()));
                }

                for (int k = 0; k < state.items14!.length; k++) {
                  if (state.items14![k]['date'] == _currentDate) {
                    datealready = true;
                  }
                }
/////////
                ///
                ///
                if (datealready == true) {
                  for (int i = 0; i < markhaltlist.length; i++) {
                    for (int j = 0; j < state.items13!.length; j++) {
                      if (markhaltlist[i].empId.toString() ==
                          state.items13![j]['empid']) {
                        setState(() {
                          markhaltlist[i].markcheck = true;
                        });
                      }
                    }
                  }
                  setState(() {});
                }

                setState(() {
                  state.items6!.length == 0
                      ? availabilitycheck = false
                      : availabilitycheck = true;
                });
              }
            }),
          ],
        ),
      ),
    );
  }

  void validate() {
    for (int i = 0; i < markhaltlist.length; i++) {
      if (markhaltlist[i].markcheck == true) {
        final date = _currentDate.toString();
        final empid = markhaltlist[i].empId;
        final empname = markhaltlist[i].empName;
        final empphone = markhaltlist[i].empPhone;
        final assignedid = markhaltlist[i].assignedid;

        if (empid!.isEmpty) {
          return;
        } else {
          Map data = {
            "date": date,
            "empid": empid,
            "empname": empname,
            "empphone": empphone,
            "assignedid": assignedid
          };

          print(data);

          markhalt(data);

/////////to make it offline ////////
          Map data2 = {
            'dateid': date,
            'haltid': "",
            'empid': empid,
            'phoneNumber': empphone,
            'role': "",
            'userName': empname,
            'dob': "",
            'gender': "",
            'assignedUnitId': "",
            'assingedTo': assignedid,
            'haltDate': date,
            'count': "1",
          };
          print(data);
          haltreport(data2);

          /////////to make it offline ////
        }
      } else {}

      if (i == markhaltlist.length - 1) {
        Fluttertoast.showToast(
            backgroundColor: Colors.white,
            msg: "Halt Marked",
            textColor: Colors.black);

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

          datecheck3(data);

          Map data2 = {"data": "not uploaded"};
          uploadhaltcheck(data2);
          setState(() {});
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HaltMainReport()));
      }
    }
  }
}

////
class MarkhaltModel {
  bool? markcheck = false;
  String? empId;
  String? empPhone;
  String? empName;
  String? assignedid;

  MarkhaltModel(
      {this.markcheck,
      this.empId,
      this.empName,
      this.assignedid,
      this.empPhone});
}
