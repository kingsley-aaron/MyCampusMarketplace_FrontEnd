import 'package:flutter/material.dart';

class ExpandedUser extends StatelessWidget {
  final Map<String, dynamic> user;

  ExpandedUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assume the seller's email is stored in the item map with the key 'email'
    String studentEmail = user['email'] ?? ''; // Assuming the key is 'email'

    return Scaffold(
      appBar: AppBar(
        //title: Text(item['name']),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the home screen
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Welcome, User'), // Replace User with your actual username
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'signOut') {
                      // _logOut();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Last name, First initial',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ), 
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Student ID: ${user['studentId']}',
                style: TextStyle(fontSize: 16.0), // Adjust font size here
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Student Email: $studentEmail',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 16.0), // Add some space between text and buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      /*
                      Implement ban functionality here
                      Preferably have button toggle between 'Ban' and 'Unban' for text with confirmation on both
                      */
                    },
                    child: Text('Ban User'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
