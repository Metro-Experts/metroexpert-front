import 'package:flutter/material.dart';
import 'package:metro_experts/pages/tutor_confirm_payment.dart';

class CustomListTile extends StatelessWidget {
  final String classTitle;
  final String studentName;
  final String studentEmail;
  final String fechaComprobante;
  final double monto;
  final String bancoEmisor;
  final String referencia;
  final String telefono;
  final List<dynamic> imgData;
  final String contentType;
  final VoidCallback onConfirm;

  const CustomListTile({
    super.key,
    required this.classTitle,
    required this.studentName,
    required this.studentEmail,
    required this.fechaComprobante,
    required this.monto,
    required this.bancoEmisor,
    required this.referencia,
    required this.telefono,
    required this.imgData,
    required this.contentType,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    bool isBolivares = bancoEmisor != "No aplica";
    Color cardColor =
        isBolivares ? const Color(0xFFEE8A6F) : const Color(0xFF4CAF50);
    IconData leadingIcon =
        isBolivares ? Icons.menu_book_outlined : Icons.attach_money;
    String montoText = isBolivares
        ? '${monto.toStringAsFixed(2)} Bs.'
        : '\$${monto.toStringAsFixed(2)}';

    return SizedBox(
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: cardColor,
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        title: Text(classTitle,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(studentName, style: const TextStyle(color: Colors.white)),
            Text('Fecha: $fechaComprobante',
                style: const TextStyle(color: Colors.white)),
            Text('Monto: $montoText',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            if (isBolivares) ...[
              Text.rich(
                TextSpan(
                  text: 'Banco Emisor: ',
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: bancoEmisor,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'Referencia: ',
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: referencia,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text('Teléfono: $telefono',
                  style: const TextStyle(color: Colors.white)),
            ],
          ],
        ),
        leading: Icon(leadingIcon, color: Colors.white, size: 35),
        trailing: SizedBox(
          height: 50,
          width: 50,
          child: isBolivares
              ? IconButton(
                  color: Colors.white,
                  iconSize: 25,
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TutorConfirmPayment(
                          classTitle: classTitle,
                          studentName: studentName,
                          fechaComprobante: fechaComprobante,
                          monto: monto,
                          bancoEmisor: bancoEmisor,
                          referencia: referencia,
                          telefono: telefono,
                          imgData: imgData,
                          contentType: contentType,
                        ),
                      ),
                    );
                  },
                )
              : ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    elevation: 5,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 25,
                  ),
                ),
        ),
      ),
    );
  }
}
