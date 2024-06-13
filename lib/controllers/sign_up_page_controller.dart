// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPageController extends ChangeNotifier {
  void reset() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    cellPhoneController.clear();
    notifyListeners();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cellPhoneController = TextEditingController();
  String genderValue = '';
  String selectedOption = "";
  bool showTutorSection = false;
  bool? isChecked = false;

  Future<void> createUserWithEmailAndPassword(
    BuildContext context,
  ) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/');
    const headers = {'Content-Type': 'application/json'};
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      String uid = userCredential.user!.uid;
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          "_id": uid,
          "name": firstNameController.text,
          "lastName": lastNameController.text,
          "email": emailController.text,
          "userType": selectedOption,
          "cellphone": cellPhoneController.text,
          "gender": genderValue.contains('Masculino') ? 'M' : 'F'
        }),
      );

      if (response.statusCode == 201 && Auth().authStateChanges != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            content: SizedBox(
              height: 25,
              child: Text(
                textAlign: TextAlign.justify,
                'User successfuly created',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              e.message!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }
}
