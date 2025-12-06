import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:student_sphere/core/errors/failure.dart';
import 'package:student_sphere/features/workspace/domain/message_entity.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> getMessages(String workspaceId);
  Future<Either<Failure, void>> sendMessage(
      String workspaceId, MessageEntity message);
  Future<Either<Failure, String>> uploadFile(String workspaceId, File file);
}
