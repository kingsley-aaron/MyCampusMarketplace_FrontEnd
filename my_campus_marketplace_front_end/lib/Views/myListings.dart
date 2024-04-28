import 'package:flutter/material.dart';
import 'forSale.dart'; // Importing forSale.dart

class MyListings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Listings',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is where your listings will be displayed.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to forSale screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForSale(
                      userName: "User", // Add user context
                      items: [], // Add user context, assuming items is a list
                    ),
                  ),
                );
              },
              child: Text(
                'Go to For Sale Page',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
