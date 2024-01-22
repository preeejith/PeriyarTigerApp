import 'package:flutter/material.dart';

class AppCard extends StatefulWidget {
  final Widget child;
  final Color color, outLineColor;
  AppCard(
      {required this.child, required this.color, required this.outLineColor});
  _AppCard createState() => _AppCard();
}

class _AppCard extends State<AppCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0, bottom: 20.0),
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        border: Border.all(color: widget.outLineColor, width: 1),
        color: widget.color,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [BoxShadow(color: Colors.black)],
      ),
      child: widget.child,
    );
  }
}
