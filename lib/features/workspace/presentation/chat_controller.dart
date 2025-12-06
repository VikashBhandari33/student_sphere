import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/auth/presentation/auth_controller.dart';
import 'package:student_sphere/features/workspace/data/chat_repository_impl.dart';
import 'package:student_sphere/features/workspace/domain/message_entity.dart';
import 'package:uuid/uuid.dart';

final chatControllerProvider =
    StateNotifierProvider<ChatController, AsyncValue<void>>((ref) {
  return ChatController(ref);
});

final chatMessagesProvider =
    StreamProvider.family<List<MessageEntity>, String>((ref, workspaceId) {
  return ref.watch(chatRepositoryProvider).getMessages(workspaceId);
});

class ChatController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  ChatController(this.ref) : super(const AsyncValue.data(null));

  Future<void> sendMessage(String workspaceId, String content) async {
    final user = ref.read(authControllerProvider).value;
    if (user == null) return;

    final message = MessageEntity(
      id: const Uuid().v4(),
      senderId: user.id,
      senderName: user.displayName,
      content: content,
      type: MessageType.text,
      timestamp: DateTime.now(),
    );

    state = const AsyncValue.loading();
    final result = await ref
        .read(chatRepositoryProvider)
        .sendMessage(workspaceId, message);
    state = result.fold(
      (l) => AsyncValue.error(l.message, StackTrace.current),
      (r) => const AsyncValue.data(null),
    );
  }

  Future<void> sendFile(String workspaceId, File file) async {
    final user = ref.read(authControllerProvider).value;
    if (user == null) return;

    state = const AsyncValue.loading();
    final uploadResult =
        await ref.read(chatRepositoryProvider).uploadFile(workspaceId, file);

    uploadResult.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (downloadUrl) async {
        final message = MessageEntity(
          id: const Uuid().v4(),
          senderId: user.id,
          senderName: user.displayName,
          content: 'Sent a file',
          type: MessageType.file,
          fileUrl: downloadUrl,
          fileName: file.path.split('/').last,
          timestamp: DateTime.now(),
        );

        final sendResult = await ref
            .read(chatRepositoryProvider)
            .sendMessage(workspaceId, message);
        state = sendResult.fold(
          (l) => AsyncValue.error(l.message, StackTrace.current),
          (r) => const AsyncValue.data(null),
        );
      },
    );
  }
}
