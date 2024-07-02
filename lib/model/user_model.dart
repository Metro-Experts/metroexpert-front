import 'package:flutter/material.dart';

class UserModel {
  final dynamic name;
  final dynamic lastName;
  final dynamic email;
  final dynamic id;

  UserModel({
    required this.name,
    required this.lastName,
    required this.email,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        lastName: json['lastName'],
        email: json['email'],
        id: json['_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lastName": lastName,
    };
  }
}

class UserOnSession extends ChangeNotifier {
  UserModel _userData = UserModel(
    name: '',
    lastName: '',
    email: '',
    id: '',
  );

  UserModel get userData => _userData;

  void updateUserData(user) {
    _userData = UserModel.fromJson(user);
    notifyListeners();
  }
}
