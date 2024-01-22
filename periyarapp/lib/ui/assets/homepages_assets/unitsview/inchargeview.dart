//////delete pending
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/data/models/assetsmodel/ic_viewunnitsmodel.dart';


import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

import '../../../../bloc/assets/localbloc/attentance/employeelistofflinebloc.dart';

/////view///////
class UnitInCharge extends StatefulWidget {
  final String unitId;
  final int index;
  final IcViewUnitsModel icViewUnitsModel;
  const UnitInCharge(
      {Key? key,
      required this.unitId,
      required this.icViewUnitsModel,
      required this.index})
      : super(key: key);
////////
  @override
  _UnitInCharge createState() => _UnitInCharge();
}

class _UnitInCharge extends State<UnitInCharge> {
  String? token;
  @override
  void initState() {
    fetcher();

    super.initState();
  }

//////////////
  void fetcher() async {
    BlocProvider.of<EmployeelistOfflineBloc>(context)
        .add(GetEmployeeListData());


    List items39 = await getAllremoveassignedemployeedata();

    // print(items33);
    if (items39.isNotEmpty) {
      for (int k = 0; k < items39.length; k++) {
        for (int j = 0;
            j <
                widget
                    .icViewUnitsModel.user![widget.index].unitincharge!.length;
            j++) {
          if (items39[k]['empId'].toString() ==
              widget.icViewUnitsModel.user![widget.index].unitincharge![j].id) {
            setState(() {
              widget.icViewUnitsModel.user![widget.index].unitincharge![j]
                  .removeincharge = true;
            });
//////////////
            // print(quantitycount);
          } else {
            setState(() {
              widget.icViewUnitsModel.user![widget.index].unitincharge![j]
                  .removeincharge = false;
            });
          }
        }
      }
    }
    ///////////////////
///////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: AppBar(
        title: const Text("In Charge"),
      ),
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
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.items6!.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return state.items6!.length == 0
                              ? Center(
                                  child: Text(
                                  "Not assigned anybody yet",
                                  style: TextStyle(color: Colors.red),
                                ))
                              : state.items6![index]['assignedUnitId']
                                          .toString() !=
                                      widget.unitId.toString()
                                  ? SizedBox()
                                  :

                                  // widget
                                  //             .icViewUnitsModel
                                  //             .user![widget.index]
                                  //             .unitincharge![index]
                                  //             .removeincharge ==
                                  //         true
                                  //     ? SizedBox()

