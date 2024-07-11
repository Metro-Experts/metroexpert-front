import 'package:flutter/material.dart';
import 'package:metro_experts/pages/course_page.dart';

class TutorCardRender extends StatelessWidget {
  final String subject;
  final String tutorName;
  final String tutorID;
  final String tutorLastName;
  final int tutoringFee;
  final String tutoringId;
  final List tutoringStudents;
  final List dates;
  final String modality;
  final Color color;
  final String category;
  final Map<String, String> bankAccount;
  final String tutorEmail;
  final String tutorDescription;
  final String tutorCareer;
  final double tutorRating;

  const TutorCardRender({
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
    required this.color,
    required this.category,
    required this.bankAccount,
    required this.tutorEmail,
    required this.tutorDescription,
    required this.tutorCareer,
    required this.tutorRating,
  });

  factory TutorCardRender.fromJson(Map<String, dynamic> json) {
    return TutorCardRender(
      subject: json['name'] ?? 'Sin asignatura',
      tutorName: json['tutor'] != null
          ? json['tutor']['name'] ?? 'Sin tutor'
          : 'Sin tutor',
      tutorLastName: json['tutor'] != null
          ? json['tutor']['lastName'] ?? 'Sin tutor'
          : 'Sin tutor',
      tutoringFee: json['price'] ?? 0,
      tutoringId: json['_id'] ?? '',
      tutoringStudents: json['students'] ?? [],
      dates: json['date'] ?? [],
      modality: json['modality'] ?? 'Sin modalidad',
      color: const Color(0xFF9FA9FF),
      category: json['category'] ?? 'Sin categoría',
      bankAccount: {
        'bank': json['tutor']?['bankaccount']?['bank'] ?? 'Sin banco',
        'cedula': json['tutor']?['bankaccount']?['cedula'] ?? 'Sin cédula',
        'numcell': json['tutor']?['bankaccount']?['numcell'] ?? 'Sin cuenta',
      },
      tutorEmail: json['tutor'] != null
          ? json['tutor']['email'] ?? 'Sin tutor'
          : 'Sin tutor',
      tutorDescription: json['tutor'] != null
          ? json['tutor']['description'] ?? 'Sin tutor'
          : 'Sin tutor',
      tutorCareer: json['tutor'] != null
          ? json['tutor']['carrer'] ?? 'Sin carrera'
          : 'Sin carrera',
      tutorRating: json['tutor'] != null
          ? (json['tutor']['rating'] is int
              ? (json['tutor']['rating'] as int).toDouble()
              : json['tutor']['rating'] ?? 0.0)
          : 0.0,
      tutorID: json['tutor'] != null
          ? json['tutor']['id'] ?? 'Sin tutor'
          : 'Sin tutor',
    );
  }

  @override
  Widget build(BuildContext context) {
    print('LE DA CLASE A: ');
    print(tutoringStudents);
    print('----------------------------------------------------------------');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoursePage(
              subject: subject,
              tutorName: tutorName,
              tutorID: tutorID,
              tutorLastName: tutorLastName,
              tutoringFee: "$tutoringFee",
              tutoringId: tutoringId,
              tutoringStudents: tutoringStudents,
              dates: dates,
              modality: modality,
              bankAccount: bankAccount,
              tutorEmail: tutorEmail,
              tutorDescription: tutorDescription,
              tutorCareer: tutorCareer,
              tutorRating: "$tutorRating",
            ),
          ),
        );
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Tutor: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '$tutorName $tutorLastName',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Precio: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '$tutoringFee',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Modalidad: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: modality,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/images/man_teaching.png",
                width: 140,
                height: 140,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
