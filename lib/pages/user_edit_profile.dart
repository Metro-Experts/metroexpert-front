//para uso de iconos svg
import 'package:flutter/material.dart';
import 'package:metro_experts/components/custom_text_field.dart';
import 'package:metro_experts/components/drawer_menu.dart';
import 'package:metro_experts/controllers/user_edit_profile_page_controller.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:provider/provider.dart';

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({super.key});

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  @override
  void initState() {
    Provider.of<UserEditProfilePageController>(context, listen: false)
        .fetchUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userEditProfilePageController =
        Provider.of<UserEditProfilePageController>(context, listen: false);

    return Consumer<UserOnSession>(
      builder: (context, accountPageModel, _) {
        return Scaffold(
          appBar: AppBar(),
          drawer: const DrawerMenu(),
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
                          image: const DecorationImage(
                              image: AssetImage('assets/images/User_01.png')),
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
                const SizedBox(height: 70),
                CustomTextField(
                  labelText: "Nombre de Usuario",
                  placeholder: accountPageModel.userData.name,
                  isPasswordTextField: false,
                  controller: userEditProfilePageController.nameController,
                ),
                CustomTextField(
                  labelText: "Apellido de Usuario",
                  placeholder: accountPageModel.userData.lastName,
                  isPasswordTextField: false,
                  controller: userEditProfilePageController.lastNameController,
                ),
                CustomTextField(
                  labelText: "Email",
                  placeholder: accountPageModel.userData.email,
                  isPasswordTextField: false,
                  controller: userEditProfilePageController.emailController,
                  isEnabled: false,
                ),
                CustomTextField(
                  labelText: "Contraseña",
                  placeholder: "*********",
                  isPasswordTextField: false,
                  controller: userEditProfilePageController.passwordController,
                  isEnabled: false,
                ),
                const SizedBox(height: 30),
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
                          backgroundColor: const Color(0xffff0000),
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
                          userEditProfilePageController.saveUserInformation(
                              UserModel(
                                name: userEditProfilePageController
                                    .nameController.text,
                                lastName: userEditProfilePageController
                                    .lastNameController.text,
                                email: accountPageModel.userData.email,
                              ),
                              context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                          userEditProfilePageController.nameController.clear();
                          userEditProfilePageController.lastNameController
                              .clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff060b26),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
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
      },
    );
  }
}
