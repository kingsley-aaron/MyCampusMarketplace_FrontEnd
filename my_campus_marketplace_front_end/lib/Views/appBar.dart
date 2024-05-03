import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Views/loginview.dart';
import 'package:mycampusmarketplace/Views/myListings.dart';
import 'package:mycampusmarketplace/Views/mainMenu.dart';
import 'package:mycampusmarketplace/theme.dart';
import 'package:mycampusmarketplace/main.dart' as m;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  CustomAppBar({
    required this.userName,
  });

  void _logout(BuildContext context) async {
    // Calling the logout function
    String logoutResponse = await m.userClient.logout();

    if (logoutResponse == "Success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginSignupPage()),
      );
    } else {
      _showErrorDialog(context, logoutResponse);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(userName: userName)),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Text(
                'Welcome, $userName',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                width: 120,
                child: PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  onSelected: (value) {
                    if (value == 'myListings') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyListings(),
                        ),
                      );
                    } else if (value == 'signOut') {
                      _logout(context); // Call logout function
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'myListings',
                      child: Text(
                        'My Listings',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'signOut',
                      child: Text(
                        'Sign Out',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      // Apply the AppBar theme styles
      backgroundColor: AppTheme.themeData.appBarTheme.backgroundColor,
      elevation: AppTheme.themeData.appBarTheme.elevation,
      centerTitle: AppTheme.themeData.appBarTheme.centerTitle,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
