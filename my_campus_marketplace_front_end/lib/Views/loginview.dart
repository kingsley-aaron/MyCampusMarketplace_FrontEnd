import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import 'mainMenu.dart';

final UserClient client = new UserClient();

class LoginSignupPage extends StatefulWidget {
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
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
      backgroundColor: Colors.grey[800],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (!_isLogin)
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
              if (!_isLogin)
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
              if (!_isLogin)
                TextFormField(
                  controller: _studentIDController,
                  decoration: InputDecoration(
                    labelText: 'StudentID',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
              if (!_isLogin)
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                obscureText: true,
                style: const TextStyle(color: Colors.white),
              ),
              if (!_isLogin)
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
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
                child: Text(_isLogin
                    ? 'Create an account'
                    : 'Have an account? Sign in'),
              ),
            ],
          ),
        ),
      ),
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

  Future<String> _getUsername() async {
    // calling the function to get a User object
    User? user = await client.getUser();

    if (user != null) {
      return user.userName;
    } else {
      return client.getErrorMessage();
    }
  }

  void _login() async {
    // Implement login logic here
    if (_isLogin) {
      String userName = _usernameController.text.trim();
      String passwordHash = _passwordController.text.trim();

      if (userName.isEmpty) {
        _showErrorDialog("Please enter your username.");
      } else if (passwordHash.isEmpty) {
        _showErrorDialog("Please enter your password.");
        return;
      }

      // Calling the login function
      String loginResponse = await client.login(userName, passwordHash);

      userName = await _getUsername();

      if (loginResponse == "Success") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(userName: userName)),
        );
      } else {
        _showErrorDialog(loginResponse);
      }
    }
  }

  void _signup() async {
    // Implement signup logic here
    if (!_isLogin) {
      String firstName = _firstNameController.text.trim();
      String lastName = _lastNameController.text.trim();
      String studentID = _studentIDController.text.trim();
      String studentEmail = _emailController.text.trim();
      String passwordHash = _passwordController.text.trim();
      String userName = _usernameController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (!_isLogin) {
        if (firstName.isEmpty) {
          _showErrorDialog("Please enter your first name.");
          return;
        }
        if (lastName.isEmpty) {
          _showErrorDialog("Please enter your last name.");
          return;
        }
        if (studentID.isEmpty) {
          _showErrorDialog("Please enter your student ID.");
          return;
        }
        if (studentEmail.isEmpty) {
          _showErrorDialog("Please enter your student email.");
          return;
        }
        if (!studentEmail.endsWith('@my.sctcc.edu')) {
          _showErrorDialog(
              "Please enter a valid SCTCC email address ending in @my.sctcc.edu");
          return;
        }
        if (passwordHash.length < 8) {
          _showErrorDialog("Password must be at least 8 characters long.");
          return;
        }
        if (passwordHash != confirmPassword) {
          _showErrorDialog("Passwords do not match.");
          return;
        }
      }
      String signupResponse = await client.signup(
          firstName, lastName, studentID, studentEmail, userName, passwordHash);

      if (signupResponse == "Success") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginSignupPage(),
          ),
        );
      } else {
        _showErrorDialog(signupResponse);
      }
    }
  }
}
