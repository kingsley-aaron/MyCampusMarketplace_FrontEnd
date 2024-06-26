import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import '../Models/user.dart';
import '../main.dart' as m;
import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/views/loginview.dart';
import 'package:mycampusmarketplace/views/adminItems.dart';
import 'package:mycampusmarketplace/views/adminusers.dart';
import 'package:mycampusmarketplace/Views/adminAppBar.dart';

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
      if (newItems != null) {
        items = newItems;
        // Navigate to For Sale screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminItems(userName: userName, items: items),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error")));
      }
    });
  }

  void getUsers() {
    setState(() {
      widget.userClient
          .getUsers(m.userClient.getSessionState())
          .then((response) => onGetUsersSuccess(response));
    });
  }

  void onGetUsersSuccess(List<User>? newUsers) {
    setState(() {
      if (newUsers != null) {
        users = newUsers;
        // Navigate to users screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminUsers(userName: userName, users: users),
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
      appBar: CustomAdminAppBar(
        userName: userName,
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
                      getItems();
                    },
                    child: const Text('Items'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      getUsers();
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
