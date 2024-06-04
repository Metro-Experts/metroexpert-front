// ignore_for_file: use_full_hex_values_for_flutter_colors
import 'package:flutter/material.dart';
import 'package:metro_experts/components/custom_text_field.dart';
import 'package:metro_experts/components/multi_textfield.dart';
//para uso de iconos svg
import 'dart:async';
import 'dart:convert';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:http/http.dart' as http;
import 'package:metro_experts/pages/home_page.dart';
import 'package:metro_experts/pages/sign_in_page.dart';

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

class TutorEditProfile extends StatefulWidget {
  const TutorEditProfile({super.key});

  @override
  State<TutorEditProfile> createState() => _TutorEditProfileState();
}

class _TutorEditProfileState extends State<TutorEditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
        },
      );
    } else {
      print('error fetching tutorings...');
    }
  }

  Future<void> saveUserInformation(User user) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/${Auth().currentUser!.uid}');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      print(response.body);
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
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      print('API request failed with status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    fetchUser();
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
              onTap: () {},
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
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)),
                      ],
                      shape: BoxShape.circle,
                      //image: DecorationImage(
                      //fit: BoxFit.cover,
                      // image: NetworkImage(),

                      // )
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
                labelText: "Nombre de Usuario",
                placeholder: userData.name,
                isPasswordTextField: false,
                controller: nameController),
            CustomTextField(
              labelText: "Apellido Del Usuario",
              placeholder: userData.lastName,
              isPasswordTextField: false,
              controller: lastNameController,
            ),
            CustomTextField(
              labelText: "Email",
              placeholder: userData.email,
              isPasswordTextField: false,
              controller: emailController,
            ),
            CustomTextField(
              labelText: "Contraseña",
              placeholder: "********",
              isPasswordTextField: true,
              controller: passwordController,
            ),
            const MultiTextfield(
              bottomPadding: 10,
              leftPadding: 50,
              rightPadding: 50,
              labelText: 'Sobre mí:',
              placeholder: '...',
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                  ElevatedButton(
                    onPressed: () {
                      saveUserInformation(
                        User(
                          name: nameController.text,
                          lastName: lastNameController.text,
                          email: userData.email,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff060B26),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Guardar",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
