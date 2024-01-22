import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/assets/echoshop/downloadechoproducts.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequestbloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequeststate.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofilebloc.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofilestate.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsbloc.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsstate.dart';

class EchoDownloadPage extends StatefulWidget {
  const EchoDownloadPage({Key? key}) : super(key: key);

  @override
  State<EchoDownloadPage> createState() => _EchoDownloadPageState();
}

class _EchoDownloadPageState extends State<EchoDownloadPage> {
  bool? profiletrue = false;
  bool? assetstrue = false;
  bool? assetsrequesttrue = false;
  bool? producttrue = false;
  bool? productimagetrue = false;
  bool? salesreports = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Fluttertoast.showToast(msg: 'Please wait');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Downloading Offline Data"),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(14.0),
          children: [
            // BlocBuilder<DownloadBloc, DownloadState>(
            //     buildWhen: ((previous, current) =>
            //         current is CreateLocalDBState),
            //     builder: ((context, state) {
            //       if (state is CreateLocalDBState) {
            //         return ListTile(
            //           leading: Icon(
            //             Icons.check_circle,
            //             color: Colors.green[400],
            //           ),
            //           title: Text("Local database created"),
            //         );
            //       }
            //       return ListTile(
            //         leading: SizedBox(
            //           width: 20,
            //           height: 20,
            //           child: CircularProgressIndicator(
            //             color: Colors.white,
            //           ),
            //         ),
            //         title: Text("Creating local database"),
            //       );
            //     })),
            BlocConsumer<GetViewProfileBloc, ViewProfileState>(
              buildWhen: ((previous, current) =>
                  current is ProfileDownloadedSuccess),
              builder: ((context, state) {
                if (state is ProfileDownloadedSuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Profile data downloaded"),
                  );
                }
                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Profile data"),
                );
              }),
              listener: (context, state) {
                if (state is ProfileDownloadedSuccess) {
                  setState(() {
                    profiletrue = true;
                  });
                }
              },
            ),
            BlocConsumer<GetViewallAssetsBloc, ViewallAssetsState>(
              buildWhen: ((previous, current) => current is DownloadedSuccess),
              builder: ((context, state) {
                if (state is DownloadedSuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Assets data downloaded"),
                  );
                }

                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Assets data"),
                );
              }),
              listener: (context, state) {
                if (state is DownloadedSuccess) {
                  setState(() {
                    assetstrue = true;
                  });
                }
              },
            ),
            BlocConsumer<GetViewMyRequestBloc, ViewMyRequestState>(
              buildWhen: ((previous, current) =>
                  current is ViewmyrequestDownloaded),
              builder: ((context, state) {
                if (state is ViewmyrequestDownloaded) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Request data downloaded"),
                  );
                }
                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Request data"),
                );
              }),
              listener: (context, state) {
                if (state is ViewmyrequestDownloaded) {
                  setState(() {
                    assetsrequesttrue = true;
                  });
                }
              },
            ),
            BlocConsumer<GetEchoShopProductBloc, EchoShopProductState>(
              buildWhen: ((previous, current) =>
                  current is ProductDownloadedSuccess),
              builder: ((context, state) {
                if (state is ProductDownloadedSuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("Products downloaded"),
                  );
                }

                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading Products"),
                );
              }),
              listener: (context, state) {
                if (state is ProductDownloadedSuccess) {
                  setState(() {
                    producttrue = true;
                  });
                }
              },
            ),

            BlocConsumer<GetEchoShopProductBloc, EchoShopProductState>(
              buildWhen: ((previous, current) =>
                  current is EchoShopProductDownloadsuccess),
              builder: ((context, state) {
                if (state is EchoShopProductDownloadsuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("ProductsImage downloaded"),
                  );
                }

                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading ProductsImage"),
                );
              }),
              listener: (context, state) {
                if (state is ProductDownloadedSuccess) {
                  setState(() {
                    productimagetrue = true;
                  });
                }
              },
            ),
            BlocConsumer<GetEchoShopProductBloc, EchoShopProductState>(
              buildWhen: ((previous, current) =>
                  current is SalereportDownloadedSuccess),
              builder: ((context, state) {
                if (state is SalereportDownloadedSuccess) {
                  return ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                    ),
                    title: Text("SalesReport downloaded"),
                  );
                }

                return ListTile(
                  leading: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  title: Text("Downloading SalesReport"),
                );
              }),
              listener: (context, state) {
                if (state is ProductDownloadedSuccess) {
                  setState(() {
                    salesreports = true;
                  });
                }
              },
            ),

            // BlocBuilder<DownloadBloc, DownloadState>(
            //     builder: ((context, state) {
            //   if (state is AddingTicketofState) {
            //     return ListTile(
            //       leading: SizedBox.shrink(),
            //       title: Text("Adding ticket of #${state.ticketNumber}"),
            //     );
            //   }
            //   return SizedBox.shrink();
            // })),
            // BlocBuilder<DownloadBloc, DownloadState>(
            //     buildWhen: ((previous, current) =>
            //         current is TermsAndConditionsAddedState),
            //     builder: ((context, state) {
            //       if (state is TermsAndConditionsAddedState) {
            //         return ListTile(
            //           leading: Icon(
            //             Icons.check_circle,
            //             color: Colors.green[400],
            //           ),
            //           title: Text("Terms & conditions added"),
            //         );
            //       }
            //       return ListTile(
            //         leading: SizedBox(
            //           width: 20,
            //           height: 20,
            //           child: CircularProgressIndicator(
            //             color: Colors.white,
            //           ),
            //         ),
            //         title: Text("Adding terms & conditions"),
            //       );
            //     })),

            profiletrue != true ||
                    assetstrue != true ||
                    assetsrequesttrue != true ||
                    producttrue != true ||
                    productimagetrue != true ||
                    salesreports != true
                ? ListTile(
                    leading: Icon(Icons.pending_actions),
                    title: Text("Offline data downloaded"),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.green[400],
                        ),
                        title: Text("Offline data downloaded"),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        onPressed: () {
                          Navigator.pop(context);

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: ((context) => MyApp()),
                          //   ),
                          //);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.home_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "GOTO HOME",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
//  profiletrue! == false &&
//   assetstrue == false &&
//    assetsrequesttrue! = false &&
//    producttrue = false ?

            Divider(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Is there a problem?")],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg:
                              "Press download button to start offline data download");
                    },
                    child: Text(
                      "DOWNLOAD AGAIN",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
