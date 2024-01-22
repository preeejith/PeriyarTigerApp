// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:intl/intl.dart';

// import 'package:parambikulam/bloc/assets/localbloc/ibreservationdetailsbloc.dart';

// import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservationfulldetailed.dart';

// class ReservationOnlineDetails extends StatefulWidget {
//   const ReservationOnlineDetails({Key? key}) : super(key: key);
// //
//   @override
//   State<ReservationOnlineDetails> createState() =>
//       _ReservationOnlineDetailsState();
// }

// class _ReservationOnlineDetailsState extends State<ReservationOnlineDetails> {
//   final TextEditingController datecontroller = TextEditingController();
//   final TextEditingController date2controller = TextEditingController();
//   final TextEditingController datecheckcontroller = TextEditingController();
//   final TextEditingController daycontroller = TextEditingController();
//   final TextEditingController monthcontroller = TextEditingController();
//   final TextEditingController yearcontroller = TextEditingController();
//   DateTime now = new DateTime.now();
//   var d1 = new DateFormat('dd-MM-yyyy');
//   var d3 = new DateFormat('yyyy');
//   var d4 = new DateFormat('MM');
//   var d5 = new DateFormat('dd');
//   var d2 = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.sss'Z'");

//   List<ReservationListModel> reservationlist = [];
//   DateTime selectedDate = DateTime.now();
//   DateTime? selected;

//   @override
//   void initState() {
//     fetcher();

//     fetcher2();
//     super.initState();
//   }

//   String? ibprogramname;
//   String? starttime;
//   String? endtime;
//   List<String> ibprogramlist = [];
//   void fetcher() {
//     BlocProvider.of<Ibreservation2datauploadBloc>(context)
//         .add(GetIbreservation2datauploadData());

//     setState(() {});
//   }

//   void fetcher2() {
//     datecontroller.text =
//         "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
//     daycontroller.text = "${selectedDate.day}";
//     monthcontroller.text = "${selectedDate.month}";
//     yearcontroller.text = "${selectedDate.year}";
//   }

//   // void fetcher2() async {
//   //   BlocProvider.of<IBReservationdatauploadBloc>(context)
//   //       .add(GetIbreservationdatauploadData());
//   // }

//   var newdate;
//   bool? checkok;

//   int? roomcount;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(title: Text("RESERVATION LIST"), actions: []),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: TextFormField(
//                   controller: date2controller,
//                   inputFormatters: const [],
//                   decoration: InputDecoration(
//                     suffixIcon: InkWell(
//                       child: Icon(Icons.calendar_month),
//                       onTap: () {
//                         _selectDate(context);
//                       },
//                     ),
//                     labelText: "Select Date",
//                   ),
//                 ),
//               ),
//               BlocConsumer<Ibreservation2datauploadBloc,
//                   StateIbreservation2dataupload>(builder: (context, state) {
//                 if (state is ReservationdataRecived) {
//                   return state.items7!.length == 0
//                       ? Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Center(child: Text("No Result Found")),
//                         )
//                       : Column(
//                           children: [
//                             ListView.builder(
//                                 scrollDirection: Axis.vertical,
//                                 shrinkWrap: true,
//                                 itemCount: state.items7!.length,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return

