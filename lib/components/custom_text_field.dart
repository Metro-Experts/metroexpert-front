// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String placeholder;
  final bool isPasswordTextField;
  final bool isObscurePassword;
  final TextEditingController controller;
  bool? isEnabled;

  CustomTextField(
      {super.key,
      required this.labelText,
      required this.placeholder,
      this.isObscurePassword = true,
      required this.isPasswordTextField,
      required this.controller,
      this.isEnabled});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscurePassword = true;

  @override
  void initState() {
    widget.isEnabled = true;
    super.initState();
    isObscurePassword = widget.isObscurePassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 50, right: 50),
      child: TextField(
        controller: widget.controller,
        enabled: widget.isEnabled,
        obscureText:
            widget.isPasswordTextField ? widget.isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: widget.isPasswordTextField
              ? IconButton(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.grey),
                  onPressed: () {
                    setState(
                      () {
                        isObscurePassword =
                            !isObscurePassword; //no se que no sirve aqui
                      },
                    );
                  },
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 5),
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
