import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataPaymentPage extends StatefulWidget {
  const DataPaymentPage({super.key});

  @override
  State<DataPaymentPage> createState() => _DataPaymentPageState();
}

class _DataPaymentPageState extends State<DataPaymentPage> {
  final double height = 1;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pago Móvil",
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
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
            child: ListBody(
              children: [
                const Text(
                  'Realizar el pago a: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color(0xFFEE8A6F),
                  ),
                ),
                Container(
                  width: 200,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: const Color(0xFFEE8A6F),
                    width: 5,
                  )),
                  child: const Column(
                    children: [
                      ListTile(
                        title: Text("Banco:",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text("BANCO NACIONAL DE CRÉDITO"),
                      ),
                      ListTile(
                        title: Text("Teléfono: ",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text("+58 04241501278"),
                      ),
                      ListTile(
                        title: Text("Cédula: ",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text("v.- 30057442"),
                      ),
                      ListTile(
                        title: Text("Asunto: ",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text("Matemáticas 2 - Apellido"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
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
                    Text(
                      "Monto Total: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color(0xFFEE8A6F),
                      ),
                    ),
                    Text(
                      "\$ 10",
                      style: TextStyle(
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
                    Text(
                      "Monto en Bs: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color(0xFFEE8A6F),
                      ),
                    ),
                    Text(
                      "Bs. 360",
                      style: TextStyle(
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffEE8A6F),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 10),
                    ),
                    child: const Text(
                      'Subir comprobante',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
