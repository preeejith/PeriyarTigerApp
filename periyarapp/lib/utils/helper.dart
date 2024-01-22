import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class Helper {
  static checkInternet(BuildContext buildContext) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[300],
          content: Text("Showing offline data",
              style: TextStyle(color: Colors.white)),
        ),
      );
      return true;
    } else {
      ScaffoldMessenger.of(buildContext).showSnackBar(
        SnackBar(
          backgroundColor: HexColor("#68D389"),
          content: Text("Showing online data",
              style: TextStyle(color: Colors.white)),
        ),
      );
      return false;
    }
  }

  static centerToast(
    String content, [
    ToastGravity? gravity,
    Toast? length,
  ]) {
    return Fluttertoast.showToast(
      msg: content,
      gravity: gravity != null ? gravity : ToastGravity.CENTER,
      toastLength: length != null ? length : Toast.LENGTH_SHORT,
    );
  }

  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
