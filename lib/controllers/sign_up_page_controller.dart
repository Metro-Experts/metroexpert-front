// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPageController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cellPhoneController = TextEditingController();
  final TextEditingController tutorDescriptionController =
      TextEditingController();
  String genderValue = '';
  String careerValue = '';
  String selectedOption = "";
  bool showTutorSection = false;
  bool? isChecked = false;

  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    if (!validateInputs(context)) {
      return;
    }

    String description = '';
    if (selectedOption == 'student') {
      description = 'Descripción predeterminada para estudiantes';
    } else if (selectedOption == 'tutor') {
      description = tutorDescriptionController.text;
    }

    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/');
    const headers = {'Content-Type': 'application/json'};
    try {
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

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.of(context)
          .pop(); // Close the loading dialog immediately after account creation

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
          "gender": genderValue.contains('Masculino') ? 'M' : 'F',
          "cellphone": cellPhoneController.text,
          "carrer": careerValue,
          "description": description,
        }),
      );

      if (response.statusCode == 201) {
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
            content: Text(
              'Usuario creado exitosamente',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Error al registrar el usuario en el servidor: ${response.body}'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.of(context)
          .pop(); // Close the loading dialog in case of an error
      String message = '';
      if (e.code == 'weak-password') {
        message = 'La contraseña es muy débil.';
      } else if (e.code == 'email-already-in-use') {
        message = 'El correo electrónico ya está en uso.';
      } else {
        message = 'Error al registrar el usuario: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    } catch (e) {
      Navigator.of(context)
          .pop(); // Close the loading dialog in case of an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error inesperado: $e'),
        ),
      );
    }
  }

  bool validateInputs(BuildContext context) {
    if (firstNameController.text.isEmpty) {
      showSnackBarMessage(context, 'Por favor, complete el nombre.');
      return false;
    }

    if (lastNameController.text.isEmpty) {
      showSnackBarMessage(context, 'Por favor, complete el apellido.');
      return false;
    }

    if (emailController.text.isEmpty) {
      showSnackBarMessage(
          context, 'Por favor, complete el correo electrónico.');
      return false;
    }

    if (!emailController.text.endsWith('@correo.unimet.edu.ve')) {
      showSnackBarMessage(context,
          'El correo electrónico debe pertenecer al dominio @correo.unimet.edu.ve.');
      return false;
    }

    if (passwordController.text.isEmpty) {
      showSnackBarMessage(context, 'Por favor, complete la contraseña.');
      return false;
    }

    if (cellPhoneController.text.isEmpty) {
      showSnackBarMessage(
          context, 'Por favor, complete el número de teléfono.');
      return false;
    }

    if (!RegExp(r'^58(424|412|416|426|414)\d{7}$')
        .hasMatch(cellPhoneController.text)) {
      showSnackBarMessage(context, 'Formato telefónico incorrecto');
      return false;
    }

    if (genderValue.isEmpty) {
      showSnackBarMessage(context, 'Por favor, seleccione el género.');
      return false;
    }

    if (careerValue.isEmpty) {
      showSnackBarMessage(context, 'Por favor, seleccione la carrera.');
      return false;
    }

    if (selectedOption.isEmpty) {
      showSnackBarMessage(context, 'Por favor, seleccione el tipo de usuario.');
      return false;
    }

    if (selectedOption == 'tutor' && tutorDescriptionController.text.isEmpty) {
      showSnackBarMessage(
          context, 'Por favor, complete la descripción del tutor.');
      return false;
    }

    if (isChecked != true) {
      showSnackBarMessage(
          context, 'Por favor, acepte los términos y condiciones.');
      return false;
    }

    return true;
  }

  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
