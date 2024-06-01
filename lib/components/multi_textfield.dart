import 'package:flutter/material.dart';

class MultiTextfield extends StatefulWidget {
  const MultiTextfield({super.key});

  @override
  State<MultiTextfield> createState() => _MultiTextfieldState();
}

class _MultiTextfieldState extends State<MultiTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30, left: 50, right: 50),
      child: TextField(
        minLines: 2,
        maxLines: 7,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(.5),
          labelText: "Sobre mí:",
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,                    
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Cuéntanos de tí!",
        hintStyle: TextStyle(
          fontSize: 12, 
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        )  
      )
    )
    );
  }
}

