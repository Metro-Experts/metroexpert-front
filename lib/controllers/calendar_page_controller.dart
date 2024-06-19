import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metro_experts/controllers/homepage_controller.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CalendarPageController extends ChangeNotifier {
  List dates = [];
  Future<void> fetchCalenderDates(BuildContext context) async {
    var url = Uri.parse(
        'https://uniexpert-gateway-6569fdd60e75.herokuapp.com/courses/get-by-ids');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {"ids": Provider.of<HomePageController>(context, listen: false).ids}),
    );

    List responseList = jsonDecode(response.body);

    Map responseData = responseList[0];

    if (response.statusCode == 200) {
      dates = responseData['calendario'];
      print('Calendars fetch has been successful');
    } else {
      print('Error');
    }
    notifyListeners();
  }
}
