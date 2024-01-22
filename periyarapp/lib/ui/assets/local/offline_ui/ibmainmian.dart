import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibprogramsofflinebloc.dart';

import 'package:parambikulam/ui/assets/local/offline_ui/ibmainmianpro.dart';


class MyPendingdata2 extends StatefulWidget {
  MyPendingdata2({Key? key}) : super(key: key);

  @override
  State<MyPendingdata2> createState() => _MyPendingdata2State();
}

class _MyPendingdata2State extends State<MyPendingdata2> {
  @override
  Widget build(BuildContext context) {
    //  getAllVhalidata();
    return Scaffold(
      appBar: AppBar(
        title: Text("IB "),
        actions: [],
      ),
      body: BlocProvider<Pendin2OfflineBloc>(
        create: (context) => Pendin2OfflineBloc()..add(GetOffline2Data()),
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: BlocBuilder<Pendin2OfflineBloc, State2Pending>(
                builder: ((context, state) {
                  if (state is OfflineDataReceived2) {
                    return Column(
                      children: [
                        Expanded(child: IBOfflineReport(state: state)),
                      ],
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              )),
        ),
      ),
    );
  }

  Widget text(String text, Color color) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: 16, fontFamily: "SofiaProregular"),
    );
  }
}
