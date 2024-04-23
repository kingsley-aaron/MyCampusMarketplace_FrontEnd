import 'package:flutter/material.dart';
import 'myListings.dart';
import '../theme.dart';

class ExpandedSale extends StatelessWidget {
  final Map<String, dynamic> item;

  ExpandedSale({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assume the seller's email is stored in the item map with the key 'email'
    String sellerEmail = item['email'] ?? ''; // Assuming the key is 'email'

    return Theme(
      data: myTheme, // Provide your theme here
      child: Scaffold(
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
                    'Welcome, User', // Replace User with your actual username
                    style: myTheme
                        .textTheme.bodyLarge, // Updated to use theme style
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
                          style: myTheme.textTheme
                              .bodyLarge, // Updated to use theme style
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'signOut',
                        child: Text(
                          'Sign Out',
                          style: myTheme.textTheme
                              .bodyLarge, // Updated to use theme style
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item['name'],
                style: myTheme
                    .textTheme.displayLarge, // Updated to use theme style
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
                  'Condition: ${item['condition']}',
                  style:
                      myTheme.textTheme.bodyLarge, // Updated to use theme style
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Price: ${item['price']}',
                  style:
                      myTheme.textTheme.bodyLarge, // Updated to use theme style
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Description: ${item['description']}',
                  style:
                      myTheme.textTheme.bodyLarge, // Updated to use theme style
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Seller\'s Email: $sellerEmail',
                  style:
                      myTheme.textTheme.bodyLarge, // Updated to use theme style
                ),
              ),
              SizedBox(height: 16.0), // Add some space between text and buttons
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
                        backgroundColor:
                            myTheme.primaryColor, // Updated to use theme color
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Implement mark as sold functionality
                      },
                      child: Text('Mark as Sold'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            myTheme.primaryColor, // Updated to use theme color
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
