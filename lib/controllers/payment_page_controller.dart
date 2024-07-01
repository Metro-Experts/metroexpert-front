import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:metro_experts/pages/home_page.dart';

class PaymentPageController with ChangeNotifier {
  String selectedOption = "";
  double? conversionRate;

  Future<void> fetchConversionRate() async {
    final response = await http.get(Uri.parse(
        'https://uniexperts-conversionmonetaria-c1b334a75b61.herokuapp.com/dolar'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      conversionRate = double.parse(
          double.parse(data['dolar'].replaceAll(',', '.')).toStringAsFixed(2));
      notifyListeners();
    } else {
      throw Exception('Failed to load conversion rate');
    }
  }

  void selectOption(String option) {
    selectedOption = option;
    notifyListeners();
  }

  Future<void> submitCashPayment(
    BuildContext context,
    String tutorID,
    String tutoringId,
    String course,
    UserOnSession userOnSession,
  ) async {
    final user = userOnSession.userData;

    final byteData = await rootBundle.load('assets/images/000_9U69T3.jpg');
    final tempDir = await getTemporaryDirectory();
    final imageFile = File('${tempDir.path}/000_9U69T3.jpg');
    await imageFile.writeAsBytes(byteData.buffer.asUint8List());

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/images/upload'));

    request.files.add(
      http.MultipartFile(
        'image',
        imageFile.readAsBytes().asStream(),
        imageFile.lengthSync(),
        filename: '000_9U69T3.jpg',
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    request.fields['idcurso'] = tutoringId;
    request.fields['idtutor'] = tutorID;
    request.fields['estudiante'] = jsonEncode({
      'name': '${user.name} ${user.lastName}',
      'email': user.email,
      'idstudiante': user.id,
    });
    request.fields['nombreTutoria'] = course;
    request.fields['referencia'] = "No aplica";
    request.fields['bancoEmisor'] = "No aplica";
    request.fields['telefono'] = "No aplica";

    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(238, 138, 111, 1),
            ),
          );
        },
      );

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      Navigator.of(context).pop(); // Close the loading dialog

      if (response.statusCode == 201) {
        _showSuccessDialog(context);
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        print('Cuerpo de la respuesta: ${responseBody.body}');
        _showSnackBar(context, 'Error al realizar el pago.');
      }
    } catch (e) {
      Navigator.of(context)
          .pop(); // Close the loading dialog in case of an error
      print('Error al realizar el pago: $e');
      _showSnackBar(context, 'Error al realizar el pago.');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pago Exitoso'),
          content: const Text('El pago se ha realizado exitosamente.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
