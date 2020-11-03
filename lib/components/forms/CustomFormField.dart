import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText, errorText, initialValue;
  final bool empty;
  final TextInputType keyboardType;
  const CustomFormField(
      {@required this.controller,
      @required this.hintText,
      @required this.initialValue,
      this.errorText = "",
      this.empty = true,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller..text = initialValue,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor),
        ),
      ),
      style: TextStyle(color: Colors.white),
      validator: empty ? null : ((value) => value.isEmpty ? errorText : null),
      keyboardType: keyboardType,
    );
  }
}
