import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/attendance/domain/attendance_repository.dart';
import 'package:student_sphere/features/attendance/domain/subject_entity.dart';
import 'package:uuid/uuid.dart';

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepositoryImpl(
      FirebaseFirestore.instance, FirebaseAuth.instance);
});

class AttendanceRepositoryImpl implements AttendanceRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AttendanceRepositoryImpl(this._firestore, this._auth);

  String get _userId => _auth.currentUser!.uid;

  CollectionReference get _subjectsCollection =>
      _firestore.collection('users').doc(_userId).collection('subjects');

  @override
  Future<Either<Failure, void>> addSubject(
      String name, int targetPercentage) async {
    try {
      final id = const Uuid().v4();
      final subject = SubjectEntity(
        id: id,
        name: name,
        presentCount: 0,
        absentCount: 0,
        targetPercentage: targetPercentage,
      );
      await _subjectsCollection.doc(id).set(subject.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSubject(String id) async {
    try {
      await _subjectsCollection.doc(id).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<SubjectEntity>> getSubjects() {
    return _subjectsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return SubjectEntity.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Future<Either<Failure, void>> markAttendance(
      String id, bool isPresent) async {
    try {
      await _subjectsCollection.doc(id).update({
        if (isPresent)
          'presentCount': FieldValue.increment(1)
        else
          'absentCount': FieldValue.increment(1),
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateSubject(SubjectEntity subject) async {
    try {
      await _subjectsCollection.doc(subject.id).update(subject.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
