import 'package:flutter/material.dart';

class CustomHistoryCard extends StatefulWidget {
  final String classTitle;
  final String studentName;
  final String amount;
  final String date;
  final Color color;

  const CustomHistoryCard(
      {super.key, required this.classTitle, required this.studentName, required this.amount, required this.date, required this.color});

  @override
  State<CustomHistoryCard> createState() => _CustomHistoryCardState();
}

class _CustomHistoryCardState extends State<CustomHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: Card(
            color: widget.color,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tutoría: ${widget.classTitle}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline_outlined,
                        color: Colors.white
                      ),
                      const SizedBox(width: 8.0),
                      Text('Estudiante: ${widget.studentName}', style: 
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: Colors.white
                      ),
                      const SizedBox(width: 8.0),
                      Text('Monto: Bs.${widget.amount}', style: 
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        color: Colors.white
                      ),
                      const SizedBox(width: 8.0),
                      Text('Fecha: ${widget.date}', style: 
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
  }
}