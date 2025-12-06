import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/classroom/v1.dart';
import 'package:googleapis/gmail/v1.dart';

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn(
    scopes: [
      'email',
      GmailApi.gmailReadonlyScope,
      ClassroomApi.classroomCoursesReadonlyScope,
      ClassroomApi.classroomCourseworkMeReadonlyScope,
      ClassroomApi.classroomAnnouncementsReadonlyScope,
      CalendarApi.calendarEventsScope,
    ],
  );
});
