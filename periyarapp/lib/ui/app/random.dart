import 'package:flutter/material.dart';

class RandomPage extends StatefulWidget {
  _RandomPage createState() => _RandomPage();
}

class _RandomPage extends State<RandomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: new Text("Hello"),),
    );
  }
}
