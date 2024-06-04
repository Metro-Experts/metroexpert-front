// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:metro_experts/pages/sign_up_page.dart';
import 'package:metro_experts/pages/user_edit_profile.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String? errorMessage = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print('Currently signed with id: ${user.uid}');
        final response = await http.get(
          Uri.parse('https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/${user.uid}')
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
        // Si la solicitud fue exitosa
          print("${response.body}");
          Map<dynamic,dynamic> usuario = jsonDecode(response.body);
          //final userProvider = Provider.of<UserProvider>(context, listen: false);
          //userProvider.setUser(Usuario(name: usuario['name'], lastname: usuario['lastName'], email: usuario['email']));
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => UserProvider()),
            ]
          );
        } else {
          // Si la solicitud falló
          print("Failed to load user data");
        }
      }
      
      if (Auth().authStateChanges != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
            //builder: (context) => UserEditProfile(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              e.message!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: ListBody(
          children: [
            const SizedBox(height: 120),
            const Text(
              '   LOG IN',
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: TextField(
                      controller: _emailController,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Email',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        hintText: 'Contraseña',
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Or',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      'Continuar con Google',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () => {},
                  ),
                  const SizedBox(height: 45),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 1, 50, 1),
                      child: ElevatedButton(
                        onPressed: () => {
                          signInWithEmailAndPassword(),
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                              Color.fromRGBO(0xF2, 0xB0, 0x80, 1)),
                        ),
                        child: const Text(
                          'Iniciar Sesión',
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
                    '¿No tienes cuenta?',
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    child: const Text(
                      'Regístrate aquí',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()))
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
