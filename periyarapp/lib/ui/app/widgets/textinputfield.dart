import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TextInputField extends StatefulWidget {
  final String labelText, error;
  // final void Function()? ontap;
  // final bool? isEnabled;
  final TextEditingController textEditingController;
  // final MaskTextInputFormatter formatter;
  final TextInputType textInputType;
  final FormFieldValidator validator;
  TextInputField(
      {required this.labelText,
      required this.error,
      // required this.isEnabled,
      // required this.ontap,
      required this.textEditingController,
      // required this.formatter,
      required this.validator,
      required this.textInputType});
  _TextInputField createState() => _TextInputField();
}

class _TextInputField extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        // readOnly: widget.isEnabled!,
        // onTap: widget.ontap,
        textCapitalization: TextCapitalization.words,
        style: new TextStyle(color: Colors.black),
        controller: widget.textEditingController,
        validator: widget.validator,
        cursorColor: Colors.black,
        keyboardType: widget.textInputType,
        decoration: new InputDecoration(
          errorStyle: new TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          fillColor: Colors.white,
          // labelText: widget.labelText,
          hintText: widget.labelText,
          hintStyle: new TextStyle(fontSize: 12.0, color: HexColor("#9E9E9E")),
          filled: true,
        ),
      ),
    );
  }
}
