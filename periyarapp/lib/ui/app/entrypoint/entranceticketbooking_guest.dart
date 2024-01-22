import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:objectid/objectid.dart';
import 'package:parambikulam/bloc/addperson/blocaddperson.dart';
import 'package:parambikulam/bloc/addperson/stateaddperson.dart';
import 'package:parambikulam/bloc/booking/bookingbloc.dart';
import 'package:parambikulam/bloc/entrancecharge/blocentrancecharge.dart';
import 'package:parambikulam/bloc/entrancecharge/stateentrancecharge.dart';
import 'package:parambikulam/bloc/entrypoint/entrybooking/entrybookingbloc.dart';
import 'package:parambikulam/bloc/entrypoint/entrybooking/entrybookingevent.dart';
import 'package:parambikulam/bloc/entrypoint/entrybooking/entrybookingstate.dart';
import 'package:parambikulam/ui/app/entrypoint/entrybookinghome.dart';
import 'package:path_provider/path_provider.dart';
import 'package:parambikulam/bloc/updateguest/blocroomupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/blocupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/eventroomupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/eventupdateguest.dart';
import 'package:parambikulam/data/models/entrymodel/camerainfomodel.dart';
import 'package:parambikulam/data/models/entrymodel/guestinfomodel.dart';
import 'package:parambikulam/data/models/entrymodel/vehicleinfomodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/booking/bookingsummary.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../config.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class EntranceTicketBookingSecond extends StatefulWidget {
  final List<ListModel> displayList;

  EntranceTicketBookingSecond({
    required this.displayList,
  });
  _EntranceTicketBookingSecond createState() => _EntranceTicketBookingSecond();
}

////////
class _EntranceTicketBookingSecond extends State<EntranceTicketBookingSecond> {
  final f = new DateFormat('MMMM dd, yyyy');
  final g = new DateFormat('yyyy-MM-dd');
  final time = new DateFormat('hh:mm a');
  String dropdownvalue = 'Item 1';
  bool? submitted = false;
  // List of items in our dropdown menu
  var items = ['Male', "Female"];
  var idproofs = ['Adhar Card', "Passport", "Driving License"];
  String? entranceTicket;
  int totalAmount = 0;
  int vehicleTotal = 0;
  int cameraTotal = 0;
  int entranceTotal = 0;
  List<Map> listDetails = [];
  String? ticketName;
  List<GuestInfoModel> customersList = [];
  List<Map> vehicleInfo = [];
  List<CameraInfoModel> cameraList = [];
  List<CameraInfoModel> cameraDetailsSelected = [];

  List<InnerListIndividual> innerListIndividual = [];
  List<AddedPerson> totalPerson = [];
  String? currentCutomer;
  List<VehicleInfoModel> vehicleDetails = [];
  List<VehicleInfoModel> vehicleDetailsSelected = [];
  List<GuestInfoModel> newList = [];
  List<GuestInfoModel> indianList = [];
  List<GuestInfoModel> indianListAll = [];
  List<GuestInfoModel> foreignerList = [];
  List<GuestInfoModel> childrenList = [];
  List<Map> vehicleDetailsList = [];

  List? newListTwo = [];
  int? vehicleAddCount = 0, personCount = 0;
  int? editingIndex, indianI = 0;
  int? allCount = 0, size, activeKey = 0;
  String? cartId, path, name, theName, visapath, passportPath;
  bool? isEnabled, isActivated;
  int? currentIndex, currentIndexTwo, selected = 0, selectedTwo = 0;
  bool? isExpanded = false, deleted = false;
  bool? disablePsButton = true;
  bool? isEditing = false, cameraState = false;
  File? imageFile;
  int? count = 0, totalGuests = 0;
  DatabaseHelper? db = DatabaseHelper.instance;
  final ticketId = ObjectId();
  bool isRemoved = false, isAdded = true;
  bool timer = false;
  Color? borderColor = Colors.green;
  BookingBloc? bookingBloc;
  TextEditingController placeController = TextEditingController();
  List termsAndConditions = [];
  @override
  void initState() {
    super.initState();
    isActivated = false;
    isEnabled = true;

    checkStatus();
  }

