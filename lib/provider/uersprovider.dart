import 'package:flutter/material.dart';
import 'package:gift_planner/models/users.dart';

class UserProvider with ChangeNotifier {
  User _user = User(
    firstName: '',
    lastName: '',
    username: '',
    phoneNumber: '',
    email: '',
    profileImage: '',
  );

  User get user => _user;

  void updateUser({
    required String firstName,
    required String lastName,
    required String username,
    required String phoneNumber,
    required String password,
    required String email,
    required String profileImage,
  }) {
    _user = User(
        firstName: firstName,
        lastName: lastName,
        username: username,
        phoneNumber: phoneNumber,
        profileImage: profileImage,
        email: email);
    notifyListeners();
  }
}
