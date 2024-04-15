class User {
  int userID;
  String firstName;
  String lastName;
  String studentID;
  String studentEmail;
  String userName;
  bool admin;
  bool banned;
  DateTime creationDate;

  User(
      {required this.userID,
      required this.firstName,
      required this.lastName,
      required this.studentID,
      required this.studentEmail,
      required this.userName,
      required this.admin,
      required this.banned,
      required this.creationDate});

  String getFullName() {
    return "$firstName $lastName";
  }
}
