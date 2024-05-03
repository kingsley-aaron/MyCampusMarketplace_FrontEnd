import 'package:flutter/material.dart';
import 'myListings.dart';

class EditListingScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  EditListingScreen({required this.item});

  @override
  _EditListingScreenState createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  late TextEditingController _itemNameController;
  late TextEditingController _itemPriceController;
  late TextEditingController _itemDescriptionController;
  late int _selectedConditionIndex;

  @override
  void initState() {
    super.initState();
    // Initialize controllers and set initial values
    _itemNameController = TextEditingController(text: widget.item['name']);
    _itemPriceController = TextEditingController(text: widget.item['price']);
    _itemDescriptionController =
        TextEditingController(text: widget.item['description']);
    _selectedConditionIndex = widget.item['condition'];
  }

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

  void _submitForm() {
    // Perform validation
    if (_selectedConditionIndex == 0) {
      // Show error message or dialog for condition not selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a condition.'),
        ),
      );
      return;
    }

    // Continue with form submission
    String itemName = _itemNameController.text;
    String itemPrice = _itemPriceController.text;
    String itemDescription = _itemDescriptionController.text;
    int selectedCondition = _selectedConditionIndex;

    // Now you can use the itemName, itemPrice, itemDescription, and selectedCondition
    // variables to perform your form submission logic
  }
}