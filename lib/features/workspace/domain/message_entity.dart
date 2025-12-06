import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';
part 'message_entity.g.dart';

enum MessageType { text, file, image }

@freezed
class MessageEntity with _$MessageEntity {
  @JsonSerializable(explicitToJson: true)
  const factory MessageEntity({
    required String id,
    required String senderId,
    required String senderName,
    required String content,
    required MessageType type,
    String? fileUrl,
    String? fileName,
    required DateTime timestamp,
  }) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);
}
