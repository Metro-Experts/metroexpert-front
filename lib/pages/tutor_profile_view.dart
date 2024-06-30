// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TutorProfileView extends StatelessWidget {
  const TutorProfileView({
    super.key,
    required this.tutorName,
    required this.tutorLastName,
    required this.tutorSubjects,
    required this.bankAccount,
    required this.tutorEmail,
    required this.tutorDescription,
  });

  final String tutorName;
  final String tutorLastName;
  final List<String> tutorSubjects;
  final Map<String, String> bankAccount;
  final String tutorEmail;
  final String tutorDescription;

  @override
  Widget build(BuildContext context) {
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
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 70,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromRGBO(238, 138, 111, 1),
                ),
                child: Image.asset('assets/images/man_teaching.png'),
              ),
            ),
            Positioned(
              top: 280,
              child: Column(
                children: [
                  Text(
                    '$tutorName$tutorLastName',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/profile.svg',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 21,
                        ),
                        const Text(
                          'Puntuación',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/card_id.svg',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Ingeniería de sistema',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/email_icon.svg',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Text(
                          '$tutorEmail'.toLowerCase(),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 460,
              child: Container(
                width: 315,
                height: 1,
                color: Colors.black,
              ),
            ),
            const Positioned(
              top: 490,
              child: SizedBox(
                width: 308,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.left,
                      'Sobre el tutor',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      "Como estudiante he conocido lo mucho que uno puede llegar a necesitar ayuda en momentos de estres y por esa razón me encuentro aquí.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 610,
              left: 60,
              child: Text(
                'Tutorias',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              left: 60,
              top: 650,
              child: Row(
                children: [
                  Container(
                    width: 110,
                    height: 94,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(254, 200, 159, 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Image.asset('assets/images/woman_teaching.png'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Matematica 5",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Tutor: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: '$tutorName',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 60,
              top: 760,
              child: Row(
                children: [
                  Container(
                    width: 110,
                    height: 94,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(254, 200, 159, 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Image.asset('assets/images/woman_teaching.png'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Matematica 5",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Tutor: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: '$tutorName',
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
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
