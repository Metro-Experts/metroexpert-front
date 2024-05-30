import 'package:flutter/material.dart';
import 'package:metro_experts/pages/create_tutoria.dart';
import 'package:metro_experts/pages/editProfile.dart';
import 'package:metro_experts/pages/intro_page.dart';
import 'package:metro_experts/pages/tutor_edit_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MetroExperts',
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
        ),
      ),
      // The property [home] defines the default route of the app
      //home:  EditProfile(),
      debugShowCheckedModeBanner: false,
    );
  }
}
