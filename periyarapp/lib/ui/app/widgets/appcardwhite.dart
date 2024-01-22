import 'package:flutter/material.dart';

class AppCardWhite extends StatefulWidget {
  final Widget child;
  final Color color;
  AppCardWhite({required this.child,required this.color});
  _AppCardWhite createState() => _AppCardWhite();
}

class _AppCardWhite extends State<AppCardWhite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0, bottom: 20.0),
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [BoxShadow(color: Colors.black)],
      ),
      child: widget.child,
    );
  }
}
