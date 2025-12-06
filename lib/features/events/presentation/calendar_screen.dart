import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:student_sphere/features/events/domain/event_entity.dart';
import 'package:student_sphere/features/events/presentation/event_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final eventState = ref.watch(eventControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: eventState.when(
        data: (events) {
          final eventsByDay = _groupEventsByDay(events);
          final selectedEvents =
              _selectedDay != null ? eventsByDay[_selectedDay!] ?? [] : [];

          return Column(
            children: [
              TableCalendar<EventEntity>(
                firstDay: DateTime.utc(2020, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                eventLoader: (day) {
                  return eventsByDay[DateTime(day.year, day.month, day.day)] ??
                      [];
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedEvents.length,
                  itemBuilder: (context, index) {
                    final event = selectedEvents[index];
                    return ListTile(
                      leading:
                          CircleAvatar(backgroundColor: Color(event.color)),
                      title: Text(event.title),
                      subtitle: Text(event.category),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          ref
                              .read(eventControllerProvider.notifier)
                              .deleteEvent(event.id);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/home/calendar/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Map<DateTime, List<EventEntity>> _groupEventsByDay(List<EventEntity> events) {
    final data = <DateTime, List<EventEntity>>{};
    for (var event in events) {
      final date = DateTime(event.date.year, event.date.month, event.date.day);
      if (data[date] == null) data[date] = [];
      data[date]!.add(event);
    }
    return data;
  }
}
