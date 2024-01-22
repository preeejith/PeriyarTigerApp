import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:parambikulam/bloc/assets/localbloc/ibprogramsofflinebloc.dart';

import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/ibmaindetailedview.dart';

import 'package:parambikulam/ui/assets/local/offline_ui/reservationview/reservationfullview.dart';

//////
class IbReservation extends StatefulWidget {
  final String index;

  final List<SlotModel> slotlist;
  final List<OldResDataModel> oldresdatalist;

  final OfflineDataReceived2 state;

  const IbReservation(
      {Key? key,
      required this.index,
      required this.state,
      required this.oldresdatalist,
      required this.slotlist})
      : super(key: key);

  @override
  State<IbReservation> createState() => _IbReservationState();
}

class _IbReservationState extends State<IbReservation> {
  var dateFormat = DateFormat("yyyyy-MM-dd hh:mm:ss");
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
  final TextEditingController slotdetailscontroler = TextEditingController();
  final TextEditingController datecheckyearcontroller = TextEditingController();
  final TextEditingController datecheckyear2controller =
      TextEditingController();
  List<SlotModel2> slotlist2 = [];
  List<FinalSlotModel> finalSlotModelList = [];
  late List newList;
  String? initialdatetest;
  String dropdownvalue = 'Vegetarian';
  int? rooomcount;
  bool? availablecheck = false;
  var items = [
    'Vegetarian',
    'Non-Vegetarian',
    'Vegetarian and Non Vegetarian',
  ];
  var d1 = new DateFormat('dd-MMM-yyyy');
  var d2 = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.sss'Z'");

  final TextEditingController dobcontroller = TextEditingController();
  int count = 0;
  int roomcount = 0;

  DateTime selected2 = DateTime.now();
  @override
  void initState() {
    super.initState();
    fetcher();
  }

