import 'package:flutter/material.dart';

class MultiTextfield extends StatefulWidget {
  final String labelText;
  final String placeholder;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;

  const MultiTextfield({
    super.key,
    required this.labelText,
    required this.placeholder,
    required this.bottomPadding,
    required this.leftPadding,
    required this.rightPadding,
  });

  @override
  State<MultiTextfield> createState() => _MultiTextfieldState();
}

class _MultiTextfieldState extends State<MultiTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.bottomPadding,
          left: widget.leftPadding,
          right: widget.rightPadding),
      child: TextField(
        minLines: 2,
        maxLines: 7,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(.5),
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: widget.placeholder,
          hintStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
