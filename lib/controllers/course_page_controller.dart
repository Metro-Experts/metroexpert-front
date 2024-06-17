// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';

class CoursePageController extends ChangeNotifier {
  bool isJoined = false;
  late String tutoringId;

  Future isAStudent(List tutoringStudents, String uid) async {
    if (await tutoringStudents.contains(uid)) {
      isJoined = true;
    } else {
      isJoined = false;
    }
    notifyListeners();
  }

  Future<void> subscribeUser(BuildContext context) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/courses/$tutoringId/add-student');
    const headers = {'Content-Type': 'application/json'};

    final response = await http.post(url,
        headers: headers,
        body: json.encode({"studentId": Auth().currentUser!.uid}));
    try {
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
                'successfuly created subscribe',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        );
        notifyListeners();
      } else {
        print(" ERROR ---- ${response.body}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'error subscribing',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    }
  }

  Future<void> unsubscribeUser(BuildContext context) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/courses/$tutoringId/remove-student');
    const headers = {'Content-Type': 'application/json'};

    final response = await http.post(url,
        headers: headers,
        body: json.encode({"studentId": Auth().currentUser!.uid}));
    try {
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
                'Subscription deleted',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        );
      } else {}
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'Error deleting the subscription',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    }
  }

  showConfirmationDialog(BuildContext context) async {
    final action = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isJoined ? 'Confirmar Salida' : 'Confirmar Unión'),
          content: Text(
            isJoined
                ? '¿Estás seguro que deseas salir de la clase?'
                : '¿Estás seguro que deseas unirte a la clase?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                subscribeUser(context); // Sí
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );

    if (action == true) {
      isJoined = !isJoined;
    }
  }
}
