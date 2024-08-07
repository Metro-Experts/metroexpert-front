// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:metro_experts/components/multi_textfield.dart';
import 'package:metro_experts/controllers/sign_up_page_controller.dart';
import 'package:metro_experts/pages/sign_in_page.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<String> genderList = ["Femenino", "Masculino"];
  List<String> careerList = [
    "Ingeniería Civil",
    "Ingeniería Mecánica",
    "Ingeniería Producción",
    "Ingeniería Química",
    "Ingeniería de Sistemas",
    "Ingeniería Eléctrica",
    "Ciencias Administrativas",
    "Economía Empresarial",
    "Contaduría Pública",
    "Psicología",
    "Matemáticas Industriales",
    "Educación",
    "Idiomas Modernos",
    "Estudios Liberales",
    "Derecho"
  ];

  @override
  Widget build(BuildContext context) {
    final signUpPageController =
        Provider.of<SignUpPageController>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: ListBody(
          children: [
            const SizedBox(height: 120),
            const Text(
              '   SIGN UP   ',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: TextField(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Nombre',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      controller: signUpPageController.firstNameController,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: TextField(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Apellido',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      controller: signUpPageController.lastNameController,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: TextField(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      controller: signUpPageController.emailController,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: TextField(
                      controller: signUpPageController.passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        hintText: 'Contraseña',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: TextField(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: '584241499654',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      controller: signUpPageController.cellPhoneController,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: 'Seleccione su género:',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      items: genderList
                          .map((gender) => DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          signUpPageController.genderValue = value!;
                        });
                      },
                      value: signUpPageController.genderValue.isNotEmpty
                          ? signUpPageController.genderValue
                          : null,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        hintText: 'Seleccione su carrera:',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      items: careerList
                          .map((career) => DropdownMenuItem<String>(
                                value: career,
                                child: Text(career),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          signUpPageController.careerValue = value!;
                        });
                      },
                      value: signUpPageController.careerValue.isNotEmpty
                          ? signUpPageController.careerValue
                          : null,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: Text(
                      "Deseo ingresar como: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: RadioMenuButton(
                            value: 'tutor',
                            groupValue: signUpPageController.selectedOption,
                            onChanged: (selectedValue) {
                              setState(() {
                                signUpPageController.selectedOption =
                                    selectedValue!;
                                signUpPageController.showTutorSection = true;
                              });
                            },
                            child: const Text('Tutor'),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: RadioMenuButton(
                            value: 'student',
                            groupValue: signUpPageController.selectedOption,
                            onChanged: (selectedValue) {
                              setState(() {
                                signUpPageController.selectedOption =
                                    selectedValue!;
                                signUpPageController.showTutorSection = false;
                              });
                            },
                            child: const Text('Estudiante'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Visibility(
                            visible: signUpPageController.showTutorSection,
                            child: MultiTextfield(
                              labelText: 'Cuentanos de ti',
                              placeholder:
                                  'Soy un estudiante que busca ayudar a mis compañeros',
                              bottomPadding: 0,
                              leftPadding: 0,
                              rightPadding: 0,
                              controller: signUpPageController
                                  .tutorDescriptionController,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                  value: signUpPageController.isChecked,
                                  activeColor: Colors.black,
                                  onChanged: (newBool) {
                                    setState(() {
                                      signUpPageController.isChecked = newBool;
                                    });
                                  }),
                              const Text('Acepto los términos y condiciones'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                      child: ElevatedButton(
                        onPressed: () => {
                          signUpPageController
                              .createUserWithEmailAndPassword(context),
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromRGBO(0xF2, 0xB0, 0x80, 1),
                          ),
                        ),
                        child: const Text(
                          'Crear una cuenta',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '¿Ya tienes cuenta?',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    child: const Text(
                      'Ingresa aquí',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogInPage(),
                        ),
                      ),
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
