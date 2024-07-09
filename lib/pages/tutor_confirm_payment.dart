import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class TutorConfirmPayment extends StatelessWidget {
  final String classTitle;
  final String studentName;
  final String fechaComprobante;
  final double monto;
  final String bancoEmisor;
  final String referencia;
  final String telefono;
  final List<dynamic> imgData;
  final String contentType;

  const TutorConfirmPayment({
    super.key,
    required this.classTitle,
    required this.studentName,
    required this.fechaComprobante,
    required this.monto,
    required this.bancoEmisor,
    required this.referencia,
    required this.telefono,
    required this.imgData,
    required this.contentType,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Confirmación de Pago",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
        ),
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
                  ListTile(
                    title: Text(
                      classTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    subtitle: Text(
                      studentName,
                      style: const TextStyle(fontSize: 16),
                    ),
                    leading: const Icon(Icons.menu_book_outlined,
                        color: Colors.black, size: 55),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Detalles del Pago:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Monto: ${monto.toStringAsFixed(2)} Bs.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Referencia: $referencia',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
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
                  if (imgData.isNotEmpty)
                    SizedBox(
                      child: Image.memory(
                        base64Decode(base64Encode(List<int>.from(imgData))),
                      ),
                    ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff008000),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 10),
                      ),
                      label: const Text(
                        'Confirmar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      icon: const Icon(Icons.check,
                          color: Colors.white, size: 25),
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
