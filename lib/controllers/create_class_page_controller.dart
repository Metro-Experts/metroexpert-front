// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:provider/provider.dart';

class CreateClassPageController extends ChangeNotifier {
  List<String> categoryList = [
    "Matemática",
    "Programación",
    "Física",
    "Química"
  ];

  List<String> mathList = [
    "Matemática basica",
    "Matemática 1",
    "Matemática 2",
    "Matemática 3",
    "Matemática 4",
    "Matemática 5",
    "Álgebra Lineal",
    "Matemática Discreta",
    "Cálculo Numérico",
    "Estadística para Ingenieros I",
    "Modelos Estocásticos"
  ];
  List<String> programmingList = [
    "Algoritmos y Programación",
    "Estructura de datos",
    "Base de datos 1",
    "Base de datos 2",
    "Arquitectura del Computador",
    "Organización del Computador",
    "Sistema de Redes",
    "Computación Emergente",
    "Sistemas Operativos"
  ];
  List<String> physicsList = ["Física 1", "Física 2", "Física 3"];

  List<String> chemistryList = [
    "Química 1",
    "Termodinámica",
    "Principios de Procesos Industriales"
  ];

  List<String> modalidadList = ["Presencial", "Virtual"];

  List<String> scheduleList = ["8:00AM", "9:00AM", "10:00AM", "3:00PM"];

  List<String> months = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
  ];

  String categorySelection = '';

  String? subject;

  String modality = '';

  String classStartMonth = '';

  String classEndMonth = '';

  List<String> categoryChildList = [];

  final hourFormat = RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$');

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

  List<String> daysOfTheWeek = [
    'lunes',
    'martes',
    'miercoles',
    'miércoles',
    'jueves',
    'viernes',
    'sabado',
    'sábado',
    'domingo'
  ];

  Future<void> createClass(BuildContext context) async {
    if (categorySelection == '' ||
        subject == '' ||
        priceController.text == '' ||
        modality == '' ||
        hora1Controller.text == '' ||
        hora2Controller.text == '' ||
        dia1Controller.text == '' ||
        dia2Controller.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'Llene todos los campos',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    } else if (!daysOfTheWeek.contains(dia1Controller.text.toLowerCase()) ||
        !daysOfTheWeek.contains(dia2Controller.text.toLowerCase())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'Error al ingresar día',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    } else if (!hourFormat.hasMatch(hora1Controller.text) ||
        !hourFormat.hasMatch(hora2Controller.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'Error al ingresar horario',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    } else {
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
              "bankaccount": {
                "cedula": "26573457",
                "numcell": "04129704419",
                "bank": "Mercantil"
              },
            },
            "name": subject,
            "description": "Aprende fácil",
            "date": [
              {"day": dia1Controller.text, "hour": hora1Controller.text},
              {"day": dia2Controller.text, "hour": hora2Controller.text},
            ],
            "price": priceController.text,
            "modality": modality,
            "category": categorySelection,
            "inicio": classStartMonth,
            "final": classEndMonth
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
                '¡Clase creada con éxito!',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        dia1Controller.clear();
        dia2Controller.clear();
        hora1Controller.clear();
        hora2Controller.clear();
        priceController.clear();
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
                'Error creando la clase',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        );
      }
    }
  }
}
