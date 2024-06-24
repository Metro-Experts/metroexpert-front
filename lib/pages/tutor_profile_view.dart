import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TutorProfileView extends StatelessWidget {
  const TutorProfileView({
    super.key,
    required this.tutorName,
    required this.tutorLastName,
    required this.tutorEmail,
    required this.tutorSubjects,
    required this.bankAccount,
    required this.subject,
    required this.tutoringFee,
    required this.tutoringId,
    required this.tutoringStudents,
    required this.dates,
    required this.modality,
  });

  final String tutorName;
  final String tutorLastName;
  final String tutorEmail;
  final List<String> tutorSubjects;
  final Map<String, String> bankAccount;
  final String subject;
  final String tutoringFee;
  final String tutoringId;
  final List tutoringStudents;
  final List dates;
  final String modality;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$tutorName $tutorLastName'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.black, width: 5),
                color: const Color.fromRGBO(238, 138, 111, 1),
              ),
              child: ClipOval(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    width: 170,
                    height: 170,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$tutorName $tutorLastName',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              tutorEmail,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            Container(
              width: 315,
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/card_id.svg',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Ingeniería en Sistemas',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/bank.svg',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Banco: ${bankAccount['bank']}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Cédula: ${bankAccount['cedula']}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Teléfono: ${bankAccount['numcell']}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 315,
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sobre el tutor',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer imperdiet facilisis felis, vitae convallis elit pulvinar eget. Morbi sapien elit, pretium eu odio ac, venenatis gravida tellus.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 60.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tutorías',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    height: 94,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(254, 200, 159, 1),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Image.asset(
                        'assets/images/man_teaching.png',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    subject,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    height: 94,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(254, 200, 159, 1),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Image.asset(
                        'assets/images/man_teaching.png',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Física 3",
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
