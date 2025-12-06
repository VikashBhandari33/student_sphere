import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/workspace/domain/chat_repository.dart';
import 'package:student_sphere/features/workspace/domain/message_entity.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(
    FirebaseFirestore.instance,
    FirebaseStorage.instance,
  );
});

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ChatRepositoryImpl(this._firestore, this._storage);

  @override
  Stream<List<MessageEntity>> getMessages(String workspaceId) {
    return _firestore
        .collection('workspaces')
        .doc(workspaceId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return MessageEntity.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<Either<Failure, void>> sendMessage(
      String workspaceId, MessageEntity message) async {
    try {
      await _firestore
          .collection('workspaces')
          .doc(workspaceId)
          .collection('messages')
          .doc(message.id)
          .set(message.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadFile(
      String workspaceId, File file) async {
    try {
      final fileName = '${const Uuid().v4()}_${file.path.split('/').last}';
      final ref =
          _storage.ref().child('workspaces/$workspaceId/files/$fileName');
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return Right(downloadUrl);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
