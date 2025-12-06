import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/ai/data/gemini_service.dart';
import 'package:student_sphere/features/notices/data/classroom_service.dart';
import 'package:student_sphere/features/notices/data/gmail_service.dart';
import 'package:student_sphere/core/utils/logger.dart';

import 'package:student_sphere/core/providers/google_sign_in_provider.dart';

final noticeRepositoryProvider = Provider<NoticeRepository>((ref) {
  final googleSignIn = ref.watch(googleSignInProvider);
  return NoticeRepository(
    GmailService(googleSignIn),
    ClassroomService(googleSignIn),
    ref.read(geminiServiceProvider),
  );
});

class NoticeRepository {
  final GmailService _gmailService;
  final ClassroomService _classroomService;
  final GeminiService _geminiService;

  NoticeRepository(
      this._gmailService, this._classroomService, this._geminiService);

  Future<String> getSummarizedNotices() async {
    try {
      final emails = await _gmailService.fetchImportantEmails();
      final courses = await _classroomService.fetchCourses();

      final StringBuffer contentBuffer = StringBuffer();

      if (emails.isNotEmpty) {
        contentBuffer.writeln('Important Emails:');
        for (final email in emails) {
          contentBuffer.writeln('- ${email.snippet}');
        }
      }

      bool hasClassroomUpdates = false;
      final StringBuffer classroomBuffer = StringBuffer();

      for (final course in courses) {
        if (course.id != null) {
          final announcements =
              await _classroomService.fetchAnnouncements(course.id!);
          final coursework =
              await _classroomService.fetchCourseWork(course.id!);

          if (announcements.isNotEmpty || coursework.isNotEmpty) {
            hasClassroomUpdates = true;
            classroomBuffer.writeln('Course: ${course.name}');
            for (final announcement in announcements) {
              classroomBuffer.writeln('  Announcement: ${announcement.text}');
            }
            for (final work in coursework) {
              classroomBuffer.writeln(
                  '  Assignment: ${work.title} (Due: ${work.dueDate?.year}-${work.dueDate?.month}-${work.dueDate?.day})');
            }
          }
        }
      }

      if (hasClassroomUpdates) {
        contentBuffer.writeln('\nClassroom Updates:');
        contentBuffer.write(classroomBuffer.toString());
      }

      if (contentBuffer.isEmpty) {
        logger.d('NoticeRepository: No content to summarize.');
        return 'No new notices found.';
      }

      logger.d('NoticeRepository: Content length: ${contentBuffer.length}');
      return await _geminiService.summarizeContent(contentBuffer.toString());
    } catch (e) {
      return 'Failed to fetch notices: $e';
    }
  }
}
