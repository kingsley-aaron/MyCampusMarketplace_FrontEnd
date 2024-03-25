import 'package:flutter/material.dart';

class LoginSignupPage extends StatefulWidget {
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'My Campus Marketplace' : 'Sign Up'),
      ),
      backgroundColor: Colors.grey[800], // Dark grey background color
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white), // White label text color
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)), // Blue border color
              ),
              style: TextStyle(color: Colors.white), // White text color
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white), // White label text color
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)), // Blue border color
              ),
              obscureText: true,
              style: TextStyle(color: Colors.white), // White text color
            ),
            if (!_isLogin)
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.white), // White label text color
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)), // Blue border color
                ),
                obscureText: true,
                style: TextStyle(color: Colors.white), // White text color
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLogin ? _login : _signup,
              child: Text(_isLogin ? 'Login' : 'Sign Up'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin ? 'Create an account' : 'Have an account? Sign in'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    // Implement login logic here
  }

  void _signup() {
    // Implement signup logic here
    if (!_isLogin) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        _showErrorDialog("Passwords do not match.");
        return;
      }

      // Continue with sign up process
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Signup Page',
      theme: ThemeData(
        hintColor: Colors.lightBlueAccent, // Light blue accent color
      ),
      home: LoginSignupPage(),
    );
  }
}
