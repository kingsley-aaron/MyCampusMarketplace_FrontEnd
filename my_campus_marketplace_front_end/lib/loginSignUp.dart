import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'mainMenu.dart';
import 'aboutUs.dart';
import 'dart:convert';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _studentEmailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordHashController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
      

  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'My Campus Marketplace' : 'Sign Up'),
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
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
                controller: _studentEmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
            TextFormField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            TextFormField(
              controller: _passwordHashController,
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

  void _login() async {
  if (_isLogin) {
    // Extract email and password from text fields and trim any leading or trailing whitespace
    String userName = _userNameController.text.trim();
    String passwordHash = _passwordHashController.text.trim();

    if (userName.isEmpty) {
      _showErrorDialog("Please enter your username.");
    } else if (passwordHash.isEmpty) {
      _showErrorDialog("Please enter your password.");
      return;
    }

    //Checking login logic
    var response = await http.post(
      Uri.parse('http://10.0.2.2/api/login.php'),
      body: {'userName': userName, 'passwordHash': passwordHash},
    );

    if (response.statusCode == 200) {
        // Parse the response JSON
        var data = json.decode(response.body);

        // Check if authentication was successful based on the response from the server
        if (data['success'] == true) {
          // Navigate to MainMenuPage upon successful authentication
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen(userName: '',)),// Or what ever page you want to navigate to after login
          );
        } else {
          // Display an error message if authentication fails
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed. Please check your credentials.')),
          );
        }
      } else {
        // Handle HTTP error (e.g., server error)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred. Please try again later.')),
        );
      }
    }
  }


  void _signup() async {
    // Implement signup logic here
    bool _isLogin = false; // Define the variable _isLogin
    if (!_isLogin) {
      String firstName = _firstNameController.text.trim();
      String lastName = _lastNameController.text.trim();
      String studentID = _studentIDController.text.trim();
      String studentEmail = _studentEmailController.text.trim();
      String passwordHash = _passwordHashController.text.trim();
      String userName = _userNameController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (firstName.isEmpty) {
        _showErrorDialog("Please enter your first name.");
      } else if (!(lastName.isNotEmpty)) {
        _showErrorDialog("Please enter your last name.");
      } else if (passwordHash.length < 8) {
        _showErrorDialog("Password must be at least 8 characters");
      } else if (passwordHash.isEmpty || confirmPassword.isEmpty) {
        _showErrorDialog("Please enter password and confirm password");
      } else if (passwordHash != confirmPassword) {
        _showErrorDialog("Passwords do not match.");
      } else if (studentEmail.isEmpty || !studentEmail.endsWith('@my.sctcc.edu') && !studentEmail.endsWith('@sctcc.edu')) {
        _showErrorDialog(studentEmail.isEmpty
            ? "Please enter email"
            : "Please enter valid SCTCC email address ending in @my.sctcc.edu or @sctcc.edu");
      } else if (userName.isEmpty) {
        _showErrorDialog("Please enter a username");
      } else {
        // Continue with sign up process
        final url =
                'http://10.0.2.2/api/Signup.php'; 
            final response = await http.post(
              Uri.parse(url),
              body: {
                'firstName': firstName,
                'lastName': lastName,
                'studentID': studentID,
                'studentEmail': studentEmail,
                'userName': userName,
                'passwordHash': passwordHash
              },
            );

            // Handle API response
            if (response.statusCode == 200) {
              // Registration successful
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User registered successfully')));
              // Optionally, navigate to the login page after successful registration
              Navigator.pop(
                  context); // Go back to the previous page (login page)
            } else {
              // Registration failed
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Failed to register user. Please try again later.')));
            }
              
       

        

        //Success snackbar of valid sign up
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Center(child: Text('Sign up successful.')),
        //     duration: Duration(seconds: 3),
        //   ),
        // );
        // Navigate to login page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginSignupPage(),
          ),
        );
      }
    }
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

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login/Signup Page',
//       theme: ThemeData(
//         hintColor: Colors.lightBlueAccent,
//       ),
//       home: const LoginSignupPage(),
//     );
//   }
// }

void _navigateToAboutUs(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutUsPage()), // Navigate to About Us page
      );
    }