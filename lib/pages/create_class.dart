import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:metro_experts/components/custom_text_field.dart';
import 'package:metro_experts/components/dropDownMenu.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:metro_experts/pages/sign_in_page.dart';
import 'package:metro_experts/pages/user_edit_profile.dart';

class User {
  final dynamic name;
  final dynamic lastName;
  final dynamic email;

  User({
    required this.name,
    required this.lastName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lastName": lastName,
    };
  }
}

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  List<String> categoryList = [
    "Matemática",
    "Programación",
    "Física",
    "Química"
  ];

  String categorySelection = '';
  String? subject;
  String modality = '';
  TextEditingController priceController = TextEditingController();
  TextEditingController dia1Controller = TextEditingController();
  TextEditingController hora1Controller = TextEditingController();
  TextEditingController dia2Controller = TextEditingController();
  TextEditingController hora2Controller = TextEditingController();

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
  List<String> programming = [
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
  List<String> physics = ["Fisica 1", "Fisica 2", "Fisica 3"];
  List<String> chemistry = [
    "Quimica 1",
    "Termodinamica",
    "Principios de procesos industriales"
  ];

  List<String> modalidadList = ["Presencial", "Virtual"];
  List<String> scheduleList = ["8:00AM", "9:00AM", "10:00AM", "3:00PM"];
  String? selectedVal = "";
  User userData = User(
    name: '',
    lastName: '',
    email: '',
  );

  Future<void> fetchUser() async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/${Auth().currentUser!.uid}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);

      setState(
        () {
          userData = User(
              name: responseData['name'],
              lastName: responseData['lastName'],
              email: responseData['email']);
          print(userData.name);
        },
      );
    } else {
      print('error fetching tutorings...');
    }
  }

  Future<void> createClass() async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/courses/');
    const headers = {'Content-Type': 'application/json'};
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        {
          "tutor": {
            "name": userData.name,
            "lastName": userData.lastName,
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
              style: TextStyle(color: Colors.white),
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
    print(response.body);
  }

  @override
  void initState() {
    fetchUser();
    print(Auth().currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(
                size: 32,
                Icons.home,
                color: Color.fromRGBO(238, 138, 111, 1),
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 32,
                color: Color.fromRGBO(238, 138, 111, 1),
              ),
              title: const Text('Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserEditProfile()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 32,
                color: Color.fromRGBO(238, 138, 111, 1),
              ),
              title: const Text('Logout',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onTap: () {
                Auth().signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInPage()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            DropDownMenu(
              text: "Selecciona una categoría: ",
              menuList: categoryList,
              onSelectionChanged: (val) {
                setState(
                  () {
                    categorySelection = val!;
                  },
                );
              },
            ),
            const SizedBox(height: 50),
            DropDownMenu(
              text: "Selecciona una asignatura: ",
              menuList: categorySelection == categoryList[0]
                  ? mathList
                  : categorySelection == categoryList[1]
                      ? programming
                      : categorySelection == categoryList[2]
                          ? physics
                          : categorySelection == categoryList[3]
                              ? chemistry
                              : [],
              onSelectionChanged: (val) {
                setState(() {
                  subject = val!;
                });
              },
            ),
            const SizedBox(height: 50),
            CustomTextField(
              labelText: "Dia 1",
              placeholder: 'Lunes',
              isPasswordTextField: false,
              controller: dia1Controller,
            ),
            CustomTextField(
              labelText: "Hora 1",
              placeholder: '17:00',
              isPasswordTextField: false,
              controller: hora1Controller,
            ),
            CustomTextField(
              labelText: "Dia 2",
              placeholder: 'Martes',
              isPasswordTextField: false,
              controller: dia2Controller,
            ),
            CustomTextField(
              labelText: "Hora 2",
              placeholder: '21:00',
              isPasswordTextField: false,
              controller: hora2Controller,
            ),
            const SizedBox(height: 50),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 5),
                labelText: "Precio por hora:",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "\$",
                hintStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 50),
            DropDownMenu(
              text: "Selecciona una modalidad: ",
              menuList: modalidadList,
              onSelectionChanged: (val) {
                setState(() {
                  modality = val!;
                });
              },
            ),
            const SizedBox(height: 80),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    createClass();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfff060B26),
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Crear",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xfffFF0000),
                  ),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
