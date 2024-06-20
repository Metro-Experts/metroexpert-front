// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:metro_experts/components/tutor_card_render.dart';
import 'package:metro_experts/firebase_auth/auth.dart';
import 'package:http/http.dart' as http;
import 'package:metro_experts/model/user_model.dart';
import 'package:provider/provider.dart';

class HomePageController extends ChangeNotifier {
  List<TutorCardRender> _tutorCard = [];
  List<TutorCardRender> filteredTutors = [];
  String searchQuery = '';
  String userType = '';
  List ids = [];

  Future<void> fetchTutorings(BuildContext context) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/courses');
    final response = await http.get(url);

    if (response.statusCode == 200 && Auth().currentUser != null) {
      List<dynamic> responseData = json.decode(response.body);
      print(responseData);
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
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/${Auth().currentUser!.uid}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map responseData = json.decode(response.body);
      userType = responseData['userType'];
      ids = responseData['courses_student'];

      Provider.of<UserOnSession>(context, listen: false)
          .updateUserData(responseData);
    } else {
      print('error fetching user...');
    }
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    filteredTutors = _tutorCard.where((tutor) {
      return tutor.subject.toLowerCase().contains(query.toLowerCase()) ||
          tutor.tutorName.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }
}
