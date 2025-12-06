import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_sphere/features/events/domain/event_entity.dart';
import 'package:student_sphere/features/events/presentation/event_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddEventScreen extends ConsumerStatefulWidget {
  const AddEventScreen({super.key});

  @override
  ConsumerState<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends ConsumerState<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  DateTime _date = DateTime.now();
  String _category = 'Reminder';
  Color _color = Colors.blue;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      final event = EventEntity(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descController.text,
        date: _date,
        category: _category,
        color: _color.value,
      );

      ref.read(eventControllerProvider.notifier).addEvent(event);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Event')),
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
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Date'),
                subtitle: Text(DateFormat.yMMMd().format(_date)),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() => _date = date);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                items: const [
                  DropdownMenuItem(value: 'Exam', child: Text('Exam')),
                  DropdownMenuItem(value: 'Project', child: Text('Project')),
                  DropdownMenuItem(value: 'Reminder', child: Text('Reminder')),
                ],
                onChanged: (v) => setState(() => _category = v!),
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Color'),
                trailing: CircleAvatar(backgroundColor: _color),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Pick a color'),
                      content: BlockPicker(
                        pickerColor: _color,
                        onColorChanged: (color) {
                          setState(() => _color = color);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saveEvent,
                child: const Text('Save Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
