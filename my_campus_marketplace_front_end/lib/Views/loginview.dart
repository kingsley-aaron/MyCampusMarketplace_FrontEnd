import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import 'package:mycampusmarketplace/Views/mainMenu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme.dart';
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
    return Theme(
      data: myTheme,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: myTheme.primaryColor,
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
                        color: myTheme.secondaryHeaderColor,
                      ),
                      SizedBox(width: 8),
                      Text(''),
                    ],
                  ),
                  Text(
                    _isLogin ? 'My Campus Marketplace' : 'Sign Up',
                  ),
                ],
              ),
              backgroundColor: myTheme.hintColor,
              elevation: 0,
              centerTitle: true,
            ),
          ),
        ),
        backgroundColor: myTheme.scaffoldBackgroundColor,
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
                      labelStyle: myTheme.textTheme.bodyLarge!.copyWith(
                        color: myTheme.primaryColorDark,
                      ),
                      enabledBorder: UnderlineInputBorder(),
                    ),
                  ),
                if (!_isLogin)
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: myTheme.textTheme.bodyLarge!.copyWith(
                        color: myTheme.primaryColorDark,
                      ),
                      enabledBorder: UnderlineInputBorder(),
                    ),
                  ),
                if (!_isLogin)
                  TextFormField(
                    controller: _studentIDController,
                    decoration: InputDecoration(
                      labelText: 'StudentID',
                      labelStyle: myTheme.textTheme.bodyLarge!.copyWith(
                        color: myTheme.primaryColorDark,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: myTheme.unselectedWidgetColor,
                        ),
                      ),
                    ),
                    style: myTheme.textTheme.bodyLarge!.copyWith(
                      color: myTheme.primaryColorDark,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                if (!_isLogin)
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: myTheme.textTheme.bodyLarge!.copyWith(
                        color: myTheme.primaryColorDark,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: myTheme.unselectedWidgetColor,
                        ),
                      ),
                    ),
                    style: myTheme.textTheme.bodyLarge!.copyWith(
                      color: myTheme.primaryColorDark,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: myTheme.textTheme.bodyLarge!.copyWith(
                      color: myTheme.primaryColorDark,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: myTheme.unselectedWidgetColor,
                      ),
                    ),
                  ),
                  style: myTheme.textTheme.bodyLarge!.copyWith(
                    color: myTheme.primaryColorDark,
                    fontFamily: 'Quicksand',
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: myTheme.unselectedWidgetColor,
                      ),
                    ),
                  ),
                  obscureText: true,
                  style: myTheme.textTheme.bodyLarge!.copyWith(
                    color: myTheme.primaryColorDark,
                    fontFamily: 'Quicksand',
                  ),
                ),
                if (!_isLogin)
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: myTheme.textTheme.bodyLarge!.copyWith(
                        color: myTheme.primaryColorDark,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: myTheme.unselectedWidgetColor,
                        ),
                      ),
                    ),
                    obscureText: true,
                    style: myTheme.textTheme.bodyLarge!.copyWith(
                      color: myTheme.primaryColorDark,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                SizedBox(height: 16.0),
                Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: myTheme.hintColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: _isLogin ? _login : _signup,
                      splashColor: myTheme.highlightColor,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        child: Center(
                          child: Text(
                            _isLogin ? 'Login' : 'Sign Up',
                            style: myTheme.textTheme.labelLarge!.copyWith(
                              color: myTheme.primaryTextTheme.labelLarge!.color,
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
                    overlayColor: WidgetStateColor.resolveWith(
                      (states) => myTheme.highlightColor,
                    ),
                  ),
                  child: Text(
                    _isLogin ? 'Create an account' : 'Have an account? Sign in',
                  ),
                ),
              ],
            ),
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
            style: myTheme.textTheme.bodyLarge!.copyWith(
              fontFamily: 'Quicksand',
            ),
          ),
          content: Text(
            message,
            style: myTheme.textTheme.bodyLarge!.copyWith(
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
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String> _getUsername() async {
    User? user = await client.getUser();

    if (user != null) {
      return user.userName;
    } else {
      return client.getErrorMessage();
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
