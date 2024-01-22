import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/busbloc/busbloc.dart';

class RecentTrips extends StatefulWidget {
  const RecentTrips({Key? key}) : super(key: key);

  @override
  State<RecentTrips> createState() => _RecentTripsState();
}

class _RecentTripsState extends State<RecentTrips> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusBloc, BusState>(builder: (context, state) {
      if (state is RecentTripsFetched) {
        return ListView.separated(
            padding: EdgeInsets.fromLTRB(14.0, 18.0, 14.0, 0.0),
            itemBuilder: (context, index) {
              return Divider();
            },
            separatorBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bus Name - ${state.list![index]['busName']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Trip Count - ${state.list![index]['tripCount']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Passengers - ${state.list![index]['noOfPassengers']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
            itemCount: state.list!.length);
      }
      if (state is RecentTripsEmpty) {
        return Center(
          child: Text("No recent trips"),
        );
      }
      if (state is RecentTripsNotFetched) {
        return Center(
          child: Text("Somwthing went wrong"),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
