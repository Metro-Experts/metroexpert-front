import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:metro_experts/components/custom_history_card.dart';
import 'package:flutter/services.dart';
import 'package:metro_experts/components/drawer_menu.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:http/http.dart' as http;

class PaymentsHistoryPage extends StatefulWidget {
  const PaymentsHistoryPage({super.key});

  @override
  State<PaymentsHistoryPage> createState() => _PaymentsHistoryPageState();
}

class _PaymentsHistoryPageState extends State<PaymentsHistoryPage> {
  List<dynamic> confirmedTutoriasList = [];
  bool isLoading = true; // Variable para controlar el estado de carga

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var userId = Auth().currentUser!.uid;

    final response = await http.get(Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/images/tutor/confirmaciones/${userId}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        confirmedTutoriasList = List<dynamic>.from(responseData['confirmadas']);
        isLoading =
            false; // Actualiza el estado de carga una vez que los datos se han obtenido
      });
    } else {
      setState(() {
        isLoading =
            false; // Incluso si hay un error, deja de mostrar el indicador de carga
      });
      throw Exception(
          'Error al obtener los datos del API. Código de estado: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pagos recibidos",
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
      ),
      drawer: const DrawerMenu(),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: isLoading
            ? const Center(
                child:
                    CircularProgressIndicator(), // Muestra un indicador de carga mientras se obtienen los datos
              )
            : Column(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          "A continuación, podrás observar un historial de los pagos que has recibido:",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: Color(0xFF7F7F7F),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          child: confirmedTutoriasList.isEmpty
                              ? Center(
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 60, 16.0, 0),
                                    child: const Text(
                                      '¡Todavía no has recibido ningún pago!',
                                      style: TextStyle(
                                          color: Color(0xFF7F7F7F),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: confirmedTutoriasList.map(
                                    (subject) {
                                      Color cardColor = confirmedTutoriasList
                                                      .indexOf(subject) %
                                                  2 ==
                                              0
                                          ? const Color(0xFF9FA9FF)
                                          : const Color(0xFFFEC89F);

                                      // Formatear fecha
                                      String obtenerFecha(String fechaConHora) {
                                        DateTime fecha =
                                            DateTime.parse(fechaConHora);
                                        String fechaFormateada =
                                            '${fecha.day}/${fecha.month}/${fecha.year}';
                                        return fechaFormateada;
                                      }

                                      String fechaFormateada = obtenerFecha(
                                          subject['fechaComprobante']);

                                      return Column(
                                        children: [
                                          CustomHistoryCard(
                                            classTitle:
                                                subject['nombreTutoria'],
                                            studentName: subject['estudiante']
                                                ['name'],
                                            amount: '${subject['monto']}',
                                            date: fechaFormateada,
                                            color: cardColor,
                                          ),
                                          const SizedBox(
                                              height:
                                                  5), // Aumenta el espacio entre tarjetas
                                        ],
                                      );
                                    },
                                  ).toList(),
                                ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
