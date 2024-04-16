import 'package:flutter/material.dart';
import 'package:mycampusmarketplace/Models/user.dart';
import 'expandedUser.dart';

class AdminUsers extends StatefulWidget {
  final String userName;

  AdminUsers({required this.userName});

  @override
  State<AdminUsers> createState() => _AdminUsersState(userName);
}

class _AdminUsersState extends State<AdminUsers> {
  _AdminUsersState(userName);

  late String userName = widget.userName;
  final List<Map<String, dynamic>> users = [
    {
      'name': 'User 1',
      'studentId': '12345',
      'email': 'sample@my.sctcc.edu',
    },
    {
      'name': 'User 2',
      'studentId': '98765',
      'email': 'sample@my.sctcc.edu',
    },
    {
      'name': 'User 3',
      'studentId': '24680',
      'email': 'sample@my.sctcc.edu',
    },
    {
      'name': 'User 4',
      'studentId': '13579',
      'email': 'sample@my.sctcc.edu',
    },
    {
      'name': 'User 5',
      'studentId': '11111',
      'email': 'sample@my.sctcc.edu',
    }
    //replace with user data from database
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('My Campus Marketplace'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Welcome, $userName'),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'signOut') {
                      //_logout();
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'signOut',
                      child: Text('Sign Out'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
                        builder: (context) => ExpandedUser(user: user),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[                       
                          SizedBox(width: 16),
                          // This column contains the item's name, condition, and price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  user['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Student ID: ${user['studentId']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Student Email: ${user['email']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
  runApp(AdminUsers(userName: "User"));
}
