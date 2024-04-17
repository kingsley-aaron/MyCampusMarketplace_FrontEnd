import 'package:mycampusmarketplace/Repositories/userClient.dart';
import '../main.dart' as m;
import 'listItem.dart';
import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/views/loginview.dart';
import 'forSale.dart';
import 'myListings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  HomeScreen({required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState(userName);
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState(userName);
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
                Text(
                  'Welcome, $userName',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 16, // Adjust font size as needed
                    fontWeight:
                        FontWeight.normal, // Adjust font weight as needed
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'myListings') {
                      // Navigate to My Listings screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyListings(),
                        ),
                      );
                    } else if (value == 'signOut') {
                      _logout();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'myListings',
                      child: Text(
                        'My Listings',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 16, // Adjust font size as needed
                          fontWeight:
                              FontWeight.normal, // Adjust font weight as needed
                        ),
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'signOut',
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 16, // Adjust font size as needed
                          fontWeight:
                              FontWeight.normal, // Adjust font weight as needed
                        ),
                      ),
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
              'My Campus Marketplace',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(229, 41, 39, 39),
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
                          builder: (context) => ListItemPage(
                            userName: userName,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'List New Item',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16, // Adjust font size as needed
                        fontWeight:
                            FontWeight.normal, // Adjust font weight as needed
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to For Sale screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForSale(
                            userName: userName,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'For Sale',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16, // Adjust font size as needed
                        fontWeight:
                            FontWeight.normal, // Adjust font weight as needed
                      ),
                    ),
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
    home: HomeScreen(userName: "User"),
  ));
}
