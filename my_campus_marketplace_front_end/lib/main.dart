import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/loginSignUp.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Signup Page',
      theme: ThemeData(
        hintColor: Colors.lightBlueAccent, // Light blue accent color
      ),
      home: const SplashScreen(),
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
    // Using a Timer to navigate to MyHomePage after a delay
    Timer(const Duration(seconds: 5), () {
      if (mounted) { // Check if the widget is still in the tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginSignupPage()), // Navigate to LoginPage instead of MyHomePage
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
            minHeight: MediaQuery.of(context).size.height * 1.1, // Adjust the multiplier as needed
            maxHeight: MediaQuery.of(context).size.height * 1.1, // Adjust the multiplier as needed
            child: Image.asset(                                  // I think it looks good
              'assets/images/myCampusMarket.png',  
              fit: BoxFit.cover, // Cover ensures the image covers the screen area without distortion
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'My Campus Marketplace', // App's name or any other text you want to display
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Choose a color that contrasts with the background
                ),
              ),
              SizedBox(height: 20), // Space between text and the progress indicator
              CircularProgressIndicator(),
            ],
          ),
        ],
      ),
    );
  }
}