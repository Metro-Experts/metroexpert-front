import 'package:flutter/material.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListBody(
          children: [
            /*
            Stack(
              children: [
                  Image.asset('assets/images/decoration.png',
                    scale: 1.5,
                    alignment: const Alignment(-3,1),
                    color: const Color.fromRGBO(0xFE,0xC8,0x9F,1),
                  ),
                  Image.asset('assets/images/decoration.png',
                      scale: 1.5,
                      alignment: const Alignment(0.5,3),
                  ),
              ],
            ),
            */
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(50,1,50,1),
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Full name',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(50,1,50,1),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      )
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
                    child: const Text('Continue with Google', style: TextStyle(
                      fontSize: 18
                    ),),
                    onPressed: () => {}
                  ),
                  const SizedBox(height: 45),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50,1,50,1),
                      child: ElevatedButton(
                        onPressed: () => {},
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(Color.fromRGBO(0xF2,0xB0,0x80,1)),
                        ),
                        child: const Text('LOG IN',
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
                  const Text('¿No tienes cuenta?', style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  TextButton(
                      child: const Text('Regístrate aquí', style: TextStyle(
                          fontSize: 18
                      ),),
                      onPressed: () => {}
                  ),
                  /*
                  Stack(
                    children: [
                      SizedBox(
                          child: Transform(
                            transform: Matrix4.rotationZ(-1.57),
                            child: Image.asset('assets/images/decoration.png',
                              width: 225, height: 168,
                              alignment: const Alignment(-3.5,6.5),
                              color: const Color.fromRGBO(0xFE,0xC8,0x9F,1),
                            ),
                          )
                      ),
                      SizedBox(
                          child: Transform(
                            transform: Matrix4.rotationZ(-1.57),
                            child: Image.asset('assets/images/decoration.png',
                              width: 225, height: 168,
                              alignment: const Alignment(-3.5,4),
                            ),
                          )
                      ),
                    ],
                  )
                  */
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}