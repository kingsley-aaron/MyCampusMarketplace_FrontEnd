import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import '../main.dart' as m;
import 'myListings.dart';

// To Do
// Handle UserID dynamically instead of using a hard-coded value
// Clean up code as needed

class ListItemPage extends StatefulWidget {
  final String userName;

  ListItemPage({required this.userName});

  @override
  _ListItemPageState createState() => _ListItemPageState(userName);
}

class _ListItemPageState extends State<ListItemPage> {
  _ListItemPageState(userName);
  late String userName = widget.userName;
  int _selectedConditionIndex = 0;
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final ItemClient itemClient = ItemClient();

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
        //title: Text('List New Item'),
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
                Text('Welcome, $userName'),
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
                'List New Item',
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
            Text('Quantity'), // New field: Quantity
            TextFormField(
              controller: _quantityController,
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
            Text('Upload Photo'),
            // Add a button or widget to load a photo here
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text('Submit'),
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
                  child: Text('Clear'),
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
    String itemQuantity = _quantityController.text;
    String userId = "1"; // this value is hard coded, not dynamic yet
    String selectedCondition;
    // condition check for item insertion
    switch (_selectedConditionIndex) {
      case 1:
        selectedCondition = 'New';
        break;
      case 2:
        selectedCondition = 'Used - Like New';
        break;
      case 3:
        selectedCondition = 'Used - Good';
        break;
      case 4:
        selectedCondition = 'Used - Fair';
        break;
      default:
        selectedCondition = '';
    }
    // create session state via user client
    // and post data from list item page
    String sessionState = m.client.sessionState;
    itemClient
        .postItem(
      itemName,
      itemDescription,
      itemPrice,
      selectedCondition,
      itemQuantity,
      userId,
      sessionState,
    )
        .then((response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response),
        ),
      );
    }).catchError((error) {
      print(error);
    });
  }
}
