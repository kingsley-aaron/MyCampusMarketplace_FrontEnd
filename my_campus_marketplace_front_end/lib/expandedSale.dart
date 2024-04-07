//just a place holder for what we pick for coding!!
import 'package:flutter/material.dart';

class ExpandedSale extends StatelessWidget {
  final Map<String, dynamic> item;

  ExpandedSale({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item['name'],
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 100.0),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text('Condition: ${item['condition']}'),
            ),
            Center(
              child: Text('Price: ${item['price']}'),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text('Description: ${item['description']}'),
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement messaging functionality or another action
                },
                child: Text('Message Owner'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
