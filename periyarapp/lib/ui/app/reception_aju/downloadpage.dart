import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/download/downloadbloc.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Fluttertoast.showToast(msg: 'Please wait');
        return false;
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
            BlocBuilder<DownloadBloc, DownloadState>(
                buildWhen: ((previous, current) =>
                    current is CreateLocalDBState),
                builder: ((context, state) {
                  if (state is CreateLocalDBState) {
                    return ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green[400],
                      ),
                      title: Text("Local database created"),
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
                    title: Text("Creating local database"),
                  );
                })),
            BlocBuilder<DownloadBloc, DownloadState>(
                buildWhen: ((previous, current) =>
                    current is ProgramDataAddedState),
                builder: ((context, state) {
                  if (state is ProgramDataAddedState) {
                    return ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green[400],
                      ),
                      title: Text("Programm data downloaded"),
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
                    title: Text("Downloading programm data"),
                  );
                })),
            BlocBuilder<DownloadBloc, DownloadState>(
                buildWhen: ((previous, current) =>
                    current is SlotDataAddedState),
                builder: ((context, state) {
                  if (state is SlotDataAddedState) {
                    return ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green[400],
                      ),
                      title: Text("Slot data downloaded"),
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
                    title: Text("Downloading slot data"),
                  );
                })),
            BlocBuilder<DownloadBloc, DownloadState>(
                buildWhen: ((previous, current) =>
                    current is BusDataAddedState),
                builder: ((context, state) {
                  if (state is BusDataAddedState) {
                    return ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green[400],
                      ),
                      title: Text("Bus data downloaded"),
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
                    title: Text("Downloading bus data"),
                  );
                })),
            BlocBuilder<DownloadBloc, DownloadState>(
                buildWhen: ((previous, current) =>
                    current is TicketsAddedState),
                builder: ((context, state) {
                  if (state is TicketsAddedState) {
                    return ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green[400],
                      ),
                      title: Text("Tickets downloaded"),
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
                    title: Text("Downloading tickets"),
                  );
                })),
            BlocBuilder<DownloadBloc, DownloadState>(
                builder: ((context, state) {
              if (state is AddingTicketofState) {
                return ListTile(
                  leading: SizedBox.shrink(),
                  title: Text("Adding ticket of #${state.ticketNumber}"),
                );
              }
              return SizedBox.shrink();
            })),
            BlocBuilder<DownloadBloc, DownloadState>(
                buildWhen: ((previous, current) =>
                    current is TermsAndConditionsAddedState),
                builder: ((context, state) {
                  if (state is TermsAndConditionsAddedState) {
                    return ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green[400],
                      ),
                      title: Text("Terms & conditions added"),
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
                    title: Text("Adding terms & conditions"),
                  );
                })),
            BlocBuilder<DownloadBloc, DownloadState>(
                buildWhen: ((previous, current) =>
                    current is TermsAndConditionsAddedState),
                builder: ((context, state) {
                  if (state is TermsAndConditionsAddedState) {
                    return Column(
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
                    );
                  }
                  return ListTile(
                    leading: Icon(Icons.pending_actions),
                    title: Text("Offline data downloaded"),
                  );
                })),
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
