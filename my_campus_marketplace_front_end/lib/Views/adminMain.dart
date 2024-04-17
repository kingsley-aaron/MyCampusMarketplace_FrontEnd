import 'listItem.dart';
import '../main.dart' as m;
import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/views/loginview.dart';
import 'adminUsers.dart';
import 'adminItems.dart';

class AdminHome extends StatefulWidget {
  final String userName;

  AdminHome({required this.userName});

  @override
  State<AdminHome> createState() => _AdminHomeState(userName);
}

class _AdminHomeState extends State<AdminHome> {
  _AdminHomeState(userName);
  late String userName = widget.userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('My Campus Marketplace'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Welcome, $userName'),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'signOut') {
                      _logout();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'MCM Admin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminItems(
                            userName: userName,
                          ),
                        ),
                      );
                    },
                    child: const Text('Items'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to For Sale screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminUsers(
                            userName: userName,
                          ),
                        ),
                      );
                    },
                    child: const Text('Users'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    // Calling the logout function
    String logoutResponse = await m.client.logout();

    if (logoutResponse == "Success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginSignupPage()),
      );
    } else {
      _showErrorDialog(logoutResponse);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminHome(userName: "User"),
  ));
}
