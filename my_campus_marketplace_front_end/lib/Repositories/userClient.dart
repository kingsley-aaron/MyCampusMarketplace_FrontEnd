import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mycampusmarketplace/Models/user.dart';

const String apiAddress = "http://10.0.2.2/api/";

class UserClient {
  String sessionState = "";
  String errorMessage = "";

  Future<String> login(String userName, String passwordHash) async {
    try {
      // Sending login request to server
      var response = await http.post(
        Uri.parse('${apiAddress}login.php'),
        body: {'userName': userName, 'passwordHash': passwordHash},
      );

      // Parse data response
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success']) {
          // Login was successful
          sessionState = data['data'];
          print('Session ID: $sessionState');
          return "Success";
        } else {
          if (data['reason'][0] == "banned") {
            return "Your account has been permanently banned. Please contact the administrators if you believe this is a mistake.";
          } else if (data['reason'][0] == "login") {
            return "Your username or password was incorrect. Try again or create a new account.";
          } else if (data['reason'][0] == "server_error") {
            return "There was an issue with the server. Please try again later.";
          } else if (data['reason'][0] == "wrong_method") {
            return "There was an issue with the application. Please contact the administrators.";
          } else {
            return "An error occurred. Please try again later.";
          }
        }
      } else {
        if (data['reason'][0] == "banned") {
          return "Your account has been permanently banned. Please contact the administrators if you believe this is a mistake.";
        } else if (data['reason'][0] == "login") {
          return "Your username or password was incorrect. Try again or create a new account.";
        } else if (data['reason'][0] == "server_error") {
          return "There was an issue with the server. Please try again later.";
        } else if (data['reason'][0] == "wrong_method") {
          return "There was an issue with the application. Please contact the administrators.";
        } else {
          return "An error occurred. Please try again later.";
        }
      }
    } catch (e) {
      return "Login failed.";
    }
  }

  Future<String> signup(String firstName, String lastName, String studentID,
      String studentEmail, String userName, String passwordHash) async {
    try {
      var response = await http.post(
        // Sending signup request to server
        Uri.parse('${apiAddress}Signup.php'),
        body: {
          'firstName': firstName,
          'lastName': lastName,
          'studentID': studentID,
          'studentEmail': studentEmail,
          'userName': userName,
          'passwordHash': passwordHash,
        },
      );

      // Parse data response
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['status'] == true &&
            data['message'] == "User successfully created.") {
          return "Success"; // Signup was successful
          // Error occurred.
        } else {
          return data['message'];
        }
      } else {
        return data['message'];
      }
    } catch (e) {
      return "An error occurred. Please try again later.";
    }
  }

  Future<String> logout() async {
    try {
      // Sending login request to server
      var response = await http.post(
        Uri.parse('${apiAddress}logout.php'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
      );

      // Parse data response
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success']) {
          return "Success"; // Login was successful
        } else {
          //determine error message based on API response
          if (data['reason'][0] == "not_logged_in") {
            return "This user is not logged in.";
          } else if (data['reason'][0] == "server_error") {
            return "There was an issue with the server. Please try again later.";
          } else {
            return "An error occurred. Please try again later.";
          }
        }
      } else {
        if (data['reason'][0] == "not_logged_in") {
          return "This user is not logged in.";
        } else if (data['reason'][0] == "server_error") {
          return "There was an issue with the server. Please try again later.";
        } else {
          return "An error occurred. Please try again later.";
        }
      }
    } catch (e) {
      return "An error occurred. Please try again later.";
    }
  }

  Future<User?> getUser() async {
    try {
      // Sending login request to server
      var response = await http.post(
        Uri.parse('${apiAddress}fetchuser.php'),
        headers: {'Cookie': "PHPSESSID=$sessionState"},
      );

      // Parse data response
      var data = json.decode(response.body);
      var userData = data['data'];

      // initialize bool for new user object
      bool admin, banned;

      if (response.statusCode == 200) {
        if (data['success']) {
          if (userData['UserAdmin'] == 0) {
            admin = false;
          } else {
            admin = true;
          }

          if (userData['UserBanned'] == 0) {
            banned = false;
          } else {
            banned = true;
          }

          // return new User object
          return User(
              userID: userData['UserId'],
              firstName: userData['FirstName'],
              lastName: userData['LastName'],
              studentID: userData['StudentId'],
              studentEmail: userData['StudentEmail'],
              userName: userData['Username'],
              admin: admin,
              banned: banned,
              creationDate: DateTime.parse(userData['UserCreated']));
        } else {
          //determine error message based on API response
          if (data['reason'][0] == "missing_data") {
            errorMessage =
                "The application had an error. Please contact the administrators.";
          } else if (data['reason'][0] == "server_error") {
            errorMessage =
                "There was an issue with the server. Please try again later.";
          } else if (data['reason'][0] == "invalid_session") {
            errorMessage = "The session is no longer valid.";
          } else if (data['reason'][0] == "not_found") {
            errorMessage = "The requested user was not found.";
          } else {
            errorMessage = "An error occurred.";
          }
          return null;
        }
      } else {
        if (data['reason'][0] == "missing_data") {
          errorMessage =
              "The application had an error. Please contact the administrators.";
        } else if (data['reason'][0] == "server_error") {
          errorMessage =
              "There was an issue with the server. Please try again later.";
        } else if (data['reason'][0] == "invalid_session") {
          errorMessage = "The session is no longer valid.";
        } else if (data['reason'][0] == "not_found") {
          errorMessage = "The requested user was not found.";
        } else {
          errorMessage = "An error occurred.";
        }
        return null;
      }
    } catch (e) {
      errorMessage = e.toString();
      return null;
    }
  }
  

  //only use for functions that don't already return a string error message, such as the getUser function
  Future<String> getErrorMessage() async {
    return errorMessage;
  }
}
