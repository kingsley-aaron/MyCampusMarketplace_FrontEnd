import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/main.dart' as m;
import 'package:mycampusmarketplace/main.dart';
import 'myListings.dart';
import 'package:mycampusmarketplace/theme.dart';


class ExpandedSale extends StatefulWidget {
  final Item item;


  ExpandedSale({Key? key, required this.item}) : super(key: key);


  @override
  _ExpandedSaleState createState() => _ExpandedSaleState();
}


class _ExpandedSaleState extends State<ExpandedSale> {
  late String sellerEmail = 'Loading...'; // insert value
  final ItemClient itemClient = ItemClient();


  @override
  void initState() {
    super.initState();
    fetchSellerEmail();
  }


  // fetches seller email
  void fetchSellerEmail() async {
    String email = await userClient.getSellerEmailById(widget.item.userId);
    setState(() {
      sellerEmail = email;
    });
  }


  @override
  Widget build(BuildContext context) {
    String formattedPrice = '\$${widget.item.itemPrice.toStringAsFixed(2)}';


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
              widget.item.itemName,
              style: AppTheme.themeData.textTheme.bodyMedium,
            ),
            SizedBox(height: 8.0),
            AspectRatio(
              aspectRatio: 38 / 28,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  widget.item.itemImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: Text(
                        'Image not available',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: Text(
                'Price: $formattedPrice',
                style: AppTheme.themeData.textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Description: ${widget.item.itemDesc}',
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
                    onPressed: () async {
                      String sessionState = m.userClient.getSessionState();
                      String result =
                          await deleteItem(widget.item.itemId, sessionState);
                      if (result == "Success") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Item successfully deleted!")));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(result)));
                      }
                    },
                    child: Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      textStyle: AppTheme.themeData.textTheme.bodyLarge,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implement mark as sold functionality
                    },
                    child: Text('Mark as Sold'),
                    style: ElevatedButton.styleFrom(
                      textStyle: AppTheme.themeData.textTheme.bodyLarge,
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


Future<String> deleteItem(int itemId, String sessionState) async {
  ItemClient itemClient = ItemClient();
  String result = await itemClient.deleteItem(itemId, sessionState);
  return result;
}

