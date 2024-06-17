// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:provider/provider.dart';

class CreateClassPageController extends ChangeNotifier {
  List<String> categoryList = [
    "Matemática",
    "Programación",
    "Física",
    "Química"
  ];

  List<String> mathList = [
    "Matematica basica",
    "Matematica 1",
    "Matematica 2",
    "Matematica 3",
    "Matematica 4",
    "Matematica 5",
    "Algebra Lineal",
    "Matematica discreta",
    "Calculo numerico",
    "Estadistica",
    "Modelos estocasticos"
  ];
  List<String> programmingList = [
    "Algoritmos y programacion",
    "Estructura de datos",
    "Base de datos 1",
    "Base de datos 2",
    "Arquitectura del computador",
    "Organizacion del computador",
    "Sistema de redes",
    "Computacion emergentes",
    "Sistemas Operativos"
  ];
  List<String> physicsList = ["Fisica 1", "Fisica 2", "Fisica 3"];

  List<String> chemistryList = [
    "Quimica 1",
    "Termodinamica",
    "Principios de procesos industriales"
  ];

  List<String> modalidadList = ["Presencial", "Virtual"];

  List<String> scheduleList = ["8:00AM", "9:00AM", "10:00AM", "3:00PM"];

  String? selectedVal = "";

  String categorySelection = '';

  String? subject;

  String modality = '';

  List<String> categoryChildList = [];

  TextEditingController priceController = TextEditingController();
  TextEditingController dia1Controller = TextEditingController();
  TextEditingController hora1Controller = TextEditingController();
  TextEditingController dia2Controller = TextEditingController();
  TextEditingController hora2Controller = TextEditingController();

  List<String> subjectsList(String categorySelection) {
    if (categorySelection == 'Matemática') {
      categoryChildList = mathList;
    } else if (categorySelection == 'Programación') {
      categoryChildList = programmingList;
    } else if (categorySelection == 'Física') {
      categoryChildList = physicsList;
    } else {
      categoryChildList = chemistryList;
    }

    // Remove any duplicate values from the categoryChildList
    categoryChildList = categoryChildList.toSet().toList();

    return categoryChildList;
  }

  Future<void> createClass(BuildContext context) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/courses/');
    const headers = {'Content-Type': 'application/json'};
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        {
          "tutor": {
            "name": Provider.of<UserOnSession>(context, listen: false)
                .userData
                .name,
            "lastName": Provider.of<UserOnSession>(context, listen: false)
                .userData
                .lastName,
            "rating": 5,
            "id": Auth().currentUser!.uid,
          },
          "name": subject,
          "description": "Aprende fácil",
          "date": [
            {"day": dia1Controller.text, "hour": hora1Controller.text},
            {"day": dia2Controller.text, "hour": hora2Controller.text},
          ],
          "price": priceController.text,
          "modality": modality,
        },
      ),
    );
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'Class created successfully',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'Error Creating The Class',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    }
  }
}
