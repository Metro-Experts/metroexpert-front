import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:metro_experts/components/tutor_card.dart';
import 'package:metro_experts/pages/sign_in_page.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:http/http.dart' as http;
import 'package:metro_experts/pages/tutor_edit_profile.dart';
import 'package:metro_experts/pages/user_edit_profile.dart';

//marico el que lo lea
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TutorCard> _tutorCard = [];
  List<TutorCard> filteredTutors = [];
  String searchQuery = '';

  Size size = const Size(0, 0);

  Future<void> fetchTutorings() async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/courses');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      setState(() {
        _tutorCard =
            responseData.map((data) => TutorCard.fromJson(data)).toList();
        filteredTutors = _tutorCard;
      });
    } else {
      print('error fetching tutorings...');
    }
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredTutors = _tutorCard.where((tutor) {
        return tutor.subject.toLowerCase().contains(query.toLowerCase()) ||
            tutor.tutorName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    fetchTutorings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('¡Hola, Daniel!', style: TextStyle(fontSize: 18)),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/man_teaching.png'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(
                size: 32,
                Icons.home,
                color: Color.fromRGBO(238, 138, 111, 1),
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Navigate to home page
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 32,
                color: Color.fromRGBO(238, 138, 111, 1),
              ),
              title: const Text('Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TutorEditProfile()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 32,
                color: Color.fromRGBO(238, 138, 111, 1),
              ),
              title: const Text('Logout',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onTap: () {
                Auth().signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInPage()),
                );
              },
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
                        var tutoring = filteredTutors[index];
                        return TutorCard(
                          subject: tutoring.subject,
                          tutorName: tutoring.tutorName,
                          tutoringFee: tutoring.tutoringFee,
                          tutoringId: tutoring.tutoringId,
                          tutoringStudents: tutoring.tutoringStudents,
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
