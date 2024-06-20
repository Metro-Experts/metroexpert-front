import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:metro_experts/components/tutor_card_render.dart';
import 'package:metro_experts/model/user_model.dart';
import 'package:provider/provider.dart';

class HomePageController extends ChangeNotifier {
  List<TutorCardRender> _tutorCard = [];
  List<TutorCardRender> filteredTutors = [];
  String searchQuery = '';
  String selectedCategory = 'Todos los cursos';
  List ids = [];

  Future<void> fetchTutorings(BuildContext context) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/courses');
    final response = await http.get(url);

    if (response.statusCode == 200 &&
        FirebaseAuth.instance.currentUser != null) {
      List<dynamic> responseData = json.decode(response.body);
      _tutorCard =
          responseData.map((data) => TutorCardRender.fromJson(data)).toList();
      filteredTutors = _tutorCard;
    } else {
      print('error fetching tutorings...');
    }
    notifyListeners();
  }

  Future<void> fetchUser(BuildContext context) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/${FirebaseAuth.instance.currentUser!.uid}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      ids = responseData['courses_student'];

      Provider.of<UserOnSession>(context, listen: false)
          .updateUserData(responseData);
    } else {
      print('error fetching user...');
    }
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    filterTutors();
  }

  void updateCategoryFilter(String category) {
    selectedCategory = category;
    filterTutors();
  }

  void filterTutors() {
    filteredTutors = _tutorCard.where((tutor) {
      bool matchesQuery =
          tutor.subject.toLowerCase().contains(searchQuery.toLowerCase()) ||
              tutor.tutorName.toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == 'Todos los cursos' ||
          tutor.category == selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
    notifyListeners();
  }
}
