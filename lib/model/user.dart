import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? email;
  String? fullName;
  String? phoneNumber;

  void setUser({
    required String email,
    required String fullName,
    required String phoneNumber,
  }) {
    this.email = email;
    this.fullName = fullName;
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }
}
