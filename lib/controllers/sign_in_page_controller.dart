import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/pages/home_page.dart';

class SignInPageController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validate inputs
    if (email.isEmpty) {
      showErrorSnackbar(context, 'El correo electrónico no puede estar vacío.');
      return;
    }

    if (password.isEmpty) {
      showErrorSnackbar(context, 'La contraseña no puede estar vacía.');
      return;
    }

    try {
      // Show the loading dialog
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing by tapping outside
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(238, 138, 111, 1),
            ),
          );
        },
      );

      // Perform the sign-in operation
      await Auth().signInWithEmailAndPassword(email: email, password: password);

      // Close the loading dialog
      Navigator.of(context).pop();

      // Navigate to the home page
      if (Auth().authStateChanges != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Close the loading dialog
      Navigator.of(context).pop();

      // Log the error code for debugging
      print('FirebaseAuthException code: ${e.code}');

      // Translate and show the error message
      String errorMsg = getErrorMessage(e.code);
      showErrorSnackbar(context, errorMsg);
    }
  }

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
        return 'La credenciales proporcionadas no son válidas.';
      default:
        return 'Se produjo un error. Por favor, inténtelo de nuevo.';
    }
  }

  void showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
