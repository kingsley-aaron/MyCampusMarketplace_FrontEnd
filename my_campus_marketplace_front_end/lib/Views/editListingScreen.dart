import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/item.dart';
import '../main.dart' as m;
import 'myListings.dart';

class EditListingScreen extends StatefulWidget {
  final Item item;


  EditListingScreen({required this.item});

  @override
  _EditListingScreenState createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  late TextEditingController _itemNameController;
  late TextEditingController _itemPriceController;
  late TextEditingController _itemDescriptionController;
  late TextEditingController _itemQuantityController;
  int _selectedConditionIndex = 0; // default


  @override
  void initState() {
    super.initState();
    // Initialize controllers and set initial values
    _itemNameController = TextEditingController(text: widget.item.itemName);
    _itemPriceController =
        TextEditingController(text: widget.item.itemPrice.toString());
    _itemDescriptionController =
        TextEditingController(text: widget.item.itemDesc);
    _itemQuantityController =
        TextEditingController(text: widget.item.itemQuantity.toString());
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _itemNameController.dispose();
    _itemPriceController.dispose();
    _itemDescriptionController.dispose();
    _itemQuantityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Listing'),
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
                Text('Welcome, User'), // Replace User with your actual username
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
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Edit Listing',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
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
            DropdownButton<int>(
              value: _selectedConditionIndex,
              onChanged: (value) {
                setState(() {
                  _selectedConditionIndex = value!;
                });
              },
              items: <DropdownMenuItem<int>>[
                DropdownMenuItem(
                  value: 0,
                  child: Text('Select Condition'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('New'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('Used - Like New'),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text('Used - Good'),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text('Used - Fair'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Quantity', style: Theme.of(context).textTheme.bodyLarge),
            TextFormField(
              controller: _itemQuantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter quantity',
              ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement clear functionality
                    _itemNameController.clear();
                    _itemPriceController.clear();
                    _itemDescriptionController.clear();
                    setState(() {
                      _selectedConditionIndex = 0;
                    });
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _submitForm() async {
    // Perform validation
    if (_selectedConditionIndex == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please select a condition.')));
      return;
    }
    // checks item condition
    String itemCondition;
    switch (_selectedConditionIndex) {
      case 1:
        itemCondition = 'New';
        break;
      case 2:
        itemCondition = 'Used - Like New';
        break;
      case 3:
        itemCondition = 'Used - Good';
        break;
      case 4:
        itemCondition = 'Used - Fair';
        break;
      default:
        itemCondition = '';
        break;
    }
    // controllers upon editing (populated)
    String itemName = _itemNameController.text;
    String itemPrice = _itemPriceController.text;
    String itemDescription = _itemDescriptionController.text;
    String itemQuantity = _itemQuantityController.text;

    // fetch user sessionstate
    String sessionState = m.userClient.getSessionState();

    try {
      String result = await m.itemClient.editItem(
        itemId: widget.item.itemId,
        itemName: itemName,
        itemDesc: itemDescription,
        itemCondition: itemCondition,
        itemPrice: itemPrice,
        itemQuantity: itemQuantity,
        sessionState: sessionState,
      );

      if (result == "Success") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Item updated successfully!")));
        Navigator.pop(context); // after item has been updated, push context
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to update item: $result")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error updating item: $e")));
    }
  }
}
