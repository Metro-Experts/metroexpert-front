import 'package:flutter/material.dart';
import 'package:metro_experts/components/drawer_menu.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Container(
          child: TableCalendar(
            focusedDay: today,
            firstDay: DateTime.utc(2020, 8, 16),
            lastDay: DateTime.utc(2030, 8, 16),
          ),
        ),
      ),
    );
  }
}
