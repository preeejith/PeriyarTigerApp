import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parambikulam/bloc/userprofilebloc/blocprofile.dart';
import 'package:parambikulam/bloc/userprofilebloc/eventprofile.dart';
import 'package:parambikulam/bloc/userprofilebloc/stateprofile.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';

class UserProfile extends StatefulWidget {
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocProfile>(context).add(GetUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Profile'),
          actions: [
            InkWell(
              onTap: () {},
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
        body: BlocConsumer<BlocProfile, StateProfile>(
          builder: (context, state) {
            if (state is UserDataReceived) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Column(
                    children: [
                      AppCard(
                        outLineColor: HexColor('#292929'),
                        color: HexColor('#292929'),
                        child: new Column(
                          children: [
                            new Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: new Text(
                                    'Name',
                                    style: StyleElements.bookingDetailsTitle,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: new Text(
                                    'Role',
                                    style: StyleElements.bookingDetailsTitle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            new Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: new Text("N/A"),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: new Text("N/A"),
                                  // new Text(state.userProfileModel!.userdata![0].user![0].role.toString()),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: new Text(
                                    'Phone',
                                    style: StyleElements.bookingDetailsTitle,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: new Text(
                                    'Email',
                                    style: StyleElements.bookingDetailsTitle,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            new Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: new Text("N/A"),
                                  // new Text(state.userProfileModel!.userdata![0].user![0].phone.toString()),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: new Text("N/A"),
                                  //  new Text(state.userProfileModel!.userdata![0].user![0].email.toString()),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
