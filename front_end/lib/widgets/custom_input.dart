import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String? label;
  final String? hintText;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final FocusNode? focusNode;
  final Icon? iconData;
  final bool obscuredText;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  CustomInput(
      {this.validator,
      this.focusNode,
      required this.obscuredText,
      this.hintText,
      this.label,
      this.onChanged,
      this.onSubmitted,
      this.iconData,
      required this.textInputAction});

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    bool obsText = widget.obscuredText;
    TextInputAction textInputAction = widget.textInputAction;

    return TextFormField(
      validator: widget.validator,
      focusNode: widget.focusNode,
      textInputAction: textInputAction,
      obscureText: obsText,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: widget.iconData,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 22.0,
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 75.0),
        border: OutlineInputBorder(
          gapPadding: 3.0,
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(width: 2.0, color: Colors.orange),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 3.0,
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(width: 2.0, color: Colors.orange),
        ),
      ),
    );
  }
}