//                                       // (int.parse(d3.format(DateTime.parse(
//                                       //             state.items7![index]
//                                       //                 ['bookingdate']))) <
//                                       //         (int.parse(
//                                       //             yearcontroller.text.toString()))
//                                       //     ? Container()
//                                       //     :
//                                       date2controller.text.toString() != "" &&
//                                               d1.format(selectedDate) !=
//                                                   d1.format(DateTime.parse(
//                                                       state.items7![index]
//                                                           ['bookingdate']))
//                                           ? Container()
//                                           : Padding(
//                                               padding: EdgeInsets.all(2.0),
//                                               child: ListTile(
//                                                   title: InkWell(
//                                                 child: Container(
//                                                   width: MediaQuery.of(context)
//                                                       .size
//                                                       .width,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.white10,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             2),
//                                                     boxShadow: [
//                                                       BoxShadow(
//                                                         color: Colors.grey
//                                                             .withOpacity(0.1),
//                                                         spreadRadius: 4,
//                                                         blurRadius: 4,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             8.0),
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Container(
//                                                           child: Column(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .start,
//                                                               children: [
//                                                                 Row(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .spaceBetween,
//                                                                   children: [
//                                                                     // Text(
//                                                                     //   "IB  :  ",
//                                                                     //   style: TextStyle(
//                                                                     //       color: Colors
//                                                                     //           .white,
//                                                                     //       fontSize: 14),
//                                                                     // ),
//                                                                     Text(
//                                                                       ibprogramlist.length ==
//                                                                               0
//                                                                           ? ""
//                                                                           : ibprogramlist[
//                                                                               index],
//                                                                       style: TextStyle(
//                                                                           color: Colors
//                                                                               .green,
//                                                                           fontSize:
//                                                                               14,
//                                                                           fontWeight:
//                                                                               FontWeight.w800),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                                 SizedBox(
//                                                                   height: 2,
//                                                                 ),
//                                                                 Row(
//                                                                     mainAxisAlignment:
//                                                                         MainAxisAlignment
//                                                                             .spaceBetween,
//                                                                     children: [
//                                                                       Text(
//                                                                         'Reserved for: ',
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 14),
//                                                                       ),
//                                                                       Text(
//                                                                         state.items7![index]
//                                                                             [
//                                                                             'guestName'],
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 14),
//                                                                       )
//                                                                     ]),
//                                                                 SizedBox(
//                                                                   height: 2,
//                                                                 ),
//                                                                 Row(children: [
//                                                                   Text(
//                                                                     "Selected Date : ",
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             14),
//                                                                   ),
//                                                                   Text(
//                                                                     d1.format(DateTime.parse(
//                                                                         state.items7![index]
//                                                                             [
//                                                                             'bookingdate'])),
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             14),
//                                                                   ),
//                                                                 ]),
//                                                                 SizedBox(
//                                                                   height: 2,
//                                                                 ),
//                                                                 Row(children: [
//                                                                   Text(
//                                                                     "Referred Person: ",
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             14),
//                                                                   ),
//                                                                   Text(
//                                                                     state.items7![
//                                                                             index]
//                                                                         [
//                                                                         'refered'],
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             14),
//                                                                   )
//                                                                 ]),
//                                                               ]),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 onTap: () {
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             ReservationFullDetailed(
//                                                               state: state,
//                                                               index: index,
//                                                             )),
//                                                   );
//                                                 },
//                                               )),
//                                             );
//                                 }),
//                           ],
//                         );
//                 } else {
//                   return Center();
//                 }
//               }, listener: (context, state) {
//                 if (state is ReservationdataRecived) {
//                   ibprogramlist.clear();
//                   for (int j = 0; j < state.items7!.length; j++) {
//                     for (int i = 0; i < state.items!.length; i++) {
//                       if (state.items![i]['_id'] ==
//                           state.items7![j]['programid']) {
//                         print('testok');
//                         ibprogramlist
//                             .add(state.items![i]['progName'].toString());
//                       }
//                     }
//                   }

//                   for (int i = 0; i < state.items7!.length; i++) {}

//                   // for (int i = 0; i < state.items2!.length; i++) {
//                   //   if (state.items2![i]['_id'] ==
//                   //       state.items7![widget.index]['slotid']) {
//                   //     print('test2ok');
//                   //     starttime = state.items2![i]['startTime'];
//                   //     endtime = state.items2![i]['endTime'];
//                   //     // ibprogramname = widget.state.items![i]['slotid'];
//                   //   }
//                   // }

//                 }
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _selectDate(BuildContext context) async {
//     final DateTime? selected = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2022),
//       lastDate: DateTime(2028),
//     );
//     if (selected != null && selected != selectedDate)
//       setState(() {
//         selectedDate = selected;
//         datecheckcontroller.text =
//             "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}/${selectedDate.hour}/${selectedDate.minute}/${selectedDate.second}";

//         date2controller.text =
//             "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

//         //  DateTime dt1 =  DateTime.parse(datecheckyearcontroller.text.toString());

//         setState(() {});
//       });
//   }
// }

// class ReservationListModel {
//   String? reservedcount,
//       status,
//       foodprefered,
//       vehicleno,
//       bookingid,
//       bookingdate,
//       slotid,
//       slotprogramid,
//       programName,
//       programid,
//       guestName,
//       noofCompaningPerson,
//       guestPhone,
//       refered,
//       referedPhone,
//       email,
//       noofVehicles,
//       details;
//   ReservationListModel({
//     this.reservedcount,
//     this.status,
//     this.foodprefered,
//     this.vehicleno,
//     this.bookingid,
//     this.bookingdate,
//     this.slotid,
//     this.slotprogramid,
//     this.programName,
//     this.programid,
//     this.guestName,
//     this.noofCompaningPerson,
//     this.guestPhone,
//     this.refered,
//     this.referedPhone,
//     this.email,
//     this.noofVehicles,
//     this.details,
//   });
// }
