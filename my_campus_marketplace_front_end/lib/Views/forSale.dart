import 'package:flutter/material.dart';
import 'expandedSale.dart';
import 'myListings.dart';
import '../theme.dart';

class ForSale extends StatefulWidget {
  final String userName;

  ForSale({required this.userName});

  @override
  State<ForSale> createState() => _ForSaleState(userName);
}

class _ForSaleState extends State<ForSale> {
  _ForSaleState(userName);

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
    //replace with data from database
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: myTheme, // Provide your theme here
      child: Scaffold(
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
                      if (value == 'myListings') {
                        // Navigate to My Listings screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyListings(),
                          ),
                        );
                      } else if (value == 'signOut') {
                        //_logout();
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Items for Sale',
                style: myTheme
                    .textTheme.displayLarge, // Updated to use theme style
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
                                  colors: [
                                    Colors.blue[900]!,
                                    Colors.blue[200]!
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Icon(Icons.image,
                                  size: 50), // Placeholder icon
                            ),
                            SizedBox(width: 16),
                            // This column contains the item's name, condition, and price
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item['name'],
                                    style: myTheme.textTheme
                                        .displayMedium, // Updated to use theme style
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Condition: ${item['condition']}',
                                    style: myTheme.textTheme
                                        .titleMedium, // Updated to use theme style
                                  ),
                                  Text(
                                    'Price: ${item['price']}',
                                    style:
                                        myTheme.textTheme.titleMedium?.copyWith(
                                      color: myTheme
                                          .primaryColor, // Adjusted to use primary color
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
      ),
    );
  }
}

void main() {
  runApp(ForSale(userName: "User"));
}
