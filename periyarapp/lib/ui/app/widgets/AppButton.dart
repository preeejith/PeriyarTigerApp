import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final Widget child;
  final Function function;
  AppButton({required this.child, required this.function});
  _AppButton createState() => _AppButton();
}

class _AppButton extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return new TextButton(
        onPressed: () {
        },
        child: widget.child);
  }
}
