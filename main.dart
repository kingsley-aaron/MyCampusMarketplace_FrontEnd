import 'package:flutter/material.dart';
import 'forSale.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Directory Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DirectoryNavigation(),
    );
  }
}

class DirectoryNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('For Sale'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the directory of your choice
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForSale()),
            );
          },
          child: Text('For Sale'),
        ),
      ),
    );
  }
}

// Create a new StatefulWidget for the directory screen
class DirectoryScreen extends StatefulWidget {
  @override
  _DirectoryScreenState createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  // Define any necessary variables or methods for the directory screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('For Sale'),
      ),
      body: Center(
        child: Text('This is the directory screen.'),
      ),
    );
  }
}
