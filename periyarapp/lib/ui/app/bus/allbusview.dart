import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/busbloc/busbloc.dart';

class AllBusView extends StatefulWidget {
  const AllBusView({Key? key}) : super(key: key);

  @override
  State<AllBusView> createState() => _AllBusViewState();
}

class _AllBusViewState extends State<AllBusView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BusBloc, BusState>(
      listenWhen: ((previous, current) => current is BusDataNotFound),
      listener: (context, state) {
        if (state is BusDataNotFound) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'Please download offline data');
        }
      },
      buildWhen: ((previous, current) => current is BusDataFetched),
      builder: (context, state) {
        if (state is BusDataFetched) {
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(14.0, 18.0, 14.0, 0.0),
            itemBuilder: ((context, index) {
              // if (index == 0) {
              //   return Column(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             "Bus Details",
              //             style: TextStyle(fontSize: 18),
              //           ),
              //           Icon(CupertinoIcons.bus)
              //         ],
              //       ),
              //       SizedBox(
              //         height: 14.5,
              //       ),
              //       Divider(
              //         thickness: 2.0,
              //       ),
              //       // SizedBox(
              //       //   height: 7.5,
              //       // ),
              //     ],
              //   );
              // }
              // index -= 1;
              return InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              state.busDataList[index].busDetails!
                                          .noOfSeatsDummy ==
                                      0
                                  ? context.read<BusBloc>().add(
                                        UpdateTrip(
                                          index: index,
                                          busId: state.busDataList[index]
                                              .busDetails!.busId,
                                        ),
                                      )
                                  : state.busDataList[index].busDetails!
                                              .status ==
                                          'active'
                                      ? context.read<BusBloc>().add(DisableBus(
                                          index: index,
                                          busId: state.busDataList[index]
                                              .busDetails!.busId))
                                      : context.read<BusBloc>().add(
                                            EnableBus(
                                              index: index,
                                              busId: state.busDataList[index]
                                                  .busDetails!.busId,
                                            ),
                                          );
                            },
                            child: Text(
                              state.busDataList[index].busDetails!
                                          .noOfSeatsDummy ==
                                      0
                                  ? "Reschedule Bus - ${state.busDataList[index].busDetails!.busName}"
                                  : state.busDataList[index].busDetails!
                                              .status ==
                                          'active'
                                      ? "Disable Bus - ${state.busDataList[index].busDetails!.busName}"
                                      : "Enable Bus - ${state.busDataList[index].busDetails!.busName}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          (index + 1).toString() + '.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${state.busDataList[index].busDetails!.busName ?? "N/A"} ${state.busDataList[index].busDetails!.regNo!}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              'Total Seats - ${state.busDataList[index].busDetails!.noOfSeatsDummy!}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Trips - ${state.busDataList[index].busDetails!.tripCount!}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    state.busDataList[index].busDetails!.noOfSeatsDummy == 0
                        ? Text(
                            "Reschedule",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : state.busDataList[index].busDetails!.status ==
                                "active"
                            ? Text(
                                "Active",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                "Disabled",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  ],
                ),
              );
            }),
            separatorBuilder: ((context, index) {
              return SizedBox(
                height: 25.0,
              );
            }),
            itemCount: state.busDataList.length,
          );
        }
        if (state is BusDataNotFound) {
          return Text("Data not fetched");
        }
        //
        return Text("Data fetched");
      },
    );
  }
}
