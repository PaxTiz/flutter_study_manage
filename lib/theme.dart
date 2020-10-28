import 'package:flutter/material.dart';

final theme = ThemeData();

final darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  backgroundColor: Color.fromRGBO(22, 22, 24, 1),
  accentColor: Color.fromRGBO(33, 33, 36, 1),
  hintColor: Colors.orange,
  textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 28,
        fontFamily: "LobsterTwo",
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
        fontFamily: "Lato",
      ),
      headline6: TextStyle(
        color: Colors.white.withOpacity(.5),
        fontWeight: FontWeight.normal,
        fontSize: 18,
        fontFamily: "Lato",
      ),
      bodyText1: TextStyle(
        color: Colors.white.withOpacity(.5),
        fontWeight: FontWeight.normal,
        fontSize: 15,
        fontFamily: "Lato",
      ),
      button: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: "Lato",
      )),
);
