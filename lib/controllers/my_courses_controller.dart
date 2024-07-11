import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class MyCoursesController extends ChangeNotifier {
  List<Map<String, dynamic>> _enrolledCourses = [];

  List<Map<String, dynamic>> get enrolledCourses => _enrolledCourses;

  Future<void> fetchEnrolledCourses() async {
    try {
      var url = Uri.parse(
          'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/users/${FirebaseAuth.instance.currentUser!.uid}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map responseData = json.decode(response.body);
        List<dynamic> courseIds = responseData['courses_student'];
        print('Course IDs: $courseIds');

        var coursesUrl = Uri.parse(
            'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/courses');
        final coursesResponse = await http.get(coursesUrl);

        if (coursesResponse.statusCode == 200) {
          List<dynamic> coursesData = json.decode(coursesResponse.body);
          _enrolledCourses = coursesData
              .where((course) => courseIds.contains(course['_id']))
              .map((course) => course as Map<String, dynamic>)
              .toList();
          print('Enrolled Courses: $_enrolledCourses');
        } else {
          print('Error fetching courses data...');
        }
      } else {
        print('Error fetching user data...');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
    notifyListeners();
  }
}
