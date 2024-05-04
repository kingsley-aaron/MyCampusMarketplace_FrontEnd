import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/theme.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import 'package:mycampusmarketplace/Views/appBar.dart';
import 'package:mycampusmarketplace/main.dart' as m;
import 'package:mycampusmarketplace/theme.dart';

class ExpandedUser extends StatefulWidget {
  final User user;

  ExpandedUser({Key? key, required this.user}) : super(key: key);

  @override
  _ExpandedUserState createState() => _ExpandedUserState();
}

class _ExpandedUserState extends State<ExpandedUser> {
  final UserClient userClient = UserClient();


  @override
  Widget build(BuildContext context) {
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
              '${widget.user.lastName}, ${widget.user.firstName}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Student ID: ${widget.user.studentID}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Student Email: ${widget.user.studentEmail}',
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

