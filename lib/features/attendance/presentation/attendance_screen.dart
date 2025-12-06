import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/attendance/domain/subject_entity.dart';
import 'package:student_sphere/features/attendance/presentation/attendance_controller.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceState = ref.watch(attendanceControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: attendanceState.when(
        data: (subjects) {
          if (subjects.isEmpty) {
            return const Center(child: Text('No subjects added yet.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              return _SubjectCard(subject: subjects[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSubjectDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSubjectDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final targetController = TextEditingController(text: '75');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Subject'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Subject Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: targetController,
              decoration:
                  const InputDecoration(labelText: 'Target Percentage (%)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                ref.read(attendanceControllerProvider.notifier).addSubject(
                      nameController.text,
                      int.tryParse(targetController.text) ?? 75,
                    );
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _SubjectCard extends ConsumerWidget {
  final SubjectEntity subject;

  const _SubjectCard({required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percentage = subject.currentPercentage;
    final isLow = percentage < subject.targetPercentage;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Target: ${subject.targetPercentage}%',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: Colors.grey.shade200,
                        color: isLow ? Colors.red : Colors.green,
                        strokeWidth: 6,
                      ),
                    ),
                    Text(
                      '${percentage.toStringAsFixed(1)}%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  icon: Icons.close,
                  color: Colors.red,
                  label: 'Absent (${subject.absentCount})',
                  onTap: () {
                    ref
                        .read(attendanceControllerProvider.notifier)
                        .markAttendance(subject.id, false);
                  },
                ),
                _ActionButton(
                  icon: Icons.check,
                  color: Colors.green,
                  label: 'Present (${subject.presentCount})',
                  onTap: () {
                    ref
                        .read(attendanceControllerProvider.notifier)
                        .markAttendance(subject.id, true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
