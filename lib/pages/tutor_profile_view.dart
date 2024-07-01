import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
          child: SizedBox(
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
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/graduation-cap-icon.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              tutorCareer,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
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
                          children: [
                            SvgPicture.asset(
                              'assets/icons/email_icon.svg',
                              width: 24,
                              height: 22,
                            ),
                            const SizedBox(
                              width: 17,
                            ),
                            Text(
                              tutorEmail.toLowerCase(),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
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
                          children: [
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              width: 24,
                              height: 24,
                              // ignore: deprecated_member_use
                              color: const Color(0xffEE8A6F),
                            ),
                            const SizedBox(
                              width: 17,
                            ),
                            Text(
                              'Calificación: ' + '${tutorRating}' + '/ 5',
                              style: const TextStyle(
                                  fontSize: 12,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RatingPage(
                                  tutorID: tutorID,
                                ),
                              ),
                            );
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
                            'Calificame aquí!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
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
                          textAlign: TextAlign.left,
                          'Sobre el tutor',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          tutorDescription,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  top: 670,
                  left: 60,
                  child: Text(
                    'Tutorias',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  left: 60,
                  top: 710,
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
                  top: 820,
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
        ));
  }
}
