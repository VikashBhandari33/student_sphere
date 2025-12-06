import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_sphere/features/assignments/domain/assignment_entity.dart';
import 'package:student_sphere/features/assignments/presentation/assignment_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddAssignmentScreen extends ConsumerStatefulWidget {
  const AddAssignmentScreen({super.key});

  @override
  ConsumerState<AddAssignmentScreen> createState() =>
      _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends ConsumerState<AddAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  DateTime _deadline = DateTime.now().add(const Duration(days: 1));
  String _priority = 'Medium';

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveAssignment() {
    if (_formKey.currentState!.validate()) {
      final assignment = AssignmentEntity(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descController.text,
        subjectId: '', // Optional: Link to subject
        deadline: _deadline,
        priority: _priority,
      );

      ref.read(assignmentControllerProvider.notifier).addAssignment(assignment);
      if (context.mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Assignment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Deadline'),
                subtitle: Text(DateFormat.yMMMd().add_jm().format(_deadline)),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _deadline,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(_deadline),
                    );
                    if (time != null) {
                      setState(() {
                        _deadline = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _priority,
                items: const [
                  DropdownMenuItem(value: 'Low', child: Text('Low')),
                  DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                  DropdownMenuItem(value: 'High', child: Text('High')),
                ],
                onChanged: (v) => setState(() => _priority = v!),
                decoration: const InputDecoration(labelText: 'Priority'),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saveAssignment,
                child: const Text('Save Assignment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
