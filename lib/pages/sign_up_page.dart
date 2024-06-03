import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metro_experts/components/dropdownmenu.dart';
import 'package:metro_experts/components/multi_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

   //Variables de ejemplos para poder trabajar en esto
  bool showTutorSection = false;
  String selectedOption = "";
  bool? isChecked = false;
  List<String> genderList = [
    "Femenino",
    "Masculino"
  ];

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: TextField(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Nombre Completo',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: TextField(
                      //controller: _passwordController,
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
                    child: dropDownMenu(text: "Género", menuList: genderList),
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
                            value: 'Tutor',
                            groupValue: selectedOption,
                            onChanged: (selectedValue){
                              setState(() =>
                                selectedOption = selectedValue!);
                                showTutorSection = true;
                            },
                            child: const Text('Tutor'),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: RadioMenuButton(
                            value: 'Estudiante',
                            groupValue: selectedOption,
                            onChanged: (selectedValue){
                              setState(() =>
                                selectedOption = selectedValue!);
                                showTutorSection = false;
                            },
                            child: const Text('Estudiante'),
                          ),
                        ),
                        Visibility(
                          visible: showTutorSection,
                          child: tutorSection()),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                value: isChecked, 
                                activeColor: Colors.black,
                                onChanged: (newBool){
                                  setState(() {
                                    isChecked = newBool;
                                  });
                                }
                              ),
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
                          //signInWithEmailAndPassword(),
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                              Color.fromRGBO(0xF2, 0xB0, 0x80, 1)),
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
                    onPressed: () => {},
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class tutorSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 1),
        child: MultiTextfield(bottomPadding: 0, leftPadding: 0, rightPadding: 0, labelText: 'Cuéntanos de ti:', placeholder: '...',)
      
    );
  }
}