  void fetcher() async {
    // selected2 = DateTime.now();

    if (selected2 != selectedDate)
      setState(() {
        selectedDate = selected2;
        finalSlotModelList.clear();
        datecontroller.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

        dateintputcontroller.text =
            "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";

        datecheckyearcontroller.text =
            "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}  ${selectedDate.hour}:${selectedDate.minute}:${selectedDate.second}";
        datecheckyear2controller.text = dateFormat
            .format(DateTime.parse(widget.slotlist[0].slottoDate.toString()));

        //  DateTime dt1 =  DateTime.parse(datecheckyearcontroller.text.toString());
        DateTime dt2 = DateTime.parse(datecheckyear2controller.text.toString());

        for (int i = 0; i < widget.oldresdatalist.length; i++) {
          if (d1.format(DateTime.parse(
                  widget.oldresdatalist[i].bookingDate.toString())) ==
              d1.format(selectedDate)) {
            finalSlotModelList.add(FinalSlotModel(
                bookingDate: widget.oldresdatalist[i].bookingDate.toString(),
                slotId: widget.oldresdatalist[i].slotid.toString(),
                slotProgrammeId:
                    widget.oldresdatalist[i].slotprogramid.toString(),
                reserveNumber: widget.oldresdatalist[i].reserveno.toString()));
          }
        }
        count = 0;
        for (int i = 0; i < finalSlotModelList.length; i++) {
          count = count + int.parse(finalSlotModelList[i].reserveNumber!);
          print(count.toString() + "count");
        }

        for (int j = 0; j < widget.slotlist.length; j++) {
          DateTime dt3 =
              DateTime.parse(widget.slotlist[j].slottoDate.toString());

          if (selected2.compareTo(dt3) == 0) {
            print("Both date time are at same moment.");
            setState(() {
              availablecheck = true;
            });
          }

          if (selected2.compareTo(dt3) < 0) {
            print("DT1 is lesser DT2");

            slotlist2.add(SlotModel2(
              status: widget.slotlist[j].status.toString(),
              id: widget.slotlist[j].id.toString(),
              starttime: widget.slotlist[j].starttime.toString(),
              endtime: widget.slotlist[j].endtime.toString(),
              availableNo: widget.slotlist[j].availableNo.toString(),
              slotisDaywise: "dsf",
              slotstatus: widget.slotlist[j].slotstatus.toString(),
              slotid: widget.slotlist[j].slotid.toString(),
              slotprogramme: widget.slotlist[j].slotprogramme.toString(),
              slotfromDate: widget.slotlist[j].slotfromDate.toString(),
              slottoDate: widget.slotlist[j].slottoDate.toString(),
              slotslotType: widget.slotlist[j].slotslotType.toString(),
            ));
            setState(() {
              availablecheck = true;
            });
          }

          if (selected2.compareTo(dt3) > 0) {
            setState(() {
              availablecheck = false;
            });
            print("DT1 is greater DT2");
          }
        }
        roomcount = 0;
        slotlist2.length != 0
            ? roomcount =
                (int.parse(slotlist2[0].availableNo.toString()) - count)
            : roomcount = 0;
        setState(() {});
      });
  }

  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("BOOKING"), actions: []),
      bottomNavigationBar: availablecheck == false
          ? SizedBox()
          : int.parse(roomcount.toString()) <= 0
              ? SizedBox()
              : SizedBox(
                  child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.green,
                    child: Text("SUBMIT"),
                    onPressed: () {
                      slotdetailscontroler.text = slotlist2.length == 0
                          ? ""
                          : slotlist2[0].id.toString();

                      validate();
                    },
                  ),
                )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            child: Column(
              children: [
                Text(
                  widget.state.items![int.parse(widget.index)]['progName'] +
                      "( " +
                      "IB" +
                      " )",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: datecontroller,
                    inputFormatters: const [],
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        child: Icon(Icons.calendar_month),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      labelText: "Select Date",
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Availability",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 45,
                    color: Colors.green.shade400,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: availablecheck == false
                                  ? Text(
                                      "No Rooms Available" + "     ",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          slotlist2.length == 0
                                              ? ""
                                              : int.parse(roomcount
                                                          .toString()) <
                                                      0
                                                  ? "0 Rooms Available"
                                                  : roomcount.toString() +
                                                      " " +
                                                      "Rooms Available",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          slotlist2.length == 0
                                              ? ""
                                              : slotlist2[0]
                                                      .starttime
                                                      .toString() +
                                                  "PM" +
                                                  "  " +
                                                  "-" +
                                                  slotlist2[0]
                                                      .endtime
                                                      .toString() +
                                                  "AM",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                availablecheck == false
                    ? Container()
                    : roomcount.toString() == "0"
                        ? Container()
                        : Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextFormField(
                                      controller: noofroomsrequiredcontroller,
                                      maxLength: 5,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'No of Rooms required',
                                      ),
                                      onChanged: (string) {
                                        noofroomsrequiredcontroller.text == ""
                                            ? SizedBox()
                                            : slotlist2.length == 0
                                                ? SizedBox()
                                                : (int.parse(
                                                            noofroomsrequiredcontroller
                                                                .text
                                                                .toString())) >
                                                        (int.parse(roomcount
                                                            .toString()))
                                                    ? Fluttertoast.showToast(
                                                        backgroundColor:
                                                            Colors.white,
                                                        msg:
                                                            "Rooms Availability Less ",
                                                        textColor: Colors.black)
                                                    : SizedBox();
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextFormField(
                                      controller: guestnamecontroller,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        labelText: 'Guest Name*',
                                      ),
                                      onChanged: (string) {}),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextFormField(
                                      controller:
                                          noofpersonaccompanyingcontroller,
                                      maxLength: 5,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'No of Person accompanying*',
                                      ),
                                      onChanged: (string) {}),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextFormField(
                                      maxLength: 10,
                                      controller: guestphonenumbercontroler,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Guest Phone No*',
                                      ),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (string) {}),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextFormField(
                                      controller: referredbycontroller,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        labelText: 'Referred by*',
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
                                        labelText: 'Reference person Phone* ',
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
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        labelText: 'Email address',
                                      ),
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
                                        foodpreferencecontroller.text =
                                            newValue;
                                      });
                                    },
                                    dropdownColor: Color(0xfff7f7f7),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextFormField(
                                      controller: noofvehiclecontroller,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'No of vehicles',
                                      ),
                                      onChanged: (string) {}),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextFormField(
                                      controller: vehiclenumbercontroller,
                                      autocorrect: true,
                                      textInputAction: TextInputAction.next,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      keyboardType: TextInputType.text,
                                      decoration: const InputDecoration(
                                        labelText: 'Vehicle Number',
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
                                        labelText: 'Any other details',
                                      ),
                                      onChanged: (string) {}),
                                ),
                              ],
                            ),
                          ),
                Container(
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

////////
  Future<void> validate() async {
    if (guestnamecontroller.text.isEmpty) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "please enter guestname",
          textColor: Colors.black);
    } else if (availablecheck == false) {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "No Slot Available for the date");
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
    } else if (noofroomsrequiredcontroller.text.isEmpty) {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "please enter total rooms required");
    } else if ((int.parse(noofroomsrequiredcontroller.text.toString())) >
        (int.parse(roomcount.toString()))) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white,
          msg: "Rooms Availability Lesser ",
          textColor: Colors.black);
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
    } else if (dateintputcontroller.text.isEmpty) {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "please select date");
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
    } else if (slotdetailscontroler.text == "") {
      Fluttertoast.showToast(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          msg: "No Slot Details Available ");
    } else {
      final date = dateintputcontroller.text.toString();

      final programid = widget.state.items![int.parse(widget.index)]['_id'];

      final slotdetailsid = slotdetailscontroler.text.toString();
      final bookingdate = d2.format(selectedDate.toLocal());
      final numberofRooms = noofroomsrequiredcontroller.text.toString();
      final guestname = guestnamecontroller.text.toString();
      final numberofpersonaccompanying =
          noofpersonaccompanyingcontroller.text.toString();
      final guestphone = guestphonenumbercontroler.text.toString();
      final reference = referredbycontroller.text.toString();
      final referencephone = refpersonphonecontroller.text.toString();
      final email = emailcontroller.text.toString();
      final foodpreference = foodpreferencecontroller.text.toString() == ""
          ? "Vegitarian"
          : foodpreferencecontroller.text.toString();
      final numberofVehicle = noofvehiclecontroller.text.toString();
      final vehicleNumbers = vehiclenumbercontroller.text.toString();
      final details = detailscontroller.text.toString();

      if (guestname.isEmpty || guestname.isEmpty) {
        return;
      } else {
        Map data = {
          'programid': programid,
          'slotdetailsid': slotdetailsid,
          'bookingdate': bookingdate,
          'numberofRooms': numberofRooms,
          'guestname': guestname,
          'numberofpersonaccompanying': numberofpersonaccompanying,
          'guestphone': guestphone,
          'reference': reference,
          'referencephone': referencephone,
          'email': email,
          'foodpreference': foodpreference,
          'numberofVehicle': numberofVehicle,
          'vehicleNumbers': vehicleNumbers,
          'details': details,
        };
        print(data);
        insertreservationdata(data);
//////////////////adding to the list of reservation very important

        // if (slotdetailsid.isEmpty || slotdetailsid.isEmpty) {
        //   return null;
        // } else {
        //   Map data = {
        //     'reservedcount': numberofRooms,
        //     'status': "active",
        //     'foodprefered': foodpreference,
        //     'vehicleno': vehicleNumbers,
        //     'bookingid': "12323",
        //     'bookingdate': bookingdate,
        //     'slotid': slotdetailsid,
        //     'slotprogramid': slotdetailsid,
        //     'programName': guestname,
        //     'programid': programid,
        //     'guestName': guestname,
        //     'NoofCompaningPerson': numberofpersonaccompanying,
        //     'guestPhone': guestphone,
        //     'refered': reference,
        //     'referedPhone': referencephone,
        //     'email': email,
        //     'noofVehicles': numberofVehicle,
        //     'details': details,
        //     'edited': "false",
        //     'removed': "false",
        //     'added': "true"
        //   };
        //   print(data);
        //   await getonlineresevationdata(data);
        // }

/////////////////////////////////

        Fluttertoast.showToast(
            backgroundColor: Colors.white,
            msg: "Reservation Added",
            textColor: Colors.black);

        // rooomcount = (int.parse(slotlist2[0].availableNo.toString()) -
        //     int.parse(noofroomsrequiredcontroller.text.toString()));

        // // updateslotdata(rooomcount, slotlist2[0].id);
        ///
        if (availablecheck == true) {
          final reserveno = int.parse(noofroomsrequiredcontroller.text);

          final bookingDate =
              selectedDate == null ? "" : d2.format(selectedDate.toLocal());
          // : DateTime.parse(selectedDate.toLocal().toString());
          final slotid = slotdetailscontroler.text.toString() == null
              ? ""
              : slotdetailscontroler.text.toString();
          final slotprogramid =
              widget.state.items![int.parse(widget.index)]['_id'] == null
                  ? ""
                  : widget.state.items![int.parse(widget.index)]['_id'];
          final programName =
              widget.state.items![int.parse(widget.index)]['progName'] == null
                  ? ""
                  : widget.state.items![int.parse(widget.index)]['progName'];

          if (slotid.isEmpty || slotid.isEmpty) {
            return null;
          } else {
            Map data = {
              'reserveno': reserveno,
              'bookingDate': bookingDate,
              'slotid': slotid,
              'slotprogramid': slotprogramid,
              'programName': programName,
            };
            print(data);
            getinsertreservationdata(data);
          }
        }
        ////////to do

        ///
        setState(() {
          BlocProvider.of<Pendin2OfflineBloc>(context).add(GetOffline2Data());
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ReservationOnlineDetails()));
      }
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2028),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        finalSlotModelList.clear();
        datecontroller.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";

        dateintputcontroller.text =
            "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";

        datecheckyearcontroller.text =
            "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}  ${selectedDate.hour}:${selectedDate.minute}:${selectedDate.second}";
        datecheckyear2controller.text = dateFormat
            .format(DateTime.parse(widget.slotlist[0].slottoDate.toString()));

        //  DateTime dt1 =  DateTime.parse(datecheckyearcontroller.text.toString());
        DateTime dt2 = DateTime.parse(datecheckyear2controller.text.toString());

        for (int i = 0; i < widget.oldresdatalist.length; i++) {
          if (d1.format(DateTime.parse(
                  widget.oldresdatalist[i].bookingDate.toString())) ==
              d1.format(selectedDate)) {
            finalSlotModelList.add(FinalSlotModel(
                bookingDate: widget.oldresdatalist[i].bookingDate.toString(),
                slotId: widget.oldresdatalist[i].slotid.toString(),
                slotProgrammeId:
                    widget.oldresdatalist[i].slotprogramid.toString(),
                reserveNumber: widget.oldresdatalist[i].reserveno.toString()));
          }
        }
        count = 0;
        for (int i = 0; i < finalSlotModelList.length; i++) {
          count = count + int.parse(finalSlotModelList[i].reserveNumber!);
          print(count.toString() + "count");
        }

        for (int j = 0; j < widget.slotlist.length; j++) {
          DateTime dt3 =
              DateTime.parse(widget.slotlist[j].slottoDate.toString());

          if (selected.compareTo(dt3) == 0) {
            print("Both date time are at same moment.");
            setState(() {
              availablecheck = true;
            });
          }

          if (selected.compareTo(dt3) < 0) {
            print("DT1 is lesser DT2");

            slotlist2.add(SlotModel2(
              status: widget.slotlist[j].status.toString(),
              id: widget.slotlist[j].id.toString(),
              starttime: widget.slotlist[j].starttime.toString(),
              endtime: widget.slotlist[j].endtime.toString(),
              availableNo: widget.slotlist[j].availableNo.toString(),
              slotisDaywise: "dsf",
              slotstatus: widget.slotlist[j].slotstatus.toString(),
              slotid: widget.slotlist[j].slotid.toString(),
              slotprogramme: widget.slotlist[j].slotprogramme.toString(),
              slotfromDate: widget.slotlist[j].slotfromDate.toString(),
              slottoDate: widget.slotlist[j].slottoDate.toString(),
              slotslotType: widget.slotlist[j].slotslotType.toString(),
            ));
            setState(() {
              availablecheck = true;
            });
          }

          if (selected.compareTo(dt3) > 0) {
            setState(() {
              availablecheck = false;
            });
            print("DT1 is greater DT2");
          }
        }
        roomcount = 0;
        slotlist2.length != 0
            ? roomcount =
                (int.parse(slotlist2[0].availableNo.toString()) - count)
            : roomcount = 0;
        setState(() {});
        //   if (selected.compareTo(dt2) == 0) {
        //     print("Both date time are at same moment.");
        //     setState(() {
        //       availablecheck = true;
        //     });
        //   }

        // if (selected.compareTo(dt2) < 0) {
        //   setState(() {
        //     availablecheck = true;
        //   });
        //   print("DT1 is lesser DT2");
        // }

        // if (selected.compareTo(dt2) > 0) {
        //   setState(() {
        //     availablecheck = false;
        //   });
        //   print("DT1 is greater DT2");
        // }
      });
  }

  String getTime(
    List list,
    param1,
    String s,
  ) {
    newList =
        list.where((element) => element['slotprogramme'] == param1).toList();
    print(newList[0][s]);

    return newList[0][s];
    // return d1.format(DateTime.parse(convert(newList[0][s])));
  }

  String convert(String uTCTime) {
    var dateFormat =
        DateFormat("yyyyy-MM-dd hh:mm:ss"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(uTCTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();

    return localDate;
  }
}

class SlotModel2 {
  String? status;
  String? id;
  String? starttime;
  String? endtime;
  String? availableNo;
  String? slotisDaywise;
  String? slotstatus;
  String? slotid;
  String? slotprogramme;
  String? slotfromDate;
  String? slottoDate;
  String? slotslotType;

  SlotModel2(
      {this.status,
      this.id,
      this.starttime,
      this.endtime,
      this.availableNo,
      this.slotisDaywise,
      this.slotstatus,
      this.slotid,
      this.slotprogramme,
      this.slotfromDate,
      this.slottoDate,
      this.slotslotType});
}

class FinalSlotModel {
  String? bookingDate, slotProgrammeId, reserveNumber, slotId;
  FinalSlotModel(
      {this.bookingDate,
      this.reserveNumber,
      this.slotId,
      this.slotProgrammeId});
}
