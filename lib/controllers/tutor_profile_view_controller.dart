import 'package:flutter/material.dart';
import 'package:metro_experts/pages/tutor_profile_view.dart';

class TutorProfileViewController extends StatelessWidget {
  const TutorProfileViewController({
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
    return TutorProfileView(
      tutorName: tutorName,
      tutorLastName: tutorLastName,
      tutorEmail: tutorEmail,
      tutorSubjects: tutorSubjects,
      bankAccount: bankAccount,
      subject: subject,
      tutoringFee: tutoringFee,
      tutoringId: tutoringId,
      tutoringStudents: tutoringStudents,
      dates: dates,
      modality: modality,
    );
  }
}
