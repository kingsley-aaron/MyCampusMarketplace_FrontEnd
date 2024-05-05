import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycampusmarketplace/Models/item.dart';

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
          return "Item Successfully Posted!";
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

  Future<String> editItem({
    required int itemId,
    String? itemName,
    String? itemDesc,
    String? itemCondition,
    String? itemPrice,
    String? itemQuantity,
    File? itemImage,
    required String sessionState,
  }) async {
    try {
      // Sending edit item request to server
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${apiAddress}editpost.php'),
      );

      // set required headers
      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Cookie'] = "PHPSESSID=$sessionState";

      // set request body fields
      request.fields['ItemID'] = itemId.toString();
      if (itemName != null) request.fields['ItemName'] = itemName;
      if (itemDesc != null) request.fields['ItemDesc'] = itemDesc;
      if (itemCondition != null) {
        request.fields['ItemCondition'] = itemCondition;
      }
      if (itemPrice != null) request.fields['ItemPrice'] = itemPrice.toString();
      if (itemQuantity != null) {
        request.fields['ItemQuantity'] = itemQuantity.toString();
      }

      // add image file to the request if provided
      if (itemImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('ItemImage', itemImage.path),
        );
      }
      // send the request
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var data = json.decode(responseData);

      // check the response status code
      if (response.statusCode == 200) {
        if (data['success']) {
          return "Success";
        } else {
          return "Failed to edit item: ${data['reason'].join(", ")}";
        }
      } else {
        return "HTTP error ${response.statusCode}: ${data['reason'].join(", ")}";
      }
    } catch (e) {
      return "Exception caught: $e";
    }
  }

  Future<String> deleteItem(int itemId, String sessionState) async {
    try {
      // Sending delete item request to server
      var url = Uri.parse('${apiAddress}deletepost.php?itemId=$itemId');
      var response = await http.delete(
        url,
        headers: {'Cookie': "PHPSESSID=$sessionState"},
      );
      // check status code
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['success']) {
          return "Success";
        } else {
          // error logging on why item won't delete
          return "Failed to delete item: ${data['data']}";
        }
      } else {
        // additional error handling
        return "HTTP error ${response.statusCode}: ${response.body}";
      }
    } catch (e) {
      return "Exception caught: $e";
    }
  }

  //The filter parameters are optional and must be called by name. Condition and orderBy are arrays that can filter on multiple values.
  Future<List<Item>> getForSaleItems(String sessionState,
      {int?
          listSize, //only works up to 100. Anything higher will result in the full list of items from the database. Might change later.
      List<String>? condition, //valid values: "new", "fair", "good", "likenew"
      double? minPrice,
      double? maxPrice,
      String?
          keyword, //if you pass multiple words separated by spaces, it will search for all words separately. To search for a multi-word phrase, enclose it in quotes
      String?
          keywordSearchType, //completely optional. Valid values are ItemName, ItemDesc, and Both. Defaults to both if you don't pass anything
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
        keyword: keyword,
        keywordSearchType: keywordSearchType,
        username: username,
        orderBy: orderBy);
  }

  Future<List<Item>> _getItems(String sessionState, bool wanted,
      {int? listSize,
      List<String>? condition,
      double? minPrice,
      double? maxPrice,
      String? keyword,
      String? keywordSearchType,
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

      if (keyword != null) {
        String encodedKeyword = keyword.replaceAll(" ", "%");

        request += "&keyword=$encodedKeyword";

        if (keywordSearchType != null) {
          request += "&keywordtype=$keywordSearchType";
        } else {
          request += "&keywordtype=both";
        }
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
            return items;
          }
          //return items;
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
