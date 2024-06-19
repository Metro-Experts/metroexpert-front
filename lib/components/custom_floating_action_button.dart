import 'package:flutter/material.dart';
import 'package:metro_experts/model/event_model.dart';

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
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Event Name'),
              content: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: widget.eventController,
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    _addEvent();
                  },
                  child: const Text('Ok'),
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

      widget.eventController.text = ''; // Clear text field
      Navigator.of(context).pop(); // Close dialog

      if (widget.getEventsForDay != null) {
        // Update selected events using the provided function
        widget.selectedEvents.value =
            widget.getEventsForDay!(widget.selectedDay!);
      }
    }
  }
}
