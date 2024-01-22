import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequestbloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequestevent.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequeststate.dart';
import 'package:parambikulam/ui/assets/echoshoppages/new/detailedrequestview2.dart';

import 'package:parambikulam/ui/assets/echoshoppages/new/myrequestviewdetailed.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

/////view///////////new//
class MyRequestView extends StatefulWidget {
  const MyRequestView({Key? key}) : super(key: key);

  @override
  _MyRequestView createState() => _MyRequestView();
}

class _MyRequestView extends State<MyRequestView> {
  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  List items60 = [];
  List items61 = [];
  String? token;
  @override
  void initState() {
    BlocProvider.of<GetViewMyRequestBloc>(context)
        .add(RefreshViewMyRequestEvent());
    fetcher();

    super.initState();
  }

//////
  void fetcher() async {
    BlocProvider.of<GetViewMyRequestBloc>(context)
        .add(FetchViewMyRequestEvent());

    items60 = await getproductionunitrequestmaindata();
    print(items60);
    items61 = await getproductionunitrequestsubdata();
    print(items61);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: AppBar(
        title: const Text("Request View"),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocConsumer<GetViewMyRequestBloc, ViewMyRequestState>(
                    builder: (context, state) {
                      if (state is ViewMyRequestSuccess) {
                        return state.myRequestViewModel.data!.length == 0
                            ? Center(child: Text("No Results Found"))
                            : Column(
                                ////for the new purchase
                                children: [
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      reverse: true,
                                      itemCount: items60.length,
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
                                                        BorderRadius.circular(
                                                            2),
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "Request Type : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              Text(
                                                                (items60[index]['requesttype'].toString() ==
                                                                            "stock Updation"
                                                                        ? "Stock Updation"
                                                                        : items60[index]['requesttype'].toString() ==
                                                                                "transfer"
                                                                            ? "Transfer"
                                                                            : items60[index]['requesttype'].toString() == 'repair'
                                                                                ? 'Repair'
                                                                                : items60[index]['requesttype'].toString() == 'damage'
                                                                                    ? 'Damage'
                                                                                    : items60[index]['requesttype'].toString() == 'replace'
                                                                                        ? 'Replace'
                                                                                        : items60[index]['requesttype'].toString()) +
                                                                    " " +
                                                                    "(" +
                                                                    items60[index]['count'].toString()
                                                                    // state
                                                                    //     .myRequestViewModel
                                                                    //     .data![index]
                                                                    //     .count
                                                                    //     .toString()
                                                                    +
                                                                    ")",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
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
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "Status : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              // Text("Boat Number : "),
                                                              Text(
                                                                (items60[index]['status']
                                                                            .toString() ==
                                                                        "transfered"
                                                                    ? "Transfered"
                                                                    : items60[index]['status'].toString() ==
                                                                            "pending"
                                                                        ? "Pending"
                                                                        : items60[index]['status']
                                                                            .toString()),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
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
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "Date",
                                                                  style:
                                                                      TextStyle(),
                                                                ),
                                                              ),
                                                              Text(
                                                                d1.format(DateTime.parse(convert(
                                                                    items60[index]
                                                                            [
                                                                            'date']
                                                                        .toString()))),
                                                                //     " | " +
                                                                //     d2.format(DateTime.parse(convert(items60[index]
                                                                //             [
                                                                //             'date']
                                                                //         .toString())

                                                                //         )),
                                                                style:
                                                                    TextStyle(),
                                                              ),
                                                            ],
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailedRequestView(
                                                              items60: items60,
                                                              items61: items61,
                                                              // offlineRequestlist:
                                                              //     state
                                                              //         .offlineRequestlist,

                                                              // myRequestViewModel:
                                                              //     state
                                                              //         .myRequestViewModel,
                                                              index: index,
                                                            )),
                                                  );

                                                  setState(() {});
                                                },
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              // Divider(
                                              //   color: AppStyles.dividerColor,
                                              //   thickness: 1,
                                              //   height: 14,
                                              // )
                                            ],
                                          ),
                                        );
                                      }),
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:
                                          state.myRequestViewModel.data!.length,
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
                                                        BorderRadius.circular(
                                                            2),
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "Request Type : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              Text(
                                                                (state.myRequestViewModel.data![index].requesttype.toString() ==
                                                                            "stock Updation"
                                                                        ? "Stock Updation"
                                                                        : state.myRequestViewModel.data![index].requesttype.toString() ==
                                                                                "transfer"
                                                                            ? "Transfer"
                                                                            : state.myRequestViewModel.data![index].requesttype.toString() == 'repair'
                                                                                ? 'Repair'
                                                                                : state.myRequestViewModel.data![index].requesttype.toString() == 'damage'
                                                                                    ? 'Damage'
                                                                                    : state.myRequestViewModel.data![index].requesttype.toString() == 'replace'
                                                                                        ? 'Replace'
                                                                                        : state.myRequestViewModel.data![index].requesttype.toString()) +
                                                                    " " +
                                                                    "(" +
                                                                    state.myRequestViewModel.data![index].count.toString() +
                                                                    ")",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
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
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "Status : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              // Text("Boat Number : "),
                                                              Text(
                                                                (state
                                                                            .myRequestViewModel
                                                                            .data![
                                                                                index]
                                                                            .requeststatus
                                                                            .toString() ==
                                                                        "transfered"
                                                                    ? "Transfered"
                                                                    : state.myRequestViewModel.data![index].requeststatus.toString() ==
                                                                            "pending"
                                                                        ? "Pending"
                                                                        : state
                                                                            .myRequestViewModel
                                                                            .data![index]
                                                                            .requeststatus
                                                                            .toString()),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
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
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child: Text(
                                                                  "Date",
                                                                  style:
                                                                      TextStyle(),
                                                                ),
                                                              ),
                                                              Text(
                                                                d1.format(DateTime.parse(convert(state
                                                                        .myRequestViewModel
                                                                        .data![
                                                                            index]
                                                                        .createDate!))) +
                                                                    " | " +
                                                                    d2.format(DateTime.parse(convert(state
                                                                        .myRequestViewModel
                                                                        .data![
                                                                            index]
                                                                        .createDate!))),
                                                                style:
                                                                    TextStyle(),
                                                              ),
                                                            ],
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyRequestDetailed(
                                                              requestId: state
                                                                  .myRequestViewModel
                                                                  .data![index]
                                                                  .id
                                                                  .toString(),
                                                              myRequestViewModel:
                                                                  state
                                                                      .myRequestViewModel,
                                                              index: index,
                                                            )),
                                                  );

                                                  setState(() {});
                                                },
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              // Divider(
                                              //   color: AppStyles.dividerColor,
                                              //   thickness: 1,
                                              //   height: 14,
                                              // )
                                            ],
                                          ),
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
            const SizedBox(
              height: 10.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
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
