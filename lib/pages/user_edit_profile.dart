// ignore_for_file: use_full_hex_values_for_flutter_colors
import 'package:flutter/material.dart';
import 'package:metro_experts/components/app_bar.dart';
import 'package:metro_experts/components/build_text_field.dart'; //para uso de iconos svg
import 'package:provider/provider.dart';


class UserEditProfile extends StatelessWidget {
  final bool isObscurePassword = true;
  UserEditProfile({super.key});

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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

            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: "Nombre de Usuario",
              )
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _apellidoController,
              decoration: const InputDecoration(
                labelText: "Carrera",
              )
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              )
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
                      child: const Text("Cancelar",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ))),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xfff060b26),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text("Guardar",
                          style: TextStyle(fontSize: 15, color: Colors.white)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class Usuario {
  String name;
  String lastname;
  String email;

  Usuario({required this.name, required this.lastname, required this.email});
}

class UserProvider with ChangeNotifier {
  Usuario? _user;

  Usuario? get user => _user;

  void setUser(Usuario user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}

