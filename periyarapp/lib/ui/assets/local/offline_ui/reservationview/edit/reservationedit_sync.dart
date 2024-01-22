import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibreservationdetailsbloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservationfullview.dart';

class ReservationsyncEdit extends StatefulWidget {
  final String ibprogramname;
  final int index;
  final String starttime;
  final String endtime;

  final ReservationdataRecived state;
  const ReservationsyncEdit(
      {Key? key,
      required this.endtime,
      required this.starttime,
      required this.ibprogramname,
      required this.state,
      required this.index})
      : super(key: key);

  @override
  State<ReservationsyncEdit> createState() => _ReservationsyncEditState();
}

class _ReservationsyncEditState extends State<ReservationsyncEdit> {
  String drop = "Vegetarian";
  String? edited = "true";
  final TextEditingController noofroomsrequiredcontroller =
      TextEditingController();

  final TextEditingController guestnamecontroller = TextEditingController();
  final TextEditingController noofpersonaccompanyingcontroller =
      TextEditingController();
  final TextEditingController guestphonenumbercontroler =
      TextEditingController();
  final TextEditingController referredbycontroller = TextEditingController();
  final TextEditingController refpersonphonecontroller =
      TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController foodpreferencecontroller =
      TextEditingController();
  final TextEditingController noofvehiclecontroller = TextEditingController();
  final TextEditingController vehiclenumbercontroller = TextEditingController();
  final TextEditingController detailscontroller = TextEditingController();
  final TextEditingController datecontroller = TextEditingController();
  final TextEditingController dateintputcontroller = TextEditingController();

  @override
  void initState() {
    // drop = widget.state.items7![widget.index]['foodprefered'];
    fetcher();

    super.initState();
  }

  void fetcher() async {
    referredbycontroller.text = widget.state.items4![widget.index]['reference'];
    print(referredbycontroller.toString());
    guestnamecontroller.text = widget.state.items4![widget.index]['guestname'];
    noofpersonaccompanyingcontroller.text =
        widget.state.items4![widget.index]['numberofpersonaccompanying'];
    guestphonenumbercontroler.text =
        widget.state.items4![widget.index]['guestphone'];
    refpersonphonecontroller.text =
        widget.state.items4![widget.index]['referencephone'];
    refpersonphonecontroller.text =
        widget.state.items4![widget.index]['referencephone'];
    emailcontroller.text = widget.state.items4![widget.index]['email'];
    foodpreferencecontroller.text =
        widget.state.items4![widget.index]['foodpreference'];
    noofvehiclecontroller.text =
        widget.state.items4![widget.index]['numberofVehicle'];
    vehiclenumbercontroller.text =
        widget.state.items4![widget.index]['vehicleNumbers'];
    detailscontroller.text = widget.state.items4![widget.index]['details'];
    noofroomsrequiredcontroller.text =
        widget.state.items4![widget.index]['numberofRooms'];
    datecontroller.text = widget.state.items4![widget.index]['bookingdate'];
    dropdownvalue = widget.state.items4![widget.index]['foodpreference'] ==
            "Non Vegitarian"
        ? "Non-Vegetarian"
        : widget.state.items4![widget.index]['foodpreference'] == "Vegitarian"
            ? "Vegetarian"
            : "Vegetarian and Non Vegetarian";
  }

  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');

  String? dropdownvalue;
  var items = [
    'Vegetarian',
    'Non-Vegetarian',
    'Vegetarian and Non Vegetarian',
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MaterialButton(
          color: Colors.green,
          child: Text("SUBMIT"),
          onPressed: () {
            validate();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                widget.ibprogramname,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Selected Date",
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                          d1.format(DateTime.parse(datecontroller.text)),
                          style: TextStyle(color: Colors.green, fontSize: 11)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(" Selected Slot",
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        widget.starttime + " PM -" + widget.endtime + "AM",
                        style: TextStyle(color: Colors.green, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Rooms Reserved",
                        style: TextStyle(color: Colors.white, fontSize: 13)),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(noofroomsrequiredcontroller.text.toString(),
                          style: TextStyle(color: Colors.green, fontSize: 11)),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                  controller: guestnamecontroller,
                  autocorrect: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Reserved for :',
                  ),
                  onChanged: (string) {}),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                  maxLength: 10,
                  controller: guestphonenumbercontroler,
                  autocorrect: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Guests Phone no.',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (string) {}),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Food preference"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: DropdownButtonFormField(
                focusColor: Colors.black,
                decoration: InputDecoration(
                    isDense: true,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none),
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    foodpreferencecontroller.text = newValue;
                  });
                },
                dropdownColor: Color(0xfff7f7f7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                  controller: noofpersonaccompanyingcontroller,
                  autocorrect: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'No. of persons accompanying :',
                  ),
                  onChanged: (string) {}),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                  controller: referredbycontroller,
                  autocorrect: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Reference :',
                  ),
                  onChanged: (string) {}),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                  maxLength: 10,
                  controller: refpersonphonecontroller,
                  autocorrect: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Reference Persons Phone :',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (string) {}),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                  controller: emailcontroller,
                  autocorrect: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Email :',
                  ),
                  onChanged: (string) {}),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                  controller: noofvehiclecontroller,
                  autocorrect: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'No. of Vehicles :',
                  ),
                  onChanged: (string) {}),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                  controller: vehiclenumbercontroller,
                  autocorrect: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Numbers : ',
                  ),
                  onChanged: (string) {}),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                  controller: detailscontroller,
                  autocorrect: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Other details provided : ',
                  ),
                  onChanged: (string) {}),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> validate() async {
    if (guestnamecontroller.text.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "please enter guestname",
          textColor: Colors.black);
    } else if (noofpersonaccompanyingcontroller.text.isEmpty) {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "please enter no. of person accompanying");
    } else if (guestphonenumbercontroler.text.isEmpty) {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "please enter guest phone number");
    } else if (guestphonenumbercontroler.text.length != 10) {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "please enter a valid phone number ");
    } else if (referredbycontroller.text.isEmpty) {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "please enter the refered person");
    } else if (refpersonphonecontroller.text.isEmpty) {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "please enter no. of refered person phone number");
    } else if (refpersonphonecontroller.text.length != 10) {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "please enter a valid phone number");
    } else if (refpersonphonecontroller.text.isEmpty) {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "please enter no. of refered person phone number");
    } else {
      ////to take the edit formula
      await updatereservationdata(
          foodpreferencecontroller.text.toString(),
          vehiclenumbercontroller.text.toString(),
          guestnamecontroller.text.toString(),
          noofpersonaccompanyingcontroller.text.toString(),
          guestphonenumbercontroler.text.toString(),
          referredbycontroller.text.toString(),
          refpersonphonecontroller.text.toString(),
          emailcontroller.text.toString(),
          noofvehiclecontroller.text.toString(),
          detailscontroller.text.toString(),
          int.parse(widget.state.items4![widget.index]['id'].toString()));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ReservationOnlineDetails()));
    }
  }
}
