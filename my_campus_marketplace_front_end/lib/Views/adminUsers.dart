import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'package:mycampusmarketplace/Repositories/userClient.dart';
import 'package:mycampusmarketplace/main.dart' as m;
import 'expandedUser.dart';
import 'package:mycampusmarketplace/Views/adminAppBar.dart';

class AdminUsers extends StatefulWidget {
  final String userName;
  List<User> users = List.empty();

  AdminUsers({required this.userName, required this.users});

  UserClient userClient = m.userClient;

  @override
  State<AdminUsers> createState() => _AdminUsersState(userName, users);
}

class _AdminUsersState extends State<AdminUsers> {
  _AdminUsersState(userName, users);

  late String userName = widget.userName;
  late List<User> users = widget.users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAdminAppBar(
        userName: userName,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'MCM Users',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        /*
                          This might be causign any error
                        */

                        builder: (context) => ExpandedUser(
                          user: user, 
                          userName: userName,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(children: <Widget>[
                          SizedBox(width: 16),
                          // This column contains the ID, and email
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Text(
                                  'Student ID: ${user.studentID}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Student Email: ${user.studentEmail}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ]))
                        ])),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(AdminUsers(userName: "User", users: List.empty()));
}
