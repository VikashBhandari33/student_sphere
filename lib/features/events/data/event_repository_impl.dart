import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/events/domain/event_entity.dart';
import 'package:student_sphere/features/events/domain/event_repository.dart';

import 'package:student_sphere/features/events/data/google_calendar_service.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepositoryImpl(
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
    ref.watch(googleCalendarServiceProvider),
  );
});

class EventRepositoryImpl implements EventRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleCalendarService _googleCalendarService;

  EventRepositoryImpl(this._firestore, this._auth, this._googleCalendarService);

  String get _userId => _auth.currentUser!.uid;

  CollectionReference get _eventsCollection =>
      _firestore.collection('users').doc(_userId).collection('events');

  @override
  Future<Either<Failure, void>> addEvent(EventEntity event) async {
    try {
      await _eventsCollection.doc(event.id).set(event.toJson());
      await _googleCalendarService.insertEvent(event);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEvent(String id) async {
    try {
      await _eventsCollection.doc(id).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<EventEntity>> getEvents() {
    return _eventsCollection.snapshots().asyncMap((snapshot) async {
      final firestoreEvents = snapshot.docs.map((doc) {
        return EventEntity.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      try {
        // Fetch Google Calendar events for a reasonable range (e.g., current month +/- 2 months)
        // For simplicity, let's fetch +/- 6 months from now
        final now = DateTime.now();
        final start = now.subtract(const Duration(days: 180));
        final end = now.add(const Duration(days: 180));

        final googleEvents = await _googleCalendarService.getEvents(start, end);
        return [...firestoreEvents, ...googleEvents];
      } catch (e) {
        // If Google fetch fails, just return Firestore events
        return firestoreEvents;
      }
    });
  }
}
