import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Views/myListings.dart';
import 'package:mycampusmarketplace/theme.dart';

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
      actions: [
        IconButton(
          icon: Icon(Icons.home),
          onPressed: onHomePressed,
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
                          builder: (context) => MyListings(
                            userName: userName,
                          ),
                        ),
                      );
                    } else if (value == 'signOut') {
                      // Perform sign out
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
