// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:metro_experts/components/app_bar.dart';
import 'package:metro_experts/components/build_text_field.dart';
import 'package:metro_experts/components/multi_textfield.dart';

class TutorEditProfile extends StatefulWidget {
  const TutorEditProfile({super.key});

  @override
  State<TutorEditProfile> createState() => _TutorEditProfileState();
}

class _TutorEditProfileState extends State<TutorEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(38.0),
          child: CustomAppBar(titleText: 'Edit Profile')),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1)),
                      ],
                      shape: BoxShape.circle,
                      //image: DecorationImage(
                      //fit: BoxFit.cover,
                      // image: NetworkImage(),

                      // )
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const CustomTextField(
                labelText: "Nombre de Usuario",
                placeholder: "Jhon Doe",
                isPasswordTextField: false),
            const CustomTextField(
                labelText: "Carrera",
                placeholder: "Ingenieria de Sistemas",
                isPasswordTextField: false),
            const CustomTextField(
                labelText: "Email",
                placeholder: "jhondoe@example.com",
                isPasswordTextField: false),
            const CustomTextField(
                labelText: "Contraseña",
                placeholder: "********",
                isPasswordTextField: true),
            const CustomTextField(
                labelText: "Telefóno",
                placeholder: "+58 04241501278",
                isPasswordTextField: false),
            const MultiTextfield(
              bottomPadding: 10,
              leftPadding: 50,
              rightPadding: 50,
              labelText: 'Sobre mí:',
              placeholder: '...',
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xfffFF0000),
                    ),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff060B26),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      "Guardar",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
