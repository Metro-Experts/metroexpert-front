import 'package:flutter/material.dart';
import 'package:metro_experts/components/customTextField.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  offset: const Offset(-120,-80),
                  child: SvgPicture.asset(
                    'assets/images/decoration.svg',
                    color: const Color.fromRGBO(0xF2,0xB0,0x80, 1)
                  )
                ),
                Transform.translate(
                  offset: const Offset(-30,-120),
                  child:
                    SvgPicture.asset(
                      'assets/images/decoration.svg',
                    ),
                  ),            
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              '   LOG IN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),     
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  const CustomTextField(labelText: "Username", placeholder: "Jhon Doe", isPasswordTextField: false),
                  const CustomTextField(labelText: "Password", placeholder: "********", isPasswordTextField: true),
                  const Text(
                    'Or',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => {},
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),                    
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      width: 200,
                      height: 40,
                      child: SvgPicture.asset(
                        'assets/images/Vector.svg',
                      ),
                    ),             
                  ), 
                  const SizedBox(height: 30),
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
                  offset: const Offset(170,30),
                  child: SvgPicture.asset(
                    'assets/images/decoration.svg',
                    color: const Color.fromRGBO(0xF2,0xB0,0x80, 1),)
                  ),
                Transform.translate(
                  offset: const Offset(280,0),
                  child:
                    SvgPicture.asset(
                      'assets/images/decoration.svg',
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