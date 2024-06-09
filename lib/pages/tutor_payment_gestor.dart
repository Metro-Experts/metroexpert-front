import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metro_experts/components/custom_listtile.dart';

class TutorPaymentGestor extends StatefulWidget {
  const TutorPaymentGestor({super.key});

  @override
  State<TutorPaymentGestor> createState() => _TutorPaymentGestorState();
}

class _TutorPaymentGestorState extends State<TutorPaymentGestor> {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmación de Pagos",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              color: Colors.grey,
              height: 0.5,
            ),
          ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child:  Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView( 
              children: const [
                SizedBox(height: 35),
                Text(
                  "Recientemente has recibido los pagos que se muestran a continuación:", 
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xFF7F7F7F),
                  ),
                ),
                SizedBox(height: 35),
                Customlisttile(classTitle: "Matemática II", studentName: "Beatriz Cardozo"),
                SizedBox(height: 20),
                Customlisttile(classTitle: "Matemática IV", studentName: "Hugo Duque"),
                SizedBox(height: 20),
                Customlisttile(classTitle: "Estadística", studentName: "Román Chacín"),
                SizedBox(height: 20),
                Customlisttile(classTitle: "Bases de Datos I", studentName: "Felipe Escalona",),
              ],
            ),
            )
          ],
        )
      ),
    );
  }
}