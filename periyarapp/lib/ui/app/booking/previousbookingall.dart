import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/bloc/programs/programsevent.dart';
import 'package:parambikulam/bloc/programs/programsstate.dart';
import 'package:parambikulam/data/web_client.dart';

import '../../../config.dart';

class PreviousBookingAll extends StatefulWidget {
  _PreviousBookingAll createState() => _PreviousBookingAll();
}

class _PreviousBookingAll extends State<PreviousBookingAll> {
  final f = new DateFormat('MMMM dd, yyyy');
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProgramsBloc>(context).add(GetPrograms(isOffline: false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgramsBloc, ProgramsState>(
      builder: (context, state) {
        if (state is HomePageDataAvailabale) {
          return new Scaffold(
            appBar: new AppBar(
              title: Text("Previous Booking"),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: _previousBooking(context),
                ),
              ),
            ),
          );
        } else {
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
        }
      },
      listener: (context, state) {},
    );
  }

  _previousBooking(BuildContext context) {
    return new Column(
      children: [
        SizedBox(height: 5.0),
        BlocConsumer<ProgramsBloc, ProgramsState>(
            builder: (context, state) {
              if (state is HomePageDataAvailabale) {
                return new ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.previoousBookingData!.upcoming!.length,
                  itemBuilder: (context, indexUpcoming) {
                    return new ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.previoousBookingData!
                          .upcoming![indexUpcoming].booking!.length,
                      itemBuilder: (context, indexBooking) {
                        return new Container(
                          // decoration: new BoxDecoration(
                          //   border: Border.all(color: Colors.white),
                          // ),
                          height: 60.0,
                          width: MediaQuery.of(context).size.width,
                          child: new Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6.0),
                                child: CachedNetworkImage(
                                  imageUrl: WebClient.imageIp +
                                      state
                                          .previoousBookingData!
                                          .upcoming![indexUpcoming]
                                          .booking![indexBooking]
                                          .programme!
                                          .coverImage
                                          .toString(),
                                  placeholder: (context, url) => Center(
                                    child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        )),
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
                              new SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                  child: new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  new Text(state
                                      .previoousBookingData!
                                      .upcoming![indexUpcoming]
                                      .booking![indexBooking]
                                      .programme!
                                      .progName
                                      .toString()),
                                  Container(
                                    child: new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        state
                                                    .previoousBookingData!
                                                    .upcoming![indexUpcoming]
                                                    .booking![indexBooking]
                                                    .indian! >
                                                0
                                            ? new Text(
                                                "Indian Adult X " +
                                                    state
                                                        .previoousBookingData!
                                                        .upcoming![
                                                            indexUpcoming]
                                                        .booking![indexBooking]
                                                        .indian
                                                        .toString(),
                                                style: StyleElements
                                                    .listViewSubOne,
                                              )
                                            : SizedBox(),
                                        SizedBox(width: 10.0),
                                        state
                                                    .previoousBookingData!
                                                    .upcoming![indexUpcoming]
                                                    .booking![indexBooking]
                                                    .foreignStudent! >
                                                0
                                            ? new Text(
                                                "Foreign Student X " +
                                                    state
                                                        .previoousBookingData!
                                                        .upcoming![
                                                            indexUpcoming]
                                                        .booking![indexBooking]
                                                        .foreignStudent
                                                        .toString(),
                                                style: StyleElements
                                                    .listViewSubOne)
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: new Wrap(
                                      spacing: 5,
                                      runSpacing: 5,
                                      children: [
                                        new Text(
                                          f.format(
                                            DateTime.parse(
                                              state
                                                  .previoousBookingData!
                                                  .upcoming![indexUpcoming]
                                                  .booking![indexBooking]
                                                  .bookingDate
                                                  .toString(),
                                            ),
                                          ),
                                          style: StyleElements
                                              .previousBookingDndTime,
                                        ),
                                        SizedBox(width: 30.0),
                                        new Text(
                                          // t.format(state
                                          //       .previoousBookingData!
                                          //       .upcoming![index]
                                          //       .booking![index]
                                          //       .slotDetail!
                                          //       .startTime
                                          //       .toString() as DateTime)
                                          state
                                                  .previoousBookingData!
                                                  .upcoming![indexUpcoming]
                                                  .booking![indexBooking]
                                                  .slotDetail!
                                                  .startTime
                                                  .toString() +
                                              " - " +
                                              state
                                                  .previoousBookingData!
                                                  .upcoming![indexUpcoming]
                                                  .booking![indexBooking]
                                                  .slotDetail!
                                                  .endTime
                                                  .toString(),
                                          style: StyleElements
                                              .previousBookingDndTime,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return new SizedBox(
                      height: 10.0,
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
            listener: (context, state) {}),
      ],
    );
  }
}
