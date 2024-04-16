import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'expandedSale.dart';
import 'adminUsers.dart';

class AdminItems extends StatefulWidget {
  final String userName;

  AdminItems({required this.userName});

  @override
  State<AdminItems> createState() => _AdminItemsState(userName);
}

class _AdminItemsState extends State<AdminItems> {
  _AdminItemsState(userName);

  late String userName = widget.userName;
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
    //replace with item data from database
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('My Campus Marketplace'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Welcome, $userName'),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'signOut') {
                      //_logout();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Items for Sale',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                            child:
                                Icon(Icons.image, size: 50), // Placeholder icon
                          ),
                          SizedBox(width: 16),
                          // This column contains the item's name, condition, and price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Condition: ${item['condition']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Price: ${item['price']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(AdminItems(userName: "User"));
}