  @override
  void dispose() {
    super.dispose();
    BookingBloc().close();
    AddPersonBloc().close();
    BlocEntranceCharge().close();
    EntryBookingBloc().close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<EntryBookingBloc>(context).add(Refresh());
        return true;
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: Text(
            'Booking',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage(
                    "assets/bgptrr.png",
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        body: new SafeArea(
          child: new SingleChildScrollView(
            child: new Container(
              padding: EdgeInsets.all(12.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Total',
                        style: StyleElements.bookingDetailsTitle,
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (widget.displayList[0].value! +
                                      widget.displayList[1].value! +
                                      widget.displayList[2].value!) >
                                  1
                              ? new Text(
                                  (widget.displayList[0].value! +
                                              widget.displayList[1].value! +
                                              widget.displayList[2].value!)
                                          .toString() +
                                      " Persons",
                                )
                              : new Text(
                                  (widget.displayList[0].value! +
                                              widget.displayList[1].value! +
                                              widget.displayList[2].value!)
                                          .toString() +
                                      " Person",
                                ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Text("Total Amount :",
                          style: StyleElements.bookingDetailsTitle),
                      Spacer(),
                      Text(totalAmount.toString() + ' INR')
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  !submitted!
                      ? Column(children: [
                          _guestNumber(context),
                          _addVehicles(context),
                          Divider(),
                          SizedBox(
                            height: 16.0,
                          ),
                          _addCamera(context),
                          Divider(),
                          SizedBox(
                            height: 16.0,
                          ),
                          _additionalFeilds(context),
                          Divider(),
                          SizedBox(
                            height: 30.0,
                          ),
                        ])
                      : Column(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 100,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Ticket Booked"),
                          ],
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  _finalSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _guestNumber(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text("Add Guest Details"),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: customersList.length,
            itemBuilder: (context, index) {
              if (customersList[index].status == true) {
                count = count! + 1;
                return Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    textColor: HexColor("#53A874"),
                    iconColor: HexColor("#53A874"),
                    leading: Text(
                      (index + 1).toString(),
                    ),
                    title: Text(customersList[index].name.toString()),
                    trailing: Text(
                      customersList[index].count! > 1
                          ? customersList[index].count.toString() + " Persons"
                          : customersList[index].count.toString() + " Person",
                      style: StyleElements.bookingDetailsTitle,
                    ),
                    children: innerList(context, index),
                  ),
                );
              }
              return Container();
            }),
        SizedBox(
          height: 10.0,
        ),
        Divider(),
      ],
    );
  }

  _addVehicles(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Add Vehicle"),
            IconButton(
              onPressed: () {
                allCount == 0
                    ? isEnabled == true
                        ? setState(
                            () {
                              vehicleAddCount = vehicleAddCount! + 1;
                              vehicleDetailsSelected.add(
                                VehicleInfoModel(number: vehicleAddCount),
                              );
                            },
                          )
                        : _showToast(
                            context, "Button Disabled", Toast.LENGTH_SHORT)
                    : _showToast(context, "Please add all member(s) details",
                        Toast.LENGTH_SHORT);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          children: dropDownMenu(context),
        )
      ],
    );
  }

  int? allCameraCount = 0;
  bool? isCameraEnabled = false;
  int cameraAddCount = 0;

  _addCamera(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Add Camera"),
            IconButton(
              onPressed: () {
                allCount == 0
                    ? isEnabled == true
                        ? setState(
                            () {
                              cameraAddCount = cameraAddCount + 1;
                              cameraDetailsSelected.add(
                                CameraInfoModel(number: cameraAddCount),
                              );
                            },
                          )
                        : _showToast(
                            context, "Button Disabled", Toast.LENGTH_SHORT)
                    : _showToast(context, "Please add all member(s) details",
                        Toast.LENGTH_SHORT);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Column(
          children: dropDownMenuCamera(context),
        )
      ],
    );
  }

  dropDownMenu(BuildContext context) {
    List<Widget> itemsMenu = [];
    for (int i = 0; i < vehicleAddCount!; i++) {
      itemsMenu.add(
        Column(
          children: [
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  underline: SizedBox.shrink(),
                  hint: Text(
                    "Choose Vehicle",
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  value: vehicleDetailsSelected[i].type,
                  onChanged: isEnabled == true
                      ? (newValue) {
                          setState(() {
                            vehicleDetailsSelected[i].type =
                                newValue.toString();
                            vehicleDetailsSelected[i].vehiclecharge =
                                vehicleDetailsSelected[i].type !=
                                        "Light Motor Vehicle"
                                    ? vehicleDetails[0].amount.toString()
                                    : vehicleDetails[1].amount.toString();
                            vehicleDetailsSelected[i].type != null
                                ? vehicleDetailsSelected[i].type !=
                                        "Light Motor Vehicle"
                                    ? vehicleDetailsSelected[i].amount =
                                        vehicleDetails[0].amount
                                    : vehicleDetailsSelected[i].amount =
                                        vehicleDetails[1].amount
                                : SizedBox.shrink();
                            vehicleTotalCalc();
                            totalCalc();
                          });
                        }
                      : null,
                  items: vehicleDetails.map((element) {
                    return DropdownMenuItem(
                        value: element.type.toString(),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              element.type.toString(),
                              style: new TextStyle(fontSize: 13.0),
                            ),
                          ],
                        ));
                  }).toList(),
                ),
                new SizedBox(
                  width: 100.0,
                  child: InkWell(
                    onTap: () {
                      _showToast(
                          context,
                          vehicleDetailsSelected[i].id.toString(),
                          Toast.LENGTH_SHORT);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        vehicleDetailsSelected[i].type != null
                            ? vehicleDetailsSelected[i].type ==
                                    "Heavy Motor Vehicle"
                                ? new Text(
                                    vehicleDetails[0].amount.toString() +
                                        " INR",
                                    style: new TextStyle(fontSize: 13.0),
                                  )
                                : new Text(
                                    vehicleDetails[1].amount.toString() +
                                        " INR",
                                    style: new TextStyle(fontSize: 13.0),
                                  )
                            : SizedBox.shrink(),
                        new IconButton(
                          onPressed: () {
                            setState(() {
                              if (isEnabled == true) {
                                if (vehicleAddCount != 0) {
                                  if (vehicleDetailsSelected[i].type != null) {
                                    vehicleAddCount = vehicleAddCount! - 1;
                                    vehicleDetailsSelected
                                        .removeAt(vehicleAddCount!);
                                    vehicleTotalCalc();
                                    totalCalc();
                                    setState(() {});
                                  } else {
                                    vehicleAddCount = vehicleAddCount! - 1;
                                    vehicleDetailsSelected
                                        .removeAt(vehicleAddCount!);
                                  }
                                }
                              } else {
                                _showToast(context, "Button Disabled",
                                    Toast.LENGTH_SHORT);
                              }
                            });
                          },
                          icon: new Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new Row(
              children: [
                Expanded(
                    child: TextFormField(
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Enter Vehicle Number";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Vehicle Number",
                    errorStyle: new TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    hintStyle: new TextStyle(
                        fontSize: 12.0, color: HexColor("#9E9E9E")),
                    filled: true,
                  ),
                  style: new TextStyle(color: Colors.black),
                  onChanged: (String? val) {
                    vehicleDetailsSelected[i].bookingDate =
                        DateTime.now().toString();
                    vehicleDetailsSelected[i].vehicleNumber = val;
                    print(vehicleDetailsSelected[i].vehicleNumber);
                  },
                )),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      );
    }

    return itemsMenu;
  }

  dropDownMenuCamera(BuildContext context) {
    List<Widget> itemsMenu = [];
    for (int i = 0; i < cameraAddCount; i++) {
      itemsMenu.add(
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton(
              underline: SizedBox.shrink(),
              hint: Text(
                "Choose Camera",
                style: new TextStyle(fontSize: 13.0),
              ),
              value: cameraDetailsSelected[i].type,
              onChanged: isEnabled == true
                  ? (newValue) {
                      setState(() {
                        cameraDetailsSelected[i].bookingDate =
                            DateTime.now().toString();
                        cameraDetailsSelected[i].type = newValue.toString();
                        cameraDetailsSelected[i].type != null
                            ? cameraDetailsSelected[i].type == "Camera"
                                ? cameraDetailsSelected[i].amount =
                                    cameraList[0].amount
                                : cameraDetailsSelected[i].amount =
                                    cameraList[1].amount
                            : SizedBox.shrink();
                        cameraTotalCalc();
                        totalCalc();
                      });
                    }
                  : null,
              items: cameraList.map((element) {
                return DropdownMenuItem(
                    value: element.type.toString(),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          element.type.toString(),
                          style: new TextStyle(fontSize: 13.0),
                        ),
                      ],
                    ));
              }).toList(),
            ),
            new SizedBox(
              width: 100.0,
              child: InkWell(
                onTap: () {
                  _showToast(context, cameraDetailsSelected[i].id.toString(),
                      Toast.LENGTH_SHORT);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cameraDetailsSelected[i].type != null
                        ? cameraDetailsSelected[i].type == "Camera"
                            ? new Text(
                                cameraList[0].amount.toString() + " INR",
                                style: new TextStyle(fontSize: 13.0),
                              )
                            : new Text(
                                cameraList[1].amount.toString() + " INR",
                                style: new TextStyle(fontSize: 13.0),
                              )
                        : SizedBox.shrink(),
                    new IconButton(
                      onPressed: () {
                        setState(() {
                          if (isEnabled == true) {
                            if (cameraAddCount != 0) {
                              if (cameraDetailsSelected[i].type != null) {
                                cameraAddCount = cameraAddCount - 1;
                                cameraDetailsSelected.removeAt(cameraAddCount);
                                cameraTotalCalc();
                                totalCalc();
                                setState(() {});
                              } else {
                                cameraAddCount = cameraAddCount - 1;
                                cameraDetailsSelected.removeAt(cameraAddCount);
                              }
                            }
                          } else {
                            _showToast(
                                context, "Button Disabled", Toast.LENGTH_SHORT);
                          }
                        });
                      },
                      icon: new Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return itemsMenu;
  }

  void addToVehicleList(BuildContext context) {
    vehicleDetails.clear();

    vehicleDetails = [
      VehicleInfoModel(
        type: "Heavy Motor Vehicle",
        amount: vehicleInfo[0]['heavyVehicleCharge'],
        id: "",
      ),
      VehicleInfoModel(
        type: "Light Motor Vehicle",
        amount: vehicleInfo[0]['lightVehicleCharge'],
        id: "",
      ),
    ];
  }

  void addToCameraList(BuildContext context) {
    cameraList.clear();

    cameraList = [
      CameraInfoModel(
        type: "Camera",
        amount: vehicleInfo[0]['camera'],
        id: "",
      ),
      CameraInfoModel(
        type: "Movie Camera",
        amount: vehicleInfo[0]['moviecamera'],
        id: "",
      ),
    ];
  }

  vehicleTotalCalc() {
    int tot = 0;
    for (int i = 0; i < vehicleDetailsSelected.length; i++) {
      tot = tot + vehicleDetailsSelected[i].amount!;
    }
    vehicleTotal = tot;
  }

  cameraTotalCalc() {
    int tot = 0;
    for (int i = 0; i < cameraDetailsSelected.length; i++) {
      tot = tot + cameraDetailsSelected[i].amount!;
    }
    cameraTotal = tot;
  }

  totalCalc() {
    totalAmount = vehicleTotal + entranceTotal + cameraTotal;
  }

  buildSeatList(BuildContext context) {
    customersList.clear();

    allCount = widget.displayList[0].value! +
        widget.displayList[1].value! +
        widget.displayList[2].value!;

    customersList = [
      GuestInfoModel(
        name: "Indian",
        label: "indian",
        count: widget.displayList[0].value,
        status: widget.displayList[0].value == 0 ? false : true,
        isDetailsAdded: true,
      ),
      GuestInfoModel(
        name: "Foreigner",
        label: "foreigner",
        count: widget.displayList[1].value,
        status: widget.displayList[1].value == 0 ? false : true,
        isDetailsAdded: true,
      ),
      GuestInfoModel(
        name: "Children",
        label: "children",
        count: widget.displayList[2].value,
        status: widget.displayList[2].value == 0 ? false : true,
        isDetailsAdded: true,
      ),
    ];

    for (int i = 0; i < customersList.length; i++) {
      if (customersList[i].status != false) {
        for (int j = 0; j < customersList[i].count!; j++) {
          newList.add(
            GuestInfoModel(
              isDetailsAdded: false,
              isEdStarted: false,
              number: j,
              label: customersList[i].label,
            ),
          );
        }
      }
    }
    setState(() {});
  }

  Widget _additionalFeilds(BuildContext context) {
    return Column(
      children: [
        new Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: placeController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value == "") {
                  return "Enter Place";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Place",
                errorStyle: new TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                fillColor: Colors.white,
                hintStyle:
                    new TextStyle(fontSize: 12.0, color: HexColor("#9E9E9E")),
                filled: true,
              ),
              style: new TextStyle(color: Colors.black),
            )),
          ],
        ),
        SizedBox(
          height: 16.0,
        ),
      ],
    );
  }

  innerList(BuildContext context, int index) {
    List<Widget> subList = [];
    for (int i = 0; i < newList.length; i++) {
      if (customersList[index].label == newList[i].label) {
        final _formKey = new GlobalKey<FormState>();
        final TextEditingController nameController =
            new TextEditingController();
        final TextEditingController dobController = new TextEditingController();
        final TextEditingController phoneController =
            new TextEditingController();
        final TextEditingController visaNumberController =
            new TextEditingController();
        final TextEditingController visaValidController =
            new TextEditingController();
        final TextEditingController passportvalidController =
            new TextEditingController();
        final TextEditingController idproofController =
            new TextEditingController();
        final TextEditingController visaProofController =
            new TextEditingController();
        final TextEditingController passportProofController =
            new TextEditingController();
        if (isEditing == true && editingIndex == i) {
          nameController.text = newList[i].name.toString();
          dobController.text = newList[i].dob.toString();
          visaNumberController.text = newList[i].visaNumber.toString();
          phoneController.text = newList[i].phoneNumber.toString();
          visaValidController.text = newList[i].visaValidTo.toString();
          passportvalidController.text =
              newList[i].passportValidationDate.toString();
        } else {
          nameController.text = "";
          dobController.text = "";
          visaNumberController.text = "";
          phoneController.text = "";
          visaValidController.text = "";
          passportvalidController.text = "";
        }

        var entranceCharge = 0;
        currentCutomer = customersList[index].label.toString();

        //vehicleInfo

        if (currentCutomer == 'indian') {
          entranceCharge = vehicleInfo[0]['indianEntranceCharge'];
        } else if (currentCutomer == 'foreigner') {
          entranceCharge = vehicleInfo[0]['foreignerEntraneCharge'];
        } else {
          entranceCharge = vehicleInfo[0]['childrenEntraneCharge'];
        }

        subList.add(ExpansionTile(
          textColor: HexColor("#53A874"),
          iconColor: HexColor("#53A874"),
          onExpansionChanged: ((state) {
            if (isActivated == false && newList[i].isEdStarted == false) {
              setState(() {
                isActivated = true;
                newList[i].isEdStarted = true;
              });
            }
          }),
          title: Text(
            "Person " + (i + 1).toString(),
            style: TextStyle(
                color: HexColor("#53A874"),
                fontSize: 12.0,
                fontWeight: FontWeight.w400),
          ),
          children: [
            newList[i].isDetailsAdded == false
                ? isActivated == true && newList[i].isEdStarted == true
                    ? Form(
                        key: _formKey,
                        child: new Container(
                          child: new Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              new Row(
                                children: [
                                  Expanded(
                                      child: TextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return "Enter Name";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      errorStyle:
                                          new TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      fillColor: Colors.white,
                                      hintStyle: new TextStyle(
                                          fontSize: 12.0,
                                          color: HexColor("#9E9E9E")),
                                      filled: true,
                                    ),
                                    style: new TextStyle(color: Colors.black),
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              new Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _selectDate(
                                            context,
                                            i,
                                            dobController,
                                            customersList[index]
                                                .name
                                                .toString());
                                      },
                                      child: IgnorePointer(
                                        child: TextFormField(
                                          controller: dobController,
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Select DOB";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: "DOB",
                                            errorStyle: new TextStyle(
                                                color: Colors.white),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            fillColor: Colors.white,
                                            hintStyle: new TextStyle(
                                                fontSize: 12.0,
                                                color: HexColor("#9E9E9E")),
                                            filled: true,
                                          ),
                                          style: new TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              new Row(
                                children: [
                                  Expanded(
                                      child: TextFormField(
                                    controller: phoneController,
                                    //  maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return "Enter Phone Number";
                                      }
                                      // else if (value.length < 10 ||
                                      //     value.length > 10) {
                                      //   return "Enter Valid Phone Number";
                                      // }
                                      return null;
                                    },
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(42),
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "Phone Number",
                                      errorStyle:
                                          new TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      fillColor: Colors.white,
                                      hintStyle: new TextStyle(
                                          fontSize: 12.0,
                                          color: HexColor("#9E9E9E")),
                                      filled: true,
                                    ),
                                    style: TextStyle(color: Colors.black),
                                  )),
                                ],
                              ),

                              // Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: DropdownButton(
                              //       // Initial Value
                              //       value: context.read<Counter>().gender!,
                              //       hint: Text('Gender'),
                              //       // Down Arrow Icon
                              //       icon: const Icon(Icons.keyboard_arrow_down),

                              //       // Array list of items
                              //       items: items.map((String items) {
                              //         return DropdownMenuItem(
                              //           value: items,
                              //           child: Text(items),
                              //         );
                              //       }).toList(),

                              //       onChanged: (String? newValue) {
                              //         context
                              //             .read<Counter>()
                              //             .changeValue(newValue);

                              //         // newList[i].gender =
                              //         //     context.read<Counter>().gender;
                              //         print(newList[i].gender);
                              //       },
                              //     )),
                              SizedBox(
                                height: 15.0,
                              ),
                              new Column(
                                children: [
                                  new Row(
                                    children: [
                                      Expanded(child: Text("ID Proof")),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  customersList[index].name.toString() ==
                                          "Foreigner"
                                      ? Column(
                                          children: [
                                            new Row(
                                              children: [
                                                Expanded(
                                                    child: TextFormField(
                                                  controller:
                                                      visaNumberController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    new LengthLimitingTextInputFormatter(
                                                        42),
                                                  ],
                                                  decoration: InputDecoration(
                                                    hintText: "Visa Number",
                                                    errorStyle: new TextStyle(
                                                        color: Colors.white),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white),
                                                    ),
                                                    fillColor: Colors.white,
                                                    hintStyle: new TextStyle(
                                                        fontSize: 12.0,
                                                        color: HexColor(
                                                            "#9E9E9E")),
                                                    filled: true,
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            new Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      _selectvisaDate(
                                                          context,
                                                          i,
                                                          visaValidController);
                                                    },
                                                    child: IgnorePointer(
                                                      child: TextFormField(
                                                        controller:
                                                            visaValidController,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value == "") {
                                                            return "Select Visa Expiry Date";
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Select visa expiry date",
                                                          errorStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          fillColor:
                                                              Colors.white,
                                                          hintStyle: new TextStyle(
                                                              fontSize: 12.0,
                                                              color: HexColor(
                                                                  "#9E9E9E")),
                                                          filled: true,
                                                        ),
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            new Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      _selectpassportDate(
                                                          context,
                                                          i,
                                                          passportvalidController);
                                                    },
                                                    child: IgnorePointer(
                                                      child: TextFormField(
                                                        controller:
                                                            passportvalidController,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value == "") {
                                                            return "Select Passport Expiry Date";
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Select Passport Expiry Date",
                                                          errorStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          fillColor:
                                                              Colors.white,
                                                          hintStyle: new TextStyle(
                                                              fontSize: 12.0,
                                                              color: HexColor(
                                                                  "#9E9E9E")),
                                                          filled: true,
                                                        ),
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            new Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      var cameraStatus =
                                                          await Permission
                                                              .camera.status;
                                                      var galleryStatus =
                                                          await Permission
                                                              .storage.status;
                                                      if (cameraStatus ==
                                                              PermissionStatus
                                                                  .denied ||
                                                          cameraStatus ==
                                                              PermissionStatus
                                                                  .permanentlyDenied) {
                                                        cameraStatus =
                                                            await Permission
                                                                .camera
                                                                .request();
                                                      }
                                                      if (galleryStatus ==
                                                              PermissionStatus
                                                                  .denied ||
                                                          galleryStatus ==
                                                              PermissionStatus
                                                                  .permanentlyDenied) {
                                                        galleryStatus =
                                                            await Permission
                                                                .storage
                                                                .request();
                                                      }

                                                      if (cameraStatus ==
                                                              PermissionStatus
                                                                  .granted &&
                                                          galleryStatus ==
                                                              PermissionStatus
                                                                  .granted) {
                                                        cameraState == false
                                                            ? _showPicker(
                                                                context,
                                                                visaProofController,
                                                                "visa")
                                                            : _showToast(
                                                                context,
                                                                "Initializing image source, please wait",
                                                                Toast
                                                                    .LENGTH_SHORT,
                                                              );
                                                      }
                                                    },
                                                    child: IgnorePointer(
                                                      child: TextFormField(
                                                        controller:
                                                            visaProofController,
                                                        // validator: (value) {
                                                        //   if (value == null ||
                                                        //       value == "") {
                                                        //     return "Upload Visa Proof";
                                                        //   }
                                                        //   return null;
                                                        // },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Upload Visa Image",
                                                          errorStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          fillColor:
                                                              Colors.white,
                                                          hintStyle: new TextStyle(
                                                              fontSize: 12.0,
                                                              color: HexColor(
                                                                  "#9E9E9E")),
                                                          filled: true,
                                                          suffixIcon: Icon(
                                                            Icons.file_upload,
                                                            color: HexColor(
                                                                "#9E9E9E"),
                                                          ),
                                                        ),
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            new Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      var cameraStatus =
                                                          await Permission
                                                              .camera.status;
                                                      var galleryStatus =
                                                          await Permission
                                                              .storage.status;
                                                      if (cameraStatus ==
                                                              PermissionStatus
                                                                  .denied ||
                                                          cameraStatus ==
                                                              PermissionStatus
                                                                  .permanentlyDenied) {
                                                        cameraStatus =
                                                            await Permission
                                                                .camera
                                                                .request();
                                                      }
                                                      if (galleryStatus ==
                                                              PermissionStatus
                                                                  .denied ||
                                                          galleryStatus ==
                                                              PermissionStatus
                                                                  .permanentlyDenied) {
                                                        galleryStatus =
                                                            await Permission
                                                                .storage
                                                                .request();
                                                      }

                                                      if (cameraStatus ==
                                                              PermissionStatus
                                                                  .granted &&
                                                          galleryStatus ==
                                                              PermissionStatus
                                                                  .granted) {
                                                        cameraState == false
                                                            ? _showPicker(
                                                                context,
                                                                passportProofController,
                                                                "passport")
                                                            : _showToast(
                                                                context,
                                                                "Initializing image source, please wait",
                                                                Toast
                                                                    .LENGTH_SHORT,
                                                              );
                                                      }
                                                    },
                                                    child: IgnorePointer(
                                                      child: TextFormField(
                                                        controller:
                                                            passportProofController,
                                                        // validator: (value) {
                                                        //   if (value == null ||
                                                        //       value == "") {
                                                        //     return "Upload Passport Proof";
                                                        //   }
                                                        //   return null;
                                                        // },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Upload Passport Image",
                                                          errorStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          fillColor:
                                                              Colors.white,
                                                          hintStyle: new TextStyle(
                                                              fontSize: 12.0,
                                                              color: HexColor(
                                                                  "#9E9E9E")),
                                                          filled: true,
                                                          suffixIcon: Icon(
                                                            Icons.file_upload,
                                                            color: HexColor(
                                                                "#9E9E9E"),
                                                          ),
                                                        ),
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // DropdownButton(
                                            //   // Initial Value
                                            //   value: newList[i].idproofs,
                                            //   hint: Text('Select ID Type'),
                                            //   // Down Arrow Icon
                                            //   icon: const Icon(
                                            //       Icons.keyboard_arrow_down),

                                            //   // Array list of items
                                            //   items:
                                            //       idproofs.map((String items) {
                                            //     return DropdownMenuItem(
                                            //       value: items,
                                            //       child: Text(items),
                                            //     );
                                            //   }).toList(),

                                            //   onChanged: (String? newValue) {
                                            //     setState(() {
                                            //       newList[i].idproofs =
                                            //           newValue!;
                                            //     });
                                            //   },
                                            // ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            new Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () async {
                                                      var cameraStatus =
                                                          await Permission
                                                              .camera.status;
                                                      var galleryStatus =
                                                          await Permission
                                                              .storage.status;
                                                      if (cameraStatus ==
                                                              PermissionStatus
                                                                  .denied ||
                                                          cameraStatus ==
                                                              PermissionStatus
                                                                  .permanentlyDenied) {
                                                        cameraStatus =
                                                            await Permission
                                                                .camera
                                                                .request();
                                                      }
                                                      if (galleryStatus ==
                                                              PermissionStatus
                                                                  .denied ||
                                                          galleryStatus ==
                                                              PermissionStatus
                                                                  .permanentlyDenied) {
                                                        galleryStatus =
                                                            await Permission
                                                                .storage
                                                                .request();
                                                      }

                                                      if (cameraStatus ==
                                                              PermissionStatus
                                                                  .granted &&
                                                          galleryStatus ==
                                                              PermissionStatus
                                                                  .granted) {
                                                        cameraState == false
                                                            ? _showPicker(
                                                                context,
                                                                idproofController,
                                                                "id")
                                                            : _showToast(
                                                                context,
                                                                "Initializing image source, please wait",
                                                                Toast
                                                                    .LENGTH_SHORT,
                                                              );
                                                      }
                                                    },
                                                    child: IgnorePointer(
                                                      child: TextFormField(
                                                        controller:
                                                            idproofController,
                                                        // validator: (value) {
                                                        //   if (value == null ||
                                                        //       value == "") {
                                                        //     return "Upload ID Proof";
                                                        //   }
                                                        //   return null;
                                                        // },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Upload ID Proof Image",
                                                          errorStyle:
                                                              new TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          fillColor:
                                                              Colors.white,
                                                          hintStyle: new TextStyle(
                                                              fontSize: 12.0,
                                                              color: HexColor(
                                                                  "#9E9E9E")),
                                                          filled: true,
                                                          suffixIcon: Icon(
                                                            Icons.file_upload,
                                                            color: HexColor(
                                                                "#9E9E9E"),
                                                          ),
                                                        ),
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  new Container(
                                    padding: EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        top: 16,
                                        bottom: 16),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BlocConsumer<BlocEntranceCharge,
                                                StateEntranceCharge>(
                                            listener: (context, state) {
                                          if (state is EntranceChargeAdded) {}
                                          if (state is EntranceChargeRemoved) {}
                                        }, builder: (context, state) {
                                          if (state is EntranceChargeAdded) {
                                            return Text(
                                              "Entrance charge Rs.$entranceCharge Applied",
                                              style: new TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            );
                                          }
                                          if (state is EntranceChargeRemoved) {
                                            return Text(
                                              "Entrance charge Rs.$entranceCharge Not Applied",
                                              style: new TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            );
                                          }
                                          return Text(
                                            "Entrance charge Rs.$entranceCharge Applied",
                                            style: new TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          );
                                        }),
                                        new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                              onPressed: () {
                                                if (isRemoved == false) {
                                                  isRemoved = true;
                                                  isAdded = false;
                                                } else {
                                                  _showToast(
                                                      context,
                                                      'Entrance charge not applied',
                                                      Toast.LENGTH_SHORT);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                                size: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25,
                                            ),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                              onPressed: () {
                                                if (isAdded == false) {
                                                  isAdded = true;
                                                  isRemoved = false;
                                                } else {
                                                  _showToast(
                                                      context,
                                                      'Entrance charge applied',
                                                      Toast.LENGTH_SHORT);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                                size: 18,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                              Container(
                                height: 45,
                                width: 270,
                                child: new TextButton(
                                  style:
                                      StyleElements.submitAddPersonButtonStyle,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      currentCutomer =
                                          customersList[index].label.toString();

                                      isActivated = false;
                                      newList[i].isDetailsAdded = true;
                                      allCount = allCount! - 1;

                                      newList[i].isDetailsAdded = true;
                                      newList[i].name = nameController.text;
                                      newList[i].phoneNumber =
                                          phoneController.text;
                                      newList[i].visaNumber =
                                          visaValidController.text;
                                      newList[i].bookingDate =
                                          DateTime.now().toString();
                                      newList[i].guestId =
                                          ObjectId().toString();
                                      newList[i].dob = dobController.text;
                                      newList[i].visaValidTo =
                                          visaValidController.text;
                                      newList[i].passportValidationDate =
                                          passportvalidController.text;
                                      newList[i].photo = path;
                                      newList[i].visaproof = visapath;
                                      newList[i].passportproof = visapath;
                                      if (currentCutomer == 'indian') {
                                        entranceCharge = vehicleInfo[0]
                                            ['indianEntranceCharge'];
                                      } else if (currentCutomer ==
                                          'foreigner') {
                                        entranceCharge = vehicleInfo[0]
                                            ['foreignerEntraneCharge'];
                                      } else {
                                        entranceCharge = vehicleInfo[0]
                                            ['childrenEntraneCharge'];
                                      }

                                      entranceTotal =
                                          entranceTotal + entranceCharge;
                                      newList[i].charge =
                                          entranceCharge.toString();
                                      totalCalc();

                                      setState(() {});
                                    }
                                  },
                                  child: BlocConsumer<AddPersonBloc,
                                      AddPersonState>(
                                    builder: (context, state) {
                                      if (state is AddingPerson) {
                                        return SizedBox(
                                          height: 28.0,
                                          width: 28.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.black),
                                            strokeWidth: 2,
                                          ),
                                        );
                                      } else if (state is UploadingFile) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Uploading File",
                                              style: StyleElements
                                                  .buttonTextStyleSemiBoldBlack,
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                              height: 20.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.black),
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (state is FileUploaded) {
                                        path = "";
                                        visapath = "";
                                        passportPath = "";
                                        disablePsButton = true;
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 20.0,
                                              height: 20.0,
                                              child: Icon(Icons.check),
                                            ),
                                          ],
                                        );
                                      } else if (state is FileNotUploaded) {
                                        _showToast(
                                            context,
                                            "ID Proof not uploaded",
                                            Toast.LENGTH_SHORT);
                                        print("File Not Uploaded - " +
                                            state.msg.toString());
                                        return new Text('File Not Uploaded',
                                            style: StyleElements
                                                .buttonTextStyleSemiBoldBlack);
                                      }
                                      {
                                        return new Text('SUBMIT',
                                            style: StyleElements
                                                .buttonTextStyleSemiBoldBlack);
                                      }
                                    },
                                    listener: (context, state) {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: isActivated == true
                              ? Text("Please fill and save opened tab")
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      isActivated = true;
                                      newList[i].isEdStarted = true;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Add this person"),
                                      SizedBox(width: 5.0),
                                      Icon(
                                        Icons.add,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      )
                : new AppCard(
                    outLineColor: HexColor('#292929'),
                    color: HexColor('#292929'),
                    child: new Column(
                      children: [
                        new Row(
                          children: [
                            Expanded(
                              child: new Text(
                                'Name',
                                style: StyleElements.bookingDetailsTitle,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                'DOB',
                                style: StyleElements.bookingDetailsTitle,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                'Guest Type',
                                style: StyleElements.bookingDetailsTitle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        new Row(
                          children: [
                            Expanded(
                              child: new Text(
                                newList[i].name.toString(),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                newList[i].dob.toString(),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: new Text(
                                customersList[index].name.toString(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        new Row(
                          children: [
                            // onTap: () {
                            //     showAlert(
                            //       context,
                            //       newList[i].name,
                            //       i,
                            //       newList[i].personUniqueID,
                            //       newList,
                            //     );
                            //   },
                            new Container(
                              height: 20.0,
                              width: MediaQuery.of(context).size.width / 6,
                              padding: EdgeInsets.all(2.0),
                              decoration: new BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              //rdelete
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    child: Icon(Icons.done, size: 14),
                                  ),
                                  new Text(
                                    "Added",
                                    style: new TextStyle(fontSize: 10.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ));
      }
    }
    return subList;
  }

  _finalSubmitButton(BuildContext context) {
    return new Container(
      width: 290,
      child: BlocConsumer<EntryBookingBloc, EntryBookingState>(
        builder: (context, state) {
          if (state is CheckingFinalData) {
            return new TextButton(
              style: StyleElements.submitButtonStyle,
              onPressed: () {},
              child: SizedBox(
                height: 28.0,
                width: 28.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              ),
            );
          } else if (state is FinalDataAdded) {
            return Column(
              children: [
                new TextButton(
                  style: StyleElements.submitButtonStyle,
                  child: new Text(
                      "TOTAL " + totalAmount.toString() + " INR, VIEW TICKET",
                      style: StyleElements.buttonTextStyleSemiBold),
                  onPressed: () async {
                    // _openLoadingDialog(context, "Please wait");
                    print(await db!.getEntryBookingDataOne(ticketId));
                    generatePdf(
                        context, await db!.getEntryBookingDataOne(ticketId));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: Text("GO HOME"),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EntryHomePage()),
                        (Route<dynamic> route) => false);
                    BlocProvider.of<EntryBookingBloc>(context).add(Refresh());
                  },
                )
              ],
            );
          }
          return new TextButton(
            style: StyleElements.submitButtonStyle,
            child: new Text(
              "SUBMIT",
              style: StyleElements.buttonTextStyleSemiBold,
            ),
            onPressed: () {
              setState(() {
                isEnabled = false;
              });

              allCount == 0
                  ? BlocProvider.of<EntryBookingBloc>(context)
                      .add(SaveEntryTicket(
                      ticketId: ticketId.toString(),
                      finalAmount: totalAmount.toString(),
                      customerlist: newList,
                      vehicleDetailsSelected: vehicleDetailsSelected,
                      cameraDetailsSelected: cameraDetailsSelected,
                      place: placeController.text,
                    ))
                  : _showToast(context, "Please add all member(s) details.",
                      Toast.LENGTH_SHORT);
            },
          );
        },
        listener: (context, state) async {
          if (state is FinalDataAdded) {
            submitted = true;
            setState(() {});
            //context.read<UploadEntryBookingBloc>().add(RefreshEntryBookings());
          }
          if (state is ProceedToViewTicket) {
            print("procees to view ticket");

            print("Ticket Id offline- " + ticketId.toString());
          } else if (state is FinalDataNotAdded) {
            _showToast(context, state.msg.toString(), Toast.LENGTH_SHORT);
          }
        },
      ),
    );
  }
  //-----------------------------------------------------------

  Widget showCircular(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }) as Widget;
  }

  Future<void> _selectDate(
      BuildContext context, int i, TextEditingController dobController,
      [String? cutomerType]) async {
    DateTime now = DateTime.now();
    if (cutomerType == "Children") {
      final date = DateTime.now();
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(date.year - 11, 2, 1),
        firstDate: new DateTime(date.year - 11, 2, 1),
        lastDate: new DateTime(date.year - 5, 2, 1),
      );
      if (picked != null && picked != now) {
        dobController.text = g.format(DateTime.parse(picked.toString()));
      }
    } else {
      final date = DateTime.now();
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(date.year - 30, 1, 1),
        firstDate: new DateTime(date.year - 55, 1, 1),
        lastDate: new DateTime(date.year - 12, 1, 1),
      );
      if (picked != null && picked != now) {
        dobController.text = g.format(DateTime.parse(picked.toString()));
      }
    }
  }

  Future<void> _selectpassportDate(
      BuildContext context, int i, TextEditingController dobController) async {
    DateTime now = DateTime.now();

    final date = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: new DateTime(date.year + 100, 1, 1),
    );
    if (picked != null) {
      dobController.text = g.format(DateTime.parse(picked.toString()));
    }
  }

  Future<void> _selectvisaDate(
    BuildContext context,
    int i,
    TextEditingController dobController,
  ) async {
    DateTime now = DateTime.now();

    final date = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: new DateTime(date.year + 100, 1, 1),
    );
    if (picked != null) {
      dobController.text = g.format(DateTime.parse(picked.toString()));
    }
  }

//-----------------------------------------------------------
  void showAlert(BuildContext context, String? name, int i,
      String? personUniqueID, List<GuestInfoModel> newList) {
    print("delete - " + newList[i].name.toString());
    AlertDialog alertDialog = AlertDialog(
      title: Text("Delete Guest"),
      content: Text("Are you sure you wnat to delete this guest " +
          name.toString() +
          " ?"),
      actions: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              deleted = true;
              Navigator.pop(context);
              //alldelete
              print("Guest Deletion - Initalized");
              BlocProvider.of<BlocUpdateGuest>(context).add(
                DoDelete(
                  personUniqueID: personUniqueID,
                  index: i,
                  list: newList,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

//-----------------------------------------------------------
  // _openLoadingDialog(BuildContext context, String? s) {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     barrierColor: Colors.black38,
  //     builder: (BuildContext context) {
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           SizedBox(
  //             width: 20.0,
  //             height: 20.0,
  //             child: CircularProgressIndicator(
  //                 color: Colors.white, strokeWidth: 3),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // _buildGuestAddList(
  //     BuildContext context, PartialBookingDataTwoReceived state) {
  //   List<Widget> guestAddList = [];
  //   for (int i = 0; i < customersList.length; i++) {
  //     if (customersList[i].status == true) {
  //       guestAddList.add(Padding(
  //         padding: const EdgeInsets.all(12.0),
  //         child: Column(
  //           children: [
  //             InkWell(
  //               child: new Row(
  //                 children: [
  //                   Expanded(
  //                     flex: 1,
  //                     child: Text("1"),
  //                   ),
  //                   Expanded(
  //                     flex: 4,
  //                     child: Text("Indian"),
  //                   ),
  //                   Expanded(
  //                     flex: 1,
  //                     child: Text("1 Person"),
  //                   ),
  //                 ],
  //               ),
  //               onTap: () {
  //                 new Column(
  //                   children: innerList(context, i, state),
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       ));
  //     }
  //   }
  //   return guestAddList;
  // }
  //-----------------------------------------------------------
  _showToast(BuildContext context, String s, Toast length) {
    Fluttertoast.showToast(
      toastLength: length,
      msg: s,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }

  void showAlertTwo(BuildContext context, String? name, int i,
      String? personUniqueID, List<GuestInfoModel> list) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Delete Guest"),
      content: Text("Are you sure you wnat to delete this guest ?"),
      actions: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              deleted = true;
              Navigator.pop(context);
              //alldelete
              print("Guest Deletion - Initalized");
              BlocProvider.of<BlocRoomUpdateGuest>(context)
                  .add(DoDeleteRoomGuest(
                personUniqueID: personUniqueID,
                list: newList,
                i: i,
              ));
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void checkStatus() async {
    vehicleInfo = await db!.getVehicleInformation();
    buildSeatList(context);
    addToVehicleList(context);
    addToCameraList(context);
  }

  _showPicker(BuildContext context, TextEditingController idproofController,
      String type) {
    showModalBottomSheet(
        context: context,
        builder: (dialogContext) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.photo_camera, color: Colors.white),
                    title: new Text('Camera'),
                    onTap: () {
                      Navigator.of(context).pop();
                      _imgFromCamera(context, idproofController, type);
                    },
                  ),
                  new ListTile(
                      leading:
                          new Icon(Icons.photo_library, color: Colors.white),
                      title: new Text('Gallery'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _imgFromGallery(context, idproofController, type);
                      }),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _imgFromCamera(BuildContext context,
      TextEditingController idproofController, String type) async {
    cameraState = true;
    try {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(
          source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
      if (pickedFile != null) {
        idproofController.text = pickedFile.path.split('/').last.toString();
        if (type == "id") {
          path = pickedFile.path;
        }
        if (type == "visa") {
          visapath = pickedFile.path;
        }
        if (type == "passport") {
          passportPath = pickedFile.path;
        }

        cameraState = false;
      } else {
        _showToast(context, "No Image Detected", Toast.LENGTH_SHORT);
        cameraState = false;
      }
    } catch (e) {
      _showToast(context, e.toString(), Toast.LENGTH_SHORT);
      cameraState = false;
    }
  }

  Future<void> _imgFromGallery(BuildContext context,
      TextEditingController idproofController, String type) async {
    cameraState = true;
    try {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50,
      );
      if (pickedFile != null) {
        idproofController.text = pickedFile.path.split('/').last.toString();

        if (type == "id") {
          path = pickedFile.path;
        }
        if (type == "visa") {
          visapath = pickedFile.path;
        }
        if (type == "passport") {
          passportPath = pickedFile.path;
        }
        cameraState = false;
      } else {
        _showToast(context, "No Image Detected", Toast.LENGTH_SHORT);
        cameraState = false;
      }
    } catch (e) {
      _showToast(context, e.toString(), Toast.LENGTH_SHORT);
    }
  }

  //generate entry ticket
  generatePdf(
      BuildContext context, List<Map<dynamic, dynamic>> detailsList) async {
    termsAndConditions = await db!.getTermsAndConditionsOffline();
    print("data||" + termsAndConditions[0]['tcValue']);
    final font = await rootBundle.load("assets/times-new-roman.ttf");
    final ttf = pw.Font.ttf(font);
    final fontOne =
        await rootBundle.load("assets/times-new-roman-grassetto.ttf");
    final ttfBold = pw.Font.ttf(fontOne);
    final forestLogoBlack = pw.MemoryImage(
      (await rootBundle.load('assets/forest_logo_black.jpg'))
          .buffer
          .asUint8List(),
    );
    final foundationLogo2 = pw.MemoryImage(
      (await rootBundle.load('assets/foundation_logo_2.jpg'))
          .buffer
          .asUint8List(),
    );
    final logoTr2 = pw.MemoryImage(
      (await rootBundle.load('assets/logo_tr_2.jpg')).buffer.asUint8List(),
    );
    var ticketAndAmount = pw.TextStyle(
      font: ttfBold,
      fontSize: 12,
    );
    var titleAndEntrance = pw.TextStyle(
      font: ttfBold,
      fontSize: 10,
    );
    var header = pw.TextStyle(
      font: ttfBold,
      fontSize: 8,
    );
    var cell = pw.TextStyle(
      font: ttf,
      fontSize: 8,
    );
    var terms = pw.TextStyle(
      font: ttf,
      fontSize: 6,
    );

    var message = pw.TextStyle(
      font: ttf,
      fontSize: 6,
    );
    final pdf = pw.Document();

    var datas = (newList)
        .map(
          (item) => pw.TableRow(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 0),
                child: pw.Text(
                  item.name!,
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 8,
                  ),
                ),
              ),
              pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 0),
                  child: pw.Text(f.format(DateTime.parse(item.dob!)),
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 8,
                      ))),
              pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 0),
                  child: pw.Text(item.label!,
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 8,
                      ))),
              pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 0),
                  child: pw.Text(item.phoneNumber!,
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 8,
                      ))),
              pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 0),
                  child: pw.Text(
                      f.format(
                          DateTime.parse(DateTime.now().toString()).toLocal()),
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 8,
                      ))),
              pw.Padding(
                padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 4),
                child: pw.SizedBox(
                  height: 55.0,
                  width: 55.0,
                  child: pw.BarcodeWidget(
                    data: jsonEncode({
                      "ticketId": ticketId.toString(),
                      "guestId": item.guestId.toString(),
                      "name": item.name,
                      "dob": item.dob,
                      "type": item.label,
                      "phone": item.phoneNumber,
                    }),
                    barcode: Barcode.qrCode(),
                  ),
                ),

                //...
              )
              //...
            ],
          ),
        )
        .toList();

    datas.insert(
        0,
        pw.TableRow(children: [
          pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 4),
              child: pw.Text("Name",
                  style: pw.TextStyle(
                    font: ttfBold,
                    fontSize: 8,
                  ))),
          pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 4),
              child: pw.Text("Date of birth",
                  style: pw.TextStyle(
                    font: ttfBold,
                    fontSize: 8,
                  ))),
          pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 4),
              child: pw.Text("Type",
                  style: pw.TextStyle(
                    font: ttfBold,
                    fontSize: 8,
                  ))),
          pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 4),
              child: pw.Text("Phone",
                  style: pw.TextStyle(
                    font: ttfBold,
                    fontSize: 8,
                  ))),
          pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 4),
              child: pw.Text("Booking Date",
                  style: pw.TextStyle(
                    font: ttfBold,
                    fontSize: 8,
                  ))),
          pw.Padding(
              padding: pw.EdgeInsets.fromLTRB(8.0, 4, 6, 4),
              child: pw.Text("QR code",
                  style: pw.TextStyle(
                    font: ttfBold,
                    fontSize: 8,
                  ))),
          //...
        ]));
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a5,
          margin: pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return <pw.Widget>[
              new pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    new pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: <pw.Widget>[
                          pw.SizedBox(
                            height: 70.0,
                            width: 70.0,
                            child: pw.Image(forestLogoBlack,
                                fit: pw.BoxFit.contain),
                          ),
                          pw.SizedBox(
                            height: 70.0,
                            width: 70.0,
                            child: pw.Image(foundationLogo2,
                                fit: pw.BoxFit.contain),
                          ),
                          pw.SizedBox(
                            height: 90.0,
                            width: 150.0,
                            child: pw.Image(logoTr2, fit: pw.BoxFit.contain),
                          ),
                          pw.SizedBox(
                            height: 60.0,
                            width: 60.0,
                            child: pw.BarcodeWidget(
                              data: ticketId.toString(),
                              barcode: pw.Barcode.qrCode(),
                            ),
                          ),
                        ]),
                    new pw.SizedBox(height: 40.0),
                    new pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: <pw.Widget>[
                          new pw.Text(
                            // "Ticket Number: 5000510",
                            "Ticket Id: $ticketId",
                            // '',
                            style: ticketAndAmount,
                          ),
                          new pw.Text(
                            "Amount: Rs ${totalAmount.toString()}",
                            style: ticketAndAmount,
                          ),
                        ]),
                    new pw.SizedBox(height: 20.0),
                    pw.Container(
                        child: pw.Table(
                            tableWidth: pw.TableWidth.min,
                            defaultVerticalAlignment:
                                pw.TableCellVerticalAlignment.full,
                            border: pw.TableBorder.all(width: 1.0),
                            children: datas)),
                    // pw.Column(children: [
                    //   new pw.SizedBox(height: 10.0),
                    //   new pw.Table.fromTextArray(
                    //       headerAlignment: pw.Alignment.center,
                    //       cellAlignment: pw.Alignment.center,
                    //       headerStyle: header,
                    //       cellStyle: cell,
                    //       headers: [
                    //         'Name',
                    //         'Date of birth',
                    //         'Gender',
                    //         'Type',
                    //         'Booking Date',
                    //         'QR code'
                    //       ],
                    //       data: newList.map((e) {
                    //         return [
                    //           e.name,
                    //           e.dob!,
                    //           'N/A',
                    //           e.label,
                    //           f.format(DateTime.parse(DateTime.now().toString())
                    //               .toLocal()),
                    //           SizedBox(
                    //             height: 60.0,
                    //             width: 60.0,
                    //             child: BarcodeWidget(
                    //               data: ticketId.toString(),
                    //               barcode: Barcode.qrCode(),
                    //             ),
                    //           ),
                    //         ];
                    //       }).toList()),
                    // ]),
                    new pw.SizedBox(height: 10.0),
                    vehicleDetailsSelected.length == 0
                        ? pw.SizedBox.shrink()
                        : new pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: <pw.Widget>[
                                new pw.Text(
                                  "Vehicle Information",
                                  //nowhere
                                  style: titleAndEntrance,
                                ),
                              ]),
                    new pw.SizedBox(height: 10.0),
                    vehicleDetailsSelected.length == 0
                        ? pw.SizedBox.shrink()
                        : new pw.Table.fromTextArray(
                            headerAlignment: pw.Alignment.center,
                            cellAlignment: pw.Alignment.center,
                            headerStyle: header,
                            tableWidth: pw.TableWidth.min,
                            cellStyle: cell,
                            headers: [
                              'Vehicle',
                              'Vehicle Number',
                              'Charge',
                            ],
                            data: vehicleDetailsSelected.map((e) {
                              return [
                                e.type,
                                e.vehicleNumber,
                                e.amount,
                              ];
                            }).toList()),
                  ]),
              new pw.SizedBox(height: 10.0),
              cameraDetailsSelected.length == 0
                  ? pw.SizedBox.shrink()
                  : new pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                          new pw.Text(
                            "Camera Information",
                            //nowhere
                            style: titleAndEntrance,
                          ),
                        ]),
              cameraDetailsSelected.length == 0
                  ? pw.SizedBox.shrink()
                  : pw.Column(children: [
                      new pw.SizedBox(height: 10.0),
                      new pw.Table.fromTextArray(
                          headerAlignment: pw.Alignment.center,
                          cellAlignment: pw.Alignment.center,
                          tableWidth: pw.TableWidth.min,
                          headerStyle: header,
                          cellStyle: cell,
                          headers: [
                            'Camaera Type',
                            'Charge',
                          ],
                          data: cameraDetailsSelected.map((e) {
                            return [
                              e.type,
                              e.amount,
                            ];
                          }).toList()),
                    ]),
              new pw.SizedBox(height: 15.0),
              new pw.Column(
                children: <pw.Widget>[
                  new pw.Row(
                    children: [
                      new pw.Text(
                          "*This is not a valid ticket. This ticket is generated under test environment. Money is not deducted from your account. Booking will be enabled soon",
                          style: message),
                    ],
                  ),
                  new pw.Row(
                    children: [
                      new pw.Text(
                        "*This is an auto generated ticket",
                        style: message,
                      ),
                    ],
                  ),
                  new pw.Row(
                    children: [
                      new pw.Text(
                        "*Helpline number: +91 94963 33873",
                        style: message,
                      ),
                    ],
                  ),
                ],
              ),
            ];
          }),
    );
    // try {
    //   termsAndConditions[0]['tcValue'] == null
    //       ? {}
    //       : pdf.addPage(
    //           pw.MultiPage(
    //               maxPages: termsAndConditions[0]['tcValue'] == "" ? 1 : 20,
    //               pageFormat: PdfPageFormat.a5,
    //               margin: pw.EdgeInsets.all(20),
    //               build: (pw.Context context) {
    //                 return <pw.Widget>[
    //                   pw.Column(children: <pw.Widget>[
    //                     new pw.Row(children: [
    //                       new pw.Text(
    //                         'Terms & Conditions',
    //                         style: terms,
    //                       )
    //                     ]),
    //                     pw.SizedBox(height: 20.0),
    //                     new pw.Text(
    //                       termsAndConditions[0]['tcValue'],
    //                       style: terms,
    //                     ),
    //                   ])
    //                 ];
    //               }),
    //         );
    // } catch (e) {
    //   print(e);
    // }
    // try {
    //   termsAndConditions[0]['tcValue'] == null
    //       ? {}
    //       : pdf.addPage(
    //           pw.MultiPage(
    //               pageFormat: PdfPageFormat.a5,
    //               margin: pw.EdgeInsets.all(20),
    //               build: (pw.Context context) {
    //                 return <pw.Widget>[
    //                   pw.Column(children: <pw.Widget>[
    //                     new pw.Row(children: [
    //                       new pw.Text(
    //                         'Booking & Cancellation Policy',
    //                         style: terms,
    //                       )
    //                     ]),
    //                     pw.SizedBox(height: 20.0),
    //                     new pw.Row(children: [
    //                       new pw.Flexible(
    //                         child: new pw.Text(
    //                           termsAndConditions[0]['canValue'],

    //                           // '',
    //                           style: terms,
    //                         ),
    //                       ),
    //                     ])
    //                   ])
    //                 ];
    //               }),
    //         );
    // } catch (e) {
    //   print(e);
    // }
    ticketName = "ticket_" + ObjectId().toString() + ".pdf";
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;
    File file = File(appDocumentsPath + "/" + ticketName.toString());
    await file.writeAsBytes(await pdf.save());

    try {
      await OpenFile.open(file.path);
      print("opening file ${file.path}");
    } catch (e) {
      print(e.toString());
    }
  }
}

class InnerListIndividual {
  String? name, label;
  int? count, number;
  bool? isAdded, status;
  Widget? fields;
  InnerListIndividual(
      {this.count,
      this.isAdded,
      this.label,
      this.name,
      this.number,
      this.fields,
      this.status});
}

class InduvicalSelection {
  bool? status;
  InduvicalSelection({this.status});
}

class AddedPerson {
  int? number;
  AddedPerson({this.number});
}

class Counter with ChangeNotifier {
  String? _gender = "Male";

  String? get gender => _gender;

  void changeValue(newValue) {
    _gender = newValue;
    notifyListeners();
  }
}
