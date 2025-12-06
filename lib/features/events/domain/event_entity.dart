import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_entity.freezed.dart';
part 'event_entity.g.dart';

@freezed
class EventEntity with _$EventEntity {
  const factory EventEntity({
    required String id,
    required String title,
    required String description,
    required DateTime date,
    required String category, // Exam, Project, Reminder
    required int color,
  }) = _EventEntity;

  factory EventEntity.fromJson(Map<String, dynamic> json) =>
      _$EventEntityFromJson(json);
}
