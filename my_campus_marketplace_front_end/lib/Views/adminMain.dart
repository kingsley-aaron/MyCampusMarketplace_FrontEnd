import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import 'package:mycampusmarketplace/main.dart';
import '../Models/user.dart';
import '../main.dart' as m;
import 'listItem.dart';
import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/views/loginview.dart';
import 'forSale.dart';
import 'myListings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mycampusmarketplace/views/adminItems.dart';
import 'package:mycampusmarketplace/views/adminusers.dart';

class AdminHome extends StatefulWidget {
  final String userName;

  AdminHome({required this.userName});

  ItemClient itemClient = m.itemClient;
  UserClient userClient = m.userClient;

  @override
  State<AdminHome> createState() => _AdminHomeState(userName);
}

class _AdminHomeState extends State<AdminHome> {
  _AdminHomeState(userName);
  late String userName = widget.userName;

  List<Item> items = List.empty();
  List<User> users = List.empty();

  void getItems() {
    setState(() {
      widget.itemClient
          .getForSaleItems(m.userClient.getSessionState(),
              condition: ["new", "likenew"],
              minPrice: 30,
              maxPrice: 1000,
              orderBy: ["Items.ItemPrice", "-Items.ItemName"])
          .then((response) => onGetItemsSuccess(response));
    });
  }

  void onGetItemsSuccess(List<Item>? newItems) {
    setState(() {
      if (newItems != null && newItems.isNotEmpty) {
        items = newItems;
        // Navigate to For Sale screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForSale(userName: userName, items: items),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error")));
      }
    });
  }

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
                            userName: userName, items: items
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
                            userName: userName, users: users
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
    String logoutResponse = await m.userClient.logout();

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
