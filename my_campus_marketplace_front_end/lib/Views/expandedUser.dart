import 'package:flutter/material.dart';
import '../theme.dart';

class ExpandedUser extends StatelessWidget {
  final Map<String, dynamic> user;

  ExpandedUser({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assume the seller's email is stored in the item map with the key 'email'
    String studentEmail = user['email'] ?? ''; // Assuming the key is 'email'

    return Theme(
      data: myTheme, // Provide your theme here
      child: Scaffold(
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
                    'Welcome, ${user['username']}',
                    style: myTheme
                        .textTheme.bodyLarge, // Updated to use theme style
                  ),
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
                        child: Text(
                          'Sign Out',
                          style: myTheme.textTheme
                              .bodyLarge, // Updated to use theme style
                        ),
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
                style: myTheme
                    .textTheme.displayLarge, // Updated to use theme style
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Student ID: ${user['studentId']}',
                  style:
                      myTheme.textTheme.bodyLarge, // Updated to use theme style
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Student Email: $studentEmail',
                  style:
                      myTheme.textTheme.bodyLarge, // Updated to use theme style
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
                      child: Text(
                        'Ban User',
                        style: myTheme
                            .textTheme.labelLarge, // Updated to use theme style
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
