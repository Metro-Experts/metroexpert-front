import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:metro_experts/components/tutor_card.dart';
import 'package:metro_experts/pages/create_class.dart';
import 'package:metro_experts/pages/sign_in_page.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:http/http.dart' as http;
import 'package:metro_experts/pages/tutor_edit_profile.dart';
import 'package:metro_experts/pages/user_edit_profile.dart';

class User {
  final dynamic name;
  final dynamic lastName;
  final dynamic email;

  User({
    required this.name,
    required this.lastName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "lastName": lastName,
    };
  }
}

//marico el que lo lea
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User userData = User(
    name: '',
    lastName: '',
    email: '',
  );
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

  Future<void> fetchUser() async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/${Auth().currentUser!.uid}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);

      setState(
        () {
          userData = User(
              name: responseData['name'],
              lastName: responseData['lastName'],
              email: responseData['email']);
        },
      );
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
    fetchUser();
    print(Auth().currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Hola, ${userData.name} 👋🏻'.toUpperCase(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/User_01.png'),
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
                      builder: (context) => const UserEditProfile()),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.assignment_add,
                size: 32,
                color: Color.fromRGBO(238, 138, 111, 1),
              ),
              title: const Text('Create Class',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateClass()),
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
