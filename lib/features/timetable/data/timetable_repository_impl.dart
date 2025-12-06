import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/timetable/domain/class_entity.dart';
import 'package:student_sphere/features/timetable/domain/timetable_repository.dart';

final timetableRepositoryProvider = Provider<TimetableRepository>((ref) {
  return TimetableRepositoryImpl(
      FirebaseFirestore.instance, FirebaseAuth.instance);
});

class TimetableRepositoryImpl implements TimetableRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  TimetableRepositoryImpl(this._firestore, this._auth);

  String get _userId => _auth.currentUser!.uid;

  CollectionReference get _classesCollection =>
      _firestore.collection('users').doc(_userId).collection('classes');

  @override
  Future<Either<Failure, void>> addClass(ClassEntity classEntity) async {
    try {
      await _classesCollection.doc(classEntity.id).set(classEntity.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteClass(String classId) async {
    try {
      await _classesCollection.doc(classId).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<ClassEntity>> getClasses() {
    return _classesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ClassEntity.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  @override
  Future<Either<Failure, void>> updateClass(ClassEntity classEntity) async {
    try {
      await _classesCollection.doc(classEntity.id).update(classEntity.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
