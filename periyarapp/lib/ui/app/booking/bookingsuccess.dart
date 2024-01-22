import 'package:flutter/material.dart';

class BookingSuccess extends StatefulWidget {
  _BookingSuccess createState() => _BookingSuccess();
}

class _BookingSuccess extends State<BookingSuccess> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Booked Ticket"),
        centerTitle: true,
      ),
      body: new Center(
        child: Text("Success")
      ),
    );
  }
}
