import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/timetable/domain/class_entity.dart';
import 'package:student_sphere/features/timetable/presentation/timetable_settings.dart';

class TimetableGridView extends ConsumerWidget {
  final List<ClassEntity> classes;

  const TimetableGridView({super.key, required this.classes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(timetableSettingsProvider);
    final startHour = settings.startHour;
    final endHour = settings.endHour;
    final showWeekends = settings.showWeekends;
    final daysToShow = showWeekends ? 7 : 5;
    final totalHours = endHour - startHour;

    return LayoutBuilder(
      builder: (context, constraints) {
        final hourHeight = 60.0;
        final timeColumnWidth = 50.0;
        final dayColumnWidth =
            (constraints.maxWidth - timeColumnWidth) / daysToShow;
        final totalHeight = (totalHours + 1) * hourHeight;

        return SingleChildScrollView(
          child: SizedBox(
            height: totalHeight + 40, // +40 for header
            child: Stack(
              children: [
                // Time Column
                for (int i = 0; i <= totalHours; i++)
                  Positioned(
                    top: 40 + (i * hourHeight),
                    left: 0,
                    width: timeColumnWidth,
                    child: Center(
                      child: Text(
                        '${(startHour + i).toString().padLeft(2, '0')}:00',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ),

                // Day Headers
                for (int i = 0; i < daysToShow; i++)
                  Positioned(
                    top: 0,
                    left: timeColumnWidth + (i * dayColumnWidth),
                    width: dayColumnWidth,
                    height: 40,
                    child: Center(
                      child: Text(
                        _getDayName(i + 1),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                // Grid Lines
                for (int i = 0; i <= totalHours; i++)
                  Positioned(
                    top: 40 + (i * hourHeight),
                    left: timeColumnWidth,
                    right: 0,
                    child: const Divider(height: 1, color: Colors.grey),
                  ),
                for (int i = 0; i <= daysToShow; i++)
                  Positioned(
                    top: 40,
                    bottom: 0,
                    left: timeColumnWidth + (i * dayColumnWidth),
                    child: const VerticalDivider(width: 1, color: Colors.grey),
                  ),

                // Class Blocks
                ...classes
                    .where((c) => showWeekends || c.dayOfWeek <= 5)
                    .map((c) {
                  final dayIndex = c.dayOfWeek - 1;
                  final startMinutes =
                      (c.startTime.hour * 60) + c.startTime.minute;
                  final endMinutes = (c.endTime.hour * 60) + c.endTime.minute;
                  final startOffsetMinutes = (startHour * 60);

                  // Skip if class is outside visible hours
                  if (endMinutes < startOffsetMinutes ||
                      startMinutes > (endHour * 60)) {
                    return const SizedBox.shrink();
                  }

                  final top = 40 +
                      ((startMinutes - startOffsetMinutes) / 60.0) * hourHeight;
                  final height =
                      ((endMinutes - startMinutes) / 60.0) * hourHeight;

                  return Positioned(
                    top: top,
                    left: timeColumnWidth + (dayIndex * dayColumnWidth) + 2,
                    width: dayColumnWidth - 4,
                    height: height,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(c.color).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.subjectName,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            c.roomNumber,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white70,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getDayName(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}
