import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:metro_experts/model/user_model.dart';

class TutorPaymentGestorController extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> payments = [];

  Future<void> fetchPayments(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/images/tutor/confirmaciones/${user.uid}');
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        final userOnSession =
            Provider.of<UserOnSession>(context, listen: false);
        final userId = userOnSession.userData;

        payments = responseData['enEspera']
            .where((payment) => payment['idtutor'] == userId.id)
            .toList();
      } else {
        print('Error fetching payments: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching payments: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void confirmPayment(BuildContext context, int index) {
    payments.removeAt(index);
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Confirmación de pago exitoso')),
    );
  }
}
