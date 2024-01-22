// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:parambikulam/bloc/bookingslot/bookingevent.dart';
// import 'package:parambikulam/bloc/bookingslot/bookingslotbloc.dart';
// import 'package:parambikulam/bloc/bookingslot/bookingstate.dart';
// import 'package:parambikulam/utils/pref_manager.dart';

// // ignore: must_be_immutable
// class AddAndRemoveButton extends StatefulWidget {
//   int add, remove, displaynumber, seatCount;
//   NumberTillNow state;

//   // BookingSlotBlocStarted state;

//   final String selectId;
//   // final Widget child;
//   AddAndRemoveButton({
//     required this.add,
//     required this.remove,
//     required this.displaynumber,
//     required this.seatCount,
//     required this.state,
//     required this.selectId,
//   });

//   get displayNumber => null;
//   _AddAndRemoveButton createState() => _AddAndRemoveButton();
// }

// class _AddAndRemoveButton extends State<AddAndRemoveButton> {
//   int newSeatCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     // _loadSeatnumber();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       padding: EdgeInsets.all(8.0),
//       width: 90.0,
//       height: 40.0,
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
//       child: new Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           new Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   // print(widget.seatCount);
//                   widget.selectId == ""
//                       ? Fluttertoast.showToast(
//                           msg: "Please select a slot",
//                           gravity: ToastGravity.CENTER,
//                         )
//                       : setState(() {
//                           if (widget.displaynumber != 0) {
//                             widget.displaynumber = widget.displaynumber - 1;
//                             newSeatCount = newSeatCount - 1;
//                             widget.seatCount = widget.seatCount + 1;
//                             print(newSeatCount);
//                             // PrefManager.setTotalSeatCount(seatCount);
//                             // initState();
//                           } else {
//                             Fluttertoast.showToast(
//                               msg: "Limit Reached",
//                               gravity: ToastGravity.CENTER,
//                             );
//                           }
//                         });
//                   widget.displaynumber != 0
//                       ? widget.displaynumber = widget.displaynumber - 1
//                       : Fluttertoast.showToast(
//                           msg: "Limit Reached",
//                           gravity: ToastGravity.CENTER,
//                         );
//                       : PrefManager.setTotalPersonNumber(widget.displaynumber);
//                   widget.displaynumber <= PrefManager.getTotalPersonNumber() ?
//                   widget.slectedId == ""
//                       ? Fluttertoast.showToast(
//                           msg: "Please select a slot",
//                           gravity: ToastGravity.CENTER,
//                         )
//                       : setState(() {
//                           widget.displaynumber != 0
//                               ? widget.displayNumber = widget.displayNumber - 1
//                   : Fluttertoast.showToast(
//                       msg: "Limit Reached",
//                       gravity: ToastGravity.CENTER,
//                     );
//                         });
//                 },
//                 child: Icon(
//                   Icons.remove,
//                   color: Colors.black,
//                   size: 18,
//                 ),
//               ),
//               new Text(
//                 widget.state.number.toString(),
//                 style: TextStyle(color: Colors.black),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   widget.selectId == ""
//                       ? Fluttertoast.showToast(
//                           msg: "Please select a slot",
//                           gravity: ToastGravity.CENTER,
//                         )
//                       : setState(() {
//                           if (widget.seatCount != 0) {
//                             BlocProvider.of<BookingSlotBloc>(context).add(
//                                 AddPerson(
//                                     seatCount: widget.seatCount,
//                                     number: widget.displaynumber));
//                           } else {
//                             Fluttertoast.showToast(
//                               msg: "Limit Reached",
//                               gravity: ToastGravity.CENTER,
//                             );
//                           }
//                         });
//                 },
//                 child: Icon(
//                   Icons.add,
//                   color: Colors.black,
//                   size: 18,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   // Future<void> _loadSeatnumber() async {
//   //   seatCount = await PrefManager.getTotalSeatCount();
//   // }
// }
