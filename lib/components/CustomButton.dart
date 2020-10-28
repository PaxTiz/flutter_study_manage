import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function action;
  const CustomButton({this.text, this.action});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).hintColor,
      onPressed: action,
      child: Text(
        text,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}
