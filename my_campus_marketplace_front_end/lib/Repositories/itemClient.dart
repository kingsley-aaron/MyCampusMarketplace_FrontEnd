import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycampusmarketplace/Models/item.dart';

//const String apiAddress = "http://10.0.2.2/api/";
const String apiAddress = "https://helpmewithfinals.com/api/";

class ItemClient {
  String errorMessage = "";

  Future<Item?> getItem(int itemId, String sessionState) async {
    try {
      // Sending getItem request to server

      var response = await http.get(
        Uri.parse('${apiAddress}fetchitem.php?id=$itemId'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
      );
      var data = json.decode(response.body);

      // getting item was a success
      if (response.statusCode == 200) {
        bool wanted = false;

        if (data['success']) {
          if (data['ItemWanted'] == 0) {
            wanted = false;
          } else {
            wanted = true;
          }
          return Item(
              itemId: data['ItemID'],
              itemName: data['ItemName'],
              itemDesc: data['ItemDesc'],
              itemCondition: data['ItemCondition'],
              itemQuantity: data['ItemQuantity'],
              itemPrice: data['ItemPrice'].toDouble(),
              itemWanted: wanted,
              itemImage: data['ItemImage'],
              userId: data['UserID'],
              itemAdded: DateTime.parse(data['ItemAdded']));
        } else {
          //determine error message based on API response
          errorMessage = data['data'];
          return null;
        }
      } else if (response.statusCode == 404) {
        errorMessage = data['data'];
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
    File itemImage,
  ) async {
    try {
      // Sending post item request to server
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${apiAddress}postitem.php'),
      );

      // set required headers
      request.headers['Content-Type'] = 'multipart/form-data';

      // set request body fields
      request.fields.addAll({
        'itemName': itemName,
        'itemDesc': itemDesc,
        'itemPrice': itemPrice,
        'itemCondition': itemCondition,
        'itemQuantity': itemQuantity,
        'itemWanted': '0',
        'userID': userID,
      });

      // add image file to the request
      request.files.add(
        await http.MultipartFile.fromPath('itemImage', itemImage.path),
      );

      // set session state cookie
      request.headers['Cookie'] = "PHPSESSID=$sessionState";

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var data = json.decode(responseData);

      // check the response status code
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
      return e.toString();
    }
  }

  //The filter parameters are optional and must be called by name. Condition and orderBy are arrays that can filter on multiple values.
  Future<List<Item>> getForSaleItems(String sessionState,
      {int?
          listSize, //only works up to 100. Anything higher will result in the full list of items from the database. Might change later.
      List<String>? condition, //valid values: "new", "fair", "good", "likenew"
      double? minPrice,
      double? maxPrice,
      String? username,
      List<String>?
          orderBy //valid values: "Items.ItemName", "Items.ItemDesc", "Items.ItemCondition", "Items.ItemAdded", and "Items.ItemPrice"
      //to sort in descending order, add a "-" before the string.
      }) async {
    return _getItems(sessionState, false,
        listSize: listSize,
        condition: condition,
        minPrice: minPrice,
        maxPrice: maxPrice,
        username: username,
        orderBy: orderBy);
  }

  //see getForSaleItems documentation, everything is the same
  Future<List<Item>> getWantedItems(String sessionState,
      {int? listSize,
      List<String>? condition,
      double? minPrice,
      double? maxPrice,
      String? username,
      List<String>? orderBy}) async {
    return _getItems(sessionState, true,
        listSize: listSize,
        condition: condition,
        minPrice: minPrice,
        maxPrice: maxPrice,
        username: username,
        orderBy: orderBy);
  }

  Future<List<Item>> _getItems(String sessionState, bool wanted,
      {int? listSize,
      List<String>? condition,
      double? minPrice,
      double? maxPrice,
      String? username,
      List<String>? orderBy}) async {
    List<Item> items = List.empty(growable: true);
    try {
      // Sending getItem request to server (to be tested still)

      int wantedInt = 0;

      if (wanted) {
        wantedInt = 1;
      }

      String request = "listposts.php?wanted=$wantedInt";

      if (condition != null) {
        for (String c in condition) {
          request += "&condition_$c=1";
        }
      }

      if (minPrice != null) {
        request += "&minprice=$minPrice";
      }

      if (maxPrice != null) {
        request += "&maxprice=$maxPrice";
      }

      if (username != null) {
        request += "&user=$username&userby=username";
      }

      if (listSize != null) {
        request += "&size=$listSize";
      }

      if (orderBy != null) {
        request += "&order=";

        int loop = 0;
        for (String o in orderBy) {
          request += o;

          if (loop != orderBy.length) {
            request += ",";
          }

          loop++;
        }
      }

      var response = await http.get(
        Uri.parse('$apiAddress$request'),
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

          if (data['success']) {
            //this counts how many items are added to the list by a single request
            int newItems = 0;
            //this determines how many items down the full list the server should start when returning a request
            int offset = 0;

            items = _parseList(data['data']);

            if (listSize == null) {
              //continue requesting new items until all items are requested from the server
              while (newItems == 100) {
                response = await http.get(
                  Uri.parse('$apiAddress$request&start$offset'),
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
            print(errorMessage);
            return items;
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
          print(errorMessage);
          return items;
        }
      } else {
        errorMessage = "An error occurred.";
        print(errorMessage);
        return items;
      }
    } catch (e) {
      errorMessage = e.toString();
      print(errorMessage);
      return items;
    }
  }

  List<Item> _parseList(dynamic jsonList) {
    List<Item> items = List.empty(growable: true);
    bool wanted = false;

    for (var item in jsonList) {
      if (item['ItemWanted'] == 0) {
        wanted = false;
      } else {
        wanted = true;
      }
      items.add(Item(
        itemId: item['ItemID'],
        itemName: item['ItemName'],
        itemDesc: item['ItemDesc'],
        itemCondition: item['ItemCondition'],
        itemQuantity: item['ItemQuantity'],
        itemPrice: item['ItemPrice'].toDouble(),
        itemWanted: wanted,
        itemImage: 'https://helpmewithfinals.com/api/${item['ItemImage']}',
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
