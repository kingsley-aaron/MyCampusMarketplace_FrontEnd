import 'package:flutter/material.dart';

class ListItemPage extends StatefulWidget {
  @override
  _ListItemPageState createState() => _ListItemPageState();
}

class _ListItemPageState extends State<ListItemPage> {
  int _conditionValue = 0;
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _itemNameController.dispose();
    _itemPriceController.dispose();
    _itemDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List New Item'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Welcome, User'), // Replace 'User' with actual user name
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'myListings') {
                      // Navigate to My Listings screen
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Item Name'),
            TextField(
              controller: _itemNameController,
              decoration: InputDecoration(
                hintText: 'Enter item name',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Item Price'),
            TextField(
              controller: _itemPriceController,
              decoration: InputDecoration(
                hintText: 'Enter item price',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Condition'),
            Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: _conditionValue,
                  onChanged: (value) {
                    setState(() {
                      _conditionValue = value as int;
                    });
                  },
                ),
                Text('New'),
                Radio(
                  value: 1,
                  groupValue: _conditionValue,
                  onChanged: (value) {
                    setState(() {
                      _conditionValue = value as int;
                    });
                  },
                ),
                Text('Used - Like New'),
                Radio(
                  value: 2,
                  groupValue: _conditionValue,
                  onChanged: (value) {
                    setState(() {
                      _conditionValue = value as int;
                    });
                  },
                ),
                Text('Used - Good'),
                Radio(
                  value: 3,
                  groupValue: _conditionValue,
                  onChanged: (value) {
                    setState(() {
                      _conditionValue = value as int;
                    });
                  },
                ),
                Text('Used - Fair'),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Item Description'),
            TextField(
              controller: _itemDescriptionController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter item description',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Upload Photo'),
            // Add a button or widget to load a photo here
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement submit functionality
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement clear functionality
                    _itemNameController.clear();
                    _itemPriceController.clear();
                    _itemDescriptionController.clear();
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
