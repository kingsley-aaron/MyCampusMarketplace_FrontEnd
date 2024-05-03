import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/main.dart' as m;

class MyListings extends StatefulWidget {
  final String userName;

  MyListings({required this.userName});

  @override
  State<MyListings> createState() => _MyListingsState(userName);
}

class _MyListingsState extends State<MyListings> {
  _MyListingsState(this.userName);

  late String userName;
  List<Item> userItems = [];
  ItemClient itemClient = m.itemClient;

  @override
  void initState() {
    super.initState();
    // Call getUserListings when the widget is initialized
    getUserListings();
  }

  void getUserListings() {
    itemClient.fetchUserListings(userName).then((List<Item> listings) {
      setState(() {
        userItems = listings;
      });
    }).catchError((error) {
      print("Error fetching user listings: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Listings',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your listings:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userItems.length,
                itemBuilder: (context, index) {
                  var item = userItems[index];
                  return ListTile(
                    title: Text(item.itemName),
                    subtitle: Text('Price: ${item.itemPrice}'),
                    // Add more details if needed
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
