import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parambikulam/bloc/imageupload/blocupload.dart';
import 'package:parambikulam/bloc/imageupload/stateupload.dart';
import 'package:parambikulam/data/models/bookingdetails.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/booking/bookingsummarysecond.dart';
import 'package:parambikulam/ui/app/entrypoint/entrybookinghome.dart';
import 'package:parambikulam/ui/app/reception_aju/homepage.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';
import 'package:parambikulam/utils/helper.dart';
import 'package:parambikulam/utils/pref_manager.dart';

class UploadGuestIdOffline extends StatefulWidget {
  final List? mainProgrammList, decodeProgramme, decodeDetails;
  final BookingDetails? bookingDetails;
  final String? ticket;
  final bool? isOffline;
  final int? indianCount, childrenCount, foreignerCount;
  UploadGuestIdOffline({
    this.mainProgrammList,
    this.decodeDetails,
    this.decodeProgramme,
    this.bookingDetails,
    this.ticket,
    this.indianCount,
    this.foreignerCount,
    this.isOffline,
    this.childrenCount,
  });
  _UploadGuestIdOffline createState() => _UploadGuestIdOffline();
}

class _UploadGuestIdOffline extends State<UploadGuestIdOffline> {
  int? allCount, photoNotUploadedCount = 0;
  List<Customers> customerList = [];
  List<Customers> newCustomerList = [];
  List<Customers> sampleList = [];

