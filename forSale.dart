import 'package:flutter/material.dart';
import 'expandedSale.dart';
import 'myListings.dart';

void main() {
  runApp(ForSaleApp());
}

class ForSaleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Campus Marketplace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ForSale(),
    );
  }
}

class ForSale extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Item 1',
      'condition': 'New',
      'price': '\$100',
      'description': 'A great item to purchase.'
    },
    {
      'name': 'Item 2',
      'condition': 'Used',
      'price': '\$50',
      'description': 'Some wear and tear visible.'
    },
    {
      'name': 'Item 3',
      'condition': 'new',
      'price': '\$60',
      'description': 'Brand new baseball bat.'
    },
    {
      'name': 'Item 4',
      'condition': 'Used',
      'price': '\$50',
      'description': 'Some wear and tear visible.'
    },
    {
      'name': 'Item 5',
      'condition': 'Used',
      'price': '\$50',
      'description': 'Some wear and tear visible.'
    }
    //replace with data from database
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Campus Marketplace')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Welcome, User'), // Replace User with your actual username
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
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          var item = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpandedSale(item: item),
                ),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    // This container is a placeholder for your item's image
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue[900]!, Colors.blue[200]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(Icons.image, size: 50), // Placeholder icon
                    ),
                    SizedBox(width: 16),
                    // This column contains the item's name, condition, and price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(item['name'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('Condition: ${item['condition']}',
                              style: TextStyle(fontSize: 16)),
                          Text('Price: ${item['price']}',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
