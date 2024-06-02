import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:metro_experts/firebase_auth/widget_tree.dart';
import 'package:metro_experts/pages/log_in_page.dart';
import 'package:metro_experts/pages/sign_up_page.dart';
import 'package:metro_experts/pages/tutor_edit_profile.dart';
import 'package:metro_experts/pages/user_edit_profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      //home:  SignUpPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
