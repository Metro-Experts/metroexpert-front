import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metro_experts/components/tutor_tutoria_card.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/pages/rate_tutor_page.dart';
import 'package:flutter/services.dart';

class TutorProfileView extends StatelessWidget {
  const TutorProfileView({
    super.key,
    required this.tutorName,
    required this.tutorLastName,
    required this.tutorSubjects,
    required this.bankAccount,
    required this.tutorEmail,
    required this.tutorDescription,
    required this.tutorCareer,
    required this.tutorRating,
    required this.tutorID,
    required this.tutoringStudents,
  });

  final String tutorName;
  final String tutorLastName;
  final List<String> tutorSubjects;
  final Map<String, String> bankAccount;
  final String tutorEmail;
  final String tutorDescription;
  final String tutorCareer;
  final String tutorRating;
  final String tutorID;
  final List tutoringStudents;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    bool isStudentOnTutoringList(String studentId, List<dynamic> tutoringList) {
      return tutoringList.contains(studentId);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: double.maxFinite,
                minHeight: 1000,
                maxHeight: 1300,
              ),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 70,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color.fromARGB(255, 231, 240, 255),
                          ),
                          child: Image.asset('assets/images/man_teaching.png'),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 280,
                    child: Column(
                      children: [
                        Text(
                          '$tutorName $tutorLastName',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 345,
                    child: Container(
                      width: 315,
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    top: 360,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/graduation-cap-icon.svg',
                                width: 22,
                                height: 22,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                tutorCareer,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/email_icon.svg',
                                width: 22,
                                height: 22,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                tutorEmail.toLowerCase(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/star.svg',
                                width: 25,
                                height: 25,
                                color: const Color(0xffEE8A6F),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Calificación: $tutorRating / 5',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffEE8A6F)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (isStudentOnTutoringList(
                                  Auth().currentUser!.uid, tutoringStudents)) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RatingPage(
                                      tutorID: tutorID,
                                    ),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text(
                                      "¡No puedes calificar a este tutor!",
                                      style: TextStyle(
                                        color: Color(0xffEE8A6F),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    content: const Text(
                                        "Si deseas dejar tu opinión, debes estar inscrito en esta tutoría"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Ok!",
                                            style: TextStyle(
                                              color: Color(0xffEE8A6F),
                                            ),
                                          )),
                                    ],
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffEE8A6F),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text(
                              '¡Califícame aquí!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 520,
                    child: Container(
                      width: 315,
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    top: 550,
                    child: SizedBox(
                      width: 308,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sobre el tutor',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            tutorDescription,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 650,
                    left: 60,
                    child: const Text(
                      'Tutorías:',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 700, left: 60),
                    child: tutorSubjects.isEmpty
                        ? const Center(
                            child: Text('No hay tutorías registradas'),
                          )
                        : Column(
                            children: tutorSubjects.map(
                              (subject) {
                                Color cardColor =
                                    tutorSubjects.indexOf(subject) % 2 == 0
                                        ? const Color(0xFF9FA9FF)
                                        : const Color(0xFFFEC89F);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TutorTutoriaCard(
                                    tutorName: tutorName,
                                    tutorLastName: tutorLastName,
                                    tutoriaName: subject,
                                    color: cardColor,
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
