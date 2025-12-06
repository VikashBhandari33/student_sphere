// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkspaceEntityImpl _$$WorkspaceEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkspaceEntityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      ownerId: json['ownerId'] as String,
      memberIds:
          (json['memberIds'] as List<dynamic>).map((e) => e as String).toList(),
      editorIds: (json['editorIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$WorkspaceEntityImplToJson(
        _$WorkspaceEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'ownerId': instance.ownerId,
      'memberIds': instance.memberIds,
      'editorIds': instance.editorIds,
      'createdAt': instance.createdAt.toIso8601String(),
    };
