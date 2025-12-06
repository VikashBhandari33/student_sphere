import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/notes/domain/note_entity.dart';
import 'package:student_sphere/features/notes/domain/note_repository.dart';
import 'package:uuid/uuid.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepositoryImpl(FirebaseFirestore.instance, FirebaseAuth.instance);
});

class NoteRepositoryImpl implements NoteRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  NoteRepositoryImpl(this._firestore, this._auth);

  String get _userId => _auth.currentUser!.uid;

  CollectionReference get _notesCollection =>
      _firestore.collection('users').doc(_userId).collection('notes');

  @override
  Future<Either<Failure, void>> addNote(String title, String content) async {
    try {
      final id = const Uuid().v4();
      final note = NoteEntity(
        id: id,
        title: title,
        content: content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _notesCollection.doc(id).set(note.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(String id) async {
    try {
      await _notesCollection.doc(id).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<NoteEntity>> getNotes() {
    return _notesCollection
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return NoteEntity.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Future<Either<Failure, void>> updateNote(NoteEntity note) async {
    try {
      final updatedNote = note.copyWith(updatedAt: DateTime.now());
      await _notesCollection.doc(note.id).update(updatedNote.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
