import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/workspace/domain/workspace_entity.dart';
import 'package:student_sphere/features/workspace/domain/workspace_repository.dart';
import 'package:uuid/uuid.dart';

final workspaceRepositoryProvider = Provider<WorkspaceRepository>((ref) {
  return WorkspaceRepositoryImpl(
      FirebaseFirestore.instance, FirebaseAuth.instance);
});

class WorkspaceRepositoryImpl implements WorkspaceRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  WorkspaceRepositoryImpl(this._firestore, this._auth);

  String get _userId => _auth.currentUser!.uid;

  @override
  Future<Either<Failure, void>> createWorkspace(
      String name, String description) async {
    try {
      final id = const Uuid().v4();
      final workspace = WorkspaceEntity(
        id: id,
        name: name,
        description: description,
        ownerId: _userId,
        memberIds: [_userId],
        editorIds: [_userId],
        createdAt: DateTime.now(),
      );
      await _firestore.collection('workspaces').doc(id).set(workspace.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteWorkspace(String id) async {
    try {
      await _firestore.collection('workspaces').doc(id).delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<WorkspaceEntity>> getWorkspaces() {
    return _firestore
        .collection('workspaces')
        .where('memberIds', arrayContains: _userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return WorkspaceEntity.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<Either<Failure, void>> addMember(
      String workspaceId, String email) async {
    try {
      // Find user by email
      final userQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (userQuery.docs.isEmpty) {
        return const Left(ServerFailure('User not found'));
      }
      final userId = userQuery.docs.first.id;

      await _firestore.collection('workspaces').doc(workspaceId).update({
        'memberIds': FieldValue.arrayUnion([userId]),
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeMember(
      String workspaceId, String userId) async {
    try {
      await _firestore.collection('workspaces').doc(workspaceId).update({
        'memberIds': FieldValue.arrayRemove([userId]),
        'editorIds': FieldValue.arrayRemove([userId]),
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
