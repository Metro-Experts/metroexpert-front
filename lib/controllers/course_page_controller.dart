// ignore_for_file: await_only_futures, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';

class CoursePageController extends ChangeNotifier {
  bool isJoined = false;
  late String tutoringId;
  late GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;

  void setScaffoldMessengerKey(GlobalKey<ScaffoldMessengerState> key) {
    _scaffoldMessengerKey = key;
  }

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
        _scaffoldMessengerKey.currentState!.showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            content: SizedBox(
              height: 25,
              child: Text(
                textAlign: TextAlign.justify,
                'Subscripción exitosa',
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
      _scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'Error al suscribirse',
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
        _scaffoldMessengerKey.currentState!.showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            content: SizedBox(
              height: 25,
              child: Text(
                textAlign: TextAlign.justify,
                'Subscripción eliminada',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        );
      } else {}
    } catch (e) {
      _scaffoldMessengerKey.currentState!.showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'Error al eliminar la subscripción',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    }
  }

  Future<bool?> showConfirmationDialog(BuildContext context) async {
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
              onPressed: () async {
                Navigator.of(context).pop(true);
                if (isJoined) {
                  await unsubscribeUser(context);
                } else {
                  await subscribeUser(context);
                }
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );

    if (action == true) {
      isJoined = !isJoined;
      notifyListeners();
    }

    return action;
  }
}
