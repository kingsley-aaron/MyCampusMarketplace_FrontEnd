import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/Views/editListingScreen.dart';
import 'package:mycampusmarketplace/main.dart' as m;
import 'myListings.dart';
import 'package:mycampusmarketplace/theme.dart';

class AdminExpandedSale extends StatefulWidget {
  final Item item;
  final String userName;

  AdminExpandedSale({Key? key, required this.item, required this.userName}) : super(key: key);

  @override
  _ExpandedSaleState createState() => _ExpandedSaleState();
}

class _ExpandedSaleState extends State<AdminExpandedSale> {
  late String userName = widget.userName;
  late String sellerEmail = 'Loading...'; // insert value
  final ItemClient itemClient = ItemClient();
  bool isCurrentUser = false;

  @override
  void initState() {
    super.initState();
    fetchSellerEmail();
    checkIfCurrentUser();
  }

  // fetches seller email
  void fetchSellerEmail() async {
    String email = await m.userClient.getSellerEmailById(widget.item.userId);
    setState(() {
      sellerEmail = email;
    });
  }

  void checkIfCurrentUser() {
    m.userClient.getUser().then((user) {
      if (user != null && user.userID == widget.item.userId) {
        setState(() {
          isCurrentUser = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedPrice = '\$${widget.item.itemPrice.toStringAsFixed(2)}';

    return Scaffold(
      appBar: AppBar(
        //title: Text(item['name']),
        actions: [
          Padding(padding: const EdgeInsets.all(8),
            child: 
              Row(
                children: [
                  Text('Welcome, $userName'),
                ],
              ),
            ),
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
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Condition: ${widget.item.itemCondition}',
                style: AppTheme.themeData.textTheme.bodyMedium,
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
            SizedBox(height: 16.0), // shows buttons to current user's items
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
