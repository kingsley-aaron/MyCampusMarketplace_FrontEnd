import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycampusmarketplace/Models/item.dart';

// Still need to test item image

const String apiAddress = "http://10.0.2.2/api/";

class ItemClient {
  Future<Item?> getItem(int itemId, String sessionState) async {
    try {
      // Sending getItem request to server (to be tested still)

      var response = await http.get(
        Uri.parse('${apiAddress}fetchitem.php?id=$itemId'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
      );
      // getting item was a success
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success']) {
          var itemData = data['data'];
          return Item(
            itemId: itemData['ItemID'],
            itemName: itemData['ItemName'],
            itemDesc: itemData['ItemDesc'],
            itemCondition: itemData['ItemCondition'],
            itemQuantity: itemData['ItemQuantity'] as int,
            itemPrice: double.tryParse(itemData['ItemPrice'] ?? '') ?? 0.0,
            itemWanted: itemData['ItemWanted'],
            //itemImage: itemData['itemImage'],
            userId: itemData['UserID'],
            itemAdded: DateTime.parse(itemData['ItemAdded']),
          );
        } else {
          return null;
        }
      } else if (response.statusCode == 404) {
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> postItem(
    String itemName,
    String itemDesc,
    String itemPrice,
    String itemCondition,
    String itemQuantity,
    String userID,
    String sessionState,
    // String itemImage,
  ) async {
    try {
      // Sending post item request to server
      var response = await http.post(
        Uri.parse('${apiAddress}postitem.php'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
        body: {
          'itemName': itemName,
          'itemDesc': itemDesc,
          'itemPrice': itemPrice,
          'itemCondition': itemCondition,
          'itemWanted': '0',
          'userID': userID,
          // 'itemImage': itemImage,
          'itemQuantity': itemQuantity,
        },
      );
      // test responses (will remove later on)
      print('Session ID: $sessionState');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      var data = json.decode(response.body);
      // posting item was successful (still needs to be worked a bit)
      if (response.statusCode == 200) {
        if (data['success']) {
          return "Success";
        } else {
          return data['data'];
        }
      } else {
        return "Server Error";
      }
    } catch (e) {
      print('Error: $e');
      return "An error occurred. Please try again later.";
    }
  }
}
