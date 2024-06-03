import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  final String subject;
  final String tutorName;

  const CoursePage({
    required this.subject,
    required this.tutorName,
    super.key,
  });

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  bool isJoined = false;

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
                Navigator.of(context).pop(false); // No
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Sí
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
                  color: isJoined ? Colors.red : Colors.orange,
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
