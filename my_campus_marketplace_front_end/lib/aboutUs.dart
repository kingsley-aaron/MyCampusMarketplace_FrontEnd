import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'About Our App:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set text color to white
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This app is designed to help students buy and sell items within our campus community.',
              style: TextStyle(fontSize: 16, color: Colors.white), // Set text color to white
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set text color to white
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Email: example@example.com',
              style: TextStyle(fontSize: 16, color: Colors.white), // Set text color to white
            ),
            Text(
              'Phone: (123) 456-7890',
              style: TextStyle(fontSize: 16, color: Colors.white), // Set text color to white
            ),
          ],
        ),
      ),
    );
  }
}