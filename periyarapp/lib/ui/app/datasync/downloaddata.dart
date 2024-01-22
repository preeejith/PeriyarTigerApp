import 'package:flutter/material.dart';

class DownloadDataSync extends StatefulWidget {
  _DownloadDataSync createState() => _DownloadDataSync();
}

class _DownloadDataSync extends State<DownloadDataSync> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Download Offline Data"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
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
          )
        ],
      ),
      body: Container(),
    );
  }
}
