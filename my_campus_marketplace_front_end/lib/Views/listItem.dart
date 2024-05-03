import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import '../main.dart' as m;
import 'myListings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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

  List<String> selectedImages = []; //plan on saving one image

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _itemNameController.dispose();
    _itemPriceController.dispose();
    _itemDescriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // extracting the file extension
      final fileExtension = path.extension(pickedFile.path);
      // generate a unique filename based on current timestamp
      final uniqueFileName =
          DateTime.now().millisecondsSinceEpoch.toString() + fileExtension;

      // save the file to the temporary directory with the unique filename
      final tempDir = await getTemporaryDirectory();
      final tempPath = tempDir.path;
      final File newImage =
          await File(pickedFile.path).copy('$tempPath/$uniqueFileName');

      setState(() {
        selectedImages.clear(); // clear the previous selected image
        selectedImages.add(newImage.path); // add the new selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                Text(
                  'Welcome, $userName',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'myListings') {
                      // Navigate to My Listings screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyListings(
                            userName: userName,
                          ),
                        ),
                      );
                    } else if (value == 'signOut') {
                      //_logout();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'myListings',
                      child: Text(
                        'My Listings',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'signOut',
                      child: Text(
                        'Sign Out',
                        style: Theme.of(context).textTheme.titleMedium,
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'List New Item',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Text('Item Name', style: Theme.of(context).textTheme.bodyLarge),
            TextField(
              controller: _itemNameController,
              decoration: InputDecoration(
                hintText: 'Enter item name',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Item Price', style: Theme.of(context).textTheme.bodyLarge),
            TextField(
              controller: _itemPriceController,
              decoration: InputDecoration(
                hintText: 'Enter item price',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Condition', style: Theme.of(context).textTheme.bodyLarge),
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
            Text('Quantity',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge), // New field: Quantity
            TextFormField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter quantity',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Item Description',
                style: Theme.of(context).textTheme.bodyLarge),
            TextField(
              controller: _itemDescriptionController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter item description',
              ),
            ),
            SizedBox(height: 16.0),
            Text('Upload Photo', style: Theme.of(context).textTheme.bodyLarge),
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Pick Images'),
            ),
            SizedBox(height: 16.0),
            Text('Selected Images:'),
            SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: selectedImages.map((imagePath) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      File(imagePath),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
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
                  child: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement clear functionality
                    _itemNameController.clear();
                    _itemPriceController.clear();
                    _itemDescriptionController.clear();
                    _quantityController.clear(); // Clear quantity controller
                    setState(() {
                      _selectedConditionIndex = 0;
                      selectedImages.clear();
                    });
                  },
                  child: Text(
                    'Clear',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
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
    String selectedCondition;

    // Condition check for item insertion
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

    String sessionState = m.userClient.sessionState;

    m.userClient.getUser().then((user) {
      // dynamic user id
      if (user != null) {
        String userId = user.userID.toString();

        // post each selected image
        for (String imagePath in selectedImages) {
          File itemImage = File(imagePath);

          itemClient
              .postItem(
            itemName,
            itemDescription,
            itemPrice,
            selectedCondition,
            itemQuantity,
            userId,
            sessionState,
            itemImage,
          )
              .then((response) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response),
              ),
            );
            Navigator.pop(context);
          }).catchError((error) {
            print(error);
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred.'),
          ),
        );
      }
    });
  }
}
