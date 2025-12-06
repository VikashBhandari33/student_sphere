import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_sphere/features/timetable/domain/class_entity.dart';
import 'package:student_sphere/features/timetable/presentation/timetable_controller.dart';
import 'package:student_sphere/features/timetable/presentation/timetable_grid_view.dart';
import 'package:student_sphere/features/timetable/presentation/timetable_settings.dart';

class TimetableScreen extends ConsumerStatefulWidget {
  const TimetableScreen({super.key});

  @override
  ConsumerState<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends ConsumerState<TimetableScreen> {
  bool _isGridView = false;

  @override
  Widget build(BuildContext context) {
    final timetableState = ref.watch(timetableControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.table_chart),
            onPressed: () => context.go('/home/timetable/tables'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(context, ref),
          ),
        ],
      ),
      body: timetableState.when(
        data: (classes) {
          if (classes.isEmpty) {
            return const Center(child: Text('No classes added yet.'));
          }

          if (_isGridView) {
            return TimetableGridView(classes: classes);
          }

          // Group classes by day
          final groupedClasses = <int, List<ClassEntity>>{};
          for (var c in classes) {
            groupedClasses.putIfAbsent(c.dayOfWeek, () => []).add(c);
          }
          // Sort classes by time
          for (var key in groupedClasses.keys) {
            groupedClasses[key]!.sort((a, b) {
              final aMinutes = a.startTime.hour * 60 + a.startTime.minute;
              final bMinutes = b.startTime.hour * 60 + b.startTime.minute;
              return aMinutes.compareTo(bMinutes);
            });
          }

          return ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              final day = index + 1;
              final dayClasses = groupedClasses[day] ?? [];

              if (dayClasses.isEmpty) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _getDayName(day),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  ...dayClasses.map((c) => _ClassCard(classEntity: c)),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/home/timetable/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String _getDayName(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  void _showSettingsDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const TimetableSettingsDialog(),
    );
  }
}

class TimetableSettingsDialog extends ConsumerWidget {
  const TimetableSettingsDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(timetableSettingsProvider);
    final notifier = ref.read(timetableSettingsProvider.notifier);

    return AlertDialog(
      title: const Text('Timetable Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('Start Hour:'),
              const Spacer(),
              DropdownButton<int>(
                value: settings.startHour,
                items: List.generate(24, (index) => index).map((h) {
                  return DropdownMenuItem(
                    value: h,
                    child: Text('$h:00'),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null && val < settings.endHour) {
                    notifier.updateStartHour(val);
                  }
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('End Hour:'),
              const Spacer(),
              DropdownButton<int>(
                value: settings.endHour,
                items: List.generate(24, (index) => index).map((h) {
                  return DropdownMenuItem(
                    value: h,
                    child: Text('$h:00'),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null && val > settings.startHour) {
                    notifier.updateEndHour(val);
                  }
                },
              ),
            ],
          ),
          SwitchListTile(
            title: const Text('Show Weekends'),
            value: settings.showWeekends,
            onChanged: (val) => notifier.toggleWeekends(val),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

class _ClassCard extends StatelessWidget {
  final ClassEntity classEntity;

  const _ClassCard({required this.classEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: Color(classEntity.color),
      child: ListTile(
        title: Text(classEntity.subjectName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            Text('${classEntity.roomNumber} • ${classEntity.facultyName}'),
        trailing: Text(
          '${classEntity.startTime.format(context)} - ${classEntity.endTime.format(context)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
