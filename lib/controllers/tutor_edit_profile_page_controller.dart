// ignore_for_file: use_build_context_synchronously, avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:provider/provider.dart';

class TutorEditProfilePageController extends ChangeNotifier {
  void reset() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    lastNameController.clear();
    notifyListeners();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> fetchUser(BuildContext context) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/${Auth().currentUser!.uid}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);

      Provider.of<UserOnSession>(context, listen: false)
          .updateUserData(responseData);
    } else {
      print('error fetching tutorings...');
    }
  }

  Future<void> saveUserInformation(UserModel user, BuildContext context) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/${Auth().currentUser!.uid}');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: user.toJson(),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'Data Uploaded successfully',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ),
      );
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }
}
