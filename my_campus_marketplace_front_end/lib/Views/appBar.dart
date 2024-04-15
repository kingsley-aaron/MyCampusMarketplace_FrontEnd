import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Views/myListings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final VoidCallback onHomePressed;

  CustomAppBar({
    required this.userName,
    required this.onHomePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //title: Text('My Campus Marketplace'),
      actions: [
        IconButton(
          icon: Icon(Icons.home),
          onPressed: onHomePressed,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Welcome, $userName'),
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
                    // Perform sign out
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'myListings',
                    child: Text('My Listings'),
                  ),
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
