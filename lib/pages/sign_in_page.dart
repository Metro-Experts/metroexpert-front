// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:metro_experts/controllers/sign_in_page_controller.dart';
import 'package:metro_experts/pages/sign_up_page.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  void initState() {
    Provider.of<SignInPageController>(context, listen: false).reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signInPageController =
        Provider.of<SignInPageController>(context, listen: false);
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
                      controller: signInPageController.emailController,
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
                      controller: signInPageController.passwordController,
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
                    'or',
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
                          signInPageController
                              .signInWithEmailAndPassword(context),
                        },
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                              Color.fromRGBO(0xF2, 0xB0, 0x80, 1)),
                        ),
                        child: const Text(
                          'Iniciar sesión',
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
