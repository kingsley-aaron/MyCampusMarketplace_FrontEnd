import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import 'package:mycampusmarketplace/theme.dart';
import 'myListings.dart';
import '../main.dart';

class ExpandedSale extends StatelessWidget {
  final Item item;

  ExpandedSale({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assume the seller's email is stored in the item map with the key 'email'
    String sellerEmail = ''; // Assuming the key is 'email'
    bool adminCheck = false;

    return Scaffold(
      appBar: AppBar(
        //title: Text(item['name']),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the home screen
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Welcome, User',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'myListings') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyListings(), // Navigate to My Listings screen
                        ),
                      );
                      // Navigate to My Listings screen
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
                        style: AppTheme.themeData.textTheme.titleMedium,
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'signOut',
                      child: Text(
                        'Sign Out',
                        style: AppTheme.themeData.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item.itemName,
              style: AppTheme.themeData.textTheme.bodyMedium,
            ),
            SizedBox(height: 8.0),
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade200,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 100.0),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Condition: ${item.itemCondition}',
                style: AppTheme.themeData.textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: Text(
                'Price: ${item.itemPrice}',
                style: AppTheme.themeData.textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Description: ${item.itemDesc}',
                style: AppTheme.themeData.textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Seller\'s Email: $sellerEmail',
                style: AppTheme.themeData.textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [                
                  ElevatedButton(
                     onPressed: () {
                        // Implement delete functionality
                     },
                     child: Text('Delete'),
                     style: ElevatedButton.styleFrom(
                       textStyle: AppTheme.themeData.textTheme.bodyLarge,
                      ),
                    ),

                  /*
                  visibility for sold button logic here with
                  Visibility(visible: )
                  */
                  Visibility(visible: adminCheck,
                  child:
                    ElevatedButton(
                      onPressed: () {
                      // Implement mark as sold functionality
                      },
                      child: Text('Mark as Sold'),
                      style: ElevatedButton.styleFrom(
                        textStyle: AppTheme.themeData.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
