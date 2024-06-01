import 'package:flutter/material.dart';
import 'package:metro_experts/pages/create_tutoria.dart';
import 'package:metro_experts/pages/tutor_profile_view.dart';
import 'package:metro_experts/pages/user_edit_profile.dart';
import 'package:metro_experts/pages/tutor_edit_profile.dart';
import './pages/log_in_page.dart';

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
      home: const TutorProfileView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
