import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_sphere/features/timetable/domain/class_entity.dart';
import 'package:student_sphere/features/timetable/presentation/timetable_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddClassScreen extends ConsumerStatefulWidget {
  const AddClassScreen({super.key});

  @override
  ConsumerState<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends ConsumerState<AddClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _roomController = TextEditingController();
  final _facultyController = TextEditingController();

  int _selectedDay = 1;
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);
  Color _selectedColor = Colors.blue;

  @override
  void dispose() {
    _subjectController.dispose();
    _roomController.dispose();
    _facultyController.dispose();
    super.dispose();
  }

  void _saveClass() {
    if (_formKey.currentState!.validate()) {
      final newClass = ClassEntity(
        id: const Uuid().v4(),
        subjectName: _subjectController.text,
        roomNumber: _roomController.text,
        facultyName: _facultyController.text,
        dayOfWeek: _selectedDay,
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor.value,
      );

      ref.read(timetableControllerProvider.notifier).addClass(newClass);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Class')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject Name'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _roomController,
                decoration: const InputDecoration(labelText: 'Room Number'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _facultyController,
                decoration: const InputDecoration(labelText: 'Faculty Name'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedDay,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Monday')),
                  DropdownMenuItem(value: 2, child: Text('Tuesday')),
                  DropdownMenuItem(value: 3, child: Text('Wednesday')),
                  DropdownMenuItem(value: 4, child: Text('Thursday')),
                  DropdownMenuItem(value: 5, child: Text('Friday')),
                  DropdownMenuItem(value: 6, child: Text('Saturday')),
                  DropdownMenuItem(value: 7, child: Text('Sunday')),
                ],
                onChanged: (v) => setState(() => _selectedDay = v!),
                decoration: const InputDecoration(labelText: 'Day of Week'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Start Time'),
                      subtitle: Text(_startTime.format(context)),
                      onTap: () async {
                        final t = await showTimePicker(
                            context: context, initialTime: _startTime);
                        if (t != null) setState(() => _startTime = t);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('End Time'),
                      subtitle: Text(_endTime.format(context)),
                      onTap: () async {
                        final t = await showTimePicker(
                            context: context, initialTime: _endTime);
                        if (t != null) setState(() => _endTime = t);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Color'),
                trailing: CircleAvatar(backgroundColor: _selectedColor),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Pick a color'),
                      content: BlockPicker(
                        pickerColor: _selectedColor,
                        onColorChanged: (color) {
                          setState(() => _selectedColor = color);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saveClass,
                child: const Text('Save Class'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
