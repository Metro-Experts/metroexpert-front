import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metro_experts/controllers/my_courses_controller.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses>
    with SingleTickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final myCoursesController =
        Provider.of<MyCoursesController>(context, listen: false);
    myCoursesController.fetchEnrolledCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCoursesController>(
      builder: (context, myCoursesController, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Mis cursos'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: myCoursesController.enrolledCourses.isNotEmpty
                ? ListView.builder(
                    itemCount: myCoursesController.enrolledCourses.length,
                    itemBuilder: (context, index) {
                      var course = myCoursesController.enrolledCourses[index];
                      return Column(
                        children: [
                          CourseCard(course: course),
                          const SizedBox(height: 16), // Espacio entre tarjetas
                        ],
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No se encontraron cursos inscritos',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class CourseCard extends StatefulWidget {
  final Map<String, dynamic> course;

  const CourseCard({required this.course, Key? key}) : super(key: key);

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard>
    with SingleTickerProviderStateMixin {
  bool isFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    isFront = !isFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final isFrontSide = _controller.value < 0.5;
          return Transform(
            transform: Matrix4.rotationY(_animation.value * 3.1415927),
            alignment: Alignment.center,
            child: Card(
              elevation: 8.0,
              shadowColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: isFrontSide ? Colors.lightBlueAccent : Colors.orangeAccent,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: isFrontSide
                    ? _buildFrontSide(widget.course)
                    : _buildBackSide(widget.course),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFrontSide(Map<String, dynamic> course) {
    List<dynamic> dates = course['date'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        Text(
          course['name'] ?? 'Nombre no disponible',
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 3),
        Text(
          course['description'] ?? 'Descripción no disponible',
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        ...dates.map((date) => Text(
              '${date['day']}: ${date['hour']}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.center,
            )),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildBackSide(Map<String, dynamic> course) {
    var tutor = course['tutor'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(3.1415927),
          child: Text(
            'Tutor: ${tutor['name']} ${tutor['lastName']}',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
