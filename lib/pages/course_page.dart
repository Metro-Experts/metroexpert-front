import 'package:flutter/material.dart';
import 'package:metro_experts/controllers/course_page_controller.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:metro_experts/pages/tutor_profile_view.dart';
import 'package:metro_experts/pages/payment_page.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatefulWidget {
  final String subject;
  final String tutorName;
  final String tutorID;
  final String tutorLastName;
  final String tutoringFee;
  final String tutoringId;
  final String modality;
  final List tutoringStudents;
  final List dates;
  final Map<String, String> bankAccount;
  final String tutorEmail;
  final String tutorDescription;

  const CoursePage({
    super.key,
    required this.subject,
    required this.tutorName,
    required this.tutorID,
    required this.tutorLastName,
    required this.tutoringFee,
    required this.tutoringId,
    required this.tutoringStudents,
    required this.dates,
    required this.modality,
    required this.bankAccount,
    required this.tutorEmail,
    required this.tutorDescription,
  });

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    Provider.of<CoursePageController>(context, listen: false).tutoringId =
        widget.tutoringId;
    Provider.of<CoursePageController>(context, listen: false)
        .isAStudent(widget.tutoringStudents, Auth().currentUser!.uid);
    Provider.of<CoursePageController>(context, listen: false)
        .setScaffoldMessengerKey(_scaffoldMessengerKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoursePageController>(
      builder: (context, coursePageControllerConsumer, _) {
        return ScaffoldMessenger(
          key: _scaffoldMessengerKey,
          child: Scaffold(
            floatingActionButton: SizedBox(
              width: 400,
              height: 64,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                onPressed: () {
                  coursePageControllerConsumer
                      .showConfirmationDialog(context)
                      .then((confirmed) {
                    if (confirmed != null && confirmed) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            tutoringName: widget.subject,
                            tutorName: widget.tutorName,
                            tutorLastName: widget.tutorLastName,
                            tutorID: widget.tutorID,
                            tutoringId: widget.tutoringId,
                            dates: widget.dates,
                            fee: widget.tutoringFee,
                            tutorDetails: widget.bankAccount,
                          ),
                        ),
                      );
                    }
                  });
                },
                child: AnimatedContainer(
                  width: 400,
                  height: double.maxFinite,
                  duration: const Duration(milliseconds: 100),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    color: coursePageControllerConsumer.isJoined
                        ? Colors.red
                        : const Color.fromARGB(152, 76, 175, 79),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      coursePageControllerConsumer.isJoined
                          ? 'Salir de la clase'
                          : 'Unirme',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
            body: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 24,
                    child: SizedBox(
                      width: 350,
                      height: 350,
                      child: Image(
                        image:
                            AssetImage('assets/images/teacher_and_student.PNG'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 320,
                    left: 16,
                    child: Text(
                      '${widget.subject}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ),
                ),
                Positioned(
                  top: 370,
                  left: 16,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TutorProfileView(
                            tutorName: widget.tutorName,
                            tutorLastName: widget.tutorLastName,// Cambia esto por el email del tutor
                            tutorSubjects: const [
                              'Math',
                              'Physics'
                            ], // Cambia esto por las materias del tutor
                            bankAccount: widget.bankAccount,
                            tutorEmail: widget.tutorEmail, 
                            tutorDescription: widget.tutorDescription,

                          ),
                        );
                      },
                      child: SizedBox(
                        width: 400,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dictado por:',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            Container(
                              height: 36,
                              width: 128,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: const Color(0xFFFEC89F),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '${widget.tutorName} ${widget.tutorLastName}'
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 24,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 420,
                    child: Text(
                      'Horarios',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Positioned(
                    top: 470,
                    child: Container(
                      width: 400,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEC89F),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Text(
                              '${widget.dates[0]['day']}'.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Text(
                              '${widget.dates[0]['hour']}'.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 550,
                    child: Container(
                      width: 400,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEC89F),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Text(
                              '${widget.dates[1]['day']}'.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Text(
                              '${widget.dates[1]['hour']}'.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 630,
                    child: SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Modalidad',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            height: 64,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: const Color(0xFFFEC89F),
                            ),
                            child: Center(
                              child: Text(
                                '${widget.modality}'.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 710,
                    child: SizedBox(
                      width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Costo',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            height: 64,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: const Color(0xFFFEC89F),
                            ),
                            child: Center(
                              child: Text(
                                '\$${widget.tutoringFee}'.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
