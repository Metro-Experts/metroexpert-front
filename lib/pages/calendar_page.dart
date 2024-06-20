// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:metro_experts/components/custom_floating_action_button.dart';
import 'package:metro_experts/components/drawer_menu.dart';
import 'package:metro_experts/controllers/calendar_page_controller.dart';
import 'package:metro_experts/model/event_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDay;

  DateTime _focusedDay = DateTime.now();

  Map<DateTime, List<Event>> events = {};

  final TextEditingController _eventController = TextEditingController();

  late final ValueNotifier<List<Event>> _selectedEvents;

  List<Event> _getEventsForToday(DateTime day) {
    print(events[day]);
    return events[day] ?? [];
  }

  Future<void> getEventsFromBack(BuildContext context) async {
    List clasesAndDates =
        await Provider.of<CalendarPageController>(context, listen: false)
            .clasesAndDates;

    for (var i = 0; i < clasesAndDates.length; i++) {
      List dates = clasesAndDates[i]['calendario'];

      for (var j = 0; j < dates.length; j++) {
        List date = dates[j].split('-');

        DateTime formattedDate =
            DateTime.parse('${date[0]}-${date[1]}-${date[2]} '
                '${0}${0}:${0}${0}:${0}${0}.'
                '${0}${0}${0}Z');
        events.addAll(
          {
            formattedDate: [
              Event('${clasesAndDates[i]['name']}'),
            ],
          },
        );
      }
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(
        () {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          _selectedEvents.value = _getEventsForToday(selectedDay);
        },
      );
    }
  }

  @override
  void initState() {
    getEventsFromBack(context);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForToday(_selectedDay!));
    super.initState();
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
                eventLoader: _getEventsForToday,
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
                            color: index % 2 == 0
                                ? const Color.fromRGBO(0xF2, 0xB0, 0x80, 1)
                                : const Color(0xFF9FA9FF),
                          ),
                          child: ListTile(
                            minTileHeight: 64,
                            trailing: const Icon(
                              Icons.book,
                              color: Colors.black,
                            ),
                            title: Text(
                              '${value[index].title}'.toUpperCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
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
