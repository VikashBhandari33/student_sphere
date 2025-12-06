import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/timetable/domain/custom_table_entity.dart';
import 'package:student_sphere/features/timetable/domain/custom_table_repository.dart';
import 'package:uuid/uuid.dart';

final customTableRepositoryProvider = Provider<CustomTableRepository>((ref) {
  return CustomTableRepositoryImpl(
      FirebaseFirestore.instance, FirebaseAuth.instance);
});

class CustomTableRepositoryImpl implements CustomTableRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CustomTableRepositoryImpl(this._firestore, this._auth);

  String get _userId => _auth.currentUser!.uid;

  @override
  Stream<List<CustomTableEntity>> getTables() {
    return _firestore
        .collection('custom_tables')
        .where('userId', isEqualTo: _userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return CustomTableEntity.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<Either<Failure, void>> createTable(String title) async {
    try {
      final id = const Uuid().v4();
      final table = CustomTableEntity(
        id: id,
        title: title,
        columns: [],
        rows: [],
        userId: _userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _firestore.collection('custom_tables').doc(id).set(table.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTable(String id) async {
    try {
      await _firestore.collection('custom_tables').doc(id).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTable(CustomTableEntity table) async {
    try {
      await _firestore
          .collection('custom_tables')
          .doc(table.id)
          .update(table.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addColumn(
      String tableId, TableColumn column) async {
    try {
      final tableRef = _firestore.collection('custom_tables').doc(tableId);
      final snapshot = await tableRef.get();
      if (snapshot.exists) {
        final table = CustomTableEntity.fromJson(snapshot.data()!);
        final updatedColumns = [...table.columns, column];
        await tableRef.update({
          'columns': updatedColumns.map((c) => c.toJson()).toList(),
          'updatedAt': DateTime.now().toIso8601String(),
        });
        return const Right(null);
      } else {
        return const Left(ServerFailure('Table not found'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addRow(String tableId, TableRow row) async {
    try {
      final tableRef = _firestore.collection('custom_tables').doc(tableId);
      final snapshot = await tableRef.get();
      if (snapshot.exists) {
        final table = CustomTableEntity.fromJson(snapshot.data()!);
        final updatedRows = [...table.rows, row];
        await tableRef.update({
          'rows': updatedRows.map((r) => r.toJson()).toList(),
          'updatedAt': DateTime.now().toIso8601String(),
        });
        return const Right(null);
      } else {
        return const Left(ServerFailure('Table not found'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
