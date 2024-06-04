import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metro_experts/firebase_auth/auth.dart';

class CoursePage extends StatefulWidget {
  final String subject;
  final String tutorName;
  final String tutoringFee;
  final String tutoringId;
  final List tutoringStudents;

  const CoursePage({
    required this.subject,
    required this.tutorName,
    required this.tutoringFee,
    required this.tutoringId,
    required this.tutoringStudents,
    super.key,
  });

  @override
  State<CoursePage> createState() => _CoursePageState();
}

bool isJoined = false;

class _CoursePageState extends State<CoursePage> {
  void isAStudent(List tutoringStudents, String uid) {
    if (tutoringStudents.contains(uid)) {
      setState(() {
        isJoined = true;
      });
    } else {
      setState(() {
        isJoined = false;
      });
    }
  }

  Future<void> subscribeUser() async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/courses/${widget.tutoringId}/add-student');
    const headers = {'Content-Type': 'application/json'};

    final response = await http.post(url,
        headers: headers,
        body: json.encode({"studentId": Auth().currentUser!.uid}));
    try {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.black,
            behavior: SnackBarBehavior.floating,
            content: SizedBox(
              height: 25,
              child: Text(
                textAlign: TextAlign.justify,
                'successfuly created subscribe',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      } else {
        print(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
          content: SizedBox(
            height: 25,
            child: Text(
              textAlign: TextAlign.justify,
              'error subscribing',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
    }
  }

  void _showConfirmationDialog() async {
    final action = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isJoined ? 'Confirmar Salida' : 'Confirmar Unión'),
          content: Text(
            isJoined
                ? '¿Estás seguro que deseas salir de la clase?'
                : '¿Estás seguro que deseas unirte a la clase?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                subscribeUser(); // Sí
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );

    if (action == true) {
      setState(() {
        isJoined = !isJoined;
      });
    }
  }

  @override
  void initState() {
    isAStudent(widget.tutoringStudents, Auth().currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centra el contenido verticalmente
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centra el contenido horizontalmente
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.book, color: Colors.black54),
                    const SizedBox(width: 8),
                    Text(
                      widget.subject,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, color: Colors.black54),
                    const SizedBox(width: 8),
                    Text(
                      'Tutor: ${widget.tutorName}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.black54),
                    SizedBox(width: 8),
                    Text(
                      'Fecha: 29 de Mayo, 2024',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time, color: Colors.black54),
                    SizedBox(width: 8),
                    Text(
                      'Horario: 3:00 p.m. - 4:00 p.m.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Costo: ${widget.tutoringFee}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: _showConfirmationDialog,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  color: isJoined ? Colors.red : const Color(0xFF9FA9FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isJoined ? 'Salir de la clase' : 'Unirme',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
