import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/config.dart';

import '../../../bloc/programs/programsevent.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(0.0),
            // child: Image.asset(
            //   "assets/logo_tr_2.jpg",
            //   fit: BoxFit.contain,
            // ),
            child: Center(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    "PERIYAR",
                    style: StyleElements.heading,
                  ),
                  new Text(
                    "TIGER RESERVE",
                    style: StyleElements.subheading,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.qr_code_2,
          //   ),
          //   title: Text("Scan Tickets"),
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.app_registration,
          //   ),
          //   title: Text("Previous Bookings"),
          // ),
          ListTile(
            onTap: () {
              context.read<ProgramsBloc>().add(
                    DoLogout(context: context),
                  );
            },
            leading: Icon(
              Icons.logout,
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
