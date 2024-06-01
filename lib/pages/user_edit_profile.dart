import 'package:flutter/material.dart';
import 'package:metro_experts/components/appBar.dart';
import 'package:metro_experts/components/buildTextField.dart'; //para uso de iconos svg

class UserEditProfile extends StatelessWidget {
  bool isObscurePassword = true;

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
            SizedBox(height: 50),
            const CustomTextField(
                labelText: "Username",
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
                labelText: "Password",
                placeholder: "********",
                isPasswordTextField: true),
            const CustomTextField(
                labelText: "Phone Number",
                placeholder: "+58 04241501278",
                isPasswordTextField: false),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Text("    Cancel    ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      )),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xfffFF0000),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Save Changes",
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xfff060B26),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
