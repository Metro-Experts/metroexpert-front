import 'package:flutter/material.dart';
import 'package:metro_experts/pages/course_page.dart';

class TutorCard extends StatelessWidget {
  final String subject;
  final String tutorName;
  final int tutoringFee;
  final String tutoringId;
  final List tutoringStudents;

  const TutorCard(
      {super.key,
      required this.subject,
      required this.tutorName,
      required this.tutoringFee,
      required this.tutoringId,
      required this.tutoringStudents});

  factory TutorCard.fromJson(Map<String, dynamic> json) {
    return TutorCard(
        subject: json['name'],
        tutorName: json['tutor']['name'],
        tutoringFee: json['price'],
        tutoringId: json['_id'],
        tutoringStudents: json['students']);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoursePage(
              subject: subject,
              tutorName: tutorName,
              tutoringFee: "${tutoringFee}",
              tutoringId: tutoringId,
              tutoringStudents: tutoringStudents,
            ),
          ),
        );
      },
      child: Card(
        color: const Color(0xFF9FA9FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0), // Ajuste del margen para menos ancho
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        subject,
                        style: const TextStyle(
                          fontSize: 20, // Título más grande
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        tutorName,
                        style: const TextStyle(
                          fontSize: 16, // Subtítulo
                        ),
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
