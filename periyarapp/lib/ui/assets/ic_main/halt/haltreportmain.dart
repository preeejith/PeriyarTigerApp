import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendancedatafetchingbloc.dart';
import 'package:parambikulam/ui/assets/ic_main/halt/haltreport.dart';

class HaltMainReport extends StatefulWidget {
  const HaltMainReport({Key? key}) : super(key: key);

  @override
  State<HaltMainReport> createState() => _HaltMainReportState();
}

class _HaltMainReportState extends State<HaltMainReport> {
  late String _currentDate;
  List<HaltDetailsMainModel> haltreportdetailsmainlist = [];
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
      appBar: AppBar(title: Text('HALT REPORT'), actions: []),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<MarkAttendanceOfflineBloc, StateMarkAttendance>(
                builder: (context, state) {
              if (state is MarkingAttendance) {
                return state.items16!.length == 0
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
                        itemCount: haltreportdetailsmainlist.length,
                        physics: NeverScrollableScrollPhysics(),
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
                                        // Padding(
                                        //   padding: const EdgeInsets.all(12.0),
                                        //   child: Text(
                                        //     "Date ",
                                        //     style: TextStyle(fontSize: 14),
                                        //   ),
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(d1.format(DateTime.parse(
                                              haltreportdetailsmainlist[index]
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
                                    builder: (context) => HaltReportPage(
                                        dateref:
                                            haltreportdetailsmainlist[index]
                                                .dateid
                                                .toString())),
                              );
                            },
                          ));
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
            }, listener: (context, state) {
              if (state is MarkingAttendance) {
                haltreportdetailsmainlist.clear();
                ////////////
                for (int i = 0; i < state.items16!.length; i++) {
                  if (haltreportdetailsmainlist.any((element) =>
                      element.dateid == state.items16![i]['dateid'])) {
                  } else {
                    haltreportdetailsmainlist.add(HaltDetailsMainModel(
                      dateid: state.items16![i]['dateid'],
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

  String currentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}

//     haltreportdetailsmainlist.add(HaltDetailsMainModel(
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

class HaltDetailsMainModel {
  String? dateid;

  HaltDetailsMainModel({
    this.dateid,
  });
}
