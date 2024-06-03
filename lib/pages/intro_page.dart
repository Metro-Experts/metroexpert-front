import 'package:flutter/material.dart';
import 'package:metro_experts/pages/sign_in_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEE8A6F),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: PageView.builder(
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/teacher_and_student.PNG"),
                  const SizedBox(height: 70),
                  const Text(
                    "Recibe tus clases, fácil y rápido",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Conéctate con tutores expertos y alcanza tus metas educativas. ¡Tu éxito académico comienza aquí!",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogInPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                      ),
                      child: const Text(
                        'Comenzar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffEE8A6F),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
