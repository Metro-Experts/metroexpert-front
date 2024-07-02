import 'package:flutter/material.dart';

class TutorTutoriaCard extends StatefulWidget {
  const TutorTutoriaCard({
    super.key,
    required this.tutoriaName,
    required this.tutorLastName,
    required this.tutorName,
    required this.color,
  });
  final String tutorLastName;
  final String tutoriaName;
  final String tutorName;
  final Color color;

  @override
  State<TutorTutoriaCard> createState() => _TutorTutoriaCardState();
}

class _TutorTutoriaCardState extends State<TutorTutoriaCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 110,
          height: 94,
          decoration: BoxDecoration(
            color: widget.color,
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
            Text(
              widget.tutoriaName,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
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
                    text: '${widget.tutorName} ${widget.tutorLastName}',
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
    );
  }
}
