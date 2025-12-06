import 'package:freezed_annotation/freezed_annotation.dart';

part 'assignment_entity.freezed.dart';
part 'assignment_entity.g.dart';

@freezed
class AssignmentEntity with _$AssignmentEntity {
  const factory AssignmentEntity({
    required String id,
    required String title,
    required String description,
    required String subjectId,
    required DateTime deadline,
    @Default(false) bool isCompleted,
    @Default('Medium') String priority, // Low, Medium, High
  }) = _AssignmentEntity;

  factory AssignmentEntity.fromJson(Map<String, dynamic> json) =>
      _$AssignmentEntityFromJson(json);
}
