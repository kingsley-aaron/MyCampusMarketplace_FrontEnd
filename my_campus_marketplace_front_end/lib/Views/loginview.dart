import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import 'package:mycampusmarketplace/Views/mainMenu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green.shade300,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.graduationCap,
                      color: Color.fromARGB(239, 114, 46, 25),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Color.fromARGB(229, 41, 39, 39),
                      ),
                    ),
                  ],
                ),
                Text(
                  _isLogin ? 'My Campus Marketplace' : 'Sign Up',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Color.fromARGB(229, 41, 39, 39),
                  ),
                ),
              ],
            ),
            backgroundColor: Color.fromRGBO(159, 232, 205, 0.831),
            elevation: 0,
            centerTitle: true,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(254, 254, 254, 1),
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
                    labelStyle: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color.fromARGB(243, 41, 39, 39),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(219, 208, 138, 116),
                      ),
                    ),
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(243, 41, 39, 39),
                      fontFamily: 'Quicksand'),
                ),
              if (!_isLogin)
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color.fromARGB(243, 41, 39, 39),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(219, 208, 138, 116),
                      ),
                    ),
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(243, 41, 39, 39),
                      fontFamily: 'Quicksand'),
                ),
              if (!_isLogin)
                TextFormField(
                  controller: _studentIDController,
                  decoration: InputDecoration(
                    labelText: 'StudentID',
                    labelStyle: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color.fromARGB(243, 41, 39, 39),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(219, 208, 138, 116),
                      ),
                    ),
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(243, 41, 39, 39),
                      fontFamily: 'Quicksand'),
                ),
              if (!_isLogin)
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color.fromARGB(243, 41, 39, 39),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(219, 208, 138, 116),
                      ),
                    ),
                  ),
                  style: TextStyle(
                      color: Color.fromARGB(243, 41, 39, 39),
                      fontFamily: 'Quicksand'),
                ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Color.fromARGB(243, 41, 39, 39),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(219, 208, 138, 116),
                    ),
                  ),
                ),
                style: TextStyle(
                    color: Color.fromARGB(243, 41, 39, 39),
                    fontFamily: 'Quicksand'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Color.fromARGB(243, 41, 39, 39),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(219, 208, 138, 116),
                    ),
                  ),
                ),
                obscureText: true,
                style: TextStyle(
                    color: Color.fromARGB(229, 41, 39, 39),
                    fontFamily: 'Quicksand'),
              ),
              if (!_isLogin)
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color.fromARGB(243, 41, 39, 39),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(219, 208, 138, 116),
                      ),
                    ),
                  ),
                  obscureText: true,
                  style: const TextStyle(
                      color: Color.fromARGB(243, 41, 39, 39),
                      fontFamily: 'Quicksand'),
                ),
              const SizedBox(height: 16.0),
              Material(
                color: Colors.transparent,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(46, 126, 97, 0.932),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    onTap: _isLogin ? _login : _signup,
                    splashColor: Color.fromARGB(219, 240, 193, 178),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      child: Center(
                        child: Text(
                          _isLogin ? 'Login' : 'Sign Up',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                  });
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) => Color.fromARGB(219, 208, 138, 116),
                  ),
                ),
                child: Text(
                  _isLogin ? 'Create an account' : 'Have an account? Sign in',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Color.fromRGBO(129, 55, 16, 1),
                  ),
                ),
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
          title: Text(
            "Error",
            style: TextStyle(
              fontFamily: 'Quicksand',
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontFamily: 'Quicksand',
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Color.fromRGBO(129, 55, 16, 1),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String> _getUsername() async {
    User? user = await userClient.getUser();

    if (user != null) {
      return user.userName;
    } else {
      return userClient.getErrorMessage();
    }
  }

  void _login() async {
    if (_isLogin) {
      String userName = _usernameController.text.trim();
      String passwordHash = _passwordController.text.trim();

      if (userName.isEmpty) {
        _showErrorDialog("Please enter your username.");
      } else if (passwordHash.isEmpty) {
        _showErrorDialog("Please enter your password.");
        return;
      }

      String loginResponse = await userClient.login(userName, passwordHash);

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
        if ((!studentEmail.endsWith('@my.sctcc.edu')) &&
            (!studentEmail.endsWith('@sctcc.edu'))) {
          _showErrorDialog(
              "Please enter a valid SCTCC email address ending in @my.sctcc.edu or @sctcc.edu");
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
      String signupResponse = await userClient.signup(
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