                                  Column(
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
                                                            ////
                                                            Text(
                                                              state.items6![
                                                                      index][
                                                                      'userName']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                                              state.items6![
                                                                      index][
                                                                      'phonenumber']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                                            // Text("Length : "),
                                                            Text(
                                                              state.items6![
                                                                      index]
                                                                      ['gender']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ]),
                                                  MaterialButton(
                                                    color: Colors.green,
                                                    child: Text(
                                                      "Remove",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12),
                                                    ),
                                                    onPressed: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                'Are your sure you want to remove the employee from this unit'),
                                                            actions: [
                                                              MaterialButton(
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  'NO',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              MaterialButton(
                                                                textColor:
                                                                    Colors
                                                                        .black,
                                                                onPressed:
                                                                    () async {
                                                              
                                                                  await getupdateemployeelistdata(
                                                                      "",
                                                                      "",
                                                                      state.items6![
                                                                              index]
                                                                          [
                                                                          'empid']);
                                                                  fetcher();

                                                                  Fluttertoast.showToast(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      msg:
                                                                          "Employee Removed",
                                                                      textColor:
                                                                          Colors
                                                                              .black);

                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  'YES',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );

                                                      // final untiId =
                                                      //     widget.unitId;
                                                      // final empId = widget
                                                      //     .icViewUnitsModel
                                                      //     .user![widget.index]
                                                      //     .unitincharge![index]
                                                      //     .id;
                                                      // final phoneNumber = widget
                                                      //     .icViewUnitsModel
                                                      //     .user![widget.index]
                                                      //     .unitincharge![index]
                                                      //     .phoneNumber;

                                                      // if (empId!.isEmpty) {
                                                      //   return;
                                                      // } else {
                                                      //   Map data = {
                                                      //     "untiId": untiId,
                                                      //     "empId": empId,
                                                      //     "phoneNumber":
                                                      //         phoneNumber,
                                                      //   };
                                                      //   print(data);

                                                      //   removeassignedemployee(
                                                      //       data);

                                                      //   setState(() {});

                                                      //   fetcher();
                                                      // }

                                                      ///to activate after the check list
                                                      // BlocProvider.of<
                                                      //             GetRemoveEmployeeBloc>(
                                                      //         context)
                                                      //     .add(GetRemoveEmployee(
                                                      //   unitId: widget.unitId,
                                                      //   empId: widget
                                                      //       .icViewUnitsModel
                                                      //       .user![widget.index]
                                                      //       .unitincharge![index]
                                                      //       .id,
                                                      // ));

                                                      // Navigator.pushReplacement(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             CustomerBottomNavigation()));
                                                    },
                                                  )
                                                ],
                                              ),
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
                                    );
                        });
                  } else {
                    return Container();
                  }
                },
                listener: (context, state) {}),
            // BlocConsumer<GetUnitsDetailedViewBloc, UnitsDetailedViewState>(
            //     builder: (context, state) {
            //       if (state is UnitsDetailedViewsuccess) {
            //         return ListView.builder(
            //             scrollDirection: Axis.vertical,
            //             shrinkWrap: true,
            //             itemCount: widget.icViewUnitsModel.user![widget.index]
            //                 .unitincharge!.length,
            //             physics: NeverScrollableScrollPhysics(),
            //             itemBuilder: (context, index) {
            //               return state.unitsDetailedViewModel.user!
            //                           .unitincharge!.length <
            //                       1
            //                   ? Center(
            //                       child: Text(
            //                       "Not assigned anybody yet",
            //                       style: TextStyle(color: Colors.red),
            //                     ))
            //                   : Column(
            //                       children: [
            //                         SizedBox(
            //                           height: 6,
            //                         ),
            //                         InkWell(
            //                           child: Container(
            //                             decoration: BoxDecoration(
            //                               color: Color(0xfff292929),
            //                               borderRadius:
            //                                   BorderRadius.circular(2),
            //                               boxShadow: [
            //                                 BoxShadow(
            //                                   color:
            //                                       Colors.grey.withOpacity(0.3),
            //                                   spreadRadius: 4,
            //                                   blurRadius: 4,
            //                                 ),
            //                               ],
            //                             ),
            //                             child: Padding(
            //                               padding: const EdgeInsets.all(8.0),
            //                               child: Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Column(
            //                                       crossAxisAlignment:
            //                                           CrossAxisAlignment.start,
            //                                       children: [
            //                                         Row(
            //                                           children: [
            //                                             Padding(
            //                                               padding:
            //                                                   const EdgeInsets
            //                                                       .all(4.0),
            //                                               child: Text(
            //                                                 "Name : ",
            //                                                 style: TextStyle(
            //                                                     color: Colors
            //                                                         .white),
            //                                               ),
            //                                             ),
            //                                             Text(
            //                                               widget
            //                                                   .icViewUnitsModel
            //                                                   .user![
            //                                                       widget.index]
            //                                                   .unitincharge![
            //                                                       index]
            //                                                   .userName
            //                                                   .toString(),
            //                                               style: TextStyle(
            //                                                 color: Colors.white,
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                         Row(
            //                                           children: [
            //                                             Padding(
            //                                               padding:
            //                                                   const EdgeInsets
            //                                                       .all(4.0),
            //                                               child: Text(
            //                                                 "Phone Number : ",
            //                                                 style: TextStyle(
            //                                                     color: Colors
            //                                                         .white),
            //                                               ),
            //                                             ),
            //                                             // Text("Boat Number : "),
            //                                             Text(
            //                                               widget
            //                                                   .icViewUnitsModel
            //                                                   .user![
            //                                                       widget.index]
            //                                                   .unitincharge![
            //                                                       index]
            //                                                   .phoneNumber
            //                                                   .toString(),
            //                                               style: TextStyle(
            //                                                 color: Colors.white,
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                         Row(
            //                                           children: [
            //                                             Padding(
            //                                               padding:
            //                                                   const EdgeInsets
            //                                                       .all(4.0),
            //                                               child: Text(
            //                                                 "Gender : ",
            //                                                 style: TextStyle(
            //                                                     color: Colors
            //                                                         .white),
            //                                               ),
            //                                             ),
            //                                             // Text("Length : "),
            //                                             Text(
            //                                               widget
            //                                                   .icViewUnitsModel
            //                                                   .user![
            //                                                       widget.index]
            //                                                   .unitincharge![
            //                                                       index]
            //                                                   .gender
            //                                                   .toString(),
            //                                               style: TextStyle(
            //                                                 color: Colors.white,
            //                                               ),
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ]),
            //                                   MaterialButton(
            //                                     color: Colors.green,
            //                                     // child: Text("Remove"),
            //                                     onPressed: () {
            //                                       BlocProvider.of<
            //                                                   GetRemoveEmployeeBloc>(
            //                                               context)
            //                                           .add(GetRemoveEmployee(
            //                                         unitId: widget.unitId,
            //                                         empId: widget
            //                                             .icViewUnitsModel
            //                                             .user![widget.index]
            //                                             .unitincharge![index]
            //                                             .id,
            //                                       ));
            //                                     },

            //                                     child: BlocConsumer<
            //                                             GetRemoveEmployeeBloc,
            //                                             RemoveEmployeeState>(
            //                                         builder: (context, state) {
            //                                       if (state
            //                                           is RemoveEmployeeing) {
            //                                         return const SizedBox(
            //                                           height: 18.0,
            //                                           width: 18.0,
            //                                           child:
            //                                               CircularProgressIndicator(
            //                                             valueColor:
            //                                                 AlwaysStoppedAnimation<
            //                                                         Color>(
            //                                                     Colors.black),
            //                                             strokeWidth: 2,
            //                                           ),
            //                                         );
            //                                       } else {
            //                                         return const Text(
            //                                           "Remove",
            //                                           style: TextStyle(
            //                                               color: Colors.white,
            //                                               fontWeight:
            //                                                   FontWeight.w600,
            //                                               fontSize: 12),
            //                                         );
            //                                       }
            //                                     }, listener: (context, state) {
            //                                       if (state
            //                                           is RemoveEmployeesuccess) {
            //                                         Fluttertoast.showToast(
            //                                             backgroundColor:
            //                                                 Colors.white,
            //                                             msg: "Employee Removed",
            //                                             textColor:
            //                                                 Colors.black);

            //                                         fetcher();
            //                                       }

            //                                       if (state
            //                                           is RemoveEmployeeError) {
            //                                         Fluttertoast.showToast(
            //                                             backgroundColor:
            //                                                 Colors.white,
            //                                             msg: state.error,
            //                                             textColor:
            //                                                 Colors.black);
            //                                       }
            //                                     }),
            //                                   )
            //                                 ],
            //                               ),
            //                             ),
            //                           ),
            //                           onTap: () {
            //                             //

            //                             setState(() {});
            //                           },
            //                         ),
            //                         SizedBox(
            //                           height: 10,
            //                         ),
            //                       ],
            //                     );
            //             });
            //       } else {
            //         return Center(
            //           child: SizedBox(
            //             height: 28.0,
            //             width: 28.0,
            //             child: CircularProgressIndicator(
            //               valueColor:
            //                   AlwaysStoppedAnimation<Color>(Colors.white),
            //               strokeWidth: 2,
            //             ),
            //           ),
            //         );
            //       }
            //     },
            //     listener: (context, state) {}),
          ],
        ),
      ),
    );
  }
}
