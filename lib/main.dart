import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:metro_experts/controllers/calendar_page_controller.dart';
import 'package:metro_experts/controllers/chatbot_page_controller.dart';
import 'package:metro_experts/controllers/course_page_controller.dart';
import 'package:metro_experts/controllers/create_class_page_controller.dart';
import 'package:metro_experts/controllers/homepage_controller.dart';
import 'package:metro_experts/controllers/sign_in_page_controller.dart';
import 'package:metro_experts/controllers/sign_up_page_controller.dart';
import 'package:metro_experts/controllers/tutor_edit_profile_page_controller.dart';
import 'package:metro_experts/controllers/user_edit_profile_page_controller.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:metro_experts/pages/intro_page.dart';
import 'package:metro_experts/controllers/data_payment_page_controller.dart';
import 'package:metro_experts/controllers/tutor_payment_gestor_controller.dart';
import 'package:metro_experts/controllers/tutor_confirm_payment_controller.dart';
import 'package:metro_experts/controllers/my_courses_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignInPageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpPageController(),
        ),
        ChangeNotifierProvider(
            create: (context) => TutorEditProfilePageController()),
        ChangeNotifierProvider(
            create: (context) => UserEditProfilePageController()),
        ChangeNotifierProvider(
          create: (context) => HomePageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserOnSession(),
        ),
        ChangeNotifierProvider(
          create: (context) => CoursePageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateClassPageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CalendarPageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatbotPageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataPaymentPageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TutorPaymentGestorController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TutorConfirmPaymentController(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyCoursesController(),
        ),
      ],
      child: MaterialApp(
        title: 'MetroExperts',
        theme: ThemeData(
          fontFamily: 'Poppins',
          useMaterial3: true,
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.white,
          ),
        ),
        // The property [home] defines the default route of the app
        home: const IntroPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
