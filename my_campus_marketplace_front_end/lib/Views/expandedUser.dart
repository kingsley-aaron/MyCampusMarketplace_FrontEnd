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
                      _ban(context, widget.user.userID);
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
                  ElevatedButton(
                    onPressed: () {
                      _unban(context, widget.user.userID);
                    },
                    child: Text('Unban User'),
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

  void _ban(BuildContext context, int userID) async {
    String banResponse = await m.userClient.banUser(userID);

    if (banResponse == "Success") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User banned.")));
    } else {
      if (banResponse == "No user ID was provided.") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No user ID was provided.")));
      } else if (banResponse == "Request was formatted incorrectly.") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Request was formatted incorrectly.")));
      } else if (banResponse ==
          "There was an issue with the server. Please try again later.") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "There was an issue with the server. Please try again later.")));
      } else if (banResponse == "You are not authorized to ban users.") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You are not authorized to ban users.")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error.")));
      }
    }
  }

  void _unban(BuildContext context, int userID) async {
    String banResponse = await m.userClient.unbanUser(userID);

    if (banResponse == "Success") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User unbanned.")));
    } else {
      if (banResponse == "No user ID was provided.") {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No user ID was provided.")));
      } else if (banResponse == "Request was formatted incorrectly.") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Request was formatted incorrectly.")));
      } else if (banResponse ==
          "There was an issue with the server. Please try again later.") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "There was an issue with the server. Please try again later.")));
      } else if (banResponse == "You are not authorized to unban users.") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("You are not authorized to unban users.")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error.")));
      }
    }
  }
}
