import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/busbloc/busbloc.dart';
import 'package:parambikulam/ui/app/bus/allbusview.dart';

class BusDetailed extends StatefulWidget {
  BusDetailed({Key? key}) : super(key: key);

  @override
  State<BusDetailed> createState() => _BusDetailedState();
}

class _BusDetailedState extends State<BusDetailed> {
  @override
  void initState() {
    context.read<BusBloc>().add(GetBusData(isFilter: false));
    context.read<BusBloc>().add(GetRecentTrips());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // DefaultTabController(
        //   length: 2,
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text("Bus View"),
        // bottom: const TabBar(
        //   tabs: <Widget>[
        //     Tab(
        //       text: "All Buses",
        //     ),
        //     Tab(
        //       text: "Recent Trips",
        //     ),
        //   ],
        // ),
      ),
      body: AllBusView(),
      // TabBarView(
      //   children: [
      //     AllBusView(),
      //     RecentTrips(),
      //   ],
      // )
    );
  }
}
