import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('My Campus Marketplace'),
      ),
      body: Center(child: Text('This is where homepage code would go'),
      ),
    );
  }
}