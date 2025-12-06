import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/assignments/domain/assignment_entity.dart';
import 'package:student_sphere/features/assignments/domain/assignment_repository.dart';

final assignmentRepositoryProvider = Provider<AssignmentRepository>((ref) {
  return AssignmentRepositoryImpl(
      FirebaseFirestore.instance, FirebaseAuth.instance);
});

class AssignmentRepositoryImpl implements AssignmentRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AssignmentRepositoryImpl(this._firestore, this._auth);

  String get _userId => _auth.currentUser!.uid;

  CollectionReference get _assignmentsCollection =>
      _firestore.collection('users').doc(_userId).collection('assignments');

  @override
  Future<Either<Failure, void>> addAssignment(
      AssignmentEntity assignment) async {
    try {
      await _assignmentsCollection.doc(assignment.id).set(assignment.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAssignment(String id) async {
    try {
      await _assignmentsCollection.doc(id).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<AssignmentEntity>> getAssignments() {
    return _assignmentsCollection
        .orderBy('deadline')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AssignmentEntity.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Future<Either<Failure, void>> toggleCompletion(
      String id, bool isCompleted) async {
    try {
      await _assignmentsCollection.doc(id).update({'isCompleted': isCompleted});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAssignment(
      AssignmentEntity assignment) async {
    try {
      await _assignmentsCollection
          .doc(assignment.id)
          .update(assignment.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
