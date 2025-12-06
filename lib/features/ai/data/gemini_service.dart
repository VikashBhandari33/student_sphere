import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:student_sphere/core/utils/logger.dart';
import 'package:student_sphere/features/auth/presentation/auth_controller.dart';
import 'package:student_sphere/features/notes/data/note_repository_impl.dart';
import 'package:student_sphere/features/timetable/domain/class_entity.dart';
import 'package:student_sphere/features/timetable/data/timetable_repository_impl.dart';
import 'package:student_sphere/features/events/domain/event_entity.dart';
import 'package:student_sphere/features/events/data/event_repository_impl.dart';
import 'package:student_sphere/features/assignments/domain/assignment_entity.dart';
import 'package:student_sphere/features/assignments/data/assignment_repository_impl.dart';
import 'package:student_sphere/features/attendance/data/attendance_repository_impl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  // TODO: Get API Key from secure storage or config
  const apiKey = 'AIzaSyD6_PBKnFq1Cukg8eaoPI2nuMhlOGnlvQ0';
  return GeminiService(apiKey, ref);
});

class GeminiService {
  final String apiKey;
  final Ref ref;
  late final GenerativeModel _model;
  late final ChatSession _chat;

  GeminiService(this.apiKey, this.ref) {
    final tools = [
      Tool(functionDeclarations: [
        FunctionDeclaration(
          'add_note',
          'Create a new note with a title and content.',
          Schema(
            SchemaType.object,
            properties: {
              'title': Schema(SchemaType.string,
                  description: 'The title of the note'),
              'content': Schema(SchemaType.string,
                  description: 'The content/body of the note'),
            },
            requiredProperties: ['title', 'content'],
          ),
        ),
        FunctionDeclaration(
          'add_class',
          'Add a class to the timetable.',
          Schema(
            SchemaType.object,
            properties: {
              'subject': Schema(SchemaType.string, description: 'Subject name'),
              'day': Schema(SchemaType.string,
                  description: 'Day of the week (e.g., Monday)'),
              'startTime': Schema(SchemaType.string,
                  description: 'Start time in HH:mm format'),
              'endTime': Schema(SchemaType.string,
                  description: 'End time in HH:mm format'),
              'room': Schema(SchemaType.string,
                  description: 'Room number or location'),
            },
            requiredProperties: ['subject', 'day', 'startTime', 'endTime'],
          ),
        ),
        FunctionDeclaration(
          'add_event',
          'Add a new event to the calendar.',
          Schema(
            SchemaType.object,
            properties: {
              'title': Schema(SchemaType.string, description: 'Event title'),
              'date': Schema(SchemaType.string,
                  description: 'Date in YYYY-MM-DD format'),
              'description':
                  Schema(SchemaType.string, description: 'Event description'),
            },
            requiredProperties: ['title', 'date'],
          ),
        ),
        FunctionDeclaration(
          'add_assignment',
          'Add a new assignment.',
          Schema(
            SchemaType.object,
            properties: {
              'title':
                  Schema(SchemaType.string, description: 'Assignment title'),
              'subject': Schema(SchemaType.string, description: 'Subject name'),
              'deadline': Schema(SchemaType.string,
                  description: 'Deadline in YYYY-MM-DD format'),
            },
            requiredProperties: ['title', 'subject', 'deadline'],
          ),
        ),
        FunctionDeclaration(
          'mark_attendance',
          'Mark attendance for a subject.',
          Schema(
            SchemaType.object,
            properties: {
              'subject': Schema(SchemaType.string, description: 'Subject name'),
              'isPresent': Schema(SchemaType.boolean,
                  description: 'True if present, false if absent'),
            },
            requiredProperties: ['subject', 'isPresent'],
          ),
        ),
      ]),
    ];

    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      tools: tools,
    );
    _chat = _model.startChat();
  }

  Future<String> sendMessage(String message) async {
    try {
      var response = await _chat.sendMessage(Content.text(message));

      final functionCalls = response.functionCalls.toList();
      if (functionCalls.isNotEmpty) {
        final functionResponses = <FunctionResponse>[];

        for (final call in functionCalls) {
          final result = await _handleFunctionCall(call);
          functionResponses.add(FunctionResponse(call.name, result));
        }

        response = await _chat
            .sendMessage(Content.functionResponses(functionResponses));
      }

      return response.text ?? 'I completed the action.';
    } catch (e) {
      logger.e('Gemini Error: $e');
      return 'Sorry, I encountered an error: $e';
    }
  }

  Future<Map<String, Object?>> _handleFunctionCall(FunctionCall call) async {
    try {
      switch (call.name) {
        case 'add_note':
          return await _addNote(
            call.args['title'] as String,
            call.args['content'] as String,
          );
        case 'add_class':
          return await _addClass(
            call.args['subject'] as String,
            call.args['day'] as String,
            call.args['startTime'] as String,
            call.args['endTime'] as String,
            call.args['room'] as String?,
          );
        case 'add_event':
          return await _addEvent(
            call.args['title'] as String,
            call.args['date'] as String,
            call.args['description'] as String?,
          );
        case 'add_assignment':
          return await _addAssignment(
            call.args['title'] as String,
            call.args['subject'] as String,
            call.args['deadline'] as String,
          );
        case 'mark_attendance':
          return await _markAttendance(
            call.args['subject'] as String,
            call.args['isPresent'] as bool,
          );
        default:
          return {'error': 'Unknown function ${call.name}'};
      }
    } catch (e) {
      return {'error': 'Error executing ${call.name}: $e'};
    }
  }

  Future<Map<String, Object?>> _addNote(String title, String content) async {
    final user = ref.read(authControllerProvider).value;
    if (user == null) return {'error': 'User not logged in'};

    await ref.read(noteRepositoryProvider).addNote(title, content);
    return {'success': true, 'message': 'Note created.'};
  }

  Future<Map<String, Object?>> _addClass(String subject, String day,
      String startTime, String endTime, String? room) async {
    final user = ref.read(authControllerProvider).value;
    if (user == null) return {'error': 'User not logged in'};

    final dayMap = {
      'monday': 1,
      'tuesday': 2,
      'wednesday': 3,
      'thursday': 4,
      'friday': 5,
      'saturday': 6,
      'sunday': 7,
    };

    final newClass = ClassEntity(
      id: const Uuid().v4(),
      subjectName: subject,
      roomNumber: room ?? 'TBD',
      facultyName: 'TBD', // Default value
      dayOfWeek: dayMap[day.toLowerCase()] ?? 1,
      startTime: _parseTime(startTime),
      endTime: _parseTime(endTime),
      color: Colors.blue.value,
    );

    await ref.read(timetableRepositoryProvider).addClass(newClass);
    return {'success': true, 'message': 'Class added to timetable.'};
  }

  Future<Map<String, Object?>> _addEvent(
      String title, String date, String? description) async {
    final user = ref.read(authControllerProvider).value;
    if (user == null) return {'error': 'User not logged in'};

    final event = EventEntity(
      id: const Uuid().v4(),
      title: title,
      description: description ?? '',
      date: DateTime.parse(date),
      category: 'General', // Default category
      color: Colors.green.value,
    );

    await ref.read(eventRepositoryProvider).addEvent(event);
    return {'success': true, 'message': 'Event added to calendar.'};
  }

  Future<Map<String, Object?>> _addAssignment(
      String title, String subject, String deadline) async {
    final user = ref.read(authControllerProvider).value;
    if (user == null) return {'error': 'User not logged in'};

    final assignment = AssignmentEntity(
      id: const Uuid().v4(),
      title: title,
      description: '', // Default description
      subjectId: subject, // Using subject name as ID for now
      deadline: DateTime.parse(deadline),
      isCompleted: false,
      priority: 'Medium',
    );

    await ref.read(assignmentRepositoryProvider).addAssignment(assignment);
    return {'success': true, 'message': 'Assignment added.'};
  }

  Future<Map<String, Object?>> _markAttendance(
      String subjectName, bool isPresent) async {
    final user = ref.read(authControllerProvider).value;
    if (user == null) return {'error': 'User not logged in'};

    // Find subject by name (simplified logic)
    final subjectsStream = ref.read(attendanceRepositoryProvider).getSubjects();
    final subjects = await subjectsStream.first;
    final subject = subjects.firstWhere(
      (s) => s.name.toLowerCase() == subjectName.toLowerCase(),
      orElse: () => throw Exception('Subject not found'),
    );

    await ref
        .read(attendanceRepositoryProvider)
        .markAttendance(subject.id, isPresent);
    return {'success': true, 'message': 'Attendance marked.'};
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
