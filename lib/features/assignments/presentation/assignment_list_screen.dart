import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_sphere/features/assignments/domain/assignment_entity.dart';
import 'package:student_sphere/features/assignments/presentation/assignment_controller.dart';
import 'package:intl/intl.dart';

class AssignmentListScreen extends ConsumerWidget {
  const AssignmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentState = ref.watch(assignmentControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Assignments')),
      body: assignmentState.when(
        data: (assignments) {
          if (assignments.isEmpty) {
            return const Center(child: Text('No assignments. Good job!'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              return _AssignmentCard(assignment: assignments[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/home/assignments/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AssignmentCard extends ConsumerWidget {
  final AssignmentEntity assignment;

  const _AssignmentCard({required this.assignment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOverdue =
        assignment.deadline.isBefore(DateTime.now()) && !assignment.isCompleted;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isOverdue ? Colors.red.shade50 : null,
      child: ListTile(
        leading: Checkbox(
          value: assignment.isCompleted,
          onChanged: (value) {
            ref
                .read(assignmentControllerProvider.notifier)
                .toggleCompletion(assignment.id, value!);
          },
        ),
        title: Text(
          assignment.title,
          style: TextStyle(
            decoration:
                assignment.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(assignment.description),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time,
                    size: 14, color: isOverdue ? Colors.red : Colors.grey),
                const SizedBox(width: 4),
                Text(
                  DateFormat.yMMMd().add_jm().format(assignment.deadline),
                  style: TextStyle(
                    color: isOverdue ? Colors.red : Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                _PriorityBadge(priority: assignment.priority),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            ref
                .read(assignmentControllerProvider.notifier)
                .deleteAssignment(assignment.id);
          },
        ),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final String priority;

  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (priority) {
      case 'High':
        color = Colors.red;
        break;
      case 'Medium':
        color = Colors.orange;
        break;
      case 'Low':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        priority,
        style:
            TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
