import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      appBar: new AppBar(
          title: new Container(
            child: Text("Hdjsnck"),
          ),
          actions: [
            CircleAvatar(),
          ]),
    );
  }

  body() {
    Container(
      child: Text("dfgfd"),
    );
  }
}
