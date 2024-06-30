import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:metro_experts/pages/data_payment_page.dart';

class PaymentPage extends StatefulWidget {
  final String tutoringName;
  final String tutorName;
  final String tutorID;
  final String tutorLastName;
  final List dates;
  final String fee;
  final Map tutorDetails;
  final String tutoringId;

  const PaymentPage({
    super.key,
    required this.tutoringName,
    required this.tutorName,
    required this.tutorID,
    required this.tutorLastName,
    required this.dates,
    required this.fee,
    required this.tutorDetails,
    required this.tutoringId,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedOption = "";
  final double height = 1;
  double? conversionRate;

  @override
  void initState() {
    super.initState();
    _fetchConversionRate();
  }

  Future<void> _fetchConversionRate() async {
    final response = await http.get(Uri.parse(
        'https://uniexperts-conversionmonetaria-c1b334a75b61.herokuapp.com/dolar'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        conversionRate = double.parse(data['dolar'].replaceAll(',', '.'));
      });
    } else {
      throw Exception('Failed to load conversion rate');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    String days = widget.dates.map((date) => date['day']).join(' y ');
    String hours = widget.dates.map((date) => date['hour']).join(' y ');
    double feeInDollars = double.parse(widget.fee);
    String conversionRateText =
        conversionRate?.toStringAsFixed(2) ?? 'Cargando...';
    double feeInBolivares =
        conversionRate != null ? feeInDollars * conversionRate! : 0.0;

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
      body: conversionRate == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                const SizedBox(height: 25),
                Center(
                  child: Column(children: [
                    SizedBox(
                      width: 200,
                      child: RadioListTile(
                        value: 'Pago Móvil',
                        groupValue: selectedOption,
                        onChanged: (selectedValue) {
                          setState(() {
                            selectedOption = selectedValue!;
                          });
                        },
                        title: const Text('Pago Móvil',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: RadioListTile(
                        value: 'Efectivo',
                        groupValue: selectedOption,
                        onChanged: (selectedValue) {
                          setState(() {
                            selectedOption = selectedValue!;
                          });
                        },
                        title: const Text('Efectivo',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ]),
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
                const Text(
                  'Detalles de la compra: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text("Tutoría:",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(widget.tutoringName),
                        leading: const Icon(Icons.menu_book_outlined,
                            color: Color(0xFFEE8A6F), size: 30),
                      ),
                      ListTile(
                        title: const Text("Tutor:",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle:
                            Text("${widget.tutorName} ${widget.tutorLastName}"),
                        leading: const Icon(Icons.account_circle_outlined,
                            color: Color(0xFFEE8A6F), size: 30),
                      ),
                      ListTile(
                        title: const Text("Día:",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(days),
                        leading: const Icon(Icons.calendar_today_outlined,
                            color: Color(0xFFEE8A6F), size: 30),
                      ),
                      ListTile(
                        title: const Text("Hora:",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(hours),
                        leading: const Icon(Icons.access_alarm_rounded,
                            color: Color(0xFFEE8A6F), size: 30),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Monto total: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color(0xFFEE8A6F),
                      ),
                    ),
                    Text(
                      "\$${widget.fee}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Monto en Bs: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color(0xFFEE8A6F),
                          ),
                        ),
                        if (conversionRate != null)
                          Text(
                            "(Tasa: ${conversionRate!.toStringAsFixed(2)} Bs/USD)",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      conversionRate != null
                          ? "Bs. ${feeInBolivares.toStringAsFixed(2)}"
                          : "Cargando...",
                      style: const TextStyle(
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
                      if (selectedOption.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Por favor seleccione un método de pago.'),
                          ),
                        );
                      } else if (selectedOption == 'Pago Móvil') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DataPaymentPage(
                              tutorID: widget.tutorID,
                              bank: widget.tutorDetails['bank'],
                              numcell: widget.tutorDetails['numcell'],
                              cedula: widget.tutorDetails['cedula'],
                              subject:
                                  '${widget.tutoringName} - ${widget.tutorLastName}',
                              course: widget.tutoringName,
                              feeInDollars: feeInDollars,
                              feeInBolivares: feeInBolivares,
                              tutoringId: widget.tutoringId,
                              conversionRate: conversionRateText,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffEE8A6F),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 10),
                    ),
                    child: const Text(
                      'Pagar ahora',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
              ]),
            ),
    );
  }
}
