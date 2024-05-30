import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // Importa la nueva página desde la carpeta pages

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
      home: HomePage(), // Usa la nueva página como página inicial
      debugShowCheckedModeBanner: false,
    );
  }
}
