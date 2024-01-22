import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parambikulam/bloc/imageupload/blocupload.dart';
import 'package:parambikulam/bloc/imageupload/eventupload.dart';
import 'package:parambikulam/bloc/imageupload/stateupload.dart';
import 'package:parambikulam/data/models/bookingdetails.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/ui/app/booking/bookingsummarysecond.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';
import 'package:parambikulam/utils/pref_manager.dart';

class UploadGuestId extends StatefulWidget {
  final BookingDetails? bookingDetails;
  final bool? isOffline;
  final List<Map>? offlineData;
  // final String? pdfId;
  UploadGuestId(
      {required this.bookingDetails, this.isOffline, this.offlineData});
  _UploadGuestId createState() => _UploadGuestId();
}

class _UploadGuestId extends State<UploadGuestId> {
  List<Customers> customerList = [];
  List<Customers> newCustomerList = [];
  List offlineMembers = [], list = [], offlineMemberDetails = [];
  int? allCount, photoNotUploadedCount = 0;
  // bool? isExpanded = false;
  String? path;
  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Upload Guest ID"),
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
      body: SingleChildScrollView(
        child: _uploadBody(context, widget.bookingDetails),
      ),
    );
  }

  _uploadBody(BuildContext context, BookingDetails? bookingDetails) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Column(
        children: [
          BlocConsumer<BlocUpload, StateUpload>(
            listener: (context, state) {
              if (state is ProcessingImage) {
                print("Current State is - ProcessingImage");
                _openLoadingDialog(context, "Uploading");
              } else if (state is ImageUploaded) {
                allCount = allCount! - 1;
                photoNotUploadedCount = photoNotUploadedCount! - 1;
                print(
                  "remaining photoNotUploadedCount + " +
                      photoNotUploadedCount.toString(),
                );
                Navigator.pop(context);
                _showToast(context, "ID Proof Uploaded Successfully",
                    Toast.LENGTH_SHORT);
              } else if (state is ImageUploadFailed) {
                setState(() {
                  newCustomerList[state.iCount!].status = false;
                  newCustomerList[state.iCount!].photo = "";
                });
                _showToast(context, "ID Proof Upload Failed, Please Try Again.",
                    Toast.LENGTH_SHORT);
                print("Image Upload Failed");
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Container();
            },
          ),

          new ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: customerList.length,
            itemBuilder: (context, index) {
              return customerList[index].count != 0
                  ? new AppCard(
                      outLineColor: HexColor('#292929'),
                      color: HexColor('#292929'),
                      child: Column(
                        children: [
                          new Row(
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
                              children: getPersonsList(
                                  context, index, bookingDetails),
                            ),
                          ),
                          // new SizedBox(
                          //   height: 20.0,
                          // ),
                        ],
                      ),
                    )
                  : SizedBox.shrink();
            },
            separatorBuilder: (BuildContext context, int index) {
              return new SizedBox(
                height: 5.0,
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
          //     child: new TextButton(
          //       style: StyleElements.submitButtonStyle,
          //       child: new Text("SUBMIT",
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
          //   child: new TextButton(
          //     style: StyleElements.submitButtonStyle,
          //     // child: new Icon(
          //     //   Icons.arrow_right_alt,
          //     //   color: Colors.white,
          //     // ),
          //     child: new Text(
          //       "VERIFY",
          //       style: StyleElements.buttonTextStyleSemiBold,
          //     ),
          //     onPressed: () async {
          //       // Navigator.pop(context);
          //       String file = await getFile();
          //       uploadProof(context, file);
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

  void buildList(BuildContext context, BookingDetails? bookingDetails,
      [List<Map>? offlineData]) {
    customerList.clear();
    widget.isOffline == false
        ? customerList = [
            Customers(
              label: "Indian",
              name: "indian",
              count: bookingDetails!.data!.details![0].indian,
            ),
            Customers(
              label: "Foreigner",
              name: "foreigner",
              count: bookingDetails.data!.details![0].foreigner,
            ),
            Customers(
              label: "Children",
              name: "children",
              count: bookingDetails.data!.details![0].children,
            ),
          ]
        : customerList = [
            Customers(
              label: "Indian",
              name: "indian",
              count: offlineData![0]['indianCount'],
            ),
            Customers(
              label: "Foreigner",
              name: "foreigner",
              count: offlineData[0]['foreignerCount'],
            ),
            Customers(
              label: "Children",
              name: "children",
              count: offlineData[0]['childrenCount'],
            ),
          ];

    for (int i = 0; i < customerList.length; i++) {
      if (customerList[i].count != 0) {
        for (int j = 0; j < customerList[i].count!; j++) {
          newCustomerList.add(
            Customers(
              status: false,
              number: j,
              count: customerList[j].count,
              label: customerList[j].label,
              name: customerList[j].name,
              //-----
              // id: bookingDetails.data!.details![0].guest![j].id.toString(),
              //-----
            ),
          );
          // }
        }
      }
    }
    allCount = newCustomerList.length;
  }

  getPersonsList(
      BuildContext context, int index, BookingDetails? bookingDetails) {
    List<Widget> personsList = [];

    if (widget.isOffline == false) {
      for (int i = 0; i < newCustomerList.length; i++) {
        print(customerList[index].name);
        //---
        // print(bookingDetails!.data!.details![0].guest![i].guestType);
        if (customerList[index].name ==
            bookingDetails!.data!.details![0].guest![i].guestType) {
          //---
          // a.add(customerList[index].name! +
          //     " " +
          //     bookingDetails.data!.details![0].guest![i].guestType! +
          //     " " +
          //     newCustomerList[i].id!);
          //---

          if (newCustomerList[i].photo == null) {
            photoNotUploadedCount = photoNotUploadedCount! + 1;
          }
          personsList.add(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Row(
                  children: [
                    new SizedBox(
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
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(
                                // bookingDetails.data!.details![0].guest![i].id
                                //       .toString()
                                bookingDetails.data!.details![0].guest![i].name
                                    .toString()),
                            SizedBox(
                              height: 5.0,
                            ),
                            new Row(
                              children: [
                                // Expanded(
                                //   flex: 2,
                                //   child: bookingDetails.data!.details![0]
                                //               .guest![i].email !=
                                //           null
                                //       ? new Text(
                                //           // newCustomerList[i].id.toString(),
                                //           bookingDetails
                                //               .data!.details![0].guest![i].email
                                //               .toString(),
                                //           style: new TextStyle(fontSize: 10.0),
                                //         )
                                //       : new Text(
                                //           "N/A",
                                //           style: new TextStyle(fontSize: 10.0),
                                //         ),
                                // ),
                                // SizedBox(
                                //   width: 2.0,
                                // ),
                                Expanded(
                                  flex: 2,
                                  child: bookingDetails.data!.details![0]
                                              .guest![i].phoneno !=
                                          null
                                      ? new Text(
                                          bookingDetails.data!.details![0]
                                              .guest![i].phoneno
                                              .toString(),
                                          style: new TextStyle(fontSize: 10.0),
                                        )
                                      : new Text(
                                          "N/A",
                                          style: new TextStyle(fontSize: 10.0),
                                        ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    bookingDetails.data!.details![0].guest![i].idproofs !=
                                null &&
                            bookingDetails.data!.details![0].guest![i].idproofs!
                                    .image !=
                                null
                        ? new Row(
                            children: [
                              newCustomerList[i].status == false
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          newCustomerList[i].status = true;
                                        });
                                        print("Expanded True");
                                      },
                                      child: new Container(
                                        padding: EdgeInsets.only(
                                            left: 12.0,
                                            right: 12.0,
                                            top: 5.0,
                                            bottom: 5.0),
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              color: HexColor("#6A6A6A"),
                                              width: 1.0),
                                        ),
                                        child: new Text(
                                          "View ID",
                                          style: new TextStyle(fontSize: 10.0),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                width: 15.0,
                              ),
                              new Icon(
                                Icons.check_circle_outline,
                                size: 15.0,
                                color: HexColor("#59AF74"),
                              ),
                            ],
                          )
                        : newCustomerList[i].photo != null
                            ? new Row(
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
                                          child: new Container(
                                            padding: EdgeInsets.only(
                                                left: 12.0,
                                                right: 12.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            decoration: new BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                  color: HexColor("#6A6A6A"),
                                                  width: 1.0),
                                            ),
                                            child: new Text(
                                              "View ID",
                                              style:
                                                  new TextStyle(fontSize: 10.0),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(width: 15.0),
                                  InkWell(
                                    onTap: () {
                                      getFromCamera(context, i, bookingDetails);
                                      print("Opening Camera For Re-Take");
                                    },
                                    child: new Icon(
                                      Icons.refresh_rounded,
                                      size: 15.0,
                                    ),
                                  ),
                                ],
                              )
                            : InkWell(
                                onTap: () {
                                  getFromCamera(context, i, bookingDetails);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: HexColor("#8E8E93")),
                                  child: new Icon(
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
                    ? bookingDetails.data!.details![0].guest![i].idproofs !=
                                null &&
                            bookingDetails.data!.details![0].guest![i].idproofs!
                                    .image !=
                                null
                        ? Column(
                            children: [
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 240,
                                    height: 140,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                        imageUrl: WebClient.imageIp +
                                            bookingDetails.data!.details![0]
                                                .guest![i].idproofs!.image
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
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        newCustomerList[i].status = false;
                                      });
                                    },
                                    child: new Icon(
                                      Icons.arrow_circle_up_outlined,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : newCustomerList[i].photo != null
                            ? Column(
                                children: [
                                  new Row(
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
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            newCustomerList[i].status = false;
                                          });
                                        },
                                        child: new Icon(
                                          Icons.arrow_circle_up_outlined,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox.shrink()
                    : SizedBox.shrink(),
              ],
            ),
          );
          continue;
        } else {}
      }
    } else {
      for (int i = 0; i < newCustomerList.length; i++) {
        print(newCustomerList.length.toString());
        print("the name + ${list[i]['name']}");
        print("${customerList[index].name} && ${list[i]['guestType']}");
        print("phonenumber ${offlineMemberDetails[i]['phoneno']}");
        if (customerList[index].name == list[i]['guestType'].toLowerCase()) {
          print("yes");
          if (newCustomerList[i].photo == null) {
            photoNotUploadedCount = photoNotUploadedCount! + 1;
          }
          personsList.add(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Row(
                  children: [
                    new SizedBox(
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
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(
                                // bookingDetails.data!.details![0].guest![i].id
                                //       .toString()
                                offlineMemberDetails[i]['name'].toString()),
                            SizedBox(
                              height: 5.0,
                            ),
                            new Row(
                              children: [
                                // Expanded(
                                //   flex: 2,
                                //   child: bookingDetails.data!.details![0]
                                //               .guest![i].email !=
                                //           null
                                //       ? new Text(
                                //           // newCustomerList[i].id.toString(),
                                //           bookingDetails
                                //               .data!.details![0].guest![i].email
                                //               .toString(),
                                //           style: new TextStyle(fontSize: 10.0),
                                //         )
                                //       : new Text(
                                //           "N/A",
                                //           style: new TextStyle(fontSize: 10.0),
                                //         ),
                                // ),
                                // SizedBox(
                                //   width: 2.0,
                                // ),
                                Expanded(
                                  flex: 2,
                                  child: offlineMemberDetails[i]['phoneno'] !=
                                          null
                                      ? new Text(
                                          offlineMemberDetails[i]['phoneno']
                                              .toString(),
                                          style: new TextStyle(fontSize: 10.0),
                                        )
                                      : new Text(
                                          "N/A",
                                          style: new TextStyle(fontSize: 10.0),
                                        ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    offlineMemberDetails[i]['image'] != null
                        ? new Row(
                            children: [
                              newCustomerList[i].status == false
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          newCustomerList[i].status = true;
                                        });
                                        print("Expanded True");
                                      },
                                      child: new Container(
                                        padding: EdgeInsets.only(
                                            left: 12.0,
                                            right: 12.0,
                                            top: 5.0,
                                            bottom: 5.0),
                                        decoration: new BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              color: HexColor("#6A6A6A"),
                                              width: 1.0),
                                        ),
                                        child: new Text(
                                          "View ID",
                                          style: new TextStyle(fontSize: 10.0),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                width: 15.0,
                              ),
                              new Icon(
                                Icons.check_circle_outline,
                                size: 15.0,
                                color: HexColor("#59AF74"),
                              ),
                            ],
                          )
                        : newCustomerList[i].photo != null
                            ? new Row(
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
                                          child: new Container(
                                            padding: EdgeInsets.only(
                                                left: 12.0,
                                                right: 12.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            decoration: new BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                  color: HexColor("#6A6A6A"),
                                                  width: 1.0),
                                            ),
                                            child: new Text(
                                              "View ID",
                                              style:
                                                  new TextStyle(fontSize: 10.0),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(width: 15.0),
                                  InkWell(
                                    onTap: () {
                                      // getFromCamera(context, i, bookingDetails);
                                      // print("Opening Camera For Re-Take");
                                    },
                                    child: new Icon(
                                      Icons.refresh_rounded,
                                      size: 15.0,
                                    ),
                                  ),
                                ],
                              )
                            : InkWell(
                                onTap: () {
                                  // getFromCamera(context, i, bookingDetails);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: HexColor("#8E8E93")),
                                  child: new Icon(
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
                    ? offlineMemberDetails[i]['image'] != null
                        ? Column(
                            children: [
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 240,
                                    height: 140,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.file(
                                          File(
                                              offlineMemberDetails[i]['image']),
                                          fit: BoxFit.fill,
                                        )
                                        // child: CachedNetworkImage(
                                        //   imageUrl: WebClient.imageIp +
                                        //       bookingDetails.data!.details![0]
                                        //           .guest![i].idproofs!.image
                                        //           .toString(),
                                        //   placeholder: (context, url) => Center(
                                        //     child: SizedBox(
                                        //       width: 40,
                                        //       height: 40,
                                        //       child: CircularProgressIndicator(
                                        //         color: Colors.white,
                                        //         strokeWidth: 4,
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   errorWidget: (context, url, error) =>
                                        //       Center(
                                        //     child: SizedBox(
                                        //       width: 20,
                                        //       height: 20,
                                        //       child: Icon(Icons.error),
                                        //     ),
                                        //   ),
                                        //   fit: BoxFit.cover,
                                        // ),
                                        ),
                                  ),
                                ],
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        newCustomerList[i].status = false;
                                      });
                                    },
                                    child: new Icon(
                                      Icons.arrow_circle_up_outlined,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : newCustomerList[i].photo != null
                            ? Column(
                                children: [
                                  new Row(
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
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            newCustomerList[i].status = false;
                                          });
                                        },
                                        child: new Icon(
                                          Icons.arrow_circle_up_outlined,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox.shrink()
                    : SizedBox.shrink(),
              ],
            ),
          );

          continue;
        } else {
          print("no");
        }
      }
    }
    // a.forEach((element) {
    //   print(element);
    // });
    return personsList;
  }

  void getTypeList(BuildContext context, BookingDetails? bookingDetails,
      [List<Map>? offlineData]) {
    for (int i = 0; i < newCustomerList.length; i++) {
      if (newCustomerList[i].name ==
          bookingDetails!.data!.details![0].guest![0].guestType) {
        print(newCustomerList[i].name);
      }
    }
  }

  Future<void> getFromCamera(
      BuildContext context, int i, BookingDetails bookingDetails) async {
    print("The Selected Index For Pic Upload - " + i.toString());
    print("Opening Camera in Uploading Guest Page");
    try {
      final ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
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

        BlocProvider.of<BlocUpload>(context).add(
          GettingImage(
              path: path,
              isOffline: widget.isOffline,
              iCount: i,
              id: bookingDetails,
              pdfId: bookingDetails.data!.payment!.id),
        );
        print("the path is + " + path.toString());
      } else {
        _showToast(context, "No Image Detected", Toast.LENGTH_SHORT);
        print("No Image Detected");
      }
    } catch (e) {
      print("Image Upload Exception - " + e.toString());
      _showToast(context, e.toString(), Toast.LENGTH_LONG);
    }
  }

  void _openLoadingDialog(BuildContext context, String s) {
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black38,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 3),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(s),
          ],
        );
      },
    );
  }

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

  void checkStatus() {
    if (widget.isOffline == false) {
      buildList(context, widget.bookingDetails, widget.offlineData);
      getTypeList(context, widget.bookingDetails, widget.offlineData);
    } else {
      print("isOffline");
      offlineMembers = json.decode(widget.offlineData![0]['members']);
      offlineMemberDetails = json.decode(widget.offlineData![0]['newListTwo']);
      print(offlineMemberDetails);
      print("the offline members $offlineMembers");
      print(offlineMemberDetails.length);
      for (int i = 0; i < offlineMemberDetails.length; i++) {
        // if (offlineMembers[i]['value'] != 0) {
        list.add(offlineMemberDetails[i]);
        // }
      }
      // print("offlineMembers.length ${offlineMembers[0]['type']}");
      buildList(context, widget.bookingDetails, widget.offlineData);
      // var newOfflineList = widget.offlineData![0]['members'];
      // print(json.decode(newOfflineList));
      // getTypeList(context, widget.bookingDetails, widget.offlineData);
    }
  }

  void uploadProof(BuildContext context, String file) async {
    try {
      Fluttertoast.showToast(msg: "Uploading");
      var token = await PrefManager.getToken();
      var request = http.MultipartRequest(
          'POST', Uri.parse(WebClient.ip + '/guest/uploadproof'));
      request.fields.addAll({"id": '616bf3806c77174ba19e0b0b'});
      // request.fields.addAll({"ticket": '616bf3806c77174ba19e0b13'});
      request.files.add(await http.MultipartFile.fromPath('image', file));
      request.headers.addAll(
          {"Content-Type": "application/multipart", "token": token ?? ""});
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("File Uploaded - " + await response.stream.bytesToString());
      } else {
        print("length " + response.contentLength.toString());
        print(response.reasonPhrase.toString());
        print("failed " + response.statusCode.toString());
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Image Upload Failed Due To - " + e.toString());
      print("Image Upload Failed Due To - " + e.toString());
    }
  }

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File? file;
    if (result != null) {
      file = File(result.files.single.path.toString());
    }
    print(file.toString());
    return file!.path;
  }
}
