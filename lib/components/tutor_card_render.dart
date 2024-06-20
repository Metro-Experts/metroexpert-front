import 'package:flutter/material.dart';
import 'package:metro_experts/pages/course_page.dart';

class TutorCardRender extends StatelessWidget {
  final String subject;
  final String tutorName;
  final int tutoringFee;
  final String tutoringId;
  final List tutoringStudents;
  final List dates;
  final String modality;
  final Color color;

  const TutorCardRender({
    super.key,
    required this.subject,
    required this.tutorName,
    required this.tutoringFee,
    required this.tutoringId,
    required this.tutoringStudents,
    required this.dates,
    required this.modality,
    required this.color,
  });

  factory TutorCardRender.fromJson(Map<String, dynamic> json) {
    return TutorCardRender(
      subject: json['name'],
      tutorName: json['tutor']['name'],
      tutoringFee: json['price'],
      tutoringId: json['_id'],
      tutoringStudents: json['students'],
      dates: json['date'],
      modality: json['modality'],
      color: const Color(0xFF9FA9FF),
    );
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
              tutoringFee: "$tutoringFee",
              tutoringId: tutoringId,
              tutoringStudents: tutoringStudents,
              dates: dates,
              modality: modality,
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
                            text: tutorName,
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
