import 'package:freezed_annotation/freezed_annotation.dart';

part 'workspace_entity.freezed.dart';
part 'workspace_entity.g.dart';

@freezed
class WorkspaceEntity with _$WorkspaceEntity {
  const factory WorkspaceEntity({
    required String id,
    required String name,
    required String description,
    required String ownerId,
    required List<String> memberIds,
    @Default([]) List<String> editorIds,
    required DateTime createdAt,
  }) = _WorkspaceEntity;

  factory WorkspaceEntity.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceEntityFromJson(json);
}
