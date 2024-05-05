import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/item.dart';
import 'package:mycampusmarketplace/Repositories/itemClient.dart';
import 'package:mycampusmarketplace/Views/appBar.dart';
import 'package:mycampusmarketplace/main.dart' as m;
import 'expandedSale.dart';

class ForSale extends StatefulWidget {
  final String userName;
  List<Item> items = List.empty();

  ForSale({required this.userName, required this.items});

  ItemClient itemClient = m.itemClient;

  @override
  State<ForSale> createState() => _ForSaleState(userName, items);
}

class _ForSaleState extends State<ForSale> {
  _ForSaleState(userName, items);

  late String userName = widget.userName;
  late List<Item> items = widget.items;

  String selectedCondition = 'All'; // Default value
  List<String> condition = [];
  double? minPrice;
  double? maxPrice;
  String searchKeyword = '';
  bool isExpanded = false; // Expansion panel state

  void applyFilters() {
    setState(() {
      condition.add(selectedCondition);
      widget.itemClient
          .getForSaleItems(m.userClient.getSessionState(),
              condition: condition,
              minPrice: minPrice,
              maxPrice: maxPrice,
              keyword: searchKeyword)
          .then((response) => onapplyFilterSuccess(response));
    });
  }

  void onapplyFilterSuccess(List<Item>? newItems) {
    setState(() {
      if (newItems != null) {
        items = newItems;
        // Navigate to For Sale screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForSale(userName: userName, items: items),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        userName: userName,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Items for Sale',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontFamily: 'Quicksand'),
                ),
                SizedBox(height: 16),
                ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      this.isExpanded = !this.isExpanded;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('Filters'),
                        );
                      },
                      body: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedCondition,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCondition = value!;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: 'All',
                                      child: Text('All'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'new',
                                      child: Text('New'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'likenew',
                                      child: Text('Used - Like New'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'good',
                                      child: Text('Used - Good'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'fair',
                                      child: Text('Used - Fair'),
                                    ),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Condition',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Min Price',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      minPrice = double.tryParse(value);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Max Price',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      maxPrice = double.tryParse(value);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Search',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      searchKeyword = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  applyFilters();
                                },
                                child: Text('Apply Filters'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      isExpanded: isExpanded,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                String formattedPrice =
                    '\$${item.itemPrice.toStringAsFixed(2)}';
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExpandedSale(username: userName, item: item),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              item.itemImage,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Icon(Icons.image_not_supported,
                                    size: 100, color: Colors.grey);
                              },
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item.itemName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontFamily: 'Quicksand'),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Condition: ${item.itemCondition}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontFamily: 'Quicksand'),
                                ),
                                Text(
                                  'Price: $formattedPrice',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Color.fromRGBO(129, 55, 16, 1),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Quicksand',
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
