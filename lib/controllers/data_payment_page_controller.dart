// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:metro_experts/model/user_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:metro_experts/pages/home_page.dart';

class DataPaymentPageController extends ChangeNotifier {
  File? _image;
  String? _selectedBank;

  File? get image => _image;
  String? get selectedBank => _selectedBank;

  final List<Map<String, String>> _banks = [
    {'code': '0102', 'name': 'BDV Banco de Venezuela'},
    {'code': '0104', 'name': 'Venezolano de Crédito'},
    {'code': '0105', 'name': 'Mercantil'},
    {'code': '0108', 'name': 'BBVA Banco Provincial'},
    {'code': '0114', 'name': 'Bancaribe'},
    {'code': '0115', 'name': 'Exterior'},
    {'code': '0128', 'name': 'Banco Caroní'},
    {'code': '0134', 'name': 'Banesco'},
    {'code': '0138', 'name': 'Banco Plaza'},
    {'code': '0151', 'name': 'BFC Banco Fondo Común'},
    {'code': '0156', 'name': '100% Banco'},
    {'code': '0157', 'name': 'Del Sur Banco Universal'},
    {'code': '0163', 'name': 'Banco del Tesoro'},
    {'code': '0166', 'name': 'Banco Agrícola de Venezuela'},
    {'code': '0168', 'name': 'Bancrecer'},
    {'code': '0169', 'name': 'Mi Banco'},
    {'code': '0171', 'name': 'Banco Activo'},
    {'code': '0172', 'name': 'Bancamiga'},
    {'code': '0174', 'name': 'Banplus'},
    {'code': '0175', 'name': 'Bicentenario del Pueblo'},
    {'code': '0177', 'name': 'BANFANB'},
    {'code': '0191', 'name': 'BNC Banco Nacional de Crédito'},
  ];

  List<Map<String, String>> get banks => _banks;

  void setSelectedBank(String? bank) {
    _selectedBank = bank;
  }

  Future<void> pickImage(BuildContext context, String? selectedBank,
      String phoneNumber, String reference) async {
    if (selectedBank == null) {
      _showSnackBar(context, 'Por favor, seleccione el banco emisor.');
      return;
    }
    if (phoneNumber.isEmpty) {
      _showSnackBar(context, 'Por favor, ingrese el número de teléfono.');
      return;
    }
    if (reference.isEmpty) {
      _showSnackBar(context, 'Por favor, ingrese la referencia del pago.');
      return;
    }
    if (_image != null) {
      _showSnackBar(context, 'Ya hay una imagen cargada.');
      return;
    }

    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }

  void removeImage() {
    _image = null;
  }

  Future<void> submitPayment(
      BuildContext context,
      TextEditingController phoneController,
      TextEditingController referenceController,
      String tutorID,
      String tutoringId,
      String course,
      UserOnSession userOnSession) async {
    final user = userOnSession.userData;

    if (_selectedBank == null ||
        phoneController.text.isEmpty ||
        referenceController.text.isEmpty ||
        _image == null) {
      _showSnackBar(
          context, 'Por favor, complete todos los campos y suba una imagen.');
      return;
    }

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/images/upload'));

    request.files.add(
      http.MultipartFile(
        'image',
        _image!.readAsBytes().asStream(),
        _image!.lengthSync(),
        filename: _image!.path.split('/').last,
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
    request.fields['referencia'] = referenceController.text;
    request.fields['bancoEmisor'] =
        _banks.firstWhere((bank) => bank['code'] == _selectedBank)['name']!;
    request.fields['telefono'] = phoneController.text;

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
        _image = null;
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
          title: const Text('¡Listo!'),
          content: const Text('Pago procesado.'),
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
