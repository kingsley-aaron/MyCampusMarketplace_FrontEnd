import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Campus Marketplace',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 156, 192, 0.86),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 300, // Set the desired width
          child: Text(
            'This app is a convenient location for SCTCC students to find and sell textbooks, school materials, and beyond!',
            style: TextStyle(
              fontFamily: 'Quicksand',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
