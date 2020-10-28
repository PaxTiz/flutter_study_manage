import 'package:flutter/material.dart';

class CustomPage extends StatelessWidget {
  final Widget child;
  const CustomPage({this.child})
      : assert(child != null, "The CustomPage child can't be null");

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(left: 16, right: 16, top: 32),
        children: [child],
      ),
    );
  }
}
