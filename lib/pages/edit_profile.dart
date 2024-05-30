// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; //para uso de iconos svg

class EditProfile extends StatelessWidget {
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
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
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.white),
                            color: const Color(0xfff060B26),
                          ),
                          child: const Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                buildTextField("Username", "jhondoe2003", false),
                buildTextField("Carrera", "Ingenieria de Sistemas", false),
                buildTextField("Email", "jhondoe@example.com", false),
                buildTextField("Password", "*******", true),
                buildTextField("Phone Number", "+58 04241501278", false),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: const Color(0xfffFF0000),
                      ),
                      child: const Text("Cancel",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          )),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xfff060B26),
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text("Save Changes",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)))
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 50, right: 50),
        child: TextField(
            obscureText: isPasswordTextField ? isObscurePassword : false,
            decoration: InputDecoration(
                suffixIcon: isPasswordTextField
                    ? IconButton(
                        icon: const Icon(Icons.remove_red_eye,
                            color: Colors.grey),
                        onPressed: () {
                          //setState(() {
                          // isObscurePassword = !isObscurePassword;
                          //});
                        })
                    : null,
                contentPadding: const EdgeInsets.only(bottom: 5),
                labelText: labelText,
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: placeholder,
                hintStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ))));
  }

  AppBar appBar() {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(
          color: Colors.black,
          height: .5,
        ),
      ),
      title: const Text(
        'Edit Profile',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}
