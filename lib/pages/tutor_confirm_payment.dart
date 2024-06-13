import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TutorConfirmPayment extends StatefulWidget {
  const TutorConfirmPayment({super.key});

  @override
  State<TutorConfirmPayment> createState() => _TutorConfirmPaymentState();
}

class _TutorConfirmPaymentState extends State<TutorConfirmPayment> {
  @override

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
       appBar: AppBar(
          title: const Text("Confirmación de Pago",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 20)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              color: Colors.grey,
              height: 0.5,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 55),
                    const Text(
                      "Verifica, cuidadosamente, que has recibido el siguiente pago:", 
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Color(0xFF7F7F7F),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const ListTile(
                      title: Text("Matemática 2", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                      subtitle: Text("Beatriz Cardozo", style: TextStyle(fontSize: 16)),
                      leading:Icon(Icons.menu_book_outlined, color: Colors.black, size: 55),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      "Comprobante:", 
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Image.asset('assets/images/pagoejemplo.png'),
                    ),
                    const SizedBox(height: 25),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color(0xff008000),
                      padding: const EdgeInsets.symmetric(
                      horizontal: 60, vertical: 10),
                    ),
                    label: const Text(
                      'Confirmar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:  Colors.white,
                      ),
                    ),
                    icon: const Icon(Icons.check, color: Colors.white, size: 25),
                    ),
                  ),
                ],
              ),
              )
            ],
          ),

      ),
    );
  }
}