// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reviews_slider/reviews_slider.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:http/http.dart' as http;

class RatingPage extends StatefulWidget {
  const RatingPage({
    super.key,
    required this.tutorID,
  });
  final String tutorID;
  @override
  State<RatingPage> createState() => _RatingPageState();

}

class _RatingPageState extends State<RatingPage> {
  
  List<dynamic> oldRatings = [];
  late bool _userHasScored = true;

  @override
  void initState() {
    super.initState();
    loadRatings();
  }

  //Enviar Rating
  Future<void> postRating(int rating) async {
    try {
      const String gateway =
          'https://uniexpert-gateway-6569fdd60e75.herokuapp.com';
      final String tutorId = widget.tutorID;
      final response = await http
          .post(
            Uri.parse('$gateway/users/$tutorId/rate'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'raterId': Auth().currentUser!.uid,
              'score': rating,
            }),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to post rating');
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  //Verificar si existen rating anteriores
  Future<void> loadRatings() async {
    try {
     final String tutorId = widget.tutorID;
      final response = await http.get(Uri.parse('https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/$tutorId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> apiData = json.decode(response.body);
      oldRatings = apiData['ratings'];

      setState(() {
        _userHasScored = findUserScore(Auth().currentUser!.uid, oldRatings);
    });
    } else {
      throw Exception('Error al obtener los datos del API. Código de estado: ${response.statusCode}');
    }
    } catch (e) {
    throw Exception('Error al obtener datos del API');
    }
  }

  bool findUserScore(String userId, List<dynamic> ratings) {
    for (var rating in ratings) {
        Map<String, dynamic> currentRating = rating as Map<String, dynamic>;
        if (currentRating["userId"] == userId) {
            return true;
        }
    }
    return false;
  }

  List<String> list = ['Horrible', 'Mal', 'Regular', 'Bueno', 'Genial'];
  String selected_value = "";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calificar Tutoría",
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
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
        child: ListBody(
          children: [
            const SizedBox(height: 100),
            const Text(
              '¿Qué opinas de tu tutor?',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 65),
            Center(
              child: ReviewSlider(
                  initialValue: 2,
                  options: list,
                  onChange: (int value) {
                    selected_value = list[value];
                    setState(() {});
                  }),
            ),
            const SizedBox(height: 25),
            Center(
              child: Text(
                selected_value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                'Calificación: ${(list.indexOf(selected_value)) + 1}/5',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 65),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        "Gracias por calificarnos",
                        style: TextStyle(
                          color: Color(0xffEE8A6F),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      content: const Text(
                          "Trabajamos para ayudarte siempre y cuando lo necesites!"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "De nada!",
                              style: TextStyle(
                                color: Color(0xffEE8A6F),
                              ),
                            )),
                      ],
                    ),
                  );
                  var ratetoSend = list.indexOf(selected_value) + 1;
                  postRating(ratetoSend);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffEE8A6F),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                ),
                child: const Text(
                  'Envíar!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
           Visibility(
            visible: _userHasScored,
            child: Column(
              children: <Widget>[
                const Center(
                  child: Text(
                    'Has calificado previamente con',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: oldRatings
                        .where((rating) => rating["userId"] == Auth().currentUser!.uid)
                        .map((rating) => Text(
                              'Puntaje dado: ${rating["score"]}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xffEE8A6F),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
           ),
          ),
         ],
        ),
      ),
    );  
  }
}

