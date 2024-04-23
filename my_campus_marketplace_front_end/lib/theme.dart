import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: Colors.green.shade300,
  hintColor: Color.fromRGBO(159, 232, 205, 0.831),
  scaffoldBackgroundColor: Color.fromRGBO(254, 254, 254, 1),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green.shade300,
    elevation: 0,
    centerTitle: true,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      fontFamily: 'Quicksand',
      color: Color.fromARGB(243, 41, 39, 39),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(219, 208, 138, 116),
      ),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    // Add more text styles as needed
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color.fromRGBO(46, 126, 97, 0.932), // Define buttonColor here
    splashColor: Color.fromARGB(219, 240, 193, 178),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
  highlightColor: Color.fromARGB(219, 240, 193, 178), // Define highlight color
);
