import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/events/domain/event_entity.dart';
import 'package:student_sphere/features/events/domain/event_repository.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepositoryImpl(FirebaseFirestore.instance, FirebaseAuth.instance);
});

class EventRepositoryImpl implements EventRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  EventRepositoryImpl(this._firestore, this._auth);

  String get _userId => _auth.currentUser!.uid;

  CollectionReference get _eventsCollection =>
      _firestore.collection('users').doc(_userId).collection('events');

  @override
  Future<Either<Failure, void>> addEvent(EventEntity event) async {
    try {
      await _eventsCollection.doc(event.id).set(event.toJson());
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
    return _eventsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return EventEntity.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
