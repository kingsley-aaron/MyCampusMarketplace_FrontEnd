import 'package:flutter/material.dart';
import 'aboutUs.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'My Campus Marketplace' : 'Sign Up'),
      ),
      backgroundColor: Colors.grey[800], // Dark grey background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: Colors.white), // White label text color
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blue)), // Blue border color
              ),
              style: const TextStyle(color: Colors.white), // White text color
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle:
                    TextStyle(color: Colors.white), // White label text color
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blue)), // Blue border color
              ),
              obscureText: true,
              style: const TextStyle(color: Colors.white), // White text color
            ),
            if (!_isLogin)
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle:
                      TextStyle(color: Colors.white), // White label text color
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blue)), // Blue border color
                ),
                obscureText: true,
                style: const TextStyle(color: Colors.white), // White text color
              ),
            const SizedBox(height: 16.0),
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
              child: Text(
                  _isLogin ? 'Create an account' : 'Have an account? Sign in'),
            ),
            Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _navigateToAboutUs(context);
                    },
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(
                    'Version 0.0.1',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
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

      if (password.isEmpty || confirmPassword.isEmpty) {
        _showErrorDialog("Please enter password and confirm password");
      } else if (password != confirmPassword) {
        _showErrorDialog("Passwords do not match.");
      } else if (email.isEmpty || !email.endsWith('@my.sctcc.edu')) {
        _showErrorDialog(email.isEmpty
            ? "Please enter email"
            : "Please enter valid SCTCC email address ending in @my.sctcc.edu");
      } else {
        // Continue with sign up process

        // Show success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(child: Text('Sign up successful!')),
            duration: Duration(seconds: 4), // Optional duration
          ),
        );

        // Navigate to login page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginSignupPage(),
          ),
        );
      }
    }
  }

  void _navigateToAboutUs(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutUsPage()), // Navigate to About Us page
      );
    }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
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