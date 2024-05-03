import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0, // Adjust the elevation for the drop shadow
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
      bodyLarge: TextStyle(
        color: Color.fromARGB(243, 41, 39, 39),
        fontFamily: 'Quicksand',
      ),
      labelLarge: TextStyle(
        fontFamily: 'Quicksand',
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Quicksand',
        color: Color.fromARGB(229, 41, 39, 39),
      ),
      titleMedium: TextStyle(
        fontFamily: 'Quicksand',
        color: Color.fromRGBO(129, 55, 16, 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(223, 5, 40, 27),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Color.fromRGBO(129, 55, 16, 1),
      ),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'Quicksand',
      ),
      contentTextStyle: TextStyle(
        fontFamily: 'Quicksand',
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(color: Colors.white),
    scaffoldBackgroundColor:
        Colors.blue.shade100, // Set scaffold background color
  );

  static TextStyle heading() {
    return TextStyle(
      fontFamily: 'Quicksand',
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }
}
