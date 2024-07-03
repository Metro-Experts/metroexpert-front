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
  
  List<Map<String, dynamic>> ConfirmedPayments = [];

  List<dynamic> confirmedTutoriasList = [];

  @override
  void initState() {
    //fetchData();
    super.initState();
    _loadConfirmedTutorias();
  }

  Future<void> _loadConfirmedTutorias() async {
    String data = await DefaultAssetBundle.of(context).loadString('assets/tutorias.json');
    final List<dynamic> tutorias = json.decode(data)['tutorias'];

    setState(() {
      confirmedTutoriasList = tutorias.where((tutoria) => tutoria['status'] == 'confirmado').toList();
    });
  }


// Future<void> fetchData() async {
//   try {
//     var userId = Auth().currentUser!.uid;
//     final response = await http.get(Uri.parse('https://uniexpert-gateway-6569fdd60e75.herokuapp.com/images/tutor/$userId'),
//     headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//     },);
//     if (response.statusCode == 200) {
//       List<dynamic> responseData = json.decode(response.body);
      
//       ConfirmedPayments = responseData
//       .where((data) => data['status'] == 'confirmado')
//       .map((data) => Map<String, dynamic>.from(data))
//       .toList();
//     } else {
//       throw Exception('Error al obtener los datos del API. Código de estado: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Error al obtener datos del API');
//   }
// }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payments History",
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
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children:  [
                    const SizedBox(height: 35),
                    const Text(
                      "A continuación, podrás observar un historial de los pagos que has recidido:",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Color(0xFF7F7F7F),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      child: confirmedTutoriasList.isEmpty
                        ? const Center(
                        child: Text('No has recibido ningún pago!'),
                      )
                        : Column(
                        children: confirmedTutoriasList.map(
                          (subject) {
                            Color cardColor =
                                confirmedTutoriasList.indexOf(subject) % 2 == 0
                                    ? const Color(0xFF9FA9FF)
                                    : const Color(0xFFFEC89F);
                            return CustomHistoryCard(
                              classTitle: subject['nombreTutoria'], 
                              studentName: subject['estudiante']['name'], 
                              amount: "250", 
                              date: subject['fechaComprobante'],
                              color: cardColor,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
    );
  }
}