  DatabaseHelper? db = DatabaseHelper.instance;
  String? path;
  List? imageUploadList = [];
  List? allList = [];
  @override
  initState() {
    buildList(context, widget.mainProgrammList);
    checkIdProofsAdded(context);
    // getTypeList(context, widget.mainProgrammList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Guests"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
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
          )
        ],
      ),
      body: ListView(
        children: [
          _uploadBody(context),
          allList!.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      // width: MediaQuery.of(context).size.width / 2,
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green[300])),
                          onPressed: () async {
                            print(imageUploadList!.length.toString());
                            if (imageUploadList!.isNotEmpty) {
                              if (imageUploadList!.length == allCount) {
                                addImage(imageUploadList);
                              } else {
                                print(allCount.toString());
                                Helper.centerToast("Please take all id proofs");
                              }
                            } else {
                              Helper.centerToast("No new ID proofs detected");
                            }
                          },
                          child: Text(
                            "Save ID Proofs",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green[300])),
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "ID Proofs Added",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }

  _uploadBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          BlocConsumer<BlocUpload, StateUpload>(
            listener: (context, state) {
              if (state is ProcessingImage) {
                print("Current State is - ProcessingImage");
                // _openLoadingDialog(context, "Uploading");
              } else if (state is ImageUploaded) {
                // allCount = allCount! - 1;
                photoNotUploadedCount = photoNotUploadedCount! - 1;
                print(
                  "remaining photoNotUploadedCount + " +
                      photoNotUploadedCount.toString(),
                );
                Navigator.pop(context);
                // _showToast(context, "ID Proof Uploaded Successfully",
                // Toast.LENGTH_SHORT);
              } else if (state is ImageUploadFailed) {
                setState(() {
                  newCustomerList[state.iCount!].status = false;
                  newCustomerList[state.iCount!].photo = "";
                });
                // _showToast(context, "ID Proof Upload Failed, Please Try Again.",
                //     Toast.LENGTH_SHORT);
                print("Image Upload Failed");
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Container();
            },
          ),

          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: customerList.length,
            itemBuilder: (context, index) {
              return customerList[index].count != 0
                  ? AppCard(
                      outLineColor: HexColor('#292929'),
                      color: HexColor('#292929'),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                (index + 1).toString() + " .",
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                customerList[index].label.toString(),
                              ),
                              Spacer(),
                              Text(
                                customerList[index].count! > 1
                                    ? customerList[index].count.toString() +
                                        " Persons"
                                    : customerList[index].count.toString() +
                                        " Person",
                                // style: StyleElements.bookingDetailsTitle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            // decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.white)),
                            child: Column(
                              children: getPersonsList(context, index),
                            ),
                          ),
                          //  SizedBox(
                          //   height: 20.0,
                          // ),
                        ],
                      ),
                    )
                  : SizedBox.shrink();
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10.0,
              );
            },
          ),
          SizedBox(
            height: 30.0,
          ),
          // widget.bookingDetails!.data!.isVerified == false
          // ? Container(
          //     height: 45.0,
          //     width: 290.0,
          //     child:  TextButton(
          //       style: StyleElements.submitButtonStyle,
          //       child:  Text("SUBMIT",
          //           style: StyleElements.buttonTextStyleSemiBold),
          //       onPressed: () {
          //         // allCount == 0
          //         //     ?
          //         Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => OnlineBookedTicket(
          //               bookingDetails: widget.bookingDetails,
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   )
          // Container(
          //   height: 45.0,
          //   width: 290.0,
          //   child:  TextButton(
          //     style: StyleElements.submitButtonStyle,
          //     // child:  Icon(
          //     //   Icons.arrow_right_alt,
          //     //   color: Colors.white,
          //     // ),
          //     child:  Text(
          //       "VERIFY",
          //       style: StyleElements.buttonTextStyleSemiBold,
          //     ),
          //     onPressed: () async {
          //       // Navigator.pop(context);

          //       // print(
          //       //   "photoNotUploadedCount + " + photoNotUploadedCount.toString(),
          //       // );
          //       // photoNotUploadedCount == 0
          //       //     ? Navigator.pushReplacement(
          //       //         context,
          //       //         MaterialPageRoute(
          //       //           builder: (context) => OnlineBookedTicket(
          //       //             bookingDetails: widget.bookingDetails,
          //       //             previousBooked: false,
          //       //           ),
          //       //         ),
          //       //       )
          //       //     : _showToast(
          //       //         context,
          //       //         "Please upload all guest(s) ID proof(s)",
          //       //         Toast.LENGTH_LONG,
          //       //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  // void _openLoadingDialog(BuildContext context, String s) {
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
  //           SizedBox(
  //             height: 15.0,
  //           ),
  //           Text(s),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showToast(BuildContext context, String s, Toast length) {
    Fluttertoast.showToast(
      toastLength: length,
      msg: s,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0,
    );
  }

  getPersonsList(BuildContext context, int index) {
    List<Widget> personsList = [];
    for (int i = 0; i < newCustomerList.length; i++) {
      //   print("the index $i");
      if (widget.isOffline == true) {
        if (customerList[index].name == widget.decodeDetails![i]['guestType']) {
          if (newCustomerList[i].photo == null) {
            photoNotUploadedCount = photoNotUploadedCount! + 1;
          }
          personsList.add(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage(
                          "assets/bgptrr.png",
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                // bookingDetails.data!.details![0].guest![i].id
                                //       .toString()
                                widget.decodeDetails![i]['name'].toString()),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                // Expanded(
                                //   flex: 2,
                                //   child: bookingDetails.data!.details![0]
                                //               .guest![i].email !=
                                //           null
                                //       ?  Text(
                                //           // newCustomerList[i].id.toString(),
                                //           bookingDetails
                                //               .data!.details![0].guest![i].email
                                //               .toString(),
                                //           style:  TextStyle(fontSize: 10.0),
                                //         )
                                //       :  Text(
                                //           "N/A",
                                //           style:  TextStyle(fontSize: 10.0),
                                //         ),
                                // ),
                                // SizedBox(
                                //   width: 2.0,
                                // ),
                                Expanded(
                                  flex: 2,
                                  child: widget.decodeDetails![0]['phoneno'] !=
                                          null
                                      ? Text(
                                          widget.decodeDetails![0]['phoneno']
                                              .toString(),
                                          style: TextStyle(fontSize: 10.0),
                                        )
                                      : Text(
                                          "N/A",
                                          style: TextStyle(fontSize: 10.0),
                                        ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    widget.decodeDetails![i]['idProof'] != null
                        ? Row(
                            children: [
                              newCustomerList[i].status == false
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          newCustomerList[i].status = true;
                                        });
                                        print("Expanded True");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 12.0,
                                            right: 12.0,
                                            top: 5.0,
                                            bottom: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              color: HexColor("#6A6A6A"),
                                              width: 1.0),
                                        ),
                                        child: Text(
                                          "View ID",
                                          style: TextStyle(fontSize: 10.0),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                width: 15.0,
                              ),
                              // Icon(
                              //   Icons.check_circle_outline,
                              //   size: 15.0,
                              //   color: HexColor("#59AF74"),
                              // ),
                            ],
                          )
                        : newCustomerList[i].photo != null
                            ? Row(
                                children: [
                                  newCustomerList[i].status == false
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              newCustomerList[i].status = true;
                                            });
                                            print(
                                                "Expanded True In Camera Mode");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 12.0,
                                                right: 12.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                  color: HexColor("#6A6A6A"),
                                                  width: 1.0),
                                            ),
                                            child: Text(
                                              "View ID",
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  // SizedBox(width: 15.0),
                                  // InkWell(
                                  //   onTap: () {
                                  //     // getFromCamera(context, i, bookingDetails);
                                  //     print("Opening Camera For Re-Take");
                                  //   },
                                  //   child: Container(
                                  //     padding: EdgeInsets.all(8.0),
                                  //     decoration:  BoxDecoration(
                                  //         borderRadius:
                                  //             BorderRadius.circular(12.0),
                                  //         color: HexColor("#8E8E93")),
                                  //     child:  Icon(
                                  //       Icons.refresh_rounded,
                                  //       size: 15.0,
                                  //     ),
                                  //     //  Icon(
                                  //     //   Icons.camera_alt_rounded,
                                  //     //   color: HexColor("#2E2E2F"),
                                  //     // ),
                                  //   ),
                                  // ),
                                ],
                              )
                            : SizedBox.shrink(),
                    allList!.isEmpty &&
                            widget.decodeDetails![i]['idProof'] == null
                        ? InkWell(
                            onTap: () {
                              _imgFromCamera(context, i,
                                  widget.decodeDetails![i]['guestId']);
                              // _showPicker(
                              //     context, i, widget.decodeDetails![i]['guestId']);
                              // getFromCamera(
                              //     context,
                              //     i,
                              //     widget.mainProgrammList![0]['details'][i]
                              //         ['guestId']);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: HexColor("#8E8E93")),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: HexColor("#2E2E2F"),
                              ),
                            ),
                          )
                        : Icon(
                            Icons.check_circle,
                            color: Colors.green[300],
                          ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                newCustomerList[i].status == true
                    ? widget.decodeDetails![i]['idProof'] != null
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 240,
                                    height: 140,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.file(
                                        File(
                                          widget.decodeDetails![i]['idProof'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //  Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         setState(() {
                              //           newCustomerList[i].status = false;
                              //         });
                              //       },
                              //       child:  Icon(
                              //         Icons.arrow_circle_up_outlined,
                              //         size: 20,
                              //       ),
                              //     )
                              //   ],
                              // ),
                            ],
                          )
                        : newCustomerList[i].photo != null
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 240,
                                        height: 140,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.file(
                                            File(newCustomerList[i].photo!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //  Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () {
                                  //         setState(() {
                                  //           newCustomerList[i].status = false;
                                  //         });
                                  //       },
                                  //       child:  Icon(
                                  //         Icons.arrow_circle_up_outlined,
                                  //         size: 20,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                ],
                              )
                            : SizedBox.shrink()
                    : SizedBox.shrink(),
              ],
            ),
          );
        } else {}
      } else {
        if (customerList[index].name ==
            widget.bookingDetails!.data!.details![0].guest![i].guestType) {
          print("local name : ${customerList[index].name}");
          print(
              "server name : ${widget.bookingDetails!.data!.details![0].guest![i].name}");
          if (newCustomerList[i].photo == null) {
            photoNotUploadedCount = photoNotUploadedCount! + 1;
          }
          personsList.add(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage(
                          "assets/bgptrr.png",
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                // widget.mainProgrammList![0]['details'][i]
                                //         ['name']
                                //     .toString()
                                widget.bookingDetails!.data!.details![0]
                                    .guest![i].name
                                    .toString()),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: widget.bookingDetails!.data!
                                              .details![0].guest![i].phoneno !=
                                          null
                                      ? Text(
                                          widget.bookingDetails!.data!
                                              .details![0].guest![i].phoneno
                                              .toString(),
                                          style: TextStyle(fontSize: 10.0),
                                        )
                                      : Text(
                                          "N/A",
                                          style: TextStyle(fontSize: 10.0),
                                        ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    widget.bookingDetails!.data!.details![0].guest![i]
                                .idproofs !=
                            null
                        ? Row(
                            children: [
                              newCustomerList[i].status == false
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          newCustomerList[i].status = true;
                                        });
                                        print("Expanded True");
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 12.0,
                                            right: 12.0,
                                            top: 5.0,
                                            bottom: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              color: HexColor("#6A6A6A"),
                                              width: 1.0),
                                        ),
                                        child: Text(
                                          "View ID",
                                          style: TextStyle(fontSize: 10.0),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                width: 15.0,
                              ),
                              Icon(
                                Icons.check_circle_outline,
                                size: 15.0,
                                color: HexColor("#59AF74"),
                              ),
                            ],
                          )
                        : newCustomerList[i].photo != null
                            ? Row(
                                children: [
                                  newCustomerList[i].status == false
                                      ? InkWell(
                                          onTap: () {
                                            setState(() {
                                              newCustomerList[i].status = true;
                                            });
                                            print(
                                                "Expanded True In Camera Mode");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 12.0,
                                                right: 12.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                  color: HexColor("#6A6A6A"),
                                                  width: 1.0),
                                            ),
                                            child: Text(
                                              "View ID",
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(width: 15.0),
                                  InkWell(
                                    onTap: () {
                                      // getFromCamera(context, i, bookingDetails);
                                      print("Opening Camera For Re-Take");
                                    },
                                    child: Icon(
                                      Icons.refresh_rounded,
                                      size: 15.0,
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                    InkWell(
                      onTap: () {
                        // _showPicker(
                        //     context,
                        //     i,
                        //     widget.bookingDetails!.data!.details![0].guest![i]
                        //         .id);
                        // getFromCamera(
                        //     context,
                        //     i,
                        //     widget.mainProgrammList![0]['details'][i]
                        //         ['guestId']);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: HexColor("#8E8E93")),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: HexColor("#2E2E2F"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                newCustomerList[i].status == true
                    ? widget.bookingDetails!.data!.details![0].guest![i]
                                .idproofs !=
                            null
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 240,
                                    height: 140,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                        imageUrl: WebClient.imageIp +
                                            widget
                                                .bookingDetails!
                                                .data!
                                                .details![0]
                                                .guest![i]
                                                .idproofs!
                                                .image
                                                .toString(),
                                        placeholder: (context, url) => Center(
                                          child: SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 4,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Icon(Icons.error),
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //  Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         setState(() {
                              //           newCustomerList[i].status = false;
                              //         });
                              //       },
                              //       child:  Icon(
                              //         Icons.arrow_circle_up_outlined,
                              //         size: 20,
                              //       ),
                              //     )
                              //   ],
                              // ),
                            ],
                          )
                        : newCustomerList[i].photo != null
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 240,
                                        height: 140,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: Image.file(
                                            File(newCustomerList[i].photo!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //  Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () {
                                  //         setState(() {
                                  //           newCustomerList[i].status = false;
                                  //         });
                                  //       },
                                  //       child:  Icon(
                                  //         Icons.arrow_circle_up_outlined,
                                  //         size: 20,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                ],
                              )
                            : SizedBox.shrink()
                    : SizedBox.shrink(),
              ],
            ),
          );
        } else {}
      }
    }
    return personsList;
  }

  buildList(BuildContext context, List? mainProgrammList) {
    print(
        "the count indian ${widget.indianCount} + foreigner ${widget.foreignerCount} + children ${widget.childrenCount}");
    customerList.clear();
    customerList = [
      Customers(
        label: "Indian",
        name: "indian",
        count: widget.indianCount,
      ),
      Customers(
        label: "Foreigner",
        name: "foreigner",
        count: widget.foreignerCount,
      ),
      Customers(
        label: "Children",
        name: "children",
        count: widget.childrenCount,
      ),
    ];

    for (int i = 0; i < customerList.length; i++) {
      int j;
      if (customerList[i].count != 0) {
        print("count ${customerList[i].count}");
        for (j = 0; j < int.parse(customerList[i].count.toString()); j++) {
          print(j);
          newCustomerList.add(
            Customers(
              status: false,
              number: j,
              count: customerList[i].count,
              label: customerList[i].label,
              name: customerList[i].name,
            ),
          );
        }
      } else {
        print("equals zero");
      }
    }
    print(newCustomerList.length);
    for (int i = 0; i < newCustomerList.length; i++) {
      print("name $i + ${newCustomerList[i].name}");
    }

    // allCount = newCustomerList.length;
    // var list = newCustomerList.where((element) => element.photo != null);
    for (int i = 0; i < widget.decodeDetails!.length; i++) {
      if (widget.decodeDetails![i]['idProof'] == null) {
        sampleList.add(newCustomerList[i]);
      }
    }
    allCount = sampleList.length;
  }

  // Future<void> getFromCamera(BuildContext context, int i, guestId) async {
  //   try {
  //     final ImagePicker _picker = ImagePicker();
  //     final pickedFile = await _picker.pickImage(
  //       source: ImageSource.gallery,
  //       maxWidth: 1800,
  //       maxHeight: 1800,
  //     );
  //     print("Camera Opened!");

  //     if (pickedFile != null) {
  //       // setState(() {
  //       newCustomerList[i].photo = pickedFile.path;
  //       // File path = pickedFile.readAsBytes();
  //       path = pickedFile.path;

  //       newCustomerList[i].status = true;
  //       // isExpanded = true;
  //       // });
  //       print("This User Id - " + newCustomerList[i].id.toString());
  //       print("Selected Index - " + i.toString());
  //       print("Selected Index - " + newCustomerList[i].name.toString());

  //       allCount = allCount! - 1;
  //       photoNotUploadedCount = photoNotUploadedCount! - 1;

  //       imageUploadList!.add({
  //         "guestId": guestId,
  //         "path": path,
  //         "ticket": widget.ticket,
  //       });

  //       print(imageUploadList);

  //       //   await insertIntoLocalTable(path, guestId);

  //       print("the path is + " + path.toString());
  //     } else {
  //       _showToast(context, "No Image Detected", Toast.LENGTH_SHORT);
  //       print("No Image Detected");
  //     }
  //   } catch (e) {
  //     print("Image Upload Exception - " + e.toString());
  //     _showToast(context, e.toString(), Toast.LENGTH_LONG);
  //   }
  // }

  // insertIntoLocalTable(String? path, guestId) async {
  //   List result = await db!.getSpecificPreviousBookingsUpdate(guestId);
  //   //await db!.updateImage(guestId, path);
  //   var count = await db!
  //       .updateTablePreviousBookingsUpdate(guestId, path, widget.ticket);
  //   print(count);
  //   // if (result.length == 0) {
  //   //   await db!.insertTablePreviousBookingsUpdate(guestId, path, widget.ticket);
  //   //   print("null");
  //   // } else {
  //   //   print("not null");
  //   //   await db!.updateTablePreviousBookingsUpdate(guestId, path, widget.ticket);
  //   // }

  //   print('the update count $result');
  //   Fluttertoast.showToast(
  //     msg:
  //         "Id proof added successfully, it will reflect after syncing data once",
  //     toastLength: Toast.LENGTH_LONG,
  //   );
  //   var list = await db!.getAllPreviousBookingsUpdate();
  //   print(list);
  // }

  // void _showPicker(BuildContext context, int i, param2) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (dialogContext) {
  //         return SafeArea(
  //           child: Container(
  //             child:  Wrap(
  //               children: <Widget>[
  //                  ListTile(
  //                   leading:  Icon(Icons.photo_camera),
  //                   title:  Text('Camera'),
  //                   onTap: () {
  //                     Navigator.of(context).pop();
  //                     _imgFromCamera(context, i, param2);
  //                   },
  //                 ),
  //                  ListTile(
  //                     leading:  Icon(Icons.photo_library),
  //                     title:  Text('Gallery'),
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                       _imgFromGallery(context, i, param2);
  //                     }),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // _imgFromGallery(BuildContext context, int i, param2) async {
  //   try {
  //     final ImagePicker _picker = ImagePicker();
  //     final pickedFile = await _picker.pickImage(
  //       source: ImageSource.gallery,
  //       maxWidth: 1800,
  //       maxHeight: 1800,
  //     );
  //     print("Camera Opened!");

  //     if (pickedFile != null) {
  //       setState(() {
  //         newCustomerList[i].photo = pickedFile.path;
  //         // File path = pickedFile.readAsBytes();
  //         path = pickedFile.path;

  //         newCustomerList[i].status = true;
  //         // isExpanded = true;
  //       });
  //       print("This User Id - " + newCustomerList[i].id.toString());
  //       print("Selected Index - " + i.toString());
  //       print("Selected Index - " + newCustomerList[i].name.toString());

  //       allCount = allCount! - 1;
  //       photoNotUploadedCount = photoNotUploadedCount! - 1;

  //       if (widget.isOffline == true) {
  //         await insertIntoLocalTable(path, param2);
  //       } else {
  //         BlocProvider.of<BlocUpload>(context).add(
  //           GettingImage(
  //             path: path,
  //             isOffline: widget.isOffline,
  //             iCount: i,
  //             idOffline: widget.bookingDetails!.data!.details![i].guest![i].id
  //                 .toString(),
  //           ),
  //         );
  //       }

  //       print("the path is + " + path.toString());
  //     } else {
  //       _showToast(context, "No Image Detected", Toast.LENGTH_SHORT);
  //       print("No Image Detected");
  //     }
  //   } catch (e) {
  //     print("Image Upload Exception - " + e.toString());
  //     _showToast(context, e.toString(), Toast.LENGTH_LONG);
  //   }
  // }

  _imgFromCamera(BuildContext context, int i, guestId) async {
    // try {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      // maxWidth: 1800,
      // maxHeight: 1800,
    );
    print("Camera Opened!");
    if (pickedFile != null) {
      setState(() {
        newCustomerList[i].photo = pickedFile.path;
        // File path = pickedFile.readAsBytes();
        path = pickedFile.path;
        newCustomerList[i].status = true;
        // isExpanded = true;
      });
      print("This User Id - " + newCustomerList[i].id.toString());
      print("Selected Index - " + i.toString());
      print("Selected Index - " + newCustomerList[i].name.toString());

      // if (!imageUploadList!.contains(guestId)) {
      //   imageUploadList!.add({
      //     "guestId": guestId,
      //     "path": path,
      //     "ticket": widget.ticket,
      //   });

      //   print(imageUploadList!.length);
      // } else {
      imageUploadList!.removeWhere((element) => element['guestId'] == guestId);
      imageUploadList!.add({
        "guestId": guestId,
        "path": path,
        "ticket": widget.ticket,
      });

      print(imageUploadList!.length);
      // }
      // imageUploadList = imageUploadList!.toSet().toList();
      print(imageUploadList);

      // allCount = allCount! - 1;
      // photoNotUploadedCount = photoNotUploadedCount! - 1;

      //await insertIntoLocalTable(path, guestId);

      // if (widget.isOffline == true) {
      //   await insertIntoLocalTable(path, param2);
      // }
      //  else {
      //   BlocProvider.of<BlocUpload>(context).add(
      //     GettingImage(
      //         path: path,
      //         isOffline: widget.isOffline,
      //         iCount: i,
      //         // id: bookingDetails,
      //         // pdfId: bookingDetails.data!.payment!.id,
      //         idOffline: widget.bookingDetails!.data!.details![i].guest![i].id
      //             .toString()),
      //   );
      // }

      print("the path is + " + path.toString());
    } else {
      _showToast(context, "No Image Detected", Toast.LENGTH_SHORT);
      print("No Image Detected");
    }
    // } catch (e) {
    //   print("Image Upload Exception - " + e.toString());
    //   _showToast(context, e.toString(), Toast.LENGTH_LONG);
    // }
  }

  void addImage(List? imageUploadList) async {
    for (int i = 0; i < imageUploadList!.length; i++) {
      var count = await db!.insertTablePreviousBookingsUpdate(
          imageUploadList[i]['guestId'], path, imageUploadList[i]['ticketId']);
      print(count);
    }
    var role = await PrefManager.getRole();
    if (role == "Reception") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (role == "Entry Point") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EntryHomePage()));
    }
    Helper.centerToast("Saved successfully");
  }

  void checkIdProofsAdded(BuildContext context) async {
    allList = await db!.getAllPreviousBookingsUpdate();
    print(allList);
    setState(() {});
  }

  // void getTypeList(BuildContext context, List? mainProgrammList) {
  //   for (int i = 0; i < newCustomerList.length; i++) {
  //     for (int k = 0; k < widget.mainProgrammList![0]['details'].length; k++) {
  //       if (newCustomerList[i].name ==
  //           widget.mainProgrammList![0]['details'][i]['guestType']) {
  //         print(newCustomerList[i].name);
  //       }
  //     }
  //   }
  // }
}
