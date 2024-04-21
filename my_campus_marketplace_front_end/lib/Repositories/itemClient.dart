import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycampusmarketplace/Models/item.dart';

// Still need to test item image

const String apiAddress = "http://10.0.2.2/api/";

class ItemClient {
  String errorMessage = "";

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
          //determine error message based on API response
          if (data['reason'][0] == "missing_data") {
            errorMessage =
                "The application had an error. Please contact the administrators.";
          } else if (data['reason'][0] == "server_error") {
            errorMessage =
                "There was an issue with the server. Please try again later.";
          } else if (data['reason'][0] == "not_found") {
            errorMessage = "The requested item was not found.";
          } else {
            errorMessage = "An error occurred.";
          }
          return null;
        }
      } else if (response.statusCode == 404) {
        errorMessage = "The requested item was not found.";
        return null;
      } else {
        errorMessage = "An error occurred.";
        return null;
      }
    } catch (e) {
      errorMessage = e.toString();
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
        return data['data'];
      }
    } catch (e) {
      print('Error: $e');
      return e.toString();
    }
  }

  Future<List<Item>> getAllForSaleItems(String sessionState) async {
    List<Item> items = List.empty(growable: true);
    try {
      // Sending getItem request to server (to be tested still)

      var response = await http.get(
        Uri.parse('${apiAddress}listposts.php?wanted=0'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
      );
      // getting items was a success
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success']) {
          //this counts how many items are added to the list by a single request
          int newItems = 0;
          //this determines how many items down the full list the server should start when returning a request
          int offset = 0;

          items = _parseList(data['data']);

          newItems = items.length;
          offset += newItems;

          //continue requesting new items until all items are requested from the server
          while (newItems == 100) {
            response = await http.get(
              Uri.parse('${apiAddress}listposts.php?wanted=0&start$offset'),
              headers: {'Cookie': "PHPSESSID=$sessionState"},
            );

            if (response.statusCode == 200) {
              var newData = json.decode(response.body);

              List<Item> newItemsList = _parseList(newData['data']);

              newItems = newItemsList.length;
              offset += newItems;

              for (Item i in newItemsList) {
                items.add(i);
              }
            }
          }
          return items;
        } else {
          //determine error message based on API response
          if (data['reason'][0] == "server_error") {
            errorMessage =
                "There was an issue with the server. Please try again later.";
          } else if (data['reason'][0] == "invalid_session") {
            errorMessage = "The session is no longer valid.";
          } else {
            errorMessage = "An error occurred.";
          }
          return items;
        }
      } else {
        errorMessage = "An error occurred.";
        return items;
      }
    } catch (e) {
      errorMessage = e.toString();
      return items;
    }
  }

  Future<List<Item>> getAllWantedItems(String sessionState) async {
    List<Item> items = List.empty(growable: true);
    try {
      // Sending getItem request to server (to be tested still)

      var response = await http.get(
        Uri.parse('${apiAddress}listposts.php?wanted=1'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
      );
      // getting items was a success
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success']) {
          //this counts how many items are added to the list by a single request
          int newItems = 0;
          //this determines how many items down the full list the server should start when returning a request
          int offset = 0;

          items = _parseList(data['data']);

          newItems = items.length;
          offset += newItems;

          //continue requesting new items until all items are requested from the server
          while (newItems == 100) {
            response = await http.get(
              Uri.parse('${apiAddress}listposts.php?wanted=1&start$offset'),
              headers: {'Cookie': "PHPSESSID=$sessionState"},
            );

            if (response.statusCode == 200) {
              var newData = json.decode(response.body);

              List<Item> newItemsList = _parseList(newData['data']);

              newItems = newItemsList.length;
              offset += newItems;

              for (Item i in newItemsList) {
                items.add(i);
              }
            }
          }
          return items;
        } else {
          //determine error message based on API response
          if (data['reason'][0] == "server_error") {
            errorMessage =
                "There was an issue with the server. Please try again later.";
          } else if (data['reason'][0] == "invalid_session") {
            errorMessage = "The session is no longer valid.";
          } else {
            errorMessage = "An error occurred.";
          }
          return items;
        }
      } else {
        errorMessage = "An error occurred.";
        return items;
      }
    } catch (e) {
      errorMessage = e.toString();
      return items;
    }
  }

  List<Item> _parseList(dynamic jsonList) {
    List<Item> items = List.empty(growable: true);

    for (var item in jsonList) {
      items.add(Item(
        itemId: item['ItemID'],
        itemName: item['ItemName'],
        itemDesc: item['ItemDesc'],
        itemCondition: item['ItemCondition'],
        itemQuantity: item['ItemQuantity'] as int,
        itemPrice: double.tryParse(item['ItemPrice'] ?? '') ?? 0.0,
        itemWanted: item['ItemWanted'],
        //itemImage: itemData['itemImage'],
        userId: item['UserID'],
        itemAdded: DateTime.parse(item['ItemAdded']),
      ));
    }

    return items;
  }

  Future<String> getErrorMessage() async {
    return errorMessage;
  }
}
