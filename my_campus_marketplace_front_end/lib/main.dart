import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import 'package:mycampusmarketplace/Views/loginview.dart';
import 'Views/mainMenu.dart';
import 'Views/adminMain.dart';
import 'package:mycampusmarketplace/homeview.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

final UserClient client = new UserClient();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Signup Page',
      theme: ThemeData(
        hintColor: Color.fromARGB(219, 240, 193, 178),
        focusColor: Color.fromARGB(219, 240, 193, 178),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(219, 240, 193, 178)),
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // Using initState to perform actions when the widget is inserted into the widget tree
  void initState() {
    super.initState();
    // Using a Timer to navigate to LoginSignupPage after a delay
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        // Check if the widget is still in the tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => LoginSignupPage()), // Navigate to LoginPage
        );
      }
    });
  }

// Building the UI of the SplashScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Displaying a background image
          OverflowBox(
            // Making the image slightly larger than the screen to hide the watermark
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height *
                1.1, // Adjust the multiplier as needed
            maxHeight: MediaQuery.of(context).size.height *
                1.1, // Adjust the multiplier as needed
            child: Image.asset(
              // I think it looks good
              'assets/images/myCampusMarket.png',
              fit: BoxFit
                  .cover, // Cover ensures the image covers the screen area without distortion
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'My Campus Marketplace', // App's name or any other text you want to display
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .white, // Choose a color that contrasts with the background
                ),
              ),
              SizedBox(
                  height: 20), // Space between text and the progress indicator
              CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}
