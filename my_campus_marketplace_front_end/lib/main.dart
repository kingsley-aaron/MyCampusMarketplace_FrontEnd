import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/loginview.dart';
import 'mainMenu.dart';
import 'package:mycampusmarketplace/homeview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement login check here to direct user to correct pages

    return MaterialApp(
      title: 'Login/Signup Page',
      theme: ThemeData(
        hintColor: Colors.lightBlueAccent,
      ),

      // home: isLoggedIn ? HomePage() : LoginSignupPage(),

      home: HomePage(),
    );
  }
}
