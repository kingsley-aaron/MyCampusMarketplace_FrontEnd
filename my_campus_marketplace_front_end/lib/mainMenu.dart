import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'loginSignUp.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Campus Marketplace')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Welcome, $userName'),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'myListings') {
                      // Navigate to My Listings screen
                    } else if (value == 'signOut') {
                      _logout(context);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'myListings',
                      child: Text('My Listings'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'signOut',
                      child: Text('Sign Out'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to List New Item screen
              },
              child: Text('List New Item'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to For Sale screen
              },
              child: const Text('For Sale'),
            ),
          ],
        ),
      ),
    );
  }
}


    // Method to handle logout button press
    void _logout(BuildContext context) {

      // Make an API call to logout
      //http.post(Uri.parse('http://10.0.2.2/api/logout.php'))
          //.then((response) {
        // Handle the API response here
        //if (response.statusCode == 200) {
          // Logout successful, navigate back to the login page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginSignupPage()),
          );
        //} else {
          // Handle error case
          // Display an error message or perform any other necessary actions
        }
      //}).catchError((error) {
        // Handle error case
        // Display an error message or perform any other necessary actions
      //});
    //}
    
