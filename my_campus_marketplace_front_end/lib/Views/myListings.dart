import 'package:flutter/material.dart';
import 'forSale.dart'; // Importing forSale.dart

class MyListings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Listings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is where your listings will be displayed.'),
            ElevatedButton(
              onPressed: () {
                // Navigate to forSale screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForSale(
                      userName: "User", //Add user context
                    ),
                  ),
                );
              },
              child: Text('Go to For Sale Page'),
            ),
          ],
        ),
      ),
    );
  }
}
