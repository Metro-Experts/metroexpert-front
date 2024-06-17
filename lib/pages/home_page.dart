import 'package:flutter/material.dart';
import 'package:metro_experts/components/drawer_menu.dart';
import 'package:metro_experts/components/tutor_card_render.dart';
import 'package:metro_experts/controllers/homepage_controller.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<HomePageController>(context, listen: false).fetchUser(context);
    Provider.of<HomePageController>(context, listen: false)
        .fetchTutorings(context);
  }

  @override
  Widget build(BuildContext context) {
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
              ],
            ),
          ),
          drawer: const DrawerMenu(),
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
                  onChanged: homePageControllerConsumer.updateSearchQuery,
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
                              dates: tutoring.dates,
                              color: const Color(0xFF9FA9FF),
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
