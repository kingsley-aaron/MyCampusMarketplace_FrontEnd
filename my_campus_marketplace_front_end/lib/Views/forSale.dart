import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/main.dart' as m;
import 'expandedSale.dart';
import 'myListings.dart';

class ForSale extends StatefulWidget {
  final String userName;
  List<Item> items = List.empty();

  ForSale({required this.userName, required this.items});

  ItemClient itemClient = m.itemClient;

  @override
  State<ForSale> createState() => _ForSaleState(userName, items);
}

class _ForSaleState extends State<ForSale> {
  _ForSaleState(userName, items);

  late String userName = widget.userName;
  late List<Item> items = widget.items;

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
                Text(
                  'Welcome, $userName',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Items for Sale',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                String formattedPrice =
                    '\$${item.itemPrice.toStringAsFixed(2)}';
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
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              item.itemImage,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                // returns an image based on stack trace (if not found)
                                return Icon(Icons.image_not_supported,
                                    size: 100, color: Colors.grey);
                              },
                            ),
                          ),

                          SizedBox(width: 16),
                          // This column contains the item's name, condition, and price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item.itemName,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Condition: ${item.itemCondition}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  'Price: $formattedPrice',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
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
  runApp(ForSale(userName: "User", items: List.empty()));
}
