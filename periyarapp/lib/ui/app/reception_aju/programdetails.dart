import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/bloc/programs/programsevent.dart';
import 'package:parambikulam/bloc/programs/programsstate.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/app/booking/bookingsummary.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';

class ProgramDetails extends StatefulWidget {
  final String? image, programId, progName;
  final bool? isCottage, isOffline;
  final List<Map>? vehicleInfo;

  ProgramDetails(
      {this.image,
      this.programId,
      this.progName,
      this.isOffline,
      this.isCottage,
      this.vehicleInfo});
  _ProgramDetails createState() => _ProgramDetails();
}

class _ProgramDetails extends State<ProgramDetails> {
  DatabaseHelper? db = DatabaseHelper.instance;
  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgramsBloc, ProgramsState>(
        buildWhen: (previous, current) =>
            current is GettingProgramDetails ||
            current is IndividualProgramDetailsNotFound ||
            current is IndividualProgramDetails,
        builder: (context, state) {
          if (state is IndividualProgramDetailsNotFound) {
            return Scaffold(
                appBar: new AppBar(
                  title: Text(widget.progName.toString()),
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
                body: Column(
                  children: [
                    Container(
                      height: 170.0,
                      width: MediaQuery.of(context).size.width,
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Column(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  width: 160.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7.0),
                                    child: CachedNetworkImage(
                                      imageUrl: WebClient.imageIp +
                                          widget.image!.toString(),
                                      placeholder: (context, url) => Center(
                                        child: SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
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
                                      width: 60.0,
                                      height: 60.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Container(
                              child: new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  new Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: new Text(
                                              widget.progName.toString(),
                                              style: new TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: new Text(
                                              'Booking Not  Avaliable',
                                              style: new TextStyle(
                                                fontSize: 12.0,
                                                color: HexColor('#68D389'),
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                Colors.grey,
                                              ),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              )),
                                            ),
                                            onPressed: () {},
                                            child: new Text('BOOK NOW',
                                                style: StyleElements
                                                    .buttonTextStyleBooking),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                        child: Text(
                      "Booking Not Available",
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: HexColor('#68D389'),
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  ],
                ));
          }
          if (state is IndividualProgramDetails) {
            return Scaffold(
              appBar: new AppBar(
                title: Text(widget.progName.toString()),
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
              body: programDetialsWidgets(context, state),
            );
          }
          return Container(
            child: SafeArea(
              child: Scaffold(
                body: new Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          // if (state is IndividualProgramDetails) {

          // }
        });
  }

  programDetialsWidgets(BuildContext context, IndividualProgramDetails state) {
    return new SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: new Column(
            children: [
              SizedBox(
                height: 5.0,
              ),
              bookNow(context, state),
              SizedBox(
                height: 20.0,
              ),
              packageData(context, state),
            ],
          ),
        ),
      ),
    );
  }

  bookNow(BuildContext context, IndividualProgramDetails state) {
    return new Container(
      height: 170.0,
      width: MediaQuery.of(context).size.width,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Column(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  width: 160.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: CachedNetworkImage(
                      imageUrl: state.isOffline == true
                          ? WebClient.imageIp +
                              state.offlineData![0]['coverImage']
                          : WebClient.imageIp +
                              state.packageRateData!.data!.coverImage
                                  .toString(),
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(Icons.error),
                        ),
                      ),
                      width: 60.0,
                      height: 60.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  new Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: new Text(
                              state.isOffline == true
                                  ? state.offlineData![0]['progName']
                                  : state.packageRateData!.data!.progName
                                      .toString(),
                              style: new TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          state.isOffline == true
                              ? state.offlineData![0]['started'] == '1'
                                  ? Expanded(
                                      child: new Text(
                                        'Booking Avaliable',
                                        style: new TextStyle(
                                          fontSize: 12.0,
                                          color: HexColor('#68D389'),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: new Text(
                                        'Booking Closed',
                                        style: new TextStyle(
                                          fontSize: 12.0,
                                          color: HexColor('#B4B4B4'),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                              : state.packageRateData!.data!.started == true
                                  ? Expanded(
                                      child: new Text(
                                        'Booking Avaliable',
                                        style: new TextStyle(
                                          fontSize: 12.0,
                                          color: HexColor('#68D389'),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: new Text(
                                        'Booking Closed',
                                        style: new TextStyle(
                                          fontSize: 12.0,
                                          color: HexColor('#B4B4B4'),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                        ],
                      ),
                    ],
                  ),
                  new Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          child: new TextButton(
                            style: StyleElements.submitButtonStyle,
                            onPressed: () {
                              print(
                                  "id ${widget.programId} & title ${widget.progName} & iscottage ${widget.isCottage}");
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingSummary(
                                    // vehicleInfo: widget.vehicleInfo,
                                    // busData: widget.busData,
                                    programId: widget.programId,
                                    title: widget.progName,
                                    isCottage: widget.isCottage,
                                    isOffline: true,
                                    offlineData: state.offlineData,
                                  ),
                                ),
                              );
                            },
                            child: new Text('BOOK NOW',
                                style: StyleElements.buttonTextStyleBooking),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  packageData(BuildContext context, IndividualProgramDetails state) {
    return Column(
      children: [
        Row(
          children: [
            Text("Package Rate"),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        AppCard(
          outLineColor: HexColor('#292929'),
          color: HexColor('#292929'),
          child: Column(
            children: [
              Row(
                children: [Text('Week Days')],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  state.isOffline == true
                      ? state.offlineData![0]['pHindian'] != null &&
                              state.offlineData![0]['pHindian'] != 0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.offlineData![0]['pHindian'].toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Indian',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink()
                      : state.packageRateData!.package![0].holidays!.indian !=
                                  null &&
                              state.packageRateData!.package![0].holidays!
                                      .indian !=
                                  0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.packageRateData!.package![0].indian
                                      .toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Indian',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                  //not connected

                  state.isOffline == true
                      ? state.offlineData![0]['pHforeigner'] != null &&
                              state.offlineData![0]['pHforeigner'] != 0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.offlineData![0]['pHforeigner']
                                      .toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Foreigner',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink()
                      : state.packageRateData!.package![0].foreigner != null &&
                              state.packageRateData!.package![0].foreigner != 0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.packageRateData!.package![0].foreigner
                                      .toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Foreigner',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),

                  state.isOffline == true
                      ? state.offlineData![0]['pHchildren'] != null &&
                              state.offlineData![0]['pHchildren'] != 0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.offlineData![0]['pHchildren']
                                      .toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Children',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink()
                      : state.packageRateData!.package![0].children != null &&
                              state.packageRateData!.package![0].children != 0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.packageRateData!.package![0].children
                                      .toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Children',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        AppCard(
          outLineColor: HexColor('#292929'),
          color: HexColor('#292929'),
          child: Column(
            children: [
              new Row(
                children: [new Text('Holy Days')],
              ),
              SizedBox(
                height: 10.0,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  state.isOffline == true
                      ? state.offlineData![0]['pHindian'] != null &&
                              state.offlineData![0]['pHindian'] != 0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.offlineData![0]['pHindian'].toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Indian',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink()
                      : state.packageRateData!.package![0].holidays!.indian !=
                                  null &&
                              state.packageRateData!.package![0].holidays!
                                      .indian !=
                                  0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.packageRateData!.package![0].holidays!
                                      .indian
                                      .toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Indian',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                  //not connected

                  state.isOffline == true
                      ? state.offlineData![0]['pHforeigner'] != null &&
                              state.offlineData![0]['pHforeigner'] != 0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.offlineData![0]['pHforeigner']
                                      .toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Foreigner',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink()
                      : state.packageRateData!.package![0].holidays!
                                      .foreigner !=
                                  null &&
                              state.packageRateData!.package![0].holidays!
                                      .foreigner !=
                                  0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.packageRateData!.package![0].holidays!
                                      .foreigner
                                      .toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Foreigner',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),

                  state.isOffline == true
                      ? state.offlineData![0]['pHchildren'] != null &&
                              state.offlineData![0]['pHchildren'] != 0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.offlineData![0]['pHchildren']
                                      .toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Children',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink()
                      : state.packageRateData!.package![0].holidays!.children !=
                                  null &&
                              state.packageRateData!.package![0].holidays!
                                      .children !=
                                  0
                          ? new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Text(
                                  state.packageRateData!.package![0].holidays!
                                      .children
                                      .toString(),
                                  style: StyleElements.packageRateSub,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Text(
                                  'Children',
                                  style: StyleElements.packageRateSubText,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        state.isOffline == true
            ? state.offlineData![0]['pEindian'] != null &&
                    state.offlineData![0]['pEforeigner'] != null &&
                    state.offlineData![0]['pEchildren'] != null
                ? new AppCard(
                    outLineColor: HexColor('#292929'),
                    color: HexColor('#292929'),
                    child: Column(
                      children: [
                        new Row(
                          children: [new Text('Extra Per Head')],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            state.offlineData![0]['eIndian'] != 0
                                ? new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        state.offlineData![0]['pEindian']
                                            .toString(),
                                        style: StyleElements.packageRateSub,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      new Text(
                                        'Indian',
                                        style: StyleElements.packageRateSubText,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            state.offlineData![0]['pEforeigner'] != 0
                                ? new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        state.offlineData![0]['pEforeigner']
                                            .toString(),
                                        style: StyleElements.packageRateSub,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      new Text(
                                        'Foreigner',
                                        style: StyleElements.packageRateSubText,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            state.offlineData![0]['pEchildren'] != 0
                                ? new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        state.offlineData![0]['pEchildren']
                                            .toString(),
                                        style: StyleElements.packageRateSub,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      new Text(
                                        'Children',
                                        style: StyleElements.packageRateSubText,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink()
            : state.packageRateData!.package![0].extraperhead!.indian != null &&
                    state.packageRateData!.package![0].extraperhead!
                            .foreigner !=
                        null &&
                    state.packageRateData!.package![0].extraperhead!.children !=
                        null
                ? new AppCard(
                    outLineColor: HexColor('#292929'),
                    color: HexColor('#292929'),
                    child: Column(
                      children: [
                        new Row(
                          children: [new Text('Extra Per Head')],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            state.packageRateData!.package![0].extraperhead!
                                        .indian !=
                                    null
                                ? new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        state.packageRateData!.package![0]
                                            .extraperhead!.indian
                                            .toString(),
                                        style: StyleElements.packageRateSub,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      new Text(
                                        'Indian',
                                        style: StyleElements.packageRateSubText,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            state.packageRateData!.package![0].extraperhead!
                                        .foreigner !=
                                    null
                                ? new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        state.packageRateData!.package![0]
                                            .extraperhead!.indian
                                            .toString(),
                                        style: StyleElements.packageRateSub,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      new Text(
                                        'Foreigner',
                                        style: StyleElements.packageRateSubText,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            state.packageRateData!.package![0].extraperhead!
                                        .children !=
                                    null
                                ? new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      new Text(
                                        state.packageRateData!.package![0]
                                            .extraperhead!.indian
                                            .toString(),
                                        style: StyleElements.packageRateSub,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      new Text(
                                        'Children',
                                        style: StyleElements.packageRateSubText,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
      ],
    );
  }

  void checkInternet() async {
    // if (widget.isOffline == true) {
    // Fluttertoast.showToast(msg: 'showing offline data');
    try {
      // List<ProgrammData> data = await db!.querySpecificRow(widget.programId);

      List<Map> detailsList = await db!.queryAllRowsOne(widget.progName);
      // print('the cover image + ' + data[0].data!.progName.toString());
      // print(detailsList);

      BlocProvider.of<ProgramsBloc>(context).add(
        GetProgramDetails(
          id: widget.programId,
          isOffline: widget.isOffline,
          offlineData: detailsList,
        ),
      );
    } catch (e) {
      print(e);
    }
    // } else {
    //   BlocProvider.of<ProgramsBloc>(context).add(
    //       GetProgramDetails(id: widget.programId, isOffline: widget.isOffline));
    // }
  }
}
