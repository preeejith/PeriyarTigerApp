import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/bloc/programs/programsevent.dart';

class TestEntryHomePage extends StatefulWidget {
  const TestEntryHomePage({Key? key}) : super(key: key);

  @override
  State<TestEntryHomePage> createState() => _TestEntryHomePageState();
}

class _TestEntryHomePageState extends State<TestEntryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parambikulam Entry"),
        actions: [
          InkWell(
              onTap: () async {
                // List<Map<String, dynamic>> entryBookingDetails =
                //     await db!.getEntryBookingData();

                // entryBookingModel = entryBookingDetails
                //     .map((data) => new EntryBookingModel.fromJson(data))
                //     .toList();
                // setState(() {});
              },
              child: new Icon(
                Icons.refresh,
                color: Colors.white,
              )),
          // IconButton(
          //   onPressed: () {
          //     print("yes");
          //     synData(context, state);
          //   },
          //   icon: Icon(Icons.sync_outlined),
          // ),
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
      body: Container(),
    );
  }

  void showAlert(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Logout"),
      content: Text("Would you like to logout from the app ?"),
      actions: [
        Padding(
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
        Padding(
          padding: EdgeInsets.all(12.0),
          child: TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              // Navigator.pop(context);
              // clearAll(context);
              // await db!.deleteTicketTable();
            },
          ),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
