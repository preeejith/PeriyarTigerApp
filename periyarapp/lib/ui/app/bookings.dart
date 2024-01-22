import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/bloc/programs/programsevent.dart';
import 'package:parambikulam/bloc/programs/programsstate.dart';

import '../../config.dart';

class Bookings extends StatefulWidget {
  _Bookings createState() => _Bookings();
}

class _Bookings extends State<Bookings> {
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
              title: Text("Bookins"),
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
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new Text("Bookings"),
          ],
        ),
        SizedBox(height: 5.0),
        BlocConsumer<ProgramsBloc, ProgramsState>(
            builder: (context, state) {
              if (state is HomePageDataAvailabale) {
                return new ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.previoousBookingData!.upcoming!.length,
                  itemBuilder: (context, index) {
                    return new ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.previoousBookingData!.upcoming![index]
                          .booking!.length,
                      itemBuilder: (context, index) {
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
                                child: new Image.network(
                                  'https://media.nationalgeographic.org/assets/photos/112/133/086f9ee9-4b97-4ba3-929d-ab0733af4a0e.jpg',
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
                                      .upcoming![index]
                                      .booking![index]
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
                                                    .upcoming![index]
                                                    .booking![index]
                                                    .indian! >
                                                0
                                            ? new Text(
                                                "Indian Adult X " +
                                                    state
                                                        .previoousBookingData!
                                                        .upcoming![index]
                                                        .booking![index]
                                                        .indian
                                                        .toString(),
                                                style: StyleElements
                                                    .listViewSubOne,
                                              )
                                            : SizedBox(),
                                        SizedBox(width: 10.0),
                                        state
                                                    .previoousBookingData!
                                                    .upcoming![index]
                                                    .booking![index]
                                                    .foreignStudent! >
                                                0
                                            ? new Text(
                                                "Foreign Student X " +
                                                    state
                                                        .previoousBookingData!
                                                        .upcoming![index]
                                                        .booking![index]
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
                                                  .upcoming![index]
                                                  .booking![index]
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
                                                  .upcoming![index]
                                                  .booking![index]
                                                  .slotDetail!
                                                  .startTime
                                                  .toString() +
                                              " - " +
                                              state
                                                  .previoousBookingData!
                                                  .upcoming![index]
                                                  .booking![index]
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
