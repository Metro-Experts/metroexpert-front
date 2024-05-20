import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnTop',
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        useMaterial3: true,
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
        ),
      ),
      // The property [home] defines the default route of the app
      // home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
