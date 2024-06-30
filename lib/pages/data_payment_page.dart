import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:metro_experts/controllers/data_payment_page_controller.dart';
import 'package:metro_experts/model/user_model.dart';

class DataPaymentPage extends StatefulWidget {
  final String bank;
  final String numcell;
  final String cedula;
  final String subject;
  final double feeInDollars;
  final double feeInBolivares;
  final String tutorID;
  final String tutoringId;
  final String conversionRate;
  final String course;

  const DataPaymentPage({
    super.key,
    required this.bank,
    required this.numcell,
    required this.cedula,
    required this.subject,
    required this.feeInDollars,
    required this.feeInBolivares,
    required this.tutorID,
    required this.tutoringId,
    required this.conversionRate,
    required this.course,
  });

  @override
  State<DataPaymentPage> createState() => _DataPaymentPageState();
}

class _DataPaymentPageState extends State<DataPaymentPage> {
  final double height = 1;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  final DataPaymentPageController _controller = DataPaymentPageController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pago Móvil",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 20,
          ),
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
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      "Banco:",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(widget.bank.toUpperCase()),
                  ),
                  ListTile(
                    title: const Text(
                      "Teléfono: ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(widget.numcell),
                  ),
                  ListTile(
                    title: const Text(
                      "Cédula: ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(widget.cedula),
                  ),
                  ListTile(
                    title: const Text(
                      "Asunto: ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(widget.subject),
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
                  "\$${widget.feeInDollars}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Monto en Bs: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color(0xFFEE8A6F),
                      ),
                    ),
                    Text(
                      "Bs. ${widget.feeInBolivares.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "(Tasa: ${widget.conversionRate} Bs/USD)",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
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
            const SizedBox(height: 50),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Banco Emisor',
                labelStyle: TextStyle(
                  color: Color(0xFFEE8A6F),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFEE8A6F),
                  ),
                ),
              ),
              value: _controller.selectedBank,
              items: _controller.banks.map((bank) {
                return DropdownMenuItem<String>(
                  value: bank['code'],
                  child: Text('${bank['code']} - ${bank['name']}'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _controller.setSelectedBank(value);
                });
              },
              hint: const Text('Seleccione el banco emisor'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Número de teléfono',
                labelStyle: TextStyle(
                  color: Color(0xFFEE8A6F),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFEE8A6F),
                  ),
                ),
                hintText: 'Ingrese el número de teléfono',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _referenceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Referencia del pago',
                labelStyle: TextStyle(
                  color: Color(0xFFEE8A6F),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFEE8A6F),
                  ),
                ),
                hintText: 'Ingrese la referencia del pago',
              ),
            ),
            const SizedBox(height: 20),
            if (_controller.image != null)
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFEE8A6F),
                        width: 5,
                      ),
                    ),
                    child: Image.file(
                      _controller.image!,
                      width: 300,
                      height: 300,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.removeImage();
                        });
                      },
                    ),
                  ),
                ],
              )
            else
              Container(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await _controller.pickImage(
                      context,
                      _controller.selectedBank,
                      _phoneController.text,
                      _referenceController.text,
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text('Subir captura de pantalla'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final userOnSession =
                    Provider.of<UserOnSession>(context, listen: false);
                _controller.submitPayment(
                  context,
                  _phoneController,
                  _referenceController,
                  widget.tutorID,
                  widget.tutoringId,
                  widget.course,
                  userOnSession,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEE8A6F),
              ),
              child: const Text(
                'Enviar pago',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
