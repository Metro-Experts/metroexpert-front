import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:metro_experts/controllers/tutor_payment_gestor_controller.dart';

class TutorConfirmPaymentController extends ChangeNotifier {
  Future<void> confirmPayment(
      BuildContext context, String paymentId, int index) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/images/confirm/$paymentId');

    try {
      final response = await http.get(url); // Cambia de POST a GET

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Confirmación de pago exitosa')),
        );
        Provider.of<TutorPaymentGestorController>(context, listen: false)
            .removePayment(index);
        Navigator.pop(
            context); // Cierra la pantalla actual después de confirmar
      } else {
        print(
            'Error confirming payment: ${response.statusCode}, response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error al confirmar el pago: ${response.body}')),
        );
      }
    } catch (e) {
      print('Error confirming payment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al confirmar el pago: $e')),
      );
    }
  }
}
