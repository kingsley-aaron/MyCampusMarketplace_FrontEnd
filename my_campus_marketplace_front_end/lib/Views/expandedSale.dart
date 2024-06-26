import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/theme.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/Views/editListingScreen.dart';
import 'package:mycampusmarketplace/Views/appBar.dart';
import 'package:mycampusmarketplace/main.dart' as m;
import 'package:mycampusmarketplace/Views/mainMenu.dart';

class ExpandedSale extends StatefulWidget {
  final Item item;
  final String username;

  ExpandedSale({Key? key, required this.item, required this.username})
      : super(key: key);

  @override
  _ExpandedSaleState createState() => _ExpandedSaleState();
}

class _ExpandedSaleState extends State<ExpandedSale> {
  late String username = widget.username;
  late String sellerEmail = 'Loading...'; // insert value
  final ItemClient itemClient = ItemClient();
  bool isCurrentUser = false;
  bool isAdmin = false;

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
      } else if (user?.admin == true) {
        isAdmin = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedPrice = '\$${widget.item.itemPrice.toStringAsFixed(2)}';

    return Scaffold(
      appBar: CustomAppBar(
        userName: username,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.item.itemName,
              style: AppTheme.heading(),
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
                style: AppTheme.themeData.textTheme.bodyLarge,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: Text(
                'Price: $formattedPrice',
                style: AppTheme.themeData.textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Description: ${widget.item.itemDesc}',
                style: AppTheme.themeData.textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                'Seller\'s Email: $sellerEmail',
                style: AppTheme.themeData.textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 16.0),
            if (isCurrentUser) // shows buttons to current user's items
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // added edit page button
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditListingScreen(
                                username: username, item: widget.item)),
                      ),
                      child: Text('Edit'),
                      style: ElevatedButton.styleFrom(
                          textStyle: AppTheme.themeData.textTheme.bodyLarge),
                    ),
                    // mark as sold, treated as the delete function when item is gone
                    ElevatedButton(
                      onPressed: () async {
                        String sessionState = m.userClient.getSessionState();
                        String result =
                            await deleteItem(widget.item.itemId, sessionState);
                        if (result == "Success") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Item successfully marked as sold!")));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(userName: username)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Failed to be mark as sold, please try again.")));
                        }
                      },
                      child: Text('Mark as Sold'),
                      style: ElevatedButton.styleFrom(
                        textStyle: AppTheme.themeData.textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            if (isCurrentUser || isAdmin)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 130.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String sessionState = m.userClient.getSessionState();
                    String result =
                        await deleteItem(widget.item.itemId, sessionState);
                    if (result == "Success") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Item successfully deleted!")));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(userName: username)),
                      );
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
