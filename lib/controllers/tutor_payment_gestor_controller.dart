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
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/images/upload');
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 200 &&
          FirebaseAuth.instance.currentUser != null) {
        List<dynamic> responseData = json.decode(response.body);

        final userOnSession =
            Provider.of<UserOnSession>(context, listen: false);
        final userId = userOnSession.userData;
        print("Hola::userId");

        payments = responseData
            .where((payment) => payment['idtutor'] == userId.id)
            .toList();
      } else {
        print('error fetching payments...');
      }
    } catch (e) {
      print('Error fetching payments: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
