import 'package:flutter/material.dart';
import 'package:metro_experts/pages/sign_in_page.dart';
import 'course_page.dart';
import 'package:metro_experts/firebase_auth/auth.dart'; // Importa la nueva página

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> tutors = List.generate(
    7,
    (index) => {
      'subject': 'Modelación Estocástica ${index + 1}',
      'tutorName': 'Tutor ${index + 1}',
      'imagePath': 'assets/images/man_teaching.png',
    },
  );

  List<Map<String, String>> filteredTutors = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredTutors = tutors;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredTutors = tutors
          .where((tutor) => tutor['subject']!
              .toLowerCase()
              .startsWith(searchQuery.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('¡Hola, Daniel!', style: TextStyle(fontSize: 18)),
            GestureDetector(
              onTap: () {
                Auth().signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInPage()),
                );
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/man_teaching.png'),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contacta a tu tutor fácilmente',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Buscar por asignatura o nombre del tutor',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredTutors.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredTutors.length,
                      itemBuilder: (context, index) {
                        return TutorCard(
                          subject: filteredTutors[index]['subject']!,
                          tutorName: filteredTutors[index]['tutorName']!,
                          imagePath: filteredTutors[index]['imagePath']!,
                          color: index.isEven
                              ? const Color(0xFFFEC89F)
                              : const Color(0xFF9FA9FF),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No se encontraron resultados',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class TutorCard extends StatelessWidget {
  final String subject;
  final String tutorName;
  final String imagePath;
  final Color color;

  const TutorCard({
    required this.subject,
    required this.tutorName,
    required this.imagePath,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoursePage(
              subject: subject,
              tutorName: tutorName,
            ),
          ),
        );
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0), // Ajuste del margen para menos ancho
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        subject,
                        style: const TextStyle(
                          fontSize: 20, // Título más grande
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        tutorName,
                        style: const TextStyle(
                          fontSize: 16, // Subtítulo
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                imagePath,
                width: 140,
                height: 140,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
