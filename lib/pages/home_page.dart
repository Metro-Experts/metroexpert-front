import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:metro_experts/components/tutor_card_render.dart';
import 'package:metro_experts/controllers/homepage_controller.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:metro_experts/pages/create_class.dart';
import 'package:metro_experts/pages/sign_in_page.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:metro_experts/pages/user_edit_profile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<HomePageController>(context, listen: false).fetchTutorings();
    Provider.of<HomePageController>(context, listen: false).fetchUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userOnSession = Provider.of<UserOnSession>(context, listen: false);
    final homePageController =
        Provider.of<HomePageController>(context, listen: false);
    return Consumer2<UserOnSession, HomePageController>(
      builder: (context, userOnSessionConsumer, homePageControllerConsumer, _) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Hola, ${userOnSessionConsumer.userData.name} 👋🏻'
                        .toUpperCase(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateClass()),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  onTap: () {
                    Auth().signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInPage()),
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
                  onChanged: homePageController.updateSearchQuery,
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
                  child: homePageControllerConsumer.filteredTutors.isNotEmpty
                      ? ListView.builder(
                          itemCount:
                              homePageControllerConsumer.filteredTutors.length,
                          itemBuilder: (context, index) {
                            var tutoring = homePageControllerConsumer
                                .filteredTutors[index];
                            return TutorCardRender(
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
      },
    );
  }
}