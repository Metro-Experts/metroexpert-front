import 'package:flutter/material.dart';
import 'package:metro_experts/components/custom_history_card.dart';
import 'package:flutter/services.dart';

class PaymentsHistoryPage extends StatefulWidget {
  const PaymentsHistoryPage({super.key});

  @override
  State<PaymentsHistoryPage> createState() => _PaymentsHistoryPageState();
}

class _PaymentsHistoryPageState extends State<PaymentsHistoryPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Historial de Pagos",
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
      body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: const [
                    SizedBox(height: 35),
                    Text(
                      "A continuación, podrás observar un historial de los pagos que has recidido:",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Color(0xFF7F7F7F),
                      ),
                    ),
                    SizedBox(height: 35),
                    CustomHistoryCard(classTitle: "Matemática II", studentName: "Beatriz Cardozo", amount: "250", date: "25/06/2024"),
                    SizedBox(height: 25),
                    CustomHistoryCard(classTitle: "Bases de Datos II", studentName: "Hugo Duque", amount: "340", date: "25/06/2024"),
                    SizedBox(height: 25),
                    CustomHistoryCard(classTitle: "Física II", studentName: "Román Chacín", amount: "120", date: "25/06/2024"),
                    SizedBox(height: 25),
                    CustomHistoryCard(classTitle: "Estadística", studentName: "Felipe Escalona", amount: "220", date: "25/06/2024"),
                    SizedBox(height: 25),
                    CustomHistoryCard(classTitle: "Bases de Datos I", studentName: "Erika Hernández", amount: "530", date: "25/06/2024"),
                    SizedBox(height: 25),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
