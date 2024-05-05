import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/main.dart' as m;
import 'expandedSale.dart';
import 'package:mycampusmarketplace/Views/adminAppBar.dart';

class AdminItems extends StatefulWidget {
  final String userName;
  List<Item> items = List.empty();

  AdminItems({required this.userName, required this.items});

  ItemClient itemClient = m.itemClient;

  @override
  State<AdminItems> createState() => _AdminItemsState(userName, items);
}

class _AdminItemsState extends State<AdminItems> {
  _AdminItemsState(userName, items);

  late String userName = widget.userName;
  late List<Item> items = widget.items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAdminAppBar(
        userName: userName,
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
                        builder: (context) => ExpandedSale(
                          item: item,
                          username: userName,
                        ),
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
                              image: DecorationImage(
                                image: NetworkImage(item.itemImage),
                                fit: BoxFit.cover,
                              ),
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
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Condition: ${item.itemCondition}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Price: ${item.itemPrice}',
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
  runApp(AdminItems(userName: "User", items: List.empty()));
}
