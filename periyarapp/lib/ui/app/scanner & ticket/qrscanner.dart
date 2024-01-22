import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/bloc/programs/programsstate.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/scanner%20&%20ticket/offlineticketdetails.dart';
import 'package:parambikulam/utils/helper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../config.dart';

class QrScanner extends StatefulWidget {
  final bool? isOffline;
  QrScanner({this.isOffline});
  _QrScannerHome createState() => _QrScannerHome();
}

class _QrScannerHome extends State<QrScanner> {
  final _formKey = GlobalKey<FormState>();
  Barcode? result;
  String? scanResult;
  String? url;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final TextEditingController bookingId = TextEditingController();
  DatabaseHelper? db = DatabaseHelper.instance;
  List? ticketDetails, mainProgramList;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // bookingId.text = '1061';
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Scan Online Booking'),
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
      body: SafeArea(
        child: _qrScannerWidgets(),
      ),
    );
  }

  _qrScannerWidgets() {
    return SingleChildScrollView(
      child: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new Column(
          children: [
            _scanner(),
            _scannerFields(),
          ],
        ),
      ),
    );
  }

  _scanner() {
    return new Container(
      height: 400.0,
      width: MediaQuery.of(context).size.width,
      child: _buildQrView(context),
    );
  }

  _buildQrView(BuildContext context) {
    // var scanArea = (MediaQuery.of(context).size.width < 400 ||
    //         MediaQuery.of(context).size.height < 400)
    //     ? 150.0
    //     : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderRadius: 35,
        overlayColor: HexColor("#1F1F1F"),
        borderLength: 40,
        borderWidth: 10,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.stopCamera();
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) async {
      print(scanData.code);
      if (scanData.code!.contains('ticketbyticketpdf')) {
        // setState(() {
        //   result = scanData;
        //   url = result!.code.toString();
        // });
        scanResult = "";
        controller.pauseCamera();
        print("valid qr code");
        List theResult =
            await getFromOffline(scanData.code!.split("=").last, "qr");
        print("moving");
        getAndMove(theResult);

        // if (widget.isOffline != false) {
        //   print("online");
        //   BlocProvider.of<ProgramsBloc>(context).add(
        //       InitialGetBookingDataQr(qrId: scanData.code!.split("=").last));
        // } else {
        //   print("offline");
        //   getFromOffline(scanData.code!.split("=").last, "qr");
        // }
      } else {
        print("not valid qr code");
      }
      // if (url!.contains(
      //         "http://api.parambikulam.org/booking/ticketbyticketpdf?id=") ||
      //     url!.contains(
      //         "https://api.parambikulam.org/booking/ticketbyticketpdf?id=")) {
      //   controller.pauseCamera();
      //   setState(() {
      //     result = scanData;
      //     url = result!.code.toString();
      //   });
      //   scanResult = "";
      //   if (widget.isOffline == false) {
      //     BlocProvider.of<ProgramsBloc>(context)
      //         .add(InitialGetBookingDataQr(qrId: url!.split("=").last));
      //   } else {
      //     // _showToast(context, url.toString(), Toast.LENGTH_LONG);
      //     getFromOffline(url!.split("=").last, "qr");
      //   }

      //   controller.pauseCamera();
      //   Future.delayed(Duration(seconds: 2), () {
      //     controller.resumeCamera();
      //   });
      // } else {
      //   scanResult = "Invalid QR Code";
      // }
    });
  }

  _scannerFields() {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          children: <Widget>[
            scanResult != null
                ? Column(
                    children: [
                      Center(child: new Text(scanResult.toString())),
                      SizedBox(height: 10.0),
                    ],
                  )
                : SizedBox.shrink(),
            new Text('OR Type Booking ID'),
            SizedBox(
              height: 15.0,
            ),
            SizedBox(
              width: 300.0,
              child: new TextFormField(
                textCapitalization: TextCapitalization.words,
                onEditingComplete: () async {
                  List theResult =
                      await getFromOffline(bookingId.text, "number");
                  getAndMove(theResult);
                },
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
                controller: bookingId,
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Enter Booking ID";
                  }
                  return null;
                },
                cursorColor: Colors.black,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  errorStyle: new TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                  hintText: "TICKET NUMBER",
                  hintStyle:
                      new TextStyle(fontSize: 13.0, color: HexColor('#9E9E9E')),
                  filled: true,
                ),
                textInputAction: TextInputAction.go,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: new TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      List theResult =
                          await getFromOffline(bookingId.text, "number");
                      getAndMove(theResult);
                    }
                  },
                  style: StyleElements.submitButtonStyle,
                  child: new BlocConsumer<ProgramsBloc, ProgramsState>(
                    listener: (context, state) async {
                      if (state is LoadedBookingData) {
                        controller?.pauseCamera();
                        print(state.bookingDetails!.data!.isVerified);
                        state.bookingDetails!.data!.isVerified == false
                            ?
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => OnlineBookedTicket(
                            //         bookingDetails: state.bookingDetails,
                            //         isOffline: false,
                            //         previousBooked: false,
                            //       ),
                            //     ),
                            //   )
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OfflineTicketDetails(
                                    onineMainProgrammList: state.bookingDetails,
                                    ticketDetails: ticketDetails,
                                    isOffline: false,
                                    mainProgrammList: mainProgramList,
                                  ),
                                ),
                              ).then((value) => controller!.resumeCamera())
                            :
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => UploadGuestId(
                            //         // idOrNumber: bookingId.text,
                            //         bookingDetails: state.bookingDetails,
                            //         isOffline: false,
                            //       ),
                            //     ),
                            //   );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OfflineTicketDetails(
                                    onineMainProgrammList: state.bookingDetails,
                                    ticketDetails: ticketDetails,
                                    isOffline: false,
                                    mainProgrammList: mainProgramList,
                                  ),
                                ),
                              ).then((value) => controller!.resumeCamera());

                        // var space = await DiskSpace.getFreeDiskSpaceForPath(directory.path);
                      } else if (state is PreviousBookingsDataNotReceived) {
                        //_showToast(context, state.error, Toast.LENGTH_SHORT);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingGetBookingData) {
                        return SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3,
                          ),
                        );
                      } else {
                        return new Text("SUBMIT",
                            style: StyleElements.buttonTextStyleSemiBold);
                      }
                    },
                  )
                  // new Text("SUBMIT",
                  //     style: StyleElements.buttonTextStyleSemiBold),
                  ),
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () {
                controller!.stopCamera();
                controller!.resumeCamera();
                Fluttertoast.showToast(msg: "Camera resumed");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Having trouble?\nTap here to turn camera on",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _showToast(BuildContext context, String s, Toast length) {
  //   Fluttertoast.showToast(
  //     toastLength: length,
  //     msg: s,
  //     gravity: ToastGravity.CENTER,
  //     backgroundColor: Colors.black,
  //     textColor: Colors.white,
  //     fontSize: 12.0,
  //   );
  // }

  getFromOffline(String ticketId, String type) async {
    if (type == "number") {
      print("from number");
      return await db!.getTicketFromLocal(ticketId);
    } else {
      print("from QR code");
      // controller?.stopCamera();
      return await db!.getFromQr(ticketId);
      // print("theResult" + theResult.toString());
    }
  }

  // void finalSubmit() {
  //   if (_formKey.currentState!.validate()) {

  //     // widget.isOffline == false
  //     //     ? BlocProvider.of<ProgramsBloc>(context)
  //     //         .add(InitialGetBookingData(bookingId: bookingId.text))
  //     //     :
  //   }
  // }

  getAndMove(List theResult) async {
    if (theResult.length == 0) {
      Helper.centerToast("Details not found");
      if (await Vibrate.canVibrate) {
        Vibrate.feedback(FeedbackType.medium);
      }
      controller!.resumeCamera();
    } else {
      ticketDetails = json.decode(theResult[0]['ticketDetails']);
      mainProgramList = json.decode(theResult[0]['mainProgramme']);
      List vehiclesList = jsonDecode(theResult[0]['vehicles']);
      List entanceList = jsonDecode(theResult[0]['entranceTickets']);
      print(
          "++++++++++++++++details length ${mainProgramList!.length.toString()}+++++++++++++++++++++");
      mainProgramList!.forEach((element) {
        print(element);
      });
      print("+++++++++++++++++++++++++++++++++++++");
      print(ticketDetails);
      print("camera paused");
      print(mainProgramList![0]['programme'].runtimeType);
      print(theResult[0]['entranceTickets']);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OfflineTicketDetails(
            ticketDetails: ticketDetails,
            isOffline: true,
            mainProgrammList: mainProgramList,
            vehiclesList: vehiclesList,
            entanceList: entanceList,
          ),
        ),
      ).then((value) => controller!.resumeCamera());
    }
  }
}
