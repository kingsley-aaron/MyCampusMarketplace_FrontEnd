import 'package:flutter/material.dart';
import 'forSale.dart';
import 'listItem.dart';
import 'myListings.dart';
import 'package:mycampusmarketplace/views/loginview.dart';
import 'package:mycampusmarketplace/main.dart' as m;
import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'appBar.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  HomeScreen({required this.userName});

  ItemClient itemClient = m.itemClient;

  @override
  State<HomeScreen> createState() => _HomeScreenState(userName);
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState(this.userName);
  late String userName = widget.userName;

  List<Item> items = List.empty();

  void getItems() {
    setState(() {
      widget.itemClient
          .getForSaleItems(m.userClient.getSessionState())
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
      appBar: CustomAppBar(
        // Use the AppBar widget
        userName: userName,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'My Campus Marketplace',
              style: Theme.of(context).textTheme.titleLarge,
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(223, 5, 40, 27),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      'List New Item',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      getItems(); // Moved outside the child property
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(223, 5, 40, 27),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      'For Sale',
                      style: Theme.of(context).textTheme.labelLarge,
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
    home: HomeScreen(userName: "User"),
  ));
}
