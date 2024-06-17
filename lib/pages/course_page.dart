import 'package:flutter/material.dart';
import 'package:metro_experts/controllers/course_page_controller.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatefulWidget {
  final String subject;
  final String tutorName;
  final String tutoringFee;
  final String tutoringId;
  final List tutoringStudents;
  final List dates;

  const CoursePage({
    required this.subject,
    required this.tutorName,
    required this.tutoringFee,
    required this.tutoringId,
    required this.tutoringStudents,
    required this.dates,
    super.key,
  });

  @override
  State<CoursePage> createState() => _CoursePageState();
}

// bool isJoined = false;

class _CoursePageState extends State<CoursePage> {
  @override
  void initState() {
    Provider.of<CoursePageController>(context, listen: false)
        .isAStudent(widget.tutoringStudents, Auth().currentUser!.uid);
    Provider.of<CoursePageController>(context, listen: false).tutoringId =
        widget.tutoringId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoursePageController>(
      builder: (context, coursePageControllerConsumer, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.subject),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const HomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(-1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;

                      final tween = Tween(begin: begin, end: end);
                      final curveTween = CurveTween(curve: curve);

                      return SlideTransition(
                        position: animation.drive(curveTween).drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centra el contenido verticalmente
              crossAxisAlignment: CrossAxisAlignment
                  .center, // Centra el contenido horizontalmente
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.book, color: Colors.black54),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            widget.subject,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.black54),
                        const SizedBox(width: 8),
                        Text(
                          'Fecha: ${widget.dates[0]['day']} -- Horario: ${widget.dates[0]['hour']}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.black54),
                        const SizedBox(width: 8),
                        Text(
                          'Fecha: ${widget.dates[1]['day']} -- Horario: ${widget.dates[1]['hour']}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$ Costo: ${widget.tutoringFee}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () {
                    if (coursePageControllerConsumer.isJoined != true) {
                      setState(
                        () {
                          coursePageControllerConsumer.isJoined = true;
                          coursePageControllerConsumer.subscribeUser(context);
                        },
                      );
                    } else {
                      setState(() {
                        coursePageControllerConsumer.isJoined = false;
                        coursePageControllerConsumer.unsubscribeUser(context);
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: coursePageControllerConsumer.isJoined
                          ? Colors.red
                          : const Color(0xFF9FA9FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      coursePageControllerConsumer.isJoined
                          ? 'Salir de la clase'
                          : 'Unirme',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
