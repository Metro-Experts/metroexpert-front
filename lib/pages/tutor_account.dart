import 'package:flutter/material.dart';

class TutorAccount extends StatelessWidget {
  const TutorAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              child: Container(
                width: double.maxFinite,
                height: 297,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(159, 169, 255, 1)),
              ),
            ),
            const Positioned(
              top: 418,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Username:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '@jhodoe2003',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Carrera:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Text(
                        'Ingenieria De Sistemas',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Password:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          '******',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 560,
              left: 45,
              child: Text(
                'Tutorías',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              left: 45,
              top: 610,
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
              left: 45,
              top: 720,
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
              top: 172,
              child: Container(
                width: 345,
                height: 195,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    const Positioned(
                      top: 95,
                      left: 25,
                      child: Text(
                        'Jhon Doe',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Positioned(
                      top: 135,
                      left: 25,
                      child: Text(
                        'jhondoe@gmail.com',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(127, 127, 127, 1),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 155,
                      left: 25,
                      child: Text(
                        '+58 24243242',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(127, 127, 127, 1),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 220,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {},
                        child: const Text(
                          'Editar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 69,
              child: Container(
                width: 178,
                height: 178,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(159, 231, 245, 1),
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
            Positioned(
              top: 860,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 40),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'Editar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
