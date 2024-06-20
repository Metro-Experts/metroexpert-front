import 'package:flutter/material.dart';
import 'package:metro_experts/model/event_model.dart';
import 'package:metro_experts/pages/calendar_page.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomFloatingActionButton extends StatefulWidget {
  final TextEditingController eventController;
  final Map<DateTime, List<Event>> events;
  final DateTime? selectedDay;
  final ValueNotifier<List<Event>> selectedEvents;
  final Function(DateTime)? getEventsForDay;

  const CustomFloatingActionButton({
    Key? key,
    required this.eventController,
    required this.selectedDay,
    required this.events,
    required this.selectedEvents,
    required this.getEventsForDay,
  }) : super(key: key);

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF9FA9FF),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              title: const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Please Add An Event',
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: widget.eventController,
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0xF2, 0xB0, 0x80, 1),
                  ),
                  onPressed: () {
                    _addEvent();
                  },
                  child: const Text(
                    'Create Event',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }

  void _addEvent() {
    if (widget.selectedDay != null) {
      if (widget.events.containsKey(widget.selectedDay)) {
        widget.events[widget.selectedDay!]!.add(
          Event(widget.eventController.text),
        );
      } else {
        widget.events[widget.selectedDay!] = [
          Event(widget.eventController.text),
        ];
      }

      widget.selectedEvents.value =
          widget.getEventsForDay!(widget.selectedDay!);

      widget.eventController.clear(); // Clear text field
      Navigator.of(context).pop();
    }
  }
}
