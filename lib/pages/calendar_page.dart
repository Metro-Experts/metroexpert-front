// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:metro_experts/components/custom_floating_action_button.dart';
import 'package:metro_experts/components/drawer_menu.dart';
import 'package:metro_experts/controllers/calendar_page_controller.dart';
import 'package:metro_experts/controllers/homepage_controller.dart';
import 'package:metro_experts/model/event_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    // getEventsFromBack(context);
    // Provider.of<CalendarPageController>(context, listen: false)
    //     .fetchCalenderDates(context);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForToday(_selectedDay!));
    super.initState();
  }

//variable that allowes the user to select a day
  DateTime? _selectedDay;
//
  DateTime _focusedDay = DateTime.now();
//here we store the day and the events related to that day

  Map<DateTime, List<Event>> events = {};
//event controller
  final TextEditingController _eventController = TextEditingController();
//events list
  late final ValueNotifier<List<Event>> _selectedEvents;
//function that allows to show events by day
  List<Event> _getEventsForToday(DateTime day) {
    return events[day] ?? [];
  }

  Future<void> getEventsFromBack(BuildContext context) async {
    List eventsFromBack =
        await Provider.of<CalendarPageController>(context, listen: false).dates;

    for (var i = 0; i < eventsFromBack.length; i++) {
      DateTime date = DateTime.parse(eventsFromBack[i]);
      events.addAll({
        date: [Event('felipe homosexual')],
      });
    }
  }

//this function allows the user to select a day and also render the events related to that date
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print(selectedDay);
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(
        () {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          //asigns the events related to that day to render it later
          _selectedEvents.value = _getEventsForToday(selectedDay);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: CustomFloatingActionButton(
        selectedEvents: _selectedEvents,
        getEventsForDay: _getEventsForToday,
        eventController: _eventController,
        selectedDay: _selectedDay,
        events: events,
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SizedBox(
          child: Column(
            children: [
              TableCalendar(
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                focusedDay: _focusedDay,
                firstDay: DateTime.utc(2020, 8, 16),
                lastDay: DateTime.utc(2030, 8, 16),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: _onDaySelected,
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text('${value[index].title}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
