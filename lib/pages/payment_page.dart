import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:metro_experts/controllers/payment_page_controller.dart';
import 'package:metro_experts/pages/data_payment_page.dart';
import 'package:metro_experts/model/user_model.dart';

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
  late PaymentPageController controller;

  @override
  void initState() {
    super.initState();
    controller = PaymentPageController();
    controller.fetchConversionRate().then((_) {
      setState(() {});
    });
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
        controller.conversionRate?.toStringAsFixed(2) ?? 'Cargando...';
    double feeInBolivares = controller.conversionRate != null
        ? feeInDollars * controller.conversionRate!
        : 0.0;

    return ChangeNotifierProvider<PaymentPageController>(
      create: (_) => controller,
      child: Scaffold(
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
        body: Consumer<PaymentPageController>(
          builder: (context, controller, _) {
            return controller.conversionRate == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(left: 40, top: 40, right: 40),
                    child: ListBody(
                      children: [
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
                                groupValue: controller.selectedOption,
                                onChanged: (selectedValue) {
                                  controller.selectOption(selectedValue!);
                                },
                                title: const Text('Pago Móvil',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: RadioListTile(
                                value: 'Efectivo',
                                groupValue: controller.selectedOption,
                                onChanged: (selectedValue) {
                                  controller.selectOption(selectedValue!);
                                },
                                title: const Text('Efectivo',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ]),
                        ),
                        const SizedBox(height: 20),
                        LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final boxWidth = constraints.constrainWidth();
                            const dashWidth = 10.0;
                            const dashHeight = 1.0;
                            final dashCount =
                                (boxWidth / (2 * dashWidth)).floor();
                            return Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
                              children: List.generate(dashCount, (_) {
                                return const SizedBox(
                                  width: dashWidth,
                                  height: dashHeight,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Color(0xffEE8A6F)),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                subtitle: Text(widget.tutoringName),
                                leading: const Icon(Icons.menu_book_outlined,
                                    color: Color(0xFFEE8A6F), size: 30),
                              ),
                              ListTile(
                                title: const Text("Tutor:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                subtitle: Text(
                                    "${widget.tutorName} ${widget.tutorLastName}"),
                                leading: const Icon(
                                    Icons.account_circle_outlined,
                                    color: Color(0xFFEE8A6F),
                                    size: 30),
                              ),
                              ListTile(
                                title: const Text("Día:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                subtitle: Text(days),
                                leading: const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Color(0xFFEE8A6F),
                                    size: 30),
                              ),
                              ListTile(
                                title: const Text("Hora:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                subtitle: Text(hours),
                                leading: const Icon(Icons.access_alarm_rounded,
                                    color: Color(0xFFEE8A6F), size: 30),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            final boxWidth = constraints.constrainWidth();
                            const dashWidth = 10.0;
                            const dashHeight = 1.0;
                            final dashCount =
                                (boxWidth / (2 * dashWidth)).floor();
                            return Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
                              children: List.generate(dashCount, (_) {
                                return const SizedBox(
                                  width: dashWidth,
                                  height: dashHeight,
                                  child: DecoratedBox(
                                    decoration:
                                        BoxDecoration(color: Color(0xffEE8A6F)),
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
                                if (controller.conversionRate != null)
                                  Text(
                                    "(Tasa: ${controller.conversionRate!.toStringAsFixed(2)} Bs/USD)",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              controller.conversionRate != null
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
                              if (controller.selectedOption.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Por favor seleccione un método de pago.'),
                                  ),
                                );
                              } else if (controller.selectedOption ==
                                  'Pago Móvil') {
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
                              } else if (controller.selectedOption ==
                                  'Efectivo') {
                                final userOnSession =
                                    Provider.of<UserOnSession>(context,
                                        listen: false);
                                controller.submitCashPayment(
                                  context,
                                  widget.tutorID,
                                  widget.tutoringId,
                                  widget.tutoringName,
                                  int.parse(widget.fee),
                                  userOnSession,
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
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
