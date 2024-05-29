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
      body: SizedBox(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Stack(
              children: [         
                Transform.translate(
                  offset: const Offset(-150,-80),
                  child: Image.asset(
                    'assets/images/decoration.png',
                    color: const Color.fromRGBO(0xF2,0xB0,0x80, 1),)
                  ),
                Transform.translate(
                  offset: const Offset(-50,-130),
                  child:
                    Image.asset(
                      'assets/images/decoration.png',
                    ),
                  ),            
              ],
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(0),
              child: const Text(
                '   LOG IN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
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
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Full name',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ),
                    
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Or',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => {},
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                    ),
                    child: Image.asset(
                      'assets/images/Vector.png',
                      width: 200,
                      height: 50,
                    ),                
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
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('¿No tienes cuenta?',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  TextButton(
                      child: const Text('Regístrate aquí',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      onPressed: () => {}
                  ),
                ],
              ),
            ),
            Stack(
              children: [         
                Transform.translate(
                  offset: const Offset(170,40),
                  child: Image.asset(
                    'assets/images/decoration.png',
                    color: const Color.fromRGBO(0xF2,0xB0,0x80, 1),)
                  ),
                Transform.translate(
                  offset: const Offset(280,0),
                  child:
                    Image.asset(
                      'assets/images/decoration.png',
                    ),
                  ),            
              ],
            ),
          ],
        ),
      )
    );
  }
}