//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metro_experts/pages/data_payment_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedOption = "";
  final double height = 1;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pagar Tutoría",
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
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
          child: ListBody(children: [
            const Text(
              'Métodos de Pago: ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color(0xFFEE8A6F),
              ),
            ),

            Center(
              child: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: RadioMenuButton(
                    value: 'Pago Móvil',
                    groupValue: selectedOption,
                    onChanged: (selectedValue) {
                      setState(() {
                        selectedOption = selectedValue!;
                      });
                    },
                    child: const Text('Pago Móvil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: RadioMenuButton(
                    value: 'Efectivo',
                    groupValue: selectedOption,
                    onChanged: (selectedValue) {
                      setState(() {
                        selectedOption = selectedValue!;
                      });
                    },
                    child: const Text('Efectivo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                )
              ]),
            ),
            const SizedBox(height: 60),
            const Text(
              'Detalles de la compra: ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: Column(
              children: [
                ListTile(
                    title: Text("Tutoría:", style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text("Matemáticas 2"),
                    leading:Icon(Icons.menu_book_outlined, color: Color(0xFFEE8A6F), size: 30),
                ),
                ListTile(
                    title: Text("Tutor: ", style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text("José Perez"),
                    leading:Icon(Icons.account_circle_outlined, color: Color(0xFFEE8A6F), size: 30),
                ),
                ListTile(
                    title: Text("Día: ", style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text("Lunes y Miércoles"),
                    leading:Icon(Icons.calendar_today_outlined, color: Color(0xFFEE8A6F), size: 30),
                ),
                ListTile(
                    title: Text("Hora: ", style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text("10:00 AM"),
                    leading:Icon(Icons.access_alarm_rounded, color: Color(0xFFEE8A6F), size: 30),
                ),
              ],
            ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final boxWidth = constraints.constrainWidth();
                const dashWidth = 10.0;
                final dashHeight = height;
                final dashCount = (boxWidth / (2 * dashWidth)).floor();
                return Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: List.generate(dashCount, (_) {
                    return SizedBox(
                      width: dashWidth,
                      height: dashHeight,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xffEE8A6F)),
                      ),
                    );
                  }),
                );
              },
            ),
            const SizedBox(height: 25),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Monto Total: ", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color(0xFFEE8A6F),
                ),
              ),
              Text("\$ 10", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ), 
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Monto en Bs: ", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Color(0xFFEE8A6F),
                ),
              ),
              Text("Bs. 360", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: 200,
              child: ElevatedButton(
              onPressed: () {
                if(selectedOption == 'Pago Móvil'){
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DataPaymentPage(),
                  ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:const Color(0xffEE8A6F),
                padding: const EdgeInsets.symmetric(
                horizontal: 60, vertical: 10),
              ),
              child: const Text(
                'Pagar Ahora',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:  Colors.white,
                ),
              ),
              ),
            ), 
          ]),
        ));
  }
}
