import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendancedatafetchingbloc.dart';

class HaltReportPage extends StatefulWidget {
  final String dateref;
  const HaltReportPage({Key? key, required this.dateref}) : super(key: key);

  @override
  State<HaltReportPage> createState() => _HaltReportPageState();
}

class _HaltReportPageState extends State<HaltReportPage> {
  late String _currentDate;
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

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HALT DETAILS'), actions: []),
      body: Column(
        children: [
          BlocConsumer<MarkAttendanceOfflineBloc, StateMarkAttendance>(
              builder: (context, state) {
            if (state is MarkingAttendance) {
              return state.items16!.length == 0
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "Please Submit halt to View Details",
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      )),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: state.items16!.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return d1.format(DateTime.parse(
                                    state.items16![index]['dateid'])) !=
                                d1.format(
                                    DateTime.parse(widget.dateref.toString()))
                            ? Container()
                            : Padding(
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

                                                        Text(state
                                                                .items16![index]
                                                            ['userName']),

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
                                                    Text(state.items16![index]
                                                        ['phoneNumber'])
                                                  ]),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                )),
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
              ;
            }
          }, listener: (context, state) {
            if (state is MarkingAttendance) {}
          }),
        ],
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
