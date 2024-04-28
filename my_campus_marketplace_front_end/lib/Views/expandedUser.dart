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
                Text(
                  'Welcome, User',
                  style: Theme.of(context).textTheme.titleMedium,
                ), // Replace User with your actual username
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'signOut') {
                      // _logOut();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'signOut',
                      child: Text('Sign Out',
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Last name, First initial',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Student ID: ${user['studentId']}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Student Email: $studentEmail',
                style: Theme.of(context).textTheme.bodyMedium,
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
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
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
