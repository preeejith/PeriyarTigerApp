import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/bloc/programs/programsevent.dart';
import 'package:parambikulam/bloc/programs/programsstate.dart';
import 'package:parambikulam/main.dart';
import 'package:parambikulam/utils/helper.dart';

class NoDataFoundPage extends StatelessWidget {
  const NoDataFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? currentBackPressedTime;
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressedTime == null ||
            now.difference(currentBackPressedTime!) > Duration(seconds: 2)) {
          currentBackPressedTime = now;
          Helper.centerToast("Press again to exit from the app");
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("PERIYAR"),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                // state.isOffline ?
                // addToOfflineList(context, state);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => UserProfile(),
                //   ),
                // );
                showAlert(context);
              },
              child: Padding(
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
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wifi_off_outlined,
                size: 46,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "No data found",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Offline data not found, please turn on the\ninternet and download offline data",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    checkInternet(context);
                  },
                  child: Text("RELOAD"))
            ],
          )),
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Logout"),
      content: Text("Would you like to logout from the app ?"),
      actions: [
        BlocListener<ProgramsBloc, ProgramsState>(
          listener: ((context, state) {
            if (state is TokensCleared) {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            }
          }),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: TextButton(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  BlocProvider.of<ProgramsBloc>(context).add(
                    DoLogout(context: context),
                  );

                  // List theDate = await db!.getAllTickets();
                  // print(
                  //     "---------------${theDate.length.toString()}---------------");
                  // for (int i = 0; i < theDate.length; i++) {
                  //   print("------------------------------");
                  //   print(theDate[i]);
                  //   print("------------------------------");
                  // }
                }),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.all(12.0),
        //   child: TextButton(
        //     child: Text(
        //       "Cancel",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     onPressed: () async {
        //       Navigator.pop(context);
        //       clearAll(context);
        //       await db!.deleteTicketTable();
        //     },
        //   ),
        // )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void checkInternet(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Helper.centerToast("Internet not available");
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyApp()));
    }
  }
}
