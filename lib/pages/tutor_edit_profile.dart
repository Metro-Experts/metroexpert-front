// ignore_for_file: use_full_hex_values_for_flutter_colors
import 'package:flutter/material.dart';
import 'package:metro_experts/components/custom_text_field.dart';
import 'package:metro_experts/components/multi_textfield.dart';
import 'package:metro_experts/controllers/tutor_edit_profile_page_controller.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:metro_experts/pages/sign_in_page.dart';
import 'package:provider/provider.dart';

class TutorEditProfile extends StatefulWidget {
  const TutorEditProfile({super.key});

  @override
  State<TutorEditProfile> createState() => _TutorEditProfileState();
}

class _TutorEditProfileState extends State<TutorEditProfile> {
  @override
  void initState() {
    Provider.of<TutorEditProfilePageController>(context, listen: false)
        .fetchUser(context);
    Provider.of<TutorEditProfilePageController>(context, listen: false).reset;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tutorEditProfilePageController =
        Provider.of<TutorEditProfilePageController>(context, listen: false);
    final accountPageModel = Provider.of<UserOnSession>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(
                size: 32,
                Icons.home,
                color: Color.fromRGBO(238, 138, 111, 1),
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 32,
                color: Color.fromRGBO(238, 138, 111, 1),
              ),
              title: const Text('Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 32,
                color: Color.fromRGBO(238, 138, 111, 1),
              ),
              title: const Text('Logout',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onTap: () {
                Auth().signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInPage()),
                );
              },
            ),
          ],
        ),
      ),
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
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
                labelText: "Nombre de Usuario",
                placeholder: accountPageModel.userData.name,
                isPasswordTextField: false,
                controller: tutorEditProfilePageController.nameController),
            CustomTextField(
              labelText: "Apellido Del Usuario",
              placeholder: accountPageModel.userData.lastName,
              isPasswordTextField: false,
              controller: tutorEditProfilePageController.lastNameController,
            ),
            CustomTextField(
              labelText: "Email",
              placeholder: accountPageModel.userData.email,
              isPasswordTextField: false,
              controller: tutorEditProfilePageController.emailController,
              isEnabled: false,
            ),
            CustomTextField(
              labelText: "Contraseña",
              placeholder: "*********",
              isPasswordTextField: false,
              controller: tutorEditProfilePageController.passwordController,
              isEnabled: false,
            ),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
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
                    onPressed: () {
                      tutorEditProfilePageController.saveUserInformation(
                          UserModel(
                            name: tutorEditProfilePageController
                                .nameController.text[0],
                            lastName: tutorEditProfilePageController
                                .lastNameController.text[1],
                            email: accountPageModel.userData.email,
                          ),
                          context);
                    },
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
