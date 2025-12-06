import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_entity.freezed.dart';
part 'subject_entity.g.dart';

@freezed
class SubjectEntity with _$SubjectEntity {
  const factory SubjectEntity({
    required String id,
    required String name,
    required int presentCount,
    required int absentCount,
    @Default(75) int targetPercentage,
  }) = _SubjectEntity;

  factory SubjectEntity.fromJson(Map<String, dynamic> json) =>
      _$SubjectEntityFromJson(json);
}

extension SubjectEntityX on SubjectEntity {
  int get totalClasses => presentCount + absentCount;
  double get currentPercentage =>
      totalClasses == 0 ? 0 : (presentCount / totalClasses) * 100;
}
