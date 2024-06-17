// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:metro_experts/pages/create_class.dart';
import 'package:metro_experts/pages/home_page.dart';
import 'package:metro_experts/pages/sign_in_page.dart';
import 'package:metro_experts/pages/user_edit_profile.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  File? image;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      // Pick the image
      final pickedFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Handle the picked image
        setState(() {
          image = File(pickedFile.path);
        });
      }
    } on PlatformException catch (e) {
      // Handle any other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: ${e.message}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserOnSession>(
        builder: (context, userOnSessionConsumer, _) {
      return Drawer(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                _pickImage();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: buildHeader(context,
                    image: image,
                    name: userOnSessionConsumer.userData.name,
                    email: userOnSessionConsumer.userData.email),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                leading: const Icon(
                  size: 32,
                  Icons.home,
                  color: Color.fromRGBO(238, 138, 111, 1),
                ),
                title: const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Home',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                  ),
                ),
                onTap: () {
                  // Navigate to home page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                leading: const Icon(
                  Icons.settings,
                  size: 32,
                  color: Color.fromRGBO(238, 138, 111, 1),
                ),
                title: const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('Account',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.normal)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserEditProfile()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                leading: const Icon(
                  Icons.assignment_add,
                  size: 32,
                  color: Color.fromRGBO(238, 138, 111, 1),
                ),
                title: const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('Create Class',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.normal)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateClass()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  size: 32,
                  color: Color.fromRGBO(238, 138, 111, 1),
                ),
                title: const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text('Logout',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.normal)),
                ),
                onTap: () {
                  Auth().signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogInPage()),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

Widget buildHeader(
  BuildContext context, {
  required File? image,
  required String name,
  required String email,
}) =>
    Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Row(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundImage: image != null ? FileImage(image) : null),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
