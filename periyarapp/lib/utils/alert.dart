import 'package:flutter/material.dart';

class Alert {
  static alert(BuildContext context, title, body) {
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        body,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        _okButton(context),
      ],
    );

    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }

  static _okButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("Ok"),
    );
  }
}
