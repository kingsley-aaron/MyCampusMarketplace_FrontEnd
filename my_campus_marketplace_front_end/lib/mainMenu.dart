import 'package:flutter/material.dart';
import 'loginSignUp.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _logout(context); // Call _logout method on button press
                },
                icon: Icon(Icons.logout), // Icon for logout button
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF3E0), // Lighter color from your custom primary color swatch
              Color(0xFFD38520), // Your custom primary color
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150, // Width of the buttons
                height: 100, // Height of the buttons
                child: ElevatedButton(
                  onPressed: () {
                    // Action to perform when 'For Sale' button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.5), // Translucent white color for button
                  ),
                  child: Text(
                    'For Sale',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Spacing between buttons
              SizedBox(
                width: 150, // Width of the buttons
                height: 100, // Height of the buttons
                child: ElevatedButton(
                  onPressed: () {
                    // Action to perform when 'Wanted' button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.5), // Translucent white color for button
                  ),
                  child: Text(
                    'Wanted',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to handle logout button press
  void _logout(BuildContext context) {
    // Clear the user session
    // You may need to implement this logic based on how your session management is done
    // For example, you may need to clear session variables and navigate back to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginSignupPage()), // Navigate back to the login page
    );
  }
}