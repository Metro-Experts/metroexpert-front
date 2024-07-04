import 'package:flutter/material.dart';
import 'package:metro_experts/pages/tutor_confirm_payment.dart';

class CustomListTile extends StatefulWidget {
  final String classTitle;
  final String studentName;

  const CustomListTile(
      {super.key, required this.classTitle, required this.studentName});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: const Color(0xFFEE8A6F),
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        title: Text(widget.classTitle,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18)),
        subtitle: Text(widget.studentName,
            style: const TextStyle(color: Colors.white)),
        leading:
            const Icon(Icons.menu_book_outlined, color: Colors.white, size: 35),
        trailing: SizedBox(
          height: 50,
          width: 50,
          child: IconButton(
            color: Colors.white,
            iconSize: 25,
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TutorConfirmPayment(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
