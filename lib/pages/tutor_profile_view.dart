import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TutorProfileView extends StatelessWidget {
  const TutorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: const Color.fromRGBO(238, 138, 111, 1)),
              ),
            ),
            const Positioned(
              top: 260,
              child: Column(
                children: [
                  Text(
                    'Jane Doe',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '@janedoe2003',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  )
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
                          'Jane Doe',
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
                        const Text(
                          'janedoe@example.com',
                          style: TextStyle(
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
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer imperdiet facilisis felis, vitae convallis elit pulvinar eget. Morbi sapien elit, pretium eu odio ac, venenatis gravida tellus.",
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
                        borderRadius: BorderRadius.circular(25)),
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
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Tutor: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Pedro Perez',
                              style: TextStyle(
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
                        borderRadius: BorderRadius.circular(25)),
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
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Tutor: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Pedro Perez',
                              style: TextStyle(
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
