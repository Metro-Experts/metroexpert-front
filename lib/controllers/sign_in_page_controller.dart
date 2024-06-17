// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/pages/home_page.dart';

class SignInPageController extends ChangeNotifier {
  String? errorMessage = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      // Show the dialog
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(238, 138, 111, 1),
            ),
          );
        },
      );

      // Perform the sign-in operation
      await Auth().signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      // Close the dialog
      Navigator.of(context).pop();

      // Navigate to the home page
      if (Auth().authStateChanges != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Close the dialog
      Navigator.of(context).pop();

      // Show the error snackbar
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
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    }
  }
}
