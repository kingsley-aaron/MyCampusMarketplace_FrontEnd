import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/Views/appBar.dart';
import 'package:mycampusmarketplace/main.dart' as m;
import 'expandedSale.dart';

class MyListings extends StatefulWidget {
  final String userName;
  List<Item> items = List.empty();

  MyListings({required this.userName, required this.items});

  ItemClient itemClient = m.itemClient;

  @override
  State<MyListings> createState() => _MyListingsState(userName, items);
}

class _MyListingsState extends State<MyListings> {
  _MyListingsState(userName, items);

  late String userName = widget.userName;
  late List<Item> items = widget.items;

  @override
  void initState() {
    super.initState();
    getItems();
  }

  void getItems() {
    widget.itemClient
        .getForSaleItems(m.userClient.getSessionState(), username: userName)
        .then((response) => onGetItemsSuccess(response));
  }

  void onGetItemsSuccess(List<Item>? newItems) {
    if (newItems != null) {
      setState(() {
        items = newItems;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        userName: userName,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Items for Sale',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontFamily: 'Quicksand'),
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
                        builder: (context) => ExpandedSale(
                          item: item,
                          username: userName,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white, // Set card background color to white
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontFamily: 'Quicksand'),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Condition: ${item.itemCondition}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontFamily: 'Quicksand'),
                                ),
                                Text(
                                  'Price: $formattedPrice',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Color.fromRGBO(129, 55, 16, 1),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Quicksand',
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
