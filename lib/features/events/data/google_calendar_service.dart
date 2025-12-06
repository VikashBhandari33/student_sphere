import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:student_sphere/core/utils/logger.dart';
import 'package:student_sphere/features/events/domain/event_entity.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/core/providers/google_sign_in_provider.dart';

final googleCalendarServiceProvider = Provider<GoogleCalendarService>((ref) {
  return GoogleCalendarService(ref.watch(googleSignInProvider));
});

class GoogleCalendarService {
  final GoogleSignIn _googleSignIn;

  GoogleCalendarService(this._googleSignIn);

  Future<void> insertEvent(EventEntity event) async {
    try {
      final client = await _googleSignIn.authenticatedClient();
      if (client == null) {
        logger.w('GoogleCalendarService: User not authenticated with Google');
        return;
      }

      final calendarApi = CalendarApi(client);
      final googleEvent = Event(
        summary: event.title,
        description: event.description,
        start: EventDateTime(
          dateTime: event.date,
          timeZone: DateTime.now().timeZoneName,
        ),
        end: EventDateTime(
          dateTime:
              event.date.add(const Duration(hours: 1)), // Default duration
          timeZone: DateTime.now().timeZoneName,
        ),
      );

      await calendarApi.events.insert(googleEvent, 'primary');
      logger.i(
          'GoogleCalendarService: Event added to Google Calendar: ${event.title}');
    } catch (e) {
      logger.e('GoogleCalendarService: Error adding event: $e');
      // We don't throw here to avoid blocking the app flow if sync fails
    }
  }

  Future<List<EventEntity>> getEvents(DateTime start, DateTime end) async {
    try {
      final client = await _googleSignIn.authenticatedClient();
      if (client == null) {
        logger.w('GoogleCalendarService: User not authenticated with Google');
        return [];
      }

      final calendarApi = CalendarApi(client);
      final events = await calendarApi.events.list(
        'primary',
        timeMin: start.toUtc(),
        timeMax: end.toUtc(),
        singleEvents: true,
      );

      if (events.items == null) return [];

      return events.items!.map((e) {
        return EventEntity(
          id: e.id ?? '',
          title: e.summary ?? 'No Title',
          description: e.description ?? '',
          date: e.start?.dateTime ?? e.start?.date ?? DateTime.now(),
          category: 'Google Calendar',
          color: 0xFF4285F4, // Google Blue
        );
      }).toList();
    } catch (e) {
      logger.e('GoogleCalendarService: Error fetching events: $e');
      return [];
    }
  }
}